Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
From: michael grosman <michaelg100@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8061_17799356.1139865580671"
Subject: [Bluez-users] hciconfig doesn't come up
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Feb 2006 23:19:40 +0200

------=_Part_8061_17799356.1139865580671
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We would like to setup BT communication on embedded MIPS-processor Broadcom
card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).
Kernel contained USB support, HID support and BlueTooth support (on all
layers).
On this card we're using USB-PCI host-controller of Philips (ISP1562ES1).
We are using Bluez-2.24 library and utils. We also use the library for
userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).

We are using CSR based BT dongle with the following description:
>T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  5 Spd=3D12  Mx=
Ch=3D 0>
>D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
>P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D11.20
(as we saw in the supported products list, it is supported.)

Following system start, we "insmoded" the following modules: usbcore,
usb-ohci, bluez, hci_usb, then creating devices /dev/vhci and /dev/rfcomm,
followed by loading also l2cap, rfcomm, input, uinput, evdev, hidp modules.
Then we start hcid, sdpd and hidd services.
So, we have:
># lsmod
>Module                  Size  Used by
>hidp                   10864   0 (unused)
>evdev                   4112   0 (unused)
>uinput                  3504   0 (unused)
>input                   4944   0 [hidp evdev uinput]
>rfcomm                 40080   0 (unused)
>l2cap                  20752   2 [hidp rfcomm]
>hci_usb                11088   0
>bluez                  41776   2 [hidp rfcomm l2cap hci_usb]
>usb-ohci               21696   0 (unused)
>usbcore                83824   1 [hci_usb usb-ohci]
># ps -aux
>  PID  Uid     Stat Command
>    1 0         S    init noinitrd
>    2 0         S    [keventd]
>    3 0         S    [ksoftirqd_CPU0]
>    4 0         S    [kswapd]
>    5 0         S    [bdflush]
>    6 0         S    [kupdated]
>    7 0         S    [mtdblockd]
>   15 0         S    /usr/sbin/dnsmasq
>   24 0         S    /usr/sbin/diag
>   25 0         S    /bin/sh
>   35 0         S    [khubd]
>   63 0         S    [krfcommd]
>   77 0         S    hcid: processing events
>   80 0         S    sdpd
>  104 0         S    hcid: processing events
>  108 0         S    hcid: hci0 init
>  111 0         S    /usr/sbin/hidd --server
>  124 0         R    ps -aux

The problem is that hciconfig doesn't come up:
># hciconfig
>hci0:   Type: USB
>        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>        DOWN
>        RX bytes:20 acl:0 sco:0 events:2 errors:0
>        TX bytes:9 acl:0 sco:0 commands:3 errors:0

When we're trying to wake it up, it failed on timeout:
># hciconfig hci0 up
>Can't init device hci0: Connection timed out (145)
We received the same timeout reply for version, revision and commands
requests.
We received the following reply for features request (# hciconfig hci0
features)
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 192:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme=
>
                <power control> <transparent SCO>

When we're trying to do the same actions on PC with Linux 2.6.12 (using the
same USB-PCI card and BT dongle), the only difference that after "hciconfig
up" it returns the BD address and UP state. Following that all hcitool,
sdptool, l2ping etc. services worked ok and we could establish BT
communication.

One additional issue. We see in the product list that our dongle is in HCI
mode, so we don't have to use hid2hci utility, but for some strange reason
it doesn't work in any direction (on both Brodacom and PC).
We found that in the list, declared in the file hid2hci.c , this pair
"vendor-productID" is defined as HID... It's strange.

We see in sources that the socket to AF_BLUETOOTH with BT_PROTOHCI is opene=
d
successfully and even some of ioctl's succeeded, but HCIDEVUP did not...
May someone hint us, what we did wrong.
Should we change something in the "default" hcid.conf (class device or
something else)?
Or should we make something additional configurations?
We don't find nothing extra in the manuals and HOWTOs...
How could we fix this HCI connection and move forward in establishing BT
communication on the described setup?

Thanks,
Michael

------=_Part_8061_17799356.1139865580671
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>We would like to setup BT communication on embedded MIPS-processor Broad=
com card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).<br>Kernel=
 contained USB support, HID support and BlueTooth support (on all layers).
