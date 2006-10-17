Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <453447B2.000105.05297@bj126app48.126.com>
Date: Tue, 17 Oct 2006 11:02:10 +0800 (CST)
From: "device_driver" <device_driver@126.com>
To: "bluez development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] BGB204 Can't init device hci0: Connection timed out
 (110)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0665384356=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0665384356==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_giBpNvlDrxGdyfKfeIYTgwRUGrmf"


--Boundary-=_giBpNvlDrxGdyfKfeIYTgwRUGrmf
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hello, all
I'm using Philips(NXP)BGB204 bluetooth Sip under the Linux 2.6.9 kernel and ran into problems now. The scenario was as follows:

[root@trina zhangqh]# insmod bluetooth.ko
Using bluetooth.ko
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized

[root@trina zhangqh]# insmod hci_uart.ko
Using hci_uart.ko
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized

[root@trina zhangqh]# insmod l2cap.ko
Using l2cap.ko
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized

[root@trina zhangqh]# ./hciattach ttyS1 ericsson 115200 noflow
hci_uart_tty_open: tty c38ae000
hci_uart_tty_ioctl:
h4_open: hu c3dfac40
hci_uart_register_dev:
[root@trina zhangqh]# h4_recv: hu c3dfac40 count 1 rx_state 0 rx_count 0
h4_recv: Unknown HCI packet type 00

[root@trina zhangqh]# ./hciconfig
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:1 acl:0 sco:0 events:0 errors:1
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

[root@trina zhangqh]# ./hciconfig hci0 up
hci_uart_open: hci0 c0343c00
hci_uart_send_frame: hci0: type 1 len 3
h4_enqueue: hu c3dfac40 skb c396eb80
hci_uart_tx_wakeup:
hci_uart_tty_wakeup:
h4_recv: hu c3dfac40 count 1 rx_state 0 rx_count 0
h4_recv: Unknown HCI packet type 80
h4_recv: hu c3dfac40 count 1 rx_state 0 rx_count 0
h4_recv: SCO packet
h4_recv: hu c3dfac40 count 1 rx_state 3 rx_count 3
hci_uart_tx_wakeup:
h4_recv: hu c3dfac40 count 1 rx_state 3 rx_count 2
hci_uart_flush: hdev c0343c00 tty c38ae000
h4_flush: hu c3dfac40
hci_uart_close: hdev c0343c00
hci_uart_flush: hdev c0343c00 tty c38ae000
h4_flush: hu c3dfac40
Can't init device hci0: Connection timed out (110)

I searched in hciconfig.c and found this error was caused by ioctl(ctl, HCIDEVUP, hdev) when hciconfig up the hci0. Then who could tell me what is wrong during the procedure or give me a hint?

Thank you in advance

Qinghua



  
--Boundary-=_giBpNvlDrxGdyfKfeIYTgwRUGrmf
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<div>Hello, all<br>I'm using Philips(NXP)BGB204 bluetooth Sip under the L=
inux 2.6.9 kernel and ran into problems now. The scenario was as follows:=
<br><br></div><div>[root@trina zhangqh]# insmod bluetooth.ko<br>Using blu=
etooth.ko<br>Bluetooth: Core ver 2.6<br>NET: Registered protocol family 3=
1<br>Bluetooth: HCI device and connection manager initialized<br>Bluetoot=
h: HCI socket layer initialized<br><br>[root@trina zhangqh]# insmod hci_u=
art.ko<br>Using hci_uart.ko<br>Bluetooth: HCI UART driver ver 2.1<br>Blue=
tooth: HCI H4 protocol initialized<br><br>[root@trina zhangqh]# insmod l2=
cap.ko<br>Using l2cap.ko<br>Bluetooth: L2CAP ver 2.4<br>Bluetooth: L2CAP =
socket layer initialized<br><br>[root@trina zhangqh]# ./hciattach ttyS1 e=
ricsson 115200 noflow<br>hci_uart_tty_open: tty c38ae000<br>hci_uart_tty_=
ioctl:<br>h4_open: hu c3dfac40<br>hci_uart_register_dev:<br>[root@trina z=
hangqh]# h4_recv: hu c3dfac40 count 1 rx_state 0 rx_count 0<br>h4_recv: U=
nknown HCI packet type 00<br><br>[root@trina zhangqh]# ./hciconfig<br>hci=
0:&nbsp;&nbsp; Type: UART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B=
D Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; RX bytes:1 acl:0 sco:0 events:0 errors:1<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; TX bytes:0 acl:0 sco:0 commands:0 errors:0<br><br>[ro=
ot@trina zhangqh]# ./hciconfig hci0 up<br>hci_uart_open: hci0 c0343c00<br=
>hci_uart_send_frame: hci0: type 1 len 3<br>h4_enqueue: hu c3dfac40 skb c=
396eb80<br>hci_uart_tx_wakeup:<br>hci_uart_tty_wakeup:<br>h4_recv: hu c3d=
fac40 count 1 rx_state 0 rx_count 0<br>h4_recv: Unknown HCI packet type 8=
0<br>h4_recv: hu c3dfac40 count 1 rx_state 0 rx_count 0<br>h4_recv: SCO p=
acket<br>h4_recv: hu c3dfac40 count 1 rx_state 3 rx_count 3<br>hci_uart_t=
x_wakeup:<br>h4_recv: hu c3dfac40 count 1 rx_state 3 rx_count 2<br>hci_ua=
rt_flush: hdev c0343c00 tty c38ae000<br>h4_flush: hu c3dfac40<br>hci_uart=
_close: hdev c0343c00<br>hci_uart_flush: hdev c0343c00 tty c38ae000<br>h4=
_flush: hu c3dfac40<br>Can't init device hci0: Connection timed out (110)=
<br><br>I searched in hciconfig.c and found this error was caused by ioct=
l(ctl, HCIDEVUP, hdev) when hciconfig up the hci0. Then who could tell me=
 what is wrong during the procedure or give me a hint?<br><br>Thank you i=
n advance<br><br>Qinghua<br><br><br><br></div><div>&nbsp;</div><div>&nbsp=
;</div><div id=3D"spnSign"></div><br><!-- footer --><br><br><br><br><br><=
div style=3D"border-bottom:1px solid #999"></div><br>=0A=0A=09<font color=
=3D"black" style=3D"font-size:14.8px">=BC=AB =C6=B7 =C3=C0 =C5=AE =B5=E4 =
=B2=D8 ( =B6=E0 =CD=BC ) </font>=0A=09<br>=0A=09 <a href=3D"http://adtaob=
ao.allyes.com/main/adfclick?db=3Dadtaobao&bid=3D600,597,58&cid=3D30015,19=
8,1&sid=3D32501&show=3Dignore&url=3Dhttp://www.taobao.com/vertical/under_=
wear.php" target=3D"_blank" style=3D"font-size:13px;line-height:160%;colo=
r:blue">=BE=F8 =B6=D4 =D5=E6 =CA=B5 ! =C0=CF =C6=C5 =D7=F2 =CD=ED =BA=DC =
=C1=ED =C0=E0 , =B4=F3 =BC=D2 =BF=B4 =BF=B4 =CB=FD =CA=C7 =C9=B6 =D1=F9 (=
 =D7=E9 =CD=BC )</a>=0A=0A
--Boundary-=_giBpNvlDrxGdyfKfeIYTgwRUGrmf--


--===============0665384356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0665384356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0665384356==--
