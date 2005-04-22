Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <13e9886105042209171edb0fba@mail.gmail.com>
From: Carsten Otto <carsten.otto@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Acer BT900 Headset profile
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
Date: Fri, 22 Apr 2005 18:17:05 +0200

Hello!

I am quite unsure whether my USB adapter supports everything I need,
but with Class 1 and and higher number in the name (BT900) than I saw
elsewhere I don't think that is a problem.
I was able to setup everything, but can't manage to get more than
noise out of my headset. Whenevery I play sounds (or pipe something
into /dev/dsp1) the noise starts and stops just when the sound is
finished.
Please tell me where the problem could be.
Some information:
- The headset is a Logitech Mobile Bluetooth Headset
- headset info:
Requesting information ...
        BD Address:  00:0D:44:02:02:85
        Device Name: Logitech HS01
        LMP Version: 1.1 (0x1) LMP Subversion: 0x3f0
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>=20
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packe=
ts>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme=
>=20
                <power control> <transparent SCO>=20
- Connections:
        < ACL 00:0D:44:02:02:85 handle 6 state 1 lm MASTER=20
- Playing a sound:
btsco v0.4a
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 15 mic volume: 15
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D15
Sending up speaker change 15
- amixer:
Simple mixer control 'Master',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control 'Mic',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control 'Loopback',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
- /proc/bus/usb/devices
T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a5c ProdID=3D200a Rev=3D 0.01
S:  Manufacturer=3DBroadcom
S:  Product=3DCCBT2035BDGP23-1
S:  SerialNumber=3D000272C32BDA
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  32 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  32 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms


Please write if you need more information.
Thanks for any hint,
--=20
Carsten Otto
carsten.otto@gmail.com
www.c-otto.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
