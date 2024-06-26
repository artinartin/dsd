module TB;

reg clk,reset,car_entered,is_uni_car_entered,car_exited,is_uni_car_exited;
reg [4:0] hour;
wire [8:0] uni_parked_car,parked_car,uni_vacated_space,vacated_space;
wire uni_is_vacated_space,is_vacated_space;

parking_logic pl (
    .clk(clk),
    .reset(reset),
    .car_entered(car_entered),
    .is_uni_car_entered(is_uni_car_entered),
    .car_exited(car_exited),
    .is_uni_car_exited(is_uni_car_exited),
    .hour(hour),
    .uni_parked_car(uni_parked_car),
    .parked_car(parked_car),
    .uni_vacated_space(uni_vacated_space),
    .vacated_space(vacated_space),
    .uni_is_vacated_space(uni_is_vacated_space),
    .is_vacated_space(is_vacated_space)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    car_entered = 0;
    is_uni_car_entered = 0;
    car_exited = 0;
    is_uni_car_exited = 0;
    hour = 0;

    $monitor("Time: %0d, Hour: %0d, uni_parked_car: %0d, parked_car: %0d, uni_vacated_space: %0d, vacated_space: %0d, uni_is_vacated_space: %b, is_vacated_space: %b", 
            $time, hour, uni_parked_car, parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);
            
    #10 reset = 0;

    // fill the parking at hour = 10
    hour = 10;
    //enter 500 uni cars 
    repeat (500) begin
        #10 car_entered = 1;
        is_uni_car_entered = 1;
        #10 car_entered = 0;
    end
    //enter 200 non uni cars
    repeat (200) begin
        #10 car_entered = 1;
        is_uni_car_entered = 0;
        #10 car_entered = 0;
    end

    // exit 70  uni cars and enter 30 non uni cars
    #10 hour = 14;
    repeat (70) begin
        #10 car_exited = 1;
        is_uni_car_exited = 1;
        #10 car_exited = 0;
    end
    repeat (30) begin
        #10 car_entered = 1;
        is_uni_car_entered = 0;
        #10 car_entered = 0;
    end

    // enter 70 uni cars (fill again)
    #10 hour = 15;
    repeat (70) begin
        #10 car_entered = 1;
        is_uni_car_entered = 0;
        #10 car_entered = 0;
    end

    // exit and enter 150 uni cars and exit 50 non uni cars and enter 200 non uni cars
    #10 hour = 16;
    repeat (150) begin
        #10 car_exited = 1;
        is_uni_car_exited = 1;
        #10 car_exited = 0;
    end
    repeat (50) begin
        #10 car_exited = 1;
        is_uni_car_exited = 0;
        #10 car_exited = 0;
    end
    repeat (150) begin
        #10 car_entered = 1;
        is_uni_car_entered = 1;
        #10 car_entered = 0;
    end
    repeat (200) begin
        #10 car_entered = 1;
        is_uni_car_entered = 0;
        #10 car_entered = 0;
    end

    #10 $finish;
end

endmodule
