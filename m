Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Teun <Teun.Kaptein@planet.nl>
To: bluez-devel@lists.sourceforge.net
Message-id: <42945836.5040608@planet.nl>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] No sound with Canyon CN-BTH1 and CN-BTU1
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
Date: Wed, 25 May 2005 12:49:26 +0200

Hi , i've a small problem with my headset en usb stick from canyon.

I have no sound with my canyon CN-BTH1

I compiled kernel 2.6.11.9 with build in alsa
usb bluetooth : Canyon CN-BTU1
headset : canyon CN-BTH1
distro : SuSE 9.2

when i changes the sound volume the headset response perfecty with
noise, but thats it.
I tried with another usb-stick BT180 from trust (also silicone wave chip
inside) but there is no difference.
Who can help me ?

Thanx anyway !


Loopback from kmix don't do anything, but i haven't test this before..

_starting :_

modprobe snd_bt_sco (start as root)
kmix (starting as user)

at this time kmix found  BT headset

starting btsco (as user)

achilles@office:~> btsco -v 00:0a:94:8e:3B:b8

btsco v0.4b
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected

when changing volume from mic of speaker in kmix it changed in my
headset and i see it changing on screen (btsco).

office:/home/achilles # hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:94:11:4F:8E ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:763 acl:23 sco:0 events:45 errors:0
        TX bytes:678 acl:16 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ office (0)'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

office:/home/achilles # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:94:11:4F:8E ACL MTU: 120:20  SCO MTU: 64:0
        Unsupported manufacturer

office:/home/achilles # hcitool info 00:0a:94:8e:3b:b8
Requesting information ...
        BD Address:  00:0a:94:8e:3b:b8
        Device Name: BT Headset-F
        LMP Version: 1.1 (0x1) LMP Subversion: 0x434
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log>
<A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>

office:/home/achilles # hcidump -X
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff

(from another shell : )
achilles@office:~> aplay -B 100000 -D plughw:Headset
/opt/kde3/share/sounds/KDE_Startup_new.wav
Playing WAVE '/opt/kde3/share/sounds/KDE_Startup_new.wav' : Signed 16
bit Little Endian, Rate 22050 Hz, Stereo

hangs .... but info from btsco -V :

speaker volume: 0 mic volume: 0
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=15
Sending up speaker change 15
speaker volume: 15 mic volume: 1
driver is not in use
disconnected SCO channel


lot of output to hcidump :

> SCO data: handle 0x0100 dlen 48
    0000: 84 ff a6 ff dd ff b4 ff 90 ff 99 ff 76 ff 89 ff   ...........v...
    0010: 7b ff 53 ff 64 ff 44 ff 4b ff 6b ff 66 ff 8c ff   {.S.d.D.K.k.f...
    0020: 7c ff 7c ff 94 ff 6d ff 80 ff 81 ff 81 ff a6 ff   |.|...m.........
> SCO data: handle 0x0100 dlen 48
    0000: 6a ff 4d ff 66 ff 7f ff 9a ff 7e ff 81 ff a7 ff   j.M.f.....~.....
    0010: b7 ff b3 ff 97 ff 92 ff 98 ff aa ff 9c ff 7a ff   .............z.
    0020: 9a ff 9e ff 84 ff 85 ff 84 ff 88 ff 8d ff 8c ff   ...............
> SCO data: handle 0x0100 dlen 48
    0000: 81 ff 84 ff 8e ff 95 ff 9b ff 8c ff 90 ff 96 ff   ...............
    0010: 98 ff 9b ff 97 ff ad ff ac ff b5 ff d1 ff bc ff   ...............
    0020: af ff 9a ff 70 ff 91 ff 92 ff 6d ff a7 ff 93 ff   ...p.....m.....
> SCO data: handle 0x0100 dlen 48
    0000: 75 ff 8a ff 49 ff 55 ff 59 ff 44 ff 7a ff 81 ff   u...I.U.Y.D.z...
    0010: 7a ff 76 ff 8d ff ad ff 86 ff 7a ff 86 ff 8b ff   z.v.......z.....
    0020: 9e ff 98 ff a1 ff d0 ff e0 ff be ff 97 ff 93 ff   ...............
> SCO data: handle 0x0100 dlen 48
    0000: 9c ff 9d ff 82 ff 73 ff a2 ff 8b ff 6d ff 8e ff   .....s.....m...
    0010: 7c ff 7d ff 73 ff 74 ff b0 ff 9b ff 8c ff b5 ff   |.}.s.t.........
    0020: ad ff ae ff ae ff 9a ff af ff c1 ff bf ff b8 ff   ...............
and a lot more (pages)


finaly when i push a button on my headset (with disconnected SCO channel)
output from btsco :
recieved AT+CKPD=200













-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
