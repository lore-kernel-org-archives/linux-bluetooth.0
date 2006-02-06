Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0602051826l2c9bc25etfbff44299ca973e@mail.gmail.com>
From: zhu yong <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
In-Reply-To: <f64f4e8a0602022121kdc8f547x2cf56a4df9b549dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24948_25015580.1139192815609"
References: <f64f4e8a0602012031sba6af2aj1db7633e9865de91@mail.gmail.com>
	 <f64f4e8a0602022121kdc8f547x2cf56a4df9b549dd@mail.gmail.com>
Subject: [Bluez-devel] help me! bluetooth usb dongle can not up in uclinux 2.24.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 6 Feb 2006 10:26:55 +0800

------=_Part_24948_25015580.1139192815609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,everyone
     I want to use my bluetooth usb dongle in my s3c44b0x board. system is
uclinux 2.24.
     I use "hciconfig" command, it can find the devices, info as follows
     "# ./hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:12 acl:0 sco:0 events:0 errors:0
        TX bytes:9 acl:0 sco:0 commands:3 errors:0"
     but, I use "hciconfig hci0 up", it timeout, info as follows
     "Can't init device hci0: Connection timed out (110)"
     I find I have no "devices" file in "/proc/bus/usb" directory.
     so I mount it use "mount -t usbdevfs none /proc/bus/usb" command. but =
I
still can not up the devices.
     I post the info of "cat /proc/bus/usb/devices ", any suggestion is
help!
    "# cat /proc/bus/usb/devices
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 1
B:  Alloc=3D  0/900 us ( 0), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB SL811HS Root Hub
S:  SerialNumber=3D0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D16 #Cfgs=3D  1
P:  Vendor=3D1131 ProdID=3D1001 Rev=3D 3.73
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)
# "

------=_Part_24948_25015580.1139192815609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"><br></span>
<div><span class=3D"e" id=3D"q_1092e5b3be0a2242_0"><span class=3D"gmail_quo=
te"><br></span>
<div>hi,everyone</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I want to use my bluetooth usb dongle in my s=
3c44b0x board. system is uclinux 2.24.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I use &quot;hciconfig&quot; command, it can f=
ind the devices, info as follows</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; &quot;# ./hciconfig<br>hci0:&nbsp;&nbsp; Type=
: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00=
:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DOWN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:12 acl:0 sc=
o:0 events:0 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX byte=
s:9 acl:0 sco:0 commands:3 errors:0&quot;=20
</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; but, I use &quot;hciconfig hci0 up&quot;, it =
timeout, info as follows</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; &quot;Can't init device hci0: Connection time=
d out (110)&quot;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I find I have no &quot;devices&quot; file in =
&quot;/proc/bus/usb&quot; directory.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;so I mount it use &quot;mount -t usbdevf=
s none /proc/bus/usb&quot; command. but I still can not up the devices.</di=
v>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I post the info of &quot;cat /proc/bus/usb/de=
vices&nbsp;&quot;, any suggestion is help!</div>
<div>&nbsp;&nbsp;&nbsp; &quot;# cat /proc/bus/usb/devices<br>T:&nbsp; Bus=
=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D&nbsp; 1 Spd=3D12&nbsp; =
MxCh=3D 1<br>B:&nbsp; Alloc=3D&nbsp; 0/900 us ( 0), #Int=3D&nbsp; 0, #Iso=
=3D&nbsp; 0<br>D:&nbsp; Ver=3D 1.10 Cls=3D09(hub&nbsp; ) Sub=3D00 Prot=3D00=
 MxPS=3D 8 #Cfgs=3D&nbsp; 1=20
<br>P:&nbsp; Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00<br>S:&nbsp; Product=3D=
USB SL811HS Root Hub<br>S:&nbsp; SerialNumber=3D0<br>C:* #Ifs=3D 1 Cfg#=3D =
1 Atr=3D40 MxPwr=3D&nbsp; 0mA<br>I:&nbsp; If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=
=3D09(hub&nbsp; ) Sub=3D00 Prot=3D00 Driver=3Dhub<br>E:&nbsp; Ad=3D81(I) At=
r=3D03(Int.) MxPS=3D&nbsp;&nbsp; 8 Ivl=3D255ms=20
<br>T:&nbsp; Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D&nbsp; 2=
 Spd=3D12&nbsp; MxCh=3D 0<br>D:&nbsp; Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 =
Prot=3D01 MxPS=3D16 #Cfgs=3D&nbsp; 1<br>P:&nbsp; Vendor=3D1131 ProdID=3D100=
1 Rev=3D 3.73<br>C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D&nbsp; 0mA<br>I:&=
nbsp; If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb=20
<br>E:&nbsp; Ad=3D81(I) Atr=3D03(Int.) MxPS=3D&nbsp; 16 Ivl=3D1ms<br>E:&nbs=
p; Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D&nbsp; 64 Ivl=3D0ms<br>E:&nbsp; Ad=3D82=
(I) Atr=3D02(Bulk) MxPS=3D&nbsp; 64 Ivl=3D0ms<br>I:&nbsp; If#=3D 1 Alt=3D 0=
 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb<br>E:&nbsp; =
Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 0 Ivl=3D1ms=20
<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 0 Ivl=3D1ms<br>I=
:&nbsp; If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driv=
er=3Dhci_usb<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 9 Iv=
l=3D1ms<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 9 Ivl=3D1=
ms<br>I:&nbsp; If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D=
01 Driver=3Dhci_usb=20
<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 17 Ivl=3D1ms<br>E:&nbs=
p; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp; 17 Ivl=3D1ms<br>I:&nbsp; If#=3D =
1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb<br=
>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 25 Ivl=3D1ms<br>E:&nbsp; =
Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp; 25 Ivl=3D1ms=20
<br>I:&nbsp; If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01=
 Driver=3Dhci_usb<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 33 Iv=
l=3D1ms<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp; 33 Ivl=3D1ms<br=
>I:&nbsp; If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3Dhci_usb=20
<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 49 Ivl=3D1ms<br>E:&nbs=
p; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp; 49 Ivl=3D1ms<br>I:&nbsp; If#=3D =
2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=3D(none)<br>=
# &quot;</div></span></div>

------=_Part_24948_25015580.1139192815609--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
