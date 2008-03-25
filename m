Return-Path: <cyrus@holtmann.org>
Message-ID: <47E98D82.5050906@sssup.it>
Date: Wed, 26 Mar 2008 00:40:50 +0100
From: Ludovico Cavedon <cavedon@sssup.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Testing audio service with BT headphone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
here are the problem I am encountering with a BT headphone.

In short:
-btsco works greatly
-audio service sometimes works, sometimes no audio is heard

Details:
-kernel 2.6.23.4 with patch
http://launchpadlibrarian.net/12699239/always_use_sco.patch (to avoid
"hci0 SCO packet for unknown connection handle")
-force_sco has no effect
-Ubuntu hardy amd64
-bluez 3.26


hci0:	Type: USB
	BD Address: 00:1A:6B:BB:82:5D ACL MTU: 1017:8 SCO MTU: 64:8
	UP RUNNING PSCAN
	RX bytes:908664 acl:178 sco:17658 events:240 errors:0
	TX bytes:1614435 acl:155 sco:31574 commands:90 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'cavedon-pc'
	Class: 0x08010c
	Service Classes: Capturing
	Device Class: Computer, Laptop
	HCI Ver: 2.0 (0x3) HCI Rev: 0x2129 LMP Ver: 2.0 (0x3) LMP Subver: 0x41cf
	Manufacturer: Broadcom Corporation (15)

=== .asoundrc
pcm.bluetooth {
    type bluetooth
    device 00:0D:44:2F:D2:F7
    profile "voice"
}

pcm.plugbt {
    type plug
    slave.pcm "bluetooth"
}


=== Connection of device:

hcid[6594]: link_key_request (sba=00:1A:6B:BB:82:5D, dba=00:0D:44:2F:D2:F7)
audio[6598]: Requesting authorization for device 00:0D:44:2F:D2:F7, UUID
00001112-0000-1000-8000-00805F9B34FB
audio[6598]: State changed /org/bluez/audio/device1:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[6598]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[6598]: Accepted headset connection from 00:0D:44:2F:D2:F7 for
/org/bluez/audio/device1
hcid[6594]: link_key_notify (sba=00:1A:6B:BB:82:5D, dba=00:0D:44:2F:D2:F7)
audio[6598]: Received AT+CKPD=200


=== aplay -D plugbt /usr/share/sounds/startup.wav

audio[6598]: Accepted new client connection on unix socket (fd=10)
audio[6598]: Audio API: received BT_GETCAPABILITIES_REQ
audio[6598]: Audio API: sending BT_GETCAPABILITIES_RSP
audio[6598]: Audio API: received BT_SETCONFIGURATION_REQ
audio[6598]: config sco - device = 00:0D:44:2F:D2:F7 access_mode = 2
audio[6598]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
audio[6598]: SCO socket opened for headset /org/bluez/audio/device1
audio[6598]: SCO fd=11
audio[6598]: Audio API: sending BT_SETCONFIGURATION_RSP
audio[6598]: State changed /org/bluez/audio/device1:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
audio[6598]: Audio API: received BT_STREAMSTART_REQ
audio[6598]: Audio API: sending BT_STREAMSTART_RSP
audio[6598]: Audio API: sending BT_STREAMFD_IND
audio[6598]: Received AT+VGS=13
... HANGS HERE.... (CTRL-C)
audio[6598]: Unix client disconnected (fd=10)
audio[6598]: State changed /org/bluez/audio/device1:
HEADSET_STATE_PLAYING -> HEADSET_STATE_DISCONNECTED


sox sometimes works, sometimes make a "beep" noise
 (long beep, as long as the device is open)

arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE
usually works, sometimes "beeps" as sox

What other information can be useful for debugging?

One more question: why is the headphone disconnected when the device is
closed? Would it not be better to just stop the audio flow and leave the
headphone in the HEADSET_STATE_CONNECTED state? This would avoid de
delay of reconnecting the device when the device gets opened.

Thank you for your help,
Regards,
Ludovico Cavedon

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
