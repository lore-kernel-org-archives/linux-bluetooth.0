Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
Date: Tue, 13 Feb 2007 01:56:33 +0000
From: "Mike Hodson" <mystica@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Successes and failures with btsco/bluez respectively
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

Hi there.  I'm posting this to the -devel list, as I think this has
more to do with the current state of the software, rather than how I'm
using it.

I just got my gentoo box working with the newest bluez package (3.9)
and it works wonderfully for scanning bluetooth devices and whatnot.
However, I also own an a2dp headset (BlueSpoon Spider) that I am
aching to use around my house while doing chores, and not bug family
members.

Now, I went and did what your page suggested first off: I downloaded
the CVS for the source of plugz. I then went about compiling it,
getting a2dpd running, getting my bdaddr right and everything. Then i
went about trying to get it to play back.  Your reports said "xmms
works" so i ofcourse tried xmms.  What happened, that bugged me for
the longest time was it would just sit, at 0:00 like its trying to
open the sound device, a2dpd shows no connection info or anything.

So, i went on about my day reading more list archives.

After a while, i decided to try mplayer, vlc, and even audacious.  Of
the 4, only vlc and mplayer worked at all (produced any connection to
a2dpd whatsoever) but i noticed a somewhat random pausing of the sound
into my headset.  The bluetooth dongle i have, a Belkin F8T001v2 will
normally show full-time blue light for sending, but during the
interrupted sound, the blue light went to blink a few times, then
continued full blue when i heard sound again.
This puzzled me to no end, because I had been reading reports of
success with similar CSR dongles and xmms with the alsa a2dpd pcm
plugin.

Then i read that there was a newer plugin, a2dpd2.  So i edited my
.asoundrc to that, and tried all 4 again, to much different results,
in every respect.
All 4 now caused a2dpd to connect and start transferring audio. Then,
a2dpd disconnected, tried to reconnect, disconnected, connected
reconnected without disconnecting ... needless to say it was worse
than even when the audio paused every few seconds.

Finally, I decided to try the 'last known fallback that should work
fine', btsco-0.5 from sf.net.
I had read someone mention that audio would sometimes jitter because
of the nvidia closed source video drivers, and as I am using that
driver, i feared the worst. But, to my surprise, a2play was completely
successful at sending uninterrupted sound to my headset for an entire
4 minute song!  I also edited a2play.c to edit the bitpool from 32
(sounds craptacular) to 53 (sounds perfect with my input, no pops, no
clicks no overamping nothing).

What do you think is happening with plugz / alsa plugins that cause
the errors I have listed?
Do you need any sort of logs from hcidump when the a2dpd2 plugin
causes disconnects?

Also, one thing I have noticed about my headset: The avrcp controls
seem to be sent twice when I press the joystick buttons. Hitting the
playpause button exactly 2 times produces:

A2DPD[218.721]: a2dpd_signal_command: avrcp_play
A2DPD[218.827]: a2dpd_signal_command: avrcp_play
A2DPD[219.215]: a2dpd_signal_command: avrcp_pause
A2DPD[219.300]: a2dpd_signal_command: avrcp_pause

However, stopping the playback (ctrl-c on say, mplayer) only causes
the headset to emit 1 avrcp_stop command.

The info for this device is:

hci0:   Type: USB
        BD Address: 00:0A:3A:59:90:77 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:636236 acl:135 sco:0 events:90176 errors:0
        TX bytes:22854468 acl:131804 sco:0 commands:69 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'thor'
        Class: 0x3e0104
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)

Headset info:

        BD Address:  00:14:CF:03:37:DC
        Device Name: Bluespoon SPIDER
        LMP Version: 2.0 (0x3) LMP Subversion: 0xbf1
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
