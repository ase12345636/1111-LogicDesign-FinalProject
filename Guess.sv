module Guess (
    output reg com1,com2,com3,com4,a,b,c,d,e,f,g,beep,big,min,enable,
    output reg [2:0] set,
    output reg [7:0] DATA_R,DATA_G,DATA_B,
    input  CLK,enter,enter2,start,
    input [1:0] choise,
    input [3:0] num
);
    wire    CLK_div,CLK_div2,CLK_div3,CLK_div4;
    bit flag,flag2,flag3;    //flag->是否按下start falg2->輸入是否正確 flag3->時間是否到了
    reg [2:0]   COM;
    reg [3:0]   t1,t2;
    reg [16:0]  s_com,r_com;
    reg [3:0] save_num [3:0];
    reg [3:0] rand_num [3:0];
    reg [7:0] t1_out [2:0];
    reg [7:0] t2_out [2:0];
    parameter logic [7:0] empty [1:0]=
    '{
    8'b11111111,
    8'b11111111
    };
    parameter logic [7:0] zero [2:0]=
    '{
    8'b10000001,
    8'b10111101,
    8'b10000001
    };
    parameter logic [7:0] one [2:0]=
    '{
    8'b11111111,
    8'b11111111,
    8'b10000001
    };
    parameter logic [7:0] two [2:0]=
    '{
    8'b10000101,
    8'b10110101,
    8'b10110001
    };
    parameter logic [7:0] three [2:0]=
    '{
    8'b10110101,
    8'b10110101,
    8'b10000001
    };
    parameter logic [7:0] four [2:0]=
    '{
    8'b11110001,
    8'b11110111,
    8'b10000001
    };
    parameter logic [7:0] five [2:0]=
    '{
    8'b10110001,
    8'b10110101,
    8'b10000101
    };
    parameter logic [7:0] six [2:0]=
    '{
    8'b10000001,
    8'b10110101,
    8'b10000101
    };
    parameter logic [7:0] seven [2:0]=
    '{
    8'b11110001,
    8'b11111101,
    8'b10000001
    };
    parameter logic [7:0] eight [2:0]=
    '{
    8'b10000001,
    8'b10110101,
    8'b10000001
    };
    parameter logic [7:0] nine [2:0]=
    '{
    8'b11110001,
    8'b11110101,
    8'b10000001
    };
    parameter logic [7:0] W_char [7:0]=
    '{
    8'b11000001,
    8'b11000001,
    8'b10111111,
    8'b11000001,
    8'b11000001,
    8'b10111111,
    8'b11000001,
    8'b11000001
    };
    parameter logic [7:0] L_char [7:0]=
    '{
    8'b11111111,
    8'b00111111,
    8'b00111111,
    8'b00111111,
    8'b00111111,
    8'b00111111,
    8'b00000001,
    8'b10000001
    };

    divfreq F0(CLK_div,CLK);
    divfreq2 F1(CLK_div2,CLK);
    divfreq3 F2(CLK_div3,CLK);
    divfreq4 F3(CLK_div4,CLK);

    initial begin
        com1=1;
        com2=1;
        com3=1;
        com4=1;
        beep=0;
        flag=0;
        flag2=0;
        flag3=0;
        enable=1;
        set=3'b000;
        t1=4'b1001;
        t2=4'b0000;
        DATA_R=8'b11111111;
        DATA_G=8'b11111111;
        DATA_B=8'b11111111;
        rand_num [0]=4'b0000;
        rand_num [1]=4'b0000;
        rand_num [2]=4'b0000;
        rand_num [3]=4'b0000;
        COM [2:0]=2'b00;
        {a,b,c,d,e,f,g}=7'b1111111;
        save_num=
        '{
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000
        };
        case (t1)
            4'b0000: t1_out=zero;
            4'b0001: t1_out=one;
            4'b0010: t1_out=two;
            4'b0011: t1_out=three;
            4'b0100: t1_out=four;
            4'b0101: t1_out=five;
            4'b0110: t1_out=six;
            4'b0111: t1_out=seven;
            4'b1000: t1_out=eight;
            4'b1001: t1_out=nine;
            default: t1_out=zero;
        endcase
        case (t2)
            4'b0000: t2_out=zero;
            4'b0001: t2_out=one;
            4'b0010: t2_out=two;
            4'b0011: t2_out=three;
            4'b0100: t2_out=four;
            4'b0101: t2_out=five;
            4'b0110: t2_out=six;
            4'b0111: t2_out=seven;
            4'b1000: t2_out=eight;
            4'b1001: t2_out=nine;
            default: t2_out=zero;
        endcase
    end

    always @(posedge CLK)
    begin
        if(!enter && num<=4'b1001 && flag && !flag3)
        begin
            case (choise)
                2'b00: save_num[0]=num;
                2'b01: save_num[1]=num;
                2'b10: save_num[2]=num;
                2'b11: save_num[3]=num;
            endcase
        end
        if(!start && !flag)
            flag=!flag;
        if(!flag)
        begin
            rand_num [0] = rand_num [0]+1;
            if(rand_num [0]>4'b1001)
                rand_num [0]=4'b0000;
        end
        if(enter2)
        begin
            s_com={save_num[3],save_num[2],save_num[1],save_num[0]};
            r_com={rand_num[3],rand_num[2],rand_num[1],rand_num[0]};
            if(s_com==r_com && !flag2)
            begin
                flag2=!flag2;
                beep=1;
            end
            else if(s_com>r_com)
            begin
                big=1;
                min=0;
            end
            else
            begin
                big=0;
                min=1;
            end
        end
    end

    always @(posedge CLK_div)
    begin
        if(!flag)
        begin
            rand_num [1] = rand_num [1]+1;
            if(rand_num [1]>4'b1001)
                rand_num [1]=4'b0000;
        end
    end

    always @(posedge CLK_div2)
    begin
        if(COM==2'b11)
            COM=2'b00;
        else
            COM=COM+1;
        case (save_num[COM])
            4'b0000: {a,b,c,d,e,f,g}=7'b0000001;
            4'b0001: {a,b,c,d,e,f,g}=7'b1001111;
            4'b0010: {a,b,c,d,e,f,g}=7'b0010010;
            4'b0011: {a,b,c,d,e,f,g}=7'b0000110;
            4'b0100: {a,b,c,d,e,f,g}=7'b1001100;
            4'b0101: {a,b,c,d,e,f,g}=7'b0100100;
            4'b0110: {a,b,c,d,e,f,g}=7'b0100000;
            4'b0111: {a,b,c,d,e,f,g}=7'b0001111;
            4'b1000: {a,b,c,d,e,f,g}=7'b0000000;
            4'b1001: {a,b,c,d,e,f,g}=7'b0000100;
            default: {a,b,c,d,e,f,g}=7'b1111111;
        endcase
        case (COM)
            2'b00:
            begin
                com1=0;
                com2=1;
                com3=1;
                com4=1;
            end
            2'b01:
            begin
                com1=1;
                com2=0;
                com3=1;
                com4=1;
            end
            2'b10:
            begin
                com1=1;
                com2=1;
                com3=0;
                com4=1;
            end
            2'b11:
            begin
                com1=1;
                com2=1;
                com3=1;
                com4=0;
            end
        endcase
        if(!flag)
        begin
            rand_num [2] = rand_num [2]+1;
            if(rand_num [2]>4'b1001)
                rand_num [2]=4'b0000;
        end
    end

    always @(posedge CLK_div3) begin
        if(!flag)
        begin
            rand_num [3] = rand_num [3]+1;
            if(rand_num [3]>4'b1001)
                rand_num [3]=4'b0000;
        end
    end

    always @(posedge CLK_div4) begin
        if(flag && !flag2)
        begin
            if (t1<=4'b0000 && t2<=4'b0000)
            begin
                t1=4'b0000;
                t2=4'b0000;
                flag3=1;
            end
            else if(t2<=4'b0000)
            begin
                t1=t1-1;
                t2=4'b1001;
            end
            else
                t2=t2-1;
            case (t1)
                4'b0000: t1_out=zero;
                4'b0001: t1_out=one;
                4'b0010: t1_out=two;
                4'b0011: t1_out=three;
                4'b0100: t1_out=four;
                4'b0101: t1_out=five;
                4'b0110: t1_out=six;
                4'b0111: t1_out=seven;
                4'b1000: t1_out=eight;
                4'b1001: t1_out=nine;
                default: t1_out=zero;
            endcase
            case (t2)
                4'b0000: t2_out=zero;
                4'b0001: t2_out=one;
                4'b0010: t2_out=two;
                4'b0011: t2_out=three;
                4'b0100: t2_out=four;
                4'b0101: t2_out=five;
                4'b0110: t2_out=six;
                4'b0111: t2_out=seven;
                4'b1000: t2_out=eight;
                4'b1001: t2_out=nine;
                default: t2_out=zero;
            endcase
        end
    end

    always @(posedge CLK_div2)
    begin
        if(set==3'b111)
            set=3'b000;
        else
            set=set+1;
        if(flag2)
        begin
            DATA_R=W_char[set];
            DATA_G=W_char[set];
            DATA_B=W_char[set];
        end
        else if(flag3)
        begin
            DATA_R=L_char[set];
            DATA_G=8'b11111111;
            DATA_B=8'b11111111;
        end
        else
        begin
            case (set)
                3'b000:
                begin
                    DATA_R=t1_out[2];
                    DATA_G=t1_out[2];
                    DATA_B=t1_out[2];
                end
                3'b001:
                begin
                    DATA_R=t1_out[1];
                    DATA_G=t1_out[1];
                    DATA_B=t1_out[1];
                end
                3'b010:
                begin
                    DATA_R=t1_out[0];
                    DATA_G=t1_out[0];
                    DATA_B=t1_out[0];
                end
                3'b011:
                begin
                    DATA_R=empty [0];
                    DATA_G=empty [0];
                    DATA_B=empty [0];
                end
                3'b100:
                begin
                    DATA_R=empty [1];
                    DATA_G=empty [1];
                    DATA_B=empty [1];
                end
                3'b101:
                begin
                    DATA_R=t2_out[2];
                    DATA_G=t2_out[2];
                    DATA_B=t2_out[2];
                end
                3'b110:
                begin
                    DATA_R=t2_out[1];
                    DATA_G=t2_out[1];
                    DATA_B=t2_out[1];
                end
                3'b111:
                begin
                    DATA_R=t2_out[0];
                    DATA_G=t2_out[0];
                    DATA_B=t2_out[0];
                end
            endcase
        end
    end
endmodule

module divfreq (output reg CLK_div,input CLK);
    reg[24:0] Count;
    always @(posedge CLK)
    begin
        if(Count>25)
            begin
                Count<=25'b0;
                CLK_div<=~CLK_div;
            end
        else
            Count <= Count+1'b1;
    end
endmodule

module divfreq2 (output reg CLK_div,input CLK);
    reg[24:0] Count;
    always @(posedge CLK)
    begin
        if(Count>2500)
            begin
                Count<=25'b0;
                CLK_div<=~CLK_div;
            end
        else
            Count <= Count+1'b1;
    end
endmodule

module divfreq3 (output reg CLK_div,input CLK);
    reg[24:0] Count;
    always @(posedge CLK)
    begin
        if(Count>250000)
            begin
                Count<=25'b0;
                CLK_div<=~CLK_div;
            end
        else
            Count <= Count+1'b1;
    end
endmodule

module divfreq4 (output reg CLK_div,input CLK);
    reg[24:0] Count;
    always @(posedge CLK)
    begin
        if(Count>25000000)
            begin
                Count<=25'b0;
                CLK_div<=~CLK_div;
            end
        else
            Count <= Count+1'b1;
    end
endmodule