Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454B3AD7.7080401@gmail.com>
Date: Fri, 03 Nov 2006 13:49:27 +0100
From: Christian Mager <christian.mager@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] bluetooth-alsa and HAMA BTH-155
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

Hello,

I followed the instructions of bluetooth-alsa.sf.net to get my bt
headset work but pairing doesn't work so far. snd_bt_sco is loaded and
when I run btsco I get the following output:

$ btsco -v 00:13:8A:04:A3:43
btsco v0.42
Device is 1:0
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied

Yes, I have restarted /etc/init.d/bluez-utils. I also started btsco as
root but same result. Pairing the headset with my cell phone works, but
it asks for a pin, btsco desn't. Could this cause the problem? In
/etc/blueooth/hci.conf there is 'pin_helper /usr/bin/bluez-pin;' and 'lm
accept;'.

On your project site you wrote, that the following information could be
useful for you:

- Output of hciconfig -a:

hci0:   Type: USB
        BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:790 acl:0 sco:0 events:63 errors:0
        TX bytes:814 acl:0 sco:0 commands:43 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'chica-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:
0x222
        Manufacturer: Cambridge Silicon Radio (10)

- Output from hciconfig hci0 revision:

hci0:   Type: USB
        BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8
        Build 546
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI

- Output of hcitool info 00:13:8A:04:A3:43:

Requesting information ...
Can't create connection: Input/output error

- Systeminformation: Debian Sarge, Kernel 2.6.17.11 (self compiled),
bluez-utils 2.15-1.1

If you need more info just let me know.

Could it be possible that my headset itself doesn't work with
bluetooth-alsa? I would be very happy if someone could help me. Any
ideas how to solve this?

Greets, Christian Mager.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
