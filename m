Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <dcbc35340702131508m11f35e92hb912ccc1a3d087a0@mail.gmail.com>
Date: Tue, 13 Feb 2007 23:08:32 +0000
From: "=?ISO-8859-1?Q?Paulo_Gon=E7alves?=" <paf.goncalves@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] help installing bluez 3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2046370265=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2046370265==
Content-Type: multipart/alternative;
	boundary="----=_Part_110952_7077561.1171408112248"

------=_Part_110952_7077561.1171408112248
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

I just installed bluez 3.9 (patched the kernel and build the modules,
installed bluez-libs-3.9 and bluez-utils-3.9)
but i can't find the script to start|stop|restart the service
(/etc/init.d/bluetooth).
Where can I find it ?

After i finish the instalation i checked that the modules ware loaded:
root@xxxx:~/bluez-utils-3.9# lsmod
Module                  Size  Used by    Not tainted
bnep                    8020   0  (autoclean)
l2cap                  15120   0  (autoclean) [bnep]
hci_usb                 8376   0  (unused)
bluez                  27812   1  [bnep l2cap hci_usb]

so i run hciconfig:
root@xxxx:/etc/bluetooth# /usr/sbin/hciconfig -a
hci0:   Type: USB
 BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
 DOWN
 RX bytes:0 acl:0 sco:0 events:0 errors:0
 TX bytes:0 acl:0 sco:0 commands:0 errors:0

but where is the BD Address ?
and all the other data that i saw in some examples

then i run the pan daemon:
root@dell:/etc/bluetooth# pand -s -M --role=3DNAP -n
pand[18321]: Bluetooth PAN daemon version 3.9
pand[18321]: Failed to connect to the local SDP server. No such file or
directory(2)

is this error normal ?

I hope someone can help me.
Thanks,

    Paulo Gon=E7alves


PS: output from 'cat /proc/bus/usb/devices':
D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0df6 ProdID=3D2200 Rev=3D19.58
S:  Product=3DSitecom USB bluetooth2.0 class 2 dongle CN-512

------=_Part_110952_7077561.1171408112248
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi!</div>
<div>&nbsp;</div>
<div>I just installed bluez 3.9 (patched the kernel and build the modules, =
installed bluez-libs-3.9 and bluez-utils-3.9) </div>
<div>but i can&#39;t find the script to start|stop|restart the service (/et=
c/init.d/bluetooth).</div>
<div>Where can I find it ?</div>
<div>&nbsp;</div>
<div>After i finish the instalation i checked that the modules ware loaded:=
</div>
<div><a href=3D"mailto:root@xxxx:~/bluez-utils-3.9">root@xxxx:~/bluez-utils=
-3.9</a># lsmod<br>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by&nbs=
p;&nbsp;&nbsp; Not tainted<br>bnep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8=
020&nbsp;&nbsp; 0&nbsp; (autoclean)<br>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 151=
20&nbsp;&nbsp; 0&nbsp; (autoclean) [bnep]
<br>hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8376&nbsp;&nbsp; 0&nbsp; (unused)<br>bluez=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 27812&nbsp;&nbsp; 1&nbsp; [bnep l2cap hci_usb]<=
/div>
<div>&nbsp;</div>
<div>so i run hciconfig:</div>
<div><a href=3D"mailto:root@xxxx:/etc/bluetooth">root@xxxx:/etc/bluetooth</=
a># /usr/sbin/hciconfig -a&nbsp;&nbsp;&nbsp; <br>hci0:&nbsp;&nbsp; Type: US=
B<br>&nbsp;BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&nbsp=
;DOWN <br>&nbsp;RX bytes:0 acl:0 sco:0 events:0 errors:0
<br>&nbsp;TX bytes:0 acl:0 sco:0 commands:0 errors:0</div>
<div>&nbsp;</div>
<div>but where is the BD Address ?</div>
<div>and all the other data that i saw in&nbsp;some examples</div>
<div>&nbsp;</div>
<div>then i run the pan daemon:</div>
<div><a href=3D"mailto:root@dell:/etc/bluetooth">root@dell:/etc/bluetooth</=
a># pand -s -M --role=3DNAP -n<br>pand[18321]: Bluetooth PAN daemon version=
 3.9<br>pand[18321]: Failed to connect to the local SDP server. No such fil=
e or directory(2)
</div>
<div>&nbsp;</div>
<div>is this error normal ?</div>
<div>&nbsp;</div>
<div>I hope someone can help me.</div>
<div>Thanks,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; Paulo Gon=E7alves</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>PS: output from &#39;cat /proc/bus/usb/devices&#39;:</div>
<div>D:&nbsp; Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfg=
s=3D&nbsp; 1<br>P:&nbsp; Vendor=3D0df6 ProdID=3D2200 Rev=3D19.58<br>S:&nbsp=
; Product=3DSitecom USB bluetooth2.0 class 2 dongle CN-512</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_110952_7077561.1171408112248--


--===============2046370265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2046370265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2046370265==--
