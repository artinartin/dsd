module parking_logic (
     input wire clk,reset,car_entered,is_uni_car_entered,car_exited,is_uni_car_exited,
     input wire [4:0] hour, 
     output reg [8:0] uni_parked_car,parked_car, uni_vacated_space, vacated_space, 
     output reg uni_is_vacated_space,is_vacated_space
);

reg [9:0] free_capacity;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        free_capacity <= 200;
        parked_car <= 0;
        uni_parked_car <= 0;
    end else begin

        if (hour >= 8 && hour < 13) begin
            free_capacity <= 200;
        end

        else if (hour >= 13 && hour < 16) begin
            free_capacity <= 200 + (hour - 13) * 50;
        end 
        
        else if (hour >= 16) begin
            free_capacity <= 500;
        end

        if (car_entered) begin
            if (is_uni_car_entered && uni_parked_car < 500) begin
                uni_parked_car <= uni_parked_car + 1;
            end 

            else if (!is_uni_car_entered && parked_car < free_capacity) begin
                parked_car <= parked_car + 1;
            end
        end

        if (car_exited) begin
            if (is_uni_car_exited && uni_parked_car > 0) begin
                uni_parked_car <= uni_parked_car - 1;
            end 
            
            else if (!is_uni_car_exited && parked_car > 0) begin
                parked_car <= parked_car - 1;
            end
        end
    end
end

always @(*) begin
    uni_vacated_space = 500 - uni_parked_car;
    vacated_space = free_capacity - parked_car;
    uni_is_vacated_space = (uni_vacated_space > 0);
    is_vacated_space = (vacated_space > 0);
end

endmodule
