Return-Path: <Olivier.Bornet@smartdata.ch>
Date: Wed, 29 Oct 2003 00:23:35 +0100
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Michal Semler (volny.cz)" <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
Message-ID: <20031028232335.GA6411@smartdata.ch>
References: <20031028084018.GA1875@smartdata.ch> <1067366086.24043.153.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <1067366086.24043.153.camel@pegasus>
Sender: Olivier Bornet <Olivier.Bornet@smartdata.ch>
List-ID: <bluez-users.lists.sourceforge.net>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Oct 28, 2003 at 07:34:40PM +0100, Marcel Holtmann wrote:
> this is another reason, why we should reuse the USB HID parser for the
> Bluetooth keyboards and mice ;)

I agree with you. I'm ready to test/help on this way when you will have
someting in progress.

> So you have the new diNovo. I am interested in the "hcitool info ..."

Please note the one I have is a "Beta Release". The real diNovo from the
market may differ.

For the mouse:

bol@delta:~$ hcitool info 00:07:61:04:1E:BD
Requesting information ...
        BD Address:  00:07:61:04:1E:BD
        Device Name: Logitech Bluetooth Mouse
        LMP Version: 1.1 (0x1) LMP Subversion: 0x350
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>=20
                <park mode> <RSSI> <channel quality> <SCO link>=20
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>=20
                <CVSD> <paging scheme> <power control> <transparent SCO>

For the keyboard:

bol@delta:~$ hcitool info 00:07:61:04:21:30
Requesting information ...
        BD Address:  00:07:61:04:21:30
        Device Name: Logitech Bluetooth Keyboard
        LMP Version: 1.1 (0x1) LMP Subversion: 0x350
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>=20
                <park mode> <RSSI> <channel quality> <SCO link>=20
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>=20
                <CVSD> <paging scheme> <power control> <transparent SCO>=20

For the Mediapad:

bol@delta:~$ sudo hcitool info 00:07:61:04:1D:35
Checking smart card key...
Requesting information ...
        BD Address:  00:07:61:04:1D:35
        Device Name: Logitech Bluetooth Mediapad
        LMP Version: 1.1 (0x1) LMP Subversion: 0x350
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>=
=20
                <hold mode> <sniff mode> <park mode> <RSSI>=20
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>=20
                <u-law log> <A-law log> <CVSD> <paging scheme>=20
                <power control> <transparent SCO>=20

> output from the devices and the "hciconfig -a" from the Bluetooth hub.

This is not possible at this time. The reason is that the Bluetooth hub
is now working as a usb hub. I can't switch it to Bluetooth mode,
because I don't have the necessary tools on Linux for this. This tool
exist, but on another OS... And I don't use this other OS. Of course, if
you think there is a simple way to switch from "usb hub" to "bluetooth
hub", let me know.

At this time, I use another bluetooth dongle for connection the
mouse/keyboard/mediapad. But I'm also really interested to have the
Logitech bluetooth hub working as bluetooth hub.

> If you have some extra time, please compile the new libs2 from CVS and
> run "sdptest records ..." and/or "sdptest browse ..." for me.

Maybe tomorow... Too late now.

>  Please also include a "hcitool inq" for them, so I can see what class
>  of device they are using.

bol@delta:~$ hcitool inq
Inquiring ...
        00:07:61:04:1D:35       clock offset: 0x435f    class: 0x002540
        00:07:61:04:1E:BD       clock offset: 0x7a9d    class: 0x002580
        00:07:61:04:21:30       clock offset: 0x6f6e    class: 0x002540
bol@delta:~$ hcitool scan
Scanning ...
        00:07:61:04:1D:35       Logitech Bluetooth Mediapad
        00:07:61:04:1E:BD       Logitech Bluetooth Mouse
        00:07:61:04:21:30       Logitech Bluetooth Keyboard

> What is the content of /proc/bus/usb/devices with the Bluetooth hub
> attached.

The hub is seen as "USB Receiver" in usbview. Here is the full
/proc/bus/usb/devices informations (many usb devices connected, sorry):

bol@delta:~$ cat /proc/bus/usb/devices=20
T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D129/900 us (14%), #Int=3D  2, #Iso=3D  0
D:  Ver=3D 1.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB UHCI Root Hub
S:  SerialNumber=3Db000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 2
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0451 ProdID=3D2036 Rev=3D 1.01
S:  Product=3DGeneral Purpose USB Hub
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms
T:  Bus=3D03 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D1.5 MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc703 Rev=3D99.12
S:  Manufacturer=3DLogitech
S:  Product=3DUSB Receiver
S:  SerialNumber=3D0403D3
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 98mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dusbkbd
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3D(none)
E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D 27/900 us ( 3%), #Int=3D  1, #Iso=3D  1
D:  Ver=3D 1.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB UHCI Root Hub
S:  SerialNumber=3Db400
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D 5.25
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
T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D1.5 MxC=
h=3D 0
D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc208 Rev=3D 1.03
S:  Manufacturer=3DLogitech Inc.
S:  Product=3DWingMan Gamepad Extreme
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D 40mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D8ms
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB UHCI Root Hub
S:  SerialNumber=3Db800
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  4 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D03f0 ProdID=3D3c02 Rev=3D 1.00
S:  Manufacturer=3Dhp
S:  Product=3Dphotosmart 7350
S:  SerialNumber=3DMY246140QJ2E
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  2mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D07(print) Sub=3D01 Prot=3D03 Driver=
=3Dusblp
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 0 Alt=3D 1 #EPs=3D 2 Cls=3D07(print) Sub=3D01 Prot=3D02 Driver=
=3Dusblp
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0403 ProdID=3D6001 Rev=3D 2.00
S:  Manufacturer=3DFTDI
S:  Product=3DUSB FAST SERIAL ADAPTER
S:  SerialNumber=3DFTAPJVEU
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 44mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dserial
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms

> Do this one really support HID proxy from CSR?

Hummm. Don't event know what this is. Can you explain this to me ?

Good day^H^H^Hnight.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
GPG key ID: C53D9218                CH Martigny/Lausanne

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/nvp3dj3R/MU9khgRApzWAJ41gBmJVfVWV9pcXX+ds3aAmCmGzgCfUZTK
ZP9NpJbGZK/wjl/QGglULFE=
=+j5X
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
