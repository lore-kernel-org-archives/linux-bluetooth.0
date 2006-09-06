Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <44FE86EC.000014.12930@bj163app52.163.com>
Date: Wed, 6 Sep 2006 16:29:32 +0800 (CST)
From: "chenjian" <ustcchenjian@163.com>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] hciemu lost its interface after I run att est
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1601063865=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1601063865==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_ncFgLLjnEClZFODvXEQukbVQtmSV"


--Boundary-=_ncFgLLjnEClZFODvXEQukbVQtmSV
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

hi guy, I experienced one issue, can anybody help? thanks!

1. setup 2 virtual hci interface hci0 and hci1
hciemu localhost:1000
hciemu localhost:2000
linux-l20w:~ # hciconfig
hci0:   Type: VHCI
        BD Address: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:15 errors:0
        TX bytes:569 acl:0 sco:0 commands:15 errors:0

hci1:   Type: VHCI
        BD Address: 7F:00:00:01:07:D0 ACL MTU: 192:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:15 errors:0
        TX bytes:569 acl:0 sco:0 commands:15 errors:0

2. run attest
attest 7F:00:00:01:03:E8 10
the $? is equal 0
linux-l20w:~ # attest 7F:00:00:01:03:E8 10
Connecting to 7F:00:00:01:03:E8 on channel 10
linux-l20w:~ # echo $?
0
Everything is OK until now.

3. But hci1 is lost
But take a look at this:
linux-l20w:~ # hciconfig
hci0:   Type: VHCI
        BD Address: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:15 sco:0 events:22 errors:0
        TX bytes:797 acl:12 sco:0 commands:18 errors:0
hci1 is lost.

Otherinfo:
linux-l20w:~ # uname -r
2.6.16.21-38-smp

--Boundary-=_ncFgLLjnEClZFODvXEQukbVQtmSV
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

hi guy, I experienced one issue, can anybody help? thanks!<br><br>1. setu=
p 2 virtual hci interface hci0 and hci1<br>hciemu localhost:1000<br>hciem=
u localhost:2000<br>linux-l20w:~ # hciconfig<br>hci0:   Type: VHCI<br>   =
     BD Address: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0<br>      =
  UP RUNNING PSCAN ISCAN<br>        RX bytes:0 acl:0 sco:0 events:15 erro=
rs:0<br>        TX bytes:569 acl:0 sco:0 commands:15 errors:0<br><br>hci1=
:   Type: VHCI<br>        BD Address: 7F:00:00:01:07:D0 ACL MTU: 192:8 SC=
O MTU: 64:0<br>        UP RUNNING PSCAN ISCAN<br>        RX bytes:0 acl:0=
 sco:0 events:15 errors:0<br>        TX bytes:569 acl:0 sco:0 commands:15=
 errors:0<br><br>2. run attest<br>attest 7F:00:00:01:03:E8 10<br>the $? i=
s equal 0<br>linux-l20w:~ # attest 7F:00:00:01:03:E8 10<br>Connecting to =
7F:00:00:01:03:E8 on channel 10<br>linux-l20w:~ # echo $?<br>0<br>Everyth=
ing is OK until now.<br><br>3. But hci1 is lost<br>But take a look at thi=
s:<br>linux-l20w:~ # hciconfig<br>hci0:   Type: VHCI<br>        BD Addres=
s: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0<br>        UP RUNNING P=
SCAN ISCAN<br>        RX bytes:0 acl:15 sco:0 events:22 errors:0<br>     =
   TX bytes:797 acl:12 sco:0 commands:18 errors:0<br>hci1 is lost.<br><br=
>Otherinfo:<br>linux-l20w:~ # uname -r<br>2.6.16.21-38-smp<br><br><!-- fo=
oter --><br><br><br><br><br><div style=3D"border-bottom:1px solid #999"><=
/div><br>=0A=0A=09<font color=3D"black" style=3D"font-size:14.8px">=D3=CA=
 =CF=E4 =BB=FD =B7=D6=A3=AC=BB=BB =D2=D7 =C8=A4 =CF=D6 =BD=F0 =B9=BA =CE=EF=
 =C8=AF</font> =0A=09<br>=0A=09 <a href=3D"http://adfarm.mediaplex.com/ad=
/ck/4080-41738-9511-6?cn=3Dnetease;textlink0822;pr;mailcoupon&mpro=3Dhttp=
://minisite.163.com/2006/0815/ebay/coupon.htm" target=3D"_blank" style=3D=
"font-size:13px;line-height:160%;color:blue">30 =D3=CA =CF=E4 =BB=FD =B7=D6=
 =3D =CF=D6 =BD=F0 30 =D4=AA , 50 =D4=AA , 99 =D4=AA   =C1=A2 =BF=CC =B6=D2=
 =BB=BB > >=0A</a>=0A=0A
--Boundary-=_ncFgLLjnEClZFODvXEQukbVQtmSV--


--===============1601063865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1601063865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1601063865==--
