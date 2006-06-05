Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44840D5E.5060800@auroramsx.nl>
Date: Mon, 05 Jun 2006 12:54:22 +0200
From: Eric Boon <eric@auroramsx.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>
	<4483B5E4.7000305@xmission.com>
In-Reply-To: <4483B5E4.7000305@xmission.com>
Subject: Re: [Bluez-devel] Belkin
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello bluez-dev'ers

I recently bought a Belkin USB BT-stick and stumbled upon the infamous 
Broadcom problem: everything seems to work fine, but no audio :-/  I'm 
running Debian testing, on a P3@1GHz, followed the installation 
instructions on http://bluetooth-alsa.sourceforge.net/ and 
http://wiki.ubuntuusers.de/Bluetooth/Headset.  The stick sits directly 
in the PC, no USB hub used.

The Belkin stick is apparently a Broadcom device -- see hciconfig 
output. I found a reference to 'F8T013' on the box, which gave me some 
hope that fiddling with the SCO MTU value could solve my problem. Helas, 
no joy...
I did not apply the kernel patch, as suggested on the bluetooth-alsa 
website, but manually set the SCO MTU to 256:8 using 'hciconfig scomtu 
256:8'. The original values were '64:0'.
Does that make any difference? Should I try different values? If 
possible I'd rather avoid patching the kernel :-/

Any suggestions to getting this thing to work are welcome!
The headset is a Logitech 'Mobile Freedom' (HS02-V08)


Many thanx in advance,
    Eric

(PS. Is there also a bluez IRC channel somewhere? :-))

eric@morpheus:~$ uname -a
Linux morpheus 2.6.15-1-686 #2 Mon Mar 6 15:27:08 UTC 2006 i686 GNU/Linux

eric@morpheus:~$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:00:3A:6A:80:1D ACL MTU: 1017:8 SCO MTU: 256:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1115011 acl:25 sco:21838 events:54 errors:0
        TX bytes:802 acl:21 sco:0 commands:25 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'morpheus-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2073 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

eric@morpheus:~$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:00:3A:6A:80:1D ACL MTU: 1017:8 SCO MTU: 256:8
        Firmware 8307.65 / 39

eric@morpheus:~$ sudo hcitool info 00:0D:44:3B:A9:35
Requesting information ...
        BD Address:  00:0D:44:3B:A9:35
        Device Name: Logitech HS02-V08
        LMP Version: 1.2 (0x2) LMP Subversion: 0x611
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

Output of btsco when trying to play a sound file:

eric@morpheus:~$ btsco -v 00:0D:44:3B:A9:35
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
speaker volume: 13 mic volume: 14
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=13
Sending up speaker change 13
speaker volume: 14 mic volume: 14
speaker volume: 14 mic volume: 14
driver is not in use
disconnected SCO channel



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
