Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EE3974.1010604@fastwebnet.it>
From: WiseLYNX <wiselynx.naima@fastwebnet.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] bluetooth headset - connects but no audio
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
Date: Wed, 19 Jan 2005 11:41:56 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi everybody,

it's some time I'm trying to get my BT headset to work with btsco, but
with no results.

the problem, which I found reported but not answered in a forum on the
bluetooth-alsa sourceforge project page
(https://sourceforge.net/tracker/?func=3Ddetail&atid=3D678259&aid=3D10679=
46&group_id=3D116589),
is I can connect to the headset (see log above), set volume from pc, see
events, and even hear a hissing sound, but I can't hear any sound using
aplay, nor record anything; the programs just hang.

I hope this issue is not an already well known and solved; if so it is,
please redirect me to where the info I need are, thanks.

Else, here are some logs as suggested to report; I omitted the output of
`hcidump -x` because it is very long, but I can of course provide it if
necessary.

thanks in advance for helping me.

BT dongle: Trust BT180 (USB, works fine with other devices, like my T39
phone)
BT headset: Ericsson HBH-35 (works fine as phone headset)

# hciconfig -a
hci0:   Type: USB
~        BD Address: 00:0B:0D:40:6F:B9 ACL MTU: 120:20  SCO MTU: 64:0
~        UP RUNNING PSCAN ISCAN AUTH
~        RX bytes:95 acl:0 sco:0 events:12 errors:0
~        TX bytes:296 acl:0 sco:0 commands:12 errors:0
~        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
~        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
~        Link policy: RSWITCH HOLD SNIFF PARK
~        Link mode: SLAVE ACCEPT
~        Name: 'Naima blue 0'
~        Class: 0x000100
~        Service Classes: Unspecified
~        Device Class: Computer, Uncategorized
~        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
0x757
~        Manufacturer: Silicon Wave (11)

# hciconfig hci0
hci0:   Type: USB
~        BD Address: 00:0B:0D:40:6F:B9 ACL MTU: 120:20  SCO MTU: 64:0
~        UP RUNNING PSCAN ISCAN AUTH
~        RX bytes:372 acl:0 sco:0 events:15 errors:0
~        TX bytes:305 acl:0 sco:0 commands:15 errors:0

# hcitool info 00:0E:07:4E:4B:3E
Requesting information ...
~        BD Address:  00:0E:07:4E:4B:3E
~        Device Name: HBH-35
~        LMP Version: 1.1 (0x1) LMP Subversion: 0x8d40
~        Manufacturer: Ericsson Technology Licensing (0)
~        Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
~                <encryption> <slot offset> <timing accuracy> <role switc=
h>
~                <sniff mode> <SCO link> <HV3 packets> <CVSD>

# btsco 00:0E:07:4E:4B:3E
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT*ECBP=3D?
recieved AT+CLIP=3D1
recieved AT+CSCS=3D"UTF-8"
recieved AT+CLAN?
recieved AT+CKPD=3D200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=3D15
Sending up speaker change 15


- --

=B0=B0=B0 Wise
~ O  LYNX

GPG key: http://wiselynx.interfree.it/wiselynx.naima.asc
MD5 checksum: http://wiselynx.interfree.it/wiselynx.naima.asc.md5

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GE>$/IT/S d+ s: !a>? C++(+++)>$ U P>+ L++>++++ E--- W++ N ?o ?K w-- ?O ?M
?V>+ PS+ !PE Y+ PGP+ t- ?5 X- R+(*) tv- b+(++)>+++ DI(++) !D G e++ h!*@
r%>++ y-->+
- ------END GEEK CODE BLOCK------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB7jlykYE9G6fXLlgRAqLrAJ0Vh9mkARjBPlNa1VFDDS6U19W2AQCcCwpz
HaFwLZHkVAstFgcy1SZySXo=3D
=3D/+LY
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
