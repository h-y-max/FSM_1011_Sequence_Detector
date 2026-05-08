module FSM_1011(
       input CLK,
       input reset_n,
       input data,
       output reg match
    );
       reg [4:0] state1;
       reg [4:0] state2;
       reg data_1;
       reg data_2;
       localparam IDLE=5'b00001;
       localparam check_1a=5'b00010;
       localparam check_0=5'b00100;
       localparam check_1b=5'b01000;
       localparam check_1c=5'b10000;
//打拍
always@(posedge CLK)
     data_1<=data;
always@(posedge CLK)
     data_2<=data_1;
//第一段
always@(posedge CLK or negedge reset_n)
        if(!reset_n)
             state1<=IDLE;
        else
             state1<=state2;
//第二段
always@(*)begin
     state2=state1;
     case(state1)
         IDLE:
            if(data_2==1)
                state2=check_1a;
          check_1a:
             if(data_2==0)
                 state2=check_0;
          check_0:
              if(data_2==1)
                 state2=check_1b;
              else
                 state2=IDLE;
          check_1b:
              if(data_2==1)
                 state2=check_1c;
              else
                 state2=check_0;
          check_1c:
              if(data_2==1)
                 state2=check_1a;
              else
                 state2=check_0;
        default:state2=IDLE;
     endcase
  end
//第三段
always@(posedge CLK or negedge reset_n)
       if(!reset_n)
           match<=0;
       else if((state2==check_1b) && (data_2==1))
           match<=1'd1;
       else
           match<=0;
endmodule
