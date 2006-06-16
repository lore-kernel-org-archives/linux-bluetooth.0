Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <4492B250.000111.26041@bj163app70.163.com>
Date: Fri, 16 Jun 2006 21:29:52 +0800 (CST)
From: "chenjian" <ustcchenjian@163.com>
To: bluez-users@lists.sourceforge.net
References: <mailman.0.1150463548.25144.bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.0.1150463548.25144.bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] l2ping issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1895944710=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1895944710==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_nnEQOaRbipNUjxWMiqWrfIxymheI"


--Boundary-=_nnEQOaRbipNUjxWMiqWrfIxymheI
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

hi guys, I have 2 issues with l2ping. bluz version is as the following:
rpm info:

linux-l20w:~ # rpm -qa|grep bluez

bluez-utils-2.24-17

bluez-libs-2.24-10

1. l2ping failed to ping itself
linux-l20w:~ # hciconfig
hci0:   Type: USB
        BD Address: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:5545 acl:3 sco:0 events:193 errors:0
        TX bytes:4482 acl:3 sco:0 commands:168 errors:0

linux-l20w:~ # lsmod|grep -E "l2cap|rfcomm|bcm203x"
rfcomm                 32408  5
l2cap                  20740  14 hidp,bnep,rfcomm
bluetooth              41188  10 hidp,bnep,rfcomm,l2cap,hci_vhci,hci_usb
linux-l20w:~ # l2ping 00:0E:9B:DD:E4:D1
Can't connect: No route to host

Is this normal or correct?

2. I can run hciemu to emulate a faked bluetooth device, but the l2ping still failed. Is that normal or correct?
linux-l20w:~ # modprobe hci_vhci
linux-l20w:~ # ls /dev/vhci -l
crw-rw---- 1 root root 10, 62 Jun 15 07:51 /dev/vhci
linux-l20w:~ # hciemu 00:0E:9B:DD:E4:D2
linux-l20w:~ # hciconfig
hci0:   Type: USB
        BD Address: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:203 acl:0 sco:0 events:28 errors:0
        TX bytes:876 acl:0 sco:0 commands:28 errors:0

hci1:   Type: VHCI
        BD Address: 00:0E:9B:DD:E4:D2 ACL MTU: 192:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:15 errors:0
        TX bytes:569 acl:0 sco:0 commands:15 errors:0

linux-l20w:~ # l2ping  00:0E:9B:DD:E4:D2
Can't connect: Host is down


--Boundary-=_nnEQOaRbipNUjxWMiqWrfIxymheI
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

hi guys, I have 2 issues with l2ping. bluz version is as the following:<b=
r>rpm info:<br>
linux-l20w:~ # rpm -qa|grep bluez<br>
bluez-utils-2.24-17<br>
bluez-libs-2.24-10<br><br>1. l2ping failed to ping itself<br>linux-l20w:~=
 # hciconfig<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; BD Address: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 1=
6:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:5545 acl:3 sco:0 e=
vents:193 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes=
:4482 acl:3 sco:0 commands:168 errors:0<br><br>linux-l20w:~ # lsmod|grep =
-E "l2cap|rfcomm|bcm203x"<br>rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32408&nbsp; 5<=
br>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20740&nbsp; 14 hidp,bnep,rfcomm<br>=
bluetooth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 41188&nbsp; 10 hidp,bnep,rfcomm,l2cap,hci_vhci,hci_usb<br>=
linux-l20w:~ # l2ping 00:0E:9B:DD:E4:D1<br>Can't connect: No route to hos=
t<br><br>Is this normal or correct?<br><br>2. I can run hciemu to emulate=
 a faked bluetooth device, but the l2ping still failed. Is that normal or=
 correct?<br>linux-l20w:~ # modprobe hci_vhci<br>linux-l20w:~ # ls /dev/v=
hci -l<br>crw-rw---- 1 root root 10, 62 Jun 15 07:51 /dev/vhci<br>linux-l=
20w:~ # hciemu 00:0E:9B:DD:E4:D2<br>linux-l20w:~ # hciconfig<br>hci0:&nbs=
p;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Addre=
ss: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 16:0<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; RX bytes:203 acl:0 sco:0 events:28 errors:0<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:876 acl:0 sco:0 commands:2=
8 errors:0<br><br>hci1:&nbsp;&nbsp; Type: VHCI<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; BD Address: 00:0E:9B:DD:E4:D2 ACL MTU: 192:8 SCO MTU:=
 64:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCA=
N<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 ev=
ents:15 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:5=
69 acl:0 sco:0 commands:15 errors:0<br><br>linux-l20w:~ # l2ping&nbsp; 00=
:0E:9B:DD:E4:D2<br>Can't connect: Host is down<br><br><br><!-- footer -->=
<br><br><br><br><br><div style=3D"border-bottom:1px solid #999"></div><br=
>

=09<font color=3D"black" style=3D"font-size:14.8px">=C4=E3 =B2=BB =CF=EB =
=CA=D4 =CA=D4 =BD=F1 =CF=C4 =D7=EE =A1=B0=BF=E1=A1=B1 =B5=C4 =D3=CA =CF=E4=
 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=D4=CC =BA=AD =D6=D0 =BB=AA =B4=AB =CD=B3=
 =CE=C4 =BB=AF =D3=DA =CA=C0 =BD=E7 =D2=BB =C1=F7 =BF=C6 =BC=BC =D6=AE =D6=
=D0=A3=AC=B4=B4 =D0=C2 Ajax =BC=BC =CA=F5=A3=AC126 =A1=B0D =BC=C6 =BB=AE=A1=
=B1=BB=F0 =C8=C8 =CC=E5 =D1=E9 =D6=D0 =A3=A1
</a>


--Boundary-=_nnEQOaRbipNUjxWMiqWrfIxymheI--


--===============1895944710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1895944710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1895944710==--
