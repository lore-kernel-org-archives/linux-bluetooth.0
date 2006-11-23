Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 23 Nov 2006 22:36:30 +0100
From: Michel Leconte <leconte.michel@cegetel.net>
To: bluez-users@lists.sourceforge.net
Message-id: <002b01c70f47$70ba4a20$27b44856@claudia>
MIME-version: 1.0
Subject: [Bluez-users] Change the uart baud rate for Semtech-Xemics kit
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0568173789=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0568173789==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_KhJRIqIyIhoAGAptj0iSxg)"

This is a multi-part message in MIME format.

--Boundary_(ID_KhJRIqIyIhoAGAptj0iSxg)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

Hi all,

I write a small function to modify the uart baud rate at the setup of the link between the stack bluez 
and the chip bluetooth. This function is highly inspired from functions in the hciattach.c file 
thanks to marcel. This function is specific to the development kit of Semtech-Xemics based on the
SX1441 (bluetooth v1.2).

I don't know if that can be usefull but I send you the output of the "diff"
command between the original hciattach.c and thus modified.

regards.

Michel  


------------------ output of the diff command --------------------------------

804a805,900
> 
> 
> 
> 
> 
> /*
>  * Specific initialization for semtech-xemics
>  * development kit based on the SX1441 Bluetooth v1.2
>  * 
>  */
> static int xemics(int fd, struct uart_t *u, struct termios *ti)
> {
>  struct timespec tm = {0, 50000};
>  char cmd[13];
>   
>  
>  
>  cmd[0] = HCI_COMMAND_PKT;
>  cmd[1] = 0x0b;   // OCF = Hci_Cmd_xemics_Set_Uart_Baud_Rate
>  cmd[2] = 0xfc;   // OGF = Vendor specific
>  cmd[3] = 0x09;
>  cmd[4] = 0x08;   
>  cmd[5] = 0x02;   
>  cmd[6] = 0x00;
>  
>  
>  
>  /* Xemics set baud rate command */ 
>  /*   BaudRate cmd[7]---cmd[10]
>  /* 115200 = 0x01C200
>   230400 = 0x038400
>   460800 = 0x070800
>   921600 = 0x0E1000 
>   
>   Important : cmd[7] = LSB first        */
>   
>  
>  switch (u->speed) {
>  
>  case 115200:
>   cmd[7] = 0x00 ;
>   cmd[8] = 0xC2;
>   cmd[9] = 0x01;
>   cmd[10] = 0x00 ;
>   
>   break;
>  case 230400:
>   cmd[7] = 0x00 ;
>   cmd[8] = 0x84;
>   cmd[9] = 0x03;
>   cmd[10] = 0x00 ;
>   break;
>  case 460800:
>   cmd[7] = 0x00;
>   cmd[8] = 0x08;
>   cmd[9] = 0x07;
>   cmd[10] = 0x00;
>   break;
>  case 921600:
>   cmd[7] = 0x00;
>   cmd[8] = 0x10;
>   cmd[9] = 0x0E;
>   cmd[10] = 0x00 ;
>   break;
>  default:
>   cmd[7] = 0x00 ;
>   cmd[8] = 0xC2;
>   cmd[9] = 0x01;
>   cmd[10] = 0x00 ;
>   
>   u->speed = 115200;
>   break;
>  }
>  
>    
>  cmd[11] = 0xb1;   
>  cmd[12] = 0x03;
> 
>  
>  /* Send  uart rate */
>  if (write(fd, cmd, 13) != 13) {
>   perror("Can't write reset cmd.");
>   return -1;
>  }
> 
>  nanosleep(&tm, NULL);
> 
> 
> 
>  
>  return 0;
> }
> 
> 
> 
> 
857a954,957
>  /* Semtech Xemics development kit  based on the SX1441 (bluetooth chip v1.2) */
>  { "xemics",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL , xemics   },
>  
>   

