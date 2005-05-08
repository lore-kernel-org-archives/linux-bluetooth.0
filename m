Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427D5693.6070501@gmx.de>
From: Michael Tede <mi.te@gmx.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] headset neo-507 not working with bluefritz 2.0
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
Date: Sun, 08 May 2005 02:00:19 +0200

Hi,

I can't manage to get my headset (Southwing Neo-507) working with my
system (SuSE 9.2, Linux version 2.6.8-24.14-default, bluetooth adapter
AVM Bluefritz USB 2.0 directly plugged into the computer).

According to http://bluetooth-alsa.sourceforge.net you're the right
people to kindly ask for help, I hope this is still valid. :-)

Although btsco seems to be able to connect with the headset (after
running btsco, I heard some short beeps), no sound is transfered to and
from the headset at all.

The headset, after trying "aplay -B 1000000 -D plughw:Headset abc.wav",
only "clicks" very briefly and and I hear some static noise.
The aplay command needs to be CTRL-C'ed to end.
Although btsco says that the speaker volume is 0, kamix shows a speaker
volume of around 8.
A subsequent call of aplay does not even produce the static noise again.


Before that, I took the following steps:

# modprobe snd-bt-sco

# esdctl stop
ALSA lib conf.c:2792:(snd_config_hook_load)
"/usr/share/alsa/cards/Bluetooth SCO.conf" is not a word
ALSA lib conf.c:2672:(snd_config_hooks_call) function
snd_config_hook_load_for_all_cards returned error: Invalid argument
ALSA lib pcm.c:1947:(snd_pcm_open_conf) Invalid type for PCM default
definition (id: default, value: cards.pcm.default)

# hciconfig hci0 voice 0x0060

# btsco -v 00:0e:16:02:2e:38 1
btsco v0.4b
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
speaker volume: 0 mic volume: 0
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=07
Sending up speaker change 7
recieved AT+VGM=00
Sending up microphone change 0
speaker volume: 7 mic volume: 1
driver is not in use
disconnected SCO channel

