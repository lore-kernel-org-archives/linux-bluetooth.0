Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050816195039.GC1103@pangeia.com.br>
References: <1124215347.21719.31.camel@pc7.dolda2000.com> <43022E86.7080909@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <43022E86.7080909@xmission.com>
Subject: [Bluez-devel] No sound in Plantronics M2500
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
Date: Tue, 16 Aug 2005 16:50:40 -0300


Technical details:
 hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:AA:AA:AA ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING=20
        RX bytes:1577 acl:40 sco:0 events:126 errors:0
        TX bytes:1201 acl:32 sco:0 commands:55 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: SLAVE ACCEPT=20
        Name: 'Debian-Note'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver: =
0x460
        Manufacturer: Cambridge Silicon Radio (10)

# aplay -l=20
**** List of PLAYBACK Hardware Devices ****
card 0: I82801CAICH3 [Intel 82801CA-ICH3], device 0: Intel ICH [Intel 828=
01CA-ICH3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Modem [Intel 82801CA-ICH3 Modem], device 0: Intel ICH - Modem [In=
tel 82801CA-ICH3 Modem - Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: Headset [BT Headset], device 0: Bluetooth SCO PCM [BT SCO PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

# btsco -v 00:03:89:AA:AA:AA
btsco v0.4c
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
[After run aplay]
speaker volume: 15 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D07
Sending up speaker change 7
[after I change volume manually]
recieved AT+VGS=3D08
Sending up speaker change 8
recieved AT+VGS=3D09
Sending up speaker change 9
recieved AT+VGS=3D11
Sending up speaker change 11
recieved AT+VGS=3D15
Sending up speaker change 15

All seems ok, but I don=B4t have any sound in speaker of HS.

Notebook=B4s sound works great with xmms (alsa config), aplay, ausamixer=20
works fine too.=20

Any hints?=20

Thanks for your time and attention,

./nelson -murilo




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
