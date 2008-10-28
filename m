Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Allow SCO with Asus WL-BTD202 dongle in btusb
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225159804.7157.41.camel@californication>
References: <1225152042.17240.18.camel@localhost>
	 <1225159804.7157.41.camel@californication>
Content-Type: multipart/mixed; boundary="=-otYcyLsC0BZn3Tz9CDPO"
Date: Tue, 28 Oct 2008 05:20:17 +0100
Message-Id: <1225167617.7998.10.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-otYcyLsC0BZn3Tz9CDPO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Le mardi 28 octobre 2008 à 03:10 +0100, Marcel Holtmann a écrit : 
> Hi Guillaume,
> 
> > This an other patch that allows my dongle to be configured correctly for
> > the voice/sco profile.
> > 
> > I already sent one for hci_usb some time ago, so it may sound familiar,
> > but it probably didn't have correct style...
> 
> you have to prove this one. Boot a kernel without the patch and call
> hciconfig hci0 up and then show me the output of hciconfig -a.

The file "hciconfig-...-before" was the output without the patch.
The file "hciconfig-...-after" is the output with the patch.
The last file contains some info from "/proc/bus/usb/devices".

Is it just proof that my dongle's firmware is out-of-date ?

Regards,

Guillaume B.

--=-otYcyLsC0BZn3Tz9CDPO
Content-Disposition: attachment; filename="hciconfig-wl-btd202.before.txt"
Content-Type: text/plain; name="hciconfig-wl-btd202.before.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hci0:	Type: USB
	BD Address: 00:0B:0D:4C:22:92 ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING 
	RX bytes:619 acl:0 sco:0 events:13 errors:0
	TX bytes:44 acl:0 sco:0 commands:13 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: 
	Link mode: SLAVE ACCEPT 
	Name: 'localhost-0'
	Class: 0x4a0104
	Service Classes: Networking, Capturing, Telephony
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0x40eb LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)


--=-otYcyLsC0BZn3Tz9CDPO
Content-Disposition: attachment; filename="hciconfig-wl-btd202.after.txt"
Content-Type: text/plain; name="hciconfig-wl-btd202.after.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hci0:	Type: USB
	BD Address: 00:0B:0D:4C:22:92 ACL MTU: 1017:8 SCO MTU: 64:8
	UP RUNNING PSCAN 
	RX bytes:4055672 acl:48817 sco:72479 events:22711 errors:0
	TX bytes:79729659 acl:89869 sco:0 commands:107 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'localhost-0'
	Class: 0x4a0104
	Service Classes: Networking, Capturing, Telephony
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0x40eb LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)


--=-otYcyLsC0BZn3Tz9CDPO
Content-Disposition: attachment; filename="wl-btd202.txt"
Content-Type: text/plain; name="wl-btd202.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=1715 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=WL-BTD202
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
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
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

--=-otYcyLsC0BZn3Tz9CDPO--