/var/log/messages says:
May  8 00:22:06 leeloo kernel: usb 3-1: new full speed USB device using
address 6
May  8 00:22:06 leeloo kernel: usb 3-1: Product: Bluetooth Device
May  8 00:22:06 leeloo kernel: usb 3-1: Manufacturer: Bluetooth Device
May  8 00:22:06 leeloo kernel: usb 3-1: SerialNumber: <serial#>
May  8 00:22:12 leeloo kernel: module bluetooth unsupported by
SUSE/Novell, tainting kernel.
May  8 00:22:12 leeloo kernel: Bluetooth: Core ver 2.6
May  8 00:22:12 leeloo kernel: NET: Registered protocol family 31
May  8 00:22:12 leeloo kernel: Bluetooth: HCI device and connection
manager initialized
May  8 00:22:12 leeloo kernel: Bluetooth: HCI socket layer initialized
May  8 00:22:12 leeloo kernel: module hci_usb unsupported by
SUSE/Novell, tainting kernel.
May  8 00:22:12 leeloo kernel: Bluetooth: HCI USB driver ver 2.7
May  8 00:22:12 leeloo kernel: usbcore: registered new driver hci_usb
May  8 00:22:12 leeloo kernel: cdrom: open failed.
May  8 00:22:13 leeloo kernel: cdrom: open failed.
May  8 00:22:13 leeloo hcid[8968]: Bluetooth HCI daemon
May  8 00:22:13 leeloo hidd[8975]: Bluetooth HID daemon
May  8 00:22:13 leeloo opd[8979]: OBEX Push Daemon - version 0.2 started
May  8 00:22:13 leeloo opd[8979]: Failed to connect to SDP server.
May  8 00:22:13 leeloo hcid[8968]: HCI dev 0 up
May  8 00:22:13 leeloo hcid[8968]: Starting security manager 0
May  8 00:22:13 leeloo sdpd[8971]: Bluetooth SDP daemon
May  8 00:22:13 leeloo opd[8979]: OBEX server listening on channel 10
May  8 00:22:13 leeloo kernel: module l2cap unsupported by SUSE/Novell,
tainting kernel.
May  8 00:22:13 leeloo kernel: Bluetooth: L2CAP ver 2.4
May  8 00:22:13 leeloo kernel: Bluetooth: L2CAP socket layer initialized
May  8 00:22:13 leeloo kernel: module hidp unsupported by SUSE/Novell,
tainting kernel.
May  8 00:22:13 leeloo kernel: Bluetooth: HIDP (Human Interface
Emulation) ver 1.0
May  8 00:22:13 leeloo kernel: module rfcomm unsupported by SUSE/Novell,
tainting kernel.
May  8 00:22:13 leeloo kernel: Bluetooth: RFCOMM ver 1.3
May  8 00:22:13 leeloo kernel: Bluetooth: RFCOMM socket layer initialized
May  8 00:22:13 leeloo kernel: Bluetooth: RFCOMM TTY layer initialized
May  8 00:22:39 leeloo kernel: module snd_bt_sco unsupported by
SUSE/Novell, tainting kernel.
May  8 00:22:39 leeloo kernel: snd-bt-sco revision 1.6 $
May  8 00:22:39 leeloo kernel: snd-bt-sco: snd-bt-scod thread starting
May  8 00:22:53 leeloo hcid[8968]: link_key_request
(sba=00:04:0E:89:BC:7F, dba=00:0E:16:02:2E:38)
May  8 00:23:01 leeloo kernel: snd-bt-sco: playback_open
May  8 00:23:01 leeloo kernel: module sco unsupported by SUSE/Novell,
tainting kernel.
May  8 00:23:01 leeloo kernel: Bluetooth: SCO (Voice Link) ver 0.3
May  8 00:23:01 leeloo kernel: Bluetooth: SCO socket layer initialized
May  8 00:23:01 leeloo kernel: snd-bt-sco: prepare ok bps: 16000 size:
16002 count: 4000
May  8 00:23:01 leeloo kernel: snd-bt-sco: playback_trigger 1
May  8 00:23:01 leeloo kernel: snd-bt-sco: setting playback to bspcm
May  8 00:23:17 leeloo kernel: snd-bt-sco: playback_trigger 0
May  8 00:23:17 leeloo kernel: snd-bt-sco: setting playback to NULL
May  8 00:23:17 leeloo kernel: snd-bt-sco: Disposing of previous socket
count 3
May  8 00:23:17 leeloo kernel: snd-bt-sco: file_count is 2 (expected 3)


Here's the output of hciconfig -a:

hci0:   Type: USB
        BD Address: 00:04:0E:89:BC:7F ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN INQUIRY AUTH
        RX bytes:128 acl:0 sco:0 events:16 errors:0
        TX bytes:313 acl:0 sco:0 commands:16 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ leeloo (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2005 LMP Ver: 1.1 (0x1) LMP
Subver: 0x1805
        Manufacturer: AVM Berlin (31)


hciconfig hci0 revision:
hci0:   Type: USB
        BD Address: 00:04:0E:89:BC:7F ACL MTU: 120:20  SCO MTU: 64:0
        Unknown type


hcitool info <headset>:
Requesting information ...
        BD Address:  00:0e:16:02:2e:38
        Device Name: Neo-507
        LMP Version: 1.1 (0x1) LMP Subversion: 0x42c
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xef 0x03 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme>


bluez-versions:
bluez-test-2.10-15
bluez-hcidump-1.11-2
bluez-libs-2.10-2
bluez-utils-2.10-15
bluez-firmware-1.0-3

I also have a "hcidump -X" log available (1,5 MB), which I can mail
separately.

Hopefully, this was enough information to solve my problem.

Thanks a lot for your help and best regards

 Michael



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