<br>On this card we're using USB-PCI host-controller of Philips (ISP1562ES1=
).<br>We are using Bluez-2.24 library and utils. We also use the library fo=
r userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).</p>
<p>We are using CSR based BT dongle with the following description:<br>&gt;=
T:&nbsp; Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D&nbsp; 5 Spd=
=3D12&nbsp; MxCh=3D 0&gt;<br>&gt;D:&nbsp; Ver=3D 1.10 Cls=3De0(unk. ) Sub=
=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D&nbsp; 1<br>&gt;P:&nbsp; Vendor=3D0a12 Pr=
odID=3D0001 Rev=3D
11.20<br>(as we saw in the supported products list, it is supported.)</p>
<p>Following system start, we &quot;insmoded&quot; the following modules: u=
sbcore, usb-ohci, bluez, hci_usb, then creating devices /dev/vhci and /dev/=
rfcomm, followed by loading also l2cap, rfcomm, input, uinput, evdev, hidp =
modules.
<br>Then we start hcid, sdpd and hidd services.<br>So, we have:<br>&gt;# ls=
mod<br>&gt;Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by<br>&gt;hidp=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10864&nbsp;&nbsp; 0 (unused)<br>&gt;evdev=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4112&nbsp;&nbsp; 0 (unused)
<br>&gt;uinput&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3504&nbsp;&nbsp; 0 (unused)<br>&g=
t;input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4944&nbsp;&nbsp; 0 [hidp evdev uin=
put]<br>&gt;rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40080&nbsp;&nbsp; 0 (unused)<br>&gt=
;l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20752&nbsp;&nbsp; 2 [hidp rfcomm]<br>&gt;=
hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 11088&nbsp;&nbsp; 0
<br>&gt;bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 41776&nbsp;&nbsp; 2 [hidp rfcomm l=
2cap hci_usb]<br>&gt;usb-ohci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21696&nbsp;&nbsp; 0 (unused)<br>&gt;=
usbcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 83824&nbsp;&nbsp; 1 [hci_usb usb-ohci]<br>&gt;# ps -=
aux<br>&gt;&nbsp; PID&nbsp; Uid&nbsp;&nbsp;&nbsp;&nbsp; Stat Command
<br>&gt;&nbsp;&nbsp;&nbsp; 1 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; S&nbsp;&nbsp;&nbsp; init noinitrd<br>&gt;&nbsp;&nbsp;&nbsp; 2 0&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; [keventd]<br>&=
gt;&nbsp;&nbsp;&nbsp; 3 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
&nbsp;&nbsp;&nbsp; [ksoftirqd_CPU0]<br>&gt;&nbsp;&nbsp;&nbsp; 4 0&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; [kswapd]<br>&gt;=
&nbsp;&nbsp;&nbsp; 5 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nb=
sp;&nbsp;&nbsp; [bdflush]<br>&gt;&nbsp;&nbsp;&nbsp; 6 0&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; [kupdated]
<br>&gt;&nbsp;&nbsp;&nbsp; 7 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; S&nbsp;&nbsp;&nbsp; [mtdblockd]<br>&gt;&nbsp;&nbsp; 15 0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; /usr/sbin/dnsmasq<br>=
&gt;&nbsp;&nbsp; 24 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbs=
p;&nbsp;&nbsp; /usr/sbin/diag<br>&gt;&nbsp;&nbsp; 25 0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; /bin/sh<br>&gt;&nbsp;&nbsp;=
 35 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; [=
khubd]<br>&gt;&nbsp;&nbsp; 63 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; S&nbsp;&nbsp;&nbsp; [krfcommd]
<br>&gt;&nbsp;&nbsp; 77 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
&nbsp;&nbsp;&nbsp; hcid: processing events<br>&gt;&nbsp;&nbsp; 80 0&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; sdpd<br>&gt;&n=
bsp; 104 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nb=
sp; hcid: processing events<br>&gt;&nbsp; 108 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; hcid: hci0 init<br>&gt;&nbsp; 111 =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; /usr/=
sbin/hidd --server
<br>&gt;&nbsp; 124 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp=
;&nbsp;&nbsp; ps -aux</p>
<p>The problem is that hciconfig doesn't come up:<br>&gt;# hciconfig<br>&gt=
;hci0:&nbsp;&nbsp; Type: USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RX bytes:20 acl:0 sco:0 events:2 errors:0
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:9 acl:0 sco:0 c=
ommands:3 errors:0</p>
<p>When we're trying to wake it up, it failed on timeout:<br>&gt;# hciconfi=
g hci0 up<br>&gt;Can't init device hci0: Connection timed out (145)<br>We r=
eceived the same timeout reply for version, revision and commands requests.
<br>We received the following reply for features request (# hciconfig hci0 =
features)<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 192:8 SCO MTU: 64:8<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x0=
0 0x00 0x00 0x00
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encry=
ption&gt; &lt;slot offset&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &l=
t;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt=
;HV2 packets&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt;=
 &lt;CVSD&gt; &lt;paging scheme&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt=
; &lt;transparent SCO&gt;</p>
<p>When we're trying to do the same actions on PC with Linux 2.6.12 (using =
the same USB-PCI card and BT dongle), the only difference that after &quot;=
hciconfig up&quot; it returns the BD address and UP state. Following that a=
ll hcitool, sdptool, l2ping etc. services worked ok and we could establish =
BT communication.
</p>
<p>One additional issue. We see in the product list that our dongle is in H=
CI mode, so we don't have to use hid2hci utility, but for some strange reas=
on it doesn't work in any direction (on both Brodacom and PC). <br>We found=
 that in the list, declared in the file=20
hid2hci.c , this pair &quot;vendor-productID&quot; is defined as HID... It'=
s strange.</p>
<p>We see in sources that the socket to AF_BLUETOOTH with BT_PROTOHCI is op=
ened successfully and even some of ioctl's succeeded, but HCIDEVUP did not.=
..</p>
<div>May someone hint us, what we did wrong. <br>Should we change something=
 in the &quot;default&quot; hcid.conf (class device or something else)?<br>=
Or should we make something additional configurations?<br>We don't find not=
hing extra in the manuals and HOWTOs...
<br>How could we fix this HCI connection and move forward in establishing B=
T communication on the described setup?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Michael<br>&nbsp;</div>

------=_Part_8061_17799356.1139865580671--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
