Return-Path: <cyrus@holtmann.org>
Message-ID: <4939BB42.1080607@slackdot.org>
Date: Fri, 05 Dec 2008 18:37:38 -0500
From: "Rob \"Deker\" Dekelbaum" <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
 steve@sparta.com
Subject: [Bluez-devel] Continued SCO audio issues...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net


I posted a while back about having some issues getting SCO audio to work 
on some Compulab em-x270 boards. Well, we're still not there, but we've 
tried a lot more things. I'm going to describe the problem in some more 
detail now in the hopes that somebody here can help point me in a 
direction to get this working.

Symptoms:

  - Everything involved (bt headset, ALSA, aplay/mplayer/pulseaudio, 
etc) seems to think everything is working.
  - No sound comes out of the headset. We hear a hissing from the 
headset during actual audio playback (or when I have pulseaudio talking 
to it via 'module-alsa-sink' and the sink is not suspended).

Config(s) Tested:

 - Kernels: 2.6.23, 2.6.26, 2.6.27
 - Bluez: 3.26, 3.36, 4.12, 4.18
 - ALSA drivers: as shipped w/ kernels above

We've been through about every possible combination of the above. We've 
tried hci_usb and btusb. We've tested with 3 models of bt headset and 2 
development boards. For some reason, the ONLY place I can make SCO audio 
work is under a stock Ubuntu 8.10 (which uses Bluez 4.12, kernel 2.6.27, 
and ALSA 1.0.17 for the record).

I'm stumped. Here is some sample output from various pieces as we try to 
play a file. Right now we're using Bluez 3.36 (getting 4.x running on 
this platform was a bit of a PITA and was somewhat unstable so we backed 
out to what currently ships with openembedded)

We've tried with separate USB dongles (using the same chipset, that 
works under Ubuntu 8.10) so it's not the onboard BT chipset...

# hciconfig hci0 version
hci0:    Type: USB
    BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
    HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
    Manufacturer: Cambridge Silicon Radio (10)

# hciconfig hci0 revision
hci0:    Type: USB
    BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
    Unified 21e
    Chip version: BlueCore4-ROM
    Max key size: 128 bit
    SCO mapping:  PCM


~/.asoundrc:

pcm.bt {
        type bluetooth
        device 00:0B:2E:D5:27:DA
        profile voice
}

pcm.rbt {
        type plug
        slave {
                pcm bt
        }
}

/etc/bluetooth/audio.conf:
[General]
SCORouting=PCM

[Headset]
HFP=false


Pertinent output of "hcid -n -d" (this is what happens when I actually 
try to play audio with "aplay -D bt -f S16_LE test.wav". Yes, the test 
wavfile is 8Khz S16_LE PCM WAV audio):

hcid[1383]: Accepted new client connection on unix socket (fd=22)
hcid[1383]: Audio API: received BT_GETCAPABILITIES_REQ
hcid[1383]: Audio API: sending BT_GETCAPABILITIES_RSP
hcid[1383]: Audio API: received BT_SETCONFIGURATION_REQ
hcid[1383]: config sco - device = 00:0B:2E:D5:27:DA access_mode = 2
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
hcid[1383]: /org/bluez/audio/device0: Connecting to 00:0B:2E:D5:27:DA 
channel 2
hcid[1383]: link_key_request (sba=00:02:5B:00:A5:A5, dba=00:0B:2E:D5:27:DA)
hcid[1383]: kernel auth requirements = 0x00
hcid[1383]: stored link key type = 0x00
hcid[1383]: /org/bluez/audio/device0: Connected to 00:0B:2E:D5:27:DA
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
hcid[1383]: SCO socket opened for headset /org/bluez/audio/device0
hcid[1383]: SCO fd=24
hcid[1383]: Audio API: sending BT_SETCONFIGURATION_RSP
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
hcid[1383]: Audio API: received BT_STREAMSTART_REQ
hcid[1383]: Audio API: sending BT_STREAMSTART_RSP
hcid[1383]: Audio API: sending BT_STREAMFD_IND
hcid[1383]: Unix client disconnected (fd=22)
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
hcid[1383]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED


I'm open to any suggestions. If more info is needed, tell me what you'd 
like to see and I'll post it up.

Thanks in advance,

-d







------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