--Boundary_(ID_KhJRIqIyIhoAGAptj0iSxg)
Content-type: text/html; charset=iso-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2>Hi all,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I write a small function to modify the uart baud 
rate at the setup of the link between the stack bluez <BR>and the chip 
bluetooth. This function is highly inspired from functions in the hciattach.c 
file <BR>thanks to marcel. This function is specific to the development kit of 
Semtech-Xemics based on the<BR>SX1441 (bluetooth v1.2).</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I don't know if that can be usefull but I send you 
the output of the "diff"<BR>command between the original hciattach.c and thus 
modified.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>regards.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Michel&nbsp; </FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=Arial size=2>
<DIV><BR>------------------ output of the diff command 
--------------------------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>804a805,900<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; 
/*<BR>&gt;&nbsp; * Specific initialization for semtech-xemics<BR>&gt;&nbsp; * 
development kit based on the SX1441 Bluetooth v1.2<BR>&gt;&nbsp; * 
<BR>&gt;&nbsp; */<BR>&gt; static int xemics(int fd, struct uart_t *u, struct 
termios *ti)<BR>&gt; {<BR>&gt; &nbsp;struct timespec tm = {0, 50000};<BR>&gt; 
&nbsp;char cmd[13];<BR>&gt; &nbsp;&nbsp;<BR>&gt; &nbsp;<BR>&gt; &nbsp;<BR>&gt; 
&nbsp;cmd[0] = HCI_COMMAND_PKT;<BR>&gt; &nbsp;cmd[1] = 0x0b;&nbsp;&nbsp;&nbsp;// 
OCF = Hci_Cmd_xemics_Set_Uart_Baud_Rate<BR>&gt; &nbsp;cmd[2] = 
0xfc;&nbsp;&nbsp;&nbsp;// OGF = Vendor specific<BR>&gt; &nbsp;cmd[3] = 
0x09;<BR>&gt; &nbsp;cmd[4] = 0x08;&nbsp;&nbsp;&nbsp;<BR>&gt; &nbsp;cmd[5] = 
0x02;&nbsp;&nbsp;&nbsp;<BR>&gt; &nbsp;cmd[6] = 0x00;<BR>&gt; &nbsp;<BR>&gt; 
&nbsp;<BR>&gt; &nbsp;<BR>&gt; &nbsp;/* Xemics set baud rate command 
*/&nbsp;<BR>&gt; &nbsp;/*&nbsp;&nbsp; BaudRate cmd[7]---cmd[10]<BR>&gt; 
&nbsp;/*&nbsp;115200 = 0x01C200<BR>&gt; &nbsp;&nbsp;230400 = 0x038400<BR>&gt; 
&nbsp;&nbsp;460800 = 0x070800<BR>&gt; &nbsp;&nbsp;921600 = 0x0E1000 <BR>&gt; 
&nbsp;&nbsp;<BR>&gt; &nbsp;&nbsp;Important : cmd[7] = LSB 
first&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<BR>&gt; &nbsp;&nbsp;<BR>&gt; 
&nbsp;<BR>&gt; &nbsp;switch (u-&gt;speed) {<BR>&gt; &nbsp;<BR>&gt; &nbsp;case 
115200:<BR>&gt; &nbsp;&nbsp;cmd[7] = 0x00 ;<BR>&gt; &nbsp;&nbsp;cmd[8] = 
0xC2;<BR>&gt; &nbsp;&nbsp;cmd[9] = 0x01;<BR>&gt; &nbsp;&nbsp;cmd[10] = 0x00 
;<BR>&gt; &nbsp;&nbsp;<BR>&gt; &nbsp;&nbsp;break;<BR>&gt; &nbsp;case 
230400:<BR>&gt; &nbsp;&nbsp;cmd[7] = 0x00 ;<BR>&gt; &nbsp;&nbsp;cmd[8] = 
0x84;<BR>&gt; &nbsp;&nbsp;cmd[9] = 0x03;<BR>&gt; &nbsp;&nbsp;cmd[10] = 0x00 
;<BR>&gt; &nbsp;&nbsp;break;<BR>&gt; &nbsp;case 460800:<BR>&gt; 
&nbsp;&nbsp;cmd[7] = 0x00;<BR>&gt; &nbsp;&nbsp;cmd[8] = 0x08;<BR>&gt; 
&nbsp;&nbsp;cmd[9] = 0x07;<BR>&gt; &nbsp;&nbsp;cmd[10] = 0x00;<BR>&gt; 
&nbsp;&nbsp;break;<BR>&gt; &nbsp;case 921600:<BR>&gt; &nbsp;&nbsp;cmd[7] = 
0x00;<BR>&gt; &nbsp;&nbsp;cmd[8] = 0x10;<BR>&gt; &nbsp;&nbsp;cmd[9] = 
0x0E;<BR>&gt; &nbsp;&nbsp;cmd[10] = 0x00 ;<BR>&gt; &nbsp;&nbsp;break;<BR>&gt; 
&nbsp;default:<BR>&gt; &nbsp;&nbsp;cmd[7] = 0x00 ;<BR>&gt; &nbsp;&nbsp;cmd[8] = 
0xC2;<BR>&gt; &nbsp;&nbsp;cmd[9] = 0x01;<BR>&gt; &nbsp;&nbsp;cmd[10] = 0x00 
;<BR>&gt; &nbsp;&nbsp;<BR>&gt; &nbsp;&nbsp;u-&gt;speed = 115200;<BR>&gt; 
&nbsp;&nbsp;break;<BR>&gt; &nbsp;}<BR>&gt; &nbsp;<BR>&gt; 
&nbsp;&nbsp;&nbsp;<BR>&gt; &nbsp;cmd[11] = 0xb1;&nbsp;&nbsp;&nbsp;<BR>&gt; 
&nbsp;cmd[12] = 0x03;<BR>&gt; <BR>&gt; &nbsp;<BR>&gt; &nbsp;/* Send&nbsp; uart 
rate */<BR>&gt; &nbsp;if (write(fd, cmd, 13) != 13) {<BR>&gt; 
&nbsp;&nbsp;perror("Can't write reset cmd.");<BR>&gt; &nbsp;&nbsp;return 
-1;<BR>&gt; &nbsp;}<BR>&gt; <BR>&gt; &nbsp;nanosleep(&amp;tm, NULL);<BR>&gt; 
<BR>&gt; <BR>&gt; <BR>&gt; &nbsp;<BR>&gt; &nbsp;return 0;<BR>&gt; }<BR>&gt; 
<BR>&gt; <BR>&gt; <BR>&gt; <BR>857a954,957<BR>&gt; &nbsp;/* Semtech Xemics 
development kit&nbsp; based on the SX1441 (bluetooth chip v1.2) */<BR>&gt; 
&nbsp;{ "xemics",&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000, 0x0000, 
HCI_UART_H4,&nbsp;&nbsp; 115200, 115200, FLOW_CTL , xemics&nbsp;&nbsp; 
},<BR>&gt; &nbsp;<BR>&gt; &nbsp; <BR></FONT></DIV></BODY></HTML>

--Boundary_(ID_KhJRIqIyIhoAGAptj0iSxg)--


--===============0568173789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0568173789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0568173789==--
