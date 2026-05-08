`timescale 1ns / 1ps
module FSM_1011_tb();
       reg CLK;
       reg reset_n;
       reg data;
       wire match;
FSM_1011 FSM_1011_inst(
       .CLK(CLK),
       .reset_n(reset_n),
       .data(data),
       .match(match)
);
initial CLK=1;
always #10 CLK=~CLK;
initial begin
reset_n=0;
data=0;
#50;
reset_n=1;
#10;
 // 第一次检测 1011
@(posedge CLK) #2; data = 1;
@(posedge CLK) #2; data = 0;
@(posedge CLK) #2; data = 1;
@(posedge CLK) #2; data = 1;
// 发送 011（不重叠）
@(posedge CLK) #2; data = 0;
@(posedge CLK) #2; data = 1;
@(posedge CLK) #2; data = 1;
// 第二次检测，验证重叠或复位后检测
@(posedge CLK) #2; data = 1;
@(posedge CLK) #2; data = 0;
@(posedge CLK) #2; data = 1;
@(posedge CLK) #2; data = 1;  
#200;
$stop;
end
endmodule
