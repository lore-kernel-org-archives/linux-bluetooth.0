Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jan 2008 14:50:52 +0100
From: Benito Torres <bluez-users@mv.so36.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080121135052.GB20816@juIljoat8>
References: <47928635.2030400@gmx.net>
	<d89ddf300801192041o12e98ee7ybeeb28efb2fdfa1d@mail.gmail.com>
	<479346D7.1080500@gmx.net>
	<d89ddf300801200639h393483e3y2ca35af47b93a608@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <d89ddf300801200639h393483e3y2ca35af47b93a608@mail.gmail.com>
Subject: Re: [Bluez-users] audio bluetooth connectivity in gutsy
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

excuse me for jumping in: I'm trying to use the same headset with a
BTA-3120 bluetooth dongle of which hciconfig also says "Unsupported
manufacturer"[1] (with bluez-utils v3.24, no sco/plugz/bt-alsa).

Nevertheless I can go one step further than Gunnar: the audio player
starts up, the headset-speaker beeps, but then there's only noise and
the audio player (mplayer in this case) doesn't start to play but (after
a while) shows errors:

  [AO_ALSA] Write error: Resource temporarily unavailable
  [AO_ALSA] Trying to reset soundcard.
  A:   1.1 (01.0) of 1.0 (01.0)  0.8% 

After some more time (the piece of sound normally would already have
ended):

  2 bytes of audio data lost due to buffer overflow, len = 4

To my uneducated eyes this looks like the audio stream somehow can't be
transmitted while the "signalling" works.

This is exactly the same behaviour as described by David Elze on this
list at November 4th:
http://sourceforge.net/mailarchive/message.php?msg_name=1194192865.2823.20.camel%40aero64.datenschrott.de

So my question: might the problem also be the headset? Is there any
point in trying to get it work, maybe with a different dongle? Or should
I rather look for a different headset and stay with my dongle (which one
works well besides for this problem)?


Thanks a lot for your opinion, Ben


[1]
$> hciconfig -a
hci0:	Type: USB
	BD Address: 00:0A:94:16:B9:25 ACL MTU: 120:20 SCO MTU: 50:0
	UP RUNNING PSCAN 
	RX bytes:2319423 acl:119 sco:45411 events:111 errors:0
	TX bytes:1768 acl:63 sco:0 commands:34 errors:0
	Features: 0xff 0xff 0x8d 0x78 0x18 0x18 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: MASTER 
	Name: 'flunder'
	Class: 0x08010c
	Service Classes: Capturing
	Device Class: Computer, Laptop
	HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x8a9
	Manufacturer: Silicon Wave (11)

$> hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:0A:94:16:B9:25 ACL MTU: 120:20 SCO MTU: 50:0
	Unsupported manufacturer


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
