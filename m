Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Cc: bmidgley@xmission.com
Message-ID: <20050318171309.GB25843@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] strange HP bluetooth headset
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
Date: Fri, 18 Mar 2005 12:13:09 -0500

Hello

I have purchased HP Bluetooth stereo headphones:
http://www.shopping.hp.com/cgi-bin/hpdirect/shopping/scripts/product_deta=
il/product_detail_view.jsp?product_code=3DFA303A%23AC3&catLevel=3D5

I thought they would work with sbcenc/a2play - they don't. The audio
is crackled, ie. I have approx 0.2 seconds with audio, 0.2 seconds
without, and so on.

They don't work at all with rcplay - can't find a channel.

Here's some info from the device:
Requesting information ...
        BD Address:  00:0D:44:2A:09:00
        Device Name: BT-Headphones
        LMP Version: 1.2 (0x2) LMP Subversion: 0x3d
        Manufacturer: Zeevo, Inc. (18)
        Features: 0xff 0x07 0x04 0x78 0x18 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offs=
et>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
               <park state> <RSSI> <channel quality> <power control>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class.  slave>
                <AFH cap. master> <AFH class. master>

Here is the browse:
Browsing 00:0D:44:2A:09:00 ...
Service Name: Audio Sink
Service RecHandle: 0x110b
Service Class ID List:
  "" (0x110b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "" (0x0019)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x110d)
    Version: 0x0100

Service Name: Remote Controller
Service RecHandle: 0x110e
Service Class ID List:
  "" (0x110e)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "" (0x0017)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x110e)
    Version: 0x0100

a2play reports:
subbands =3D 0
allocation method =3D 1
channel_mode =3D 0
blocks =3D 3
sampling frequency =3D 3
bitpool =3D 18
frame len =3D 38


So I took rcplay source and tried to hardcode a channel in - 25 of
course.

This didn't really help:
$ ./rcplay 00:0D:44:2A:09:00 test.sbc
Can't get channel number - defaulting to 25: Success
Channel : 25
Can't open connection: Connection refused

However after that, using a2play I can play audio much better. It
plays much too fast, without any distortion however. So I guess
there's some capability settings I'm missing.

a2play reports:
subbands =3D 1
allocation method =3D 1
channel_mode =3D 2
blocks =3D 3
sampling frequency =3D 2
bitpool =3D 32
frame len =3D 72

Any suggestion ?

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
