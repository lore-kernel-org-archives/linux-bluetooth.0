Return-Path: <cyrus@holtmann.org>
Message-ID: <d7c444d50810010229o4df9b985q2d2ca579819b8bf7@mail.gmail.com>
Date: Wed, 1 Oct 2008 12:29:57 +0300
From: "Ville Tervo" <vtervo@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Bluetooth 2.1 USB adapter!
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1222851981.11272.4.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_67063_4685926.1222853397163"
References: <294606.8239.qm@web52903.mail.re2.yahoo.com>
	 <1222381386.6442.8.camel@californication>
	 <d7c444d50810010157p4c67854ejf6317dbc60ac578f@mail.gmail.com>
	 <1222851981.11272.4.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_67063_4685926.1222853397163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On Wed, Oct 1, 2008 at 12:06 PM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Ville,
>
> > I have A-link dongle with following records. This seems to require the
> > same quirk. Tested with v2.6.26-mh4 and btusb module.
> >
> > hci0:   Type: USB
> >         BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1
> >         UP RUNNING
> >         RX bytes:5385 acl:0 sco:0 events:70 errors:0
> >         TX bytes:698 acl:0 sco:0 commands:48 errors:0
> >         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >         Link policy: RSWITCH HOLD SNIFF PARK
> >         Link mode: SLAVE ACCEPT
> >         Name: 'null-0'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 2.1 (0x4) HCI Rev: 0x5111 LMP Ver: 2.1 (0x4) LMP
> > Subver: 0x420e
> >         Manufacturer: Broadcom Corporation (15)
> >
> > hci0:   Type: USB
> >         BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1
> >         Firmware 17.66 / 14
>
> can you give me the simple lsusb and /proc/bus/usb/devices for this one
> please.


Here you are. Note that this dongle is also shown as 2xHID device and usb
hub in addition to bluetooth device.

Relevant part of lsusb
---- clip ----
Bus 001 Device 066: ID 0a5c:2146 Broadcom Corp.
Bus 001 Device 065: ID 0a5c:4503 Broadcom Corp.
Bus 001 Device 064: ID 0a5c:4502 Broadcom Corp.
Bus 001 Device 063: ID 0a5c:4500 Broadcom Corp.
----- clip ---

relevant part of /proc/bus/usb/devices
---- clip ----
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 63 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4500 Rev= 1.00
S:  Manufacturer=Broadcom
S:  Product=BCM2046B1
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 94mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=63 Port=00 Cnt=01 Dev#= 64 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4502 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=63 Port=01 Cnt=02 Dev#= 65 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4503 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=63 Port=02 Cnt=03 Dev#= 66 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2146 Rev= 2.73
S:  Manufacturer=Broadcom Corp
S:  Product=BCM92046DG-CL1ROM
S:  SerialNumber=0002721615F9
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
---- clip ----

------=_Part_67063_4685926.1222853397163
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Marcel,<br><br><div class="gmail_quote">On Wed, Oct 1, 2008 at 12:06 PM, Marcel Holtmann <span dir="ltr">&lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Ville,<br>
<div class="Ih2E3d"><br>
&gt; I have A-link dongle with following records. This seems to require the<br>
&gt; same quirk. Tested with v2.6.26-mh4 and btusb module.<br>
&gt;<br>
&gt; hci0: &nbsp; Type: USB<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; UP RUNNING<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:5385 acl:0 sco:0 events:70 errors:0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; TX bytes:698 acl:0 sco:0 commands:48 errors:0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Link mode: SLAVE ACCEPT<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Name: &#39;null-0&#39;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Class: 0x000100<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Service Classes: Unspecified<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Device Class: Computer, Uncategorized<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; HCI Ver: 2.1 (0x4) HCI Rev: 0x5111 LMP Ver: 2.1 (0x4) LMP<br>
&gt; Subver: 0x420e<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Manufacturer: Broadcom Corporation (15)<br>
&gt;<br>
&gt; hci0: &nbsp; Type: USB<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Firmware 17.66 / 14<br>
<br>
</div>can you give me the simple lsusb and /proc/bus/usb/devices for this one<br>
please.</blockquote><div><br>Here you are. Note that this dongle is also shown as 2xHID device and usb hub in addition to bluetooth device.<br><br>Relevant part of lsusb<br>---- clip ----<br>Bus 001 Device 066: ID 0a5c:2146 Broadcom Corp.<br>
Bus 001 Device 065: ID 0a5c:4503 Broadcom Corp.<br>Bus 001 Device 064: ID 0a5c:4502 Broadcom Corp.<br>Bus 001 Device 063: ID 0a5c:4500 Broadcom Corp.<br>----- clip ---<br><br>relevant part of /proc/bus/usb/devices<br>---- clip ----<br>
T:&nbsp; Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 63 Spd=12&nbsp; MxCh= 3<br>D:&nbsp; Ver= 2.00 Cls=09(hub&nbsp; ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=4500 Rev= 1.00<br>S:&nbsp; Manufacturer=Broadcom<br>S:&nbsp; Product=BCM2046B1<br>
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 94mA<br>I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub&nbsp; ) Sub=00 Prot=00 Driver=hub<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 1 Ivl=255ms<br><br>T:&nbsp; Bus=01 Lev=02 Prnt=63 Port=00 Cnt=01 Dev#= 64 Spd=12&nbsp; MxCh= 0<br>
D:&nbsp; Ver= 2.00 Cls=00(&gt;ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=4502 Rev= 1.00<br>C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=&nbsp; 2mA<br>I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID&nbsp; ) Sub=01 Prot=01 Driver=usbhid<br>
E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 8 Ivl=10ms<br><br>T:&nbsp; Bus=01 Lev=02 Prnt=63 Port=01 Cnt=02 Dev#= 65 Spd=12&nbsp; MxCh= 0<br>D:&nbsp; Ver= 2.00 Cls=00(&gt;ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=4503 Rev= 1.00<br>
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=&nbsp; 2mA<br>I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID&nbsp; ) Sub=01 Prot=02 Driver=usbhid<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 4 Ivl=10ms<br><br>T:&nbsp; Bus=01 Lev=02 Prnt=63 Port=02 Cnt=03 Dev#= 66 Spd=12&nbsp; MxCh= 0<br>
D:&nbsp; Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=2146 Rev= 2.73<br>S:&nbsp; Manufacturer=Broadcom Corp<br>S:&nbsp; Product=BCM92046DG-CL1ROM<br>S:&nbsp; SerialNumber=0002721615F9<br>C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=&nbsp; 2mA<br>
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp; 16 Ivl=1ms<br>E:&nbsp; Ad=82(I) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<br>E:&nbsp; Ad=02(O) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<br>I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>
I:&nbsp; If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 32 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 32 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>
I:&nbsp; If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)<br>
E:&nbsp; Ad=84(I) Atr=02(Bulk) MxPS=&nbsp; 32 Ivl=0ms<br>E:&nbsp; Ad=04(O) Atr=02(Bulk) MxPS=&nbsp; 32 Ivl=0ms<br>I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)<br>---- clip ----<br></div></div><br></div>

------=_Part_67063_4685926.1222853397163--
