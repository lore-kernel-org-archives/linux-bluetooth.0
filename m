Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin Soto <soto@informatik.uni-kl.de>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 23 Sep 2007 16:47:45 +0200
Message-Id: <1190558865.8868.38.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Sony Ericsson Headset HBH-PV705 and recording
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi everyone:

I'm trying to configure my brand new Sony Ericsson headset, model
HBH-PV705, to make phone calls (Skype, Ekiga) from my Ubuntu system. I
managed to get it to play audio sent from the computer, by I'm not being
able to record any audio from the headset's microphone. Since I already
tried everything else I found on the Net to no avail, I was wondering if
anyone here could give me some light to investigate the problem further.

So, first of all, I'm running Ubuntu Gutsy (current development version)
and bluez-utils v. 3.19 installed from Ubuntu. My .asoundrc looks like
this:

pcm.bluetooth {
   type bluetooth
   device 00:18:13:E2:66:81
}

pcm.bluetooth-resample {
    # Resample device
    type plug
    slave {
        pcm "bluetooth"
        rate 8000
        format S16_LE
        channels 1
    }
}

The second stance (bluetooth-resample) is necessary to play audio with
sample rates different from 8000Hz.

I used the instructions in http://wiki.bluez.org/wiki/HOWTO/AudioDevices
as follows:

Activate:

$ dbus-send --system --type=method_call --print-reply \
--dest=org.bluez /org/bluez org.bluez.Manager.ActivateService \
string:audio

method return sender=:1.11 -> dest=:1.65 reply_serial=2
   string ":1.13"

Connect:

$ dbus-send --system --type=method_call --print-reply --dest=":1.13" \
 "/org/bluez/audio/device0" org.bluez.audio.Headset.Connect

This takes about 10 seconds. During this time, the following messages
appear in /var/log/syslog:

Sep 23 16:04:51 localhost audio[13046]: /org/bluez/audio/device0: org.bluez.audio.Headset.Connect()
Sep 23 16:04:51 localhost audio[13046]: State changed /org/bluez/audio/device0: DISCONNECTED -> CONNECTING
Sep 23 16:05:00 localhost audio[13046]: /org/bluez/audio/device0: Connecting to 00:18:13:E2:66:81 channel 1
Sep 23 16:05:06 localhost audio[13046]: State changed /org/bluez/audio/device0: CONNECTING -> CONNECTED
Sep 23 16:05:06 localhost audio[13046]: /org/bluez/audio/device0: Connected to 00:18:13:E2:66:81
Sep 23 16:05:07 localhost audio[13046]: Unknown headset event
Sep 23 16:05:10 localhost last message repeated 2 times

The final result is:

method return sender=:1.13 -> dest=:1.66 reply_serial=2

Play:

$ dbus-send --system --type=method_call --print-reply --dest=":1.13" \
 "/org/bluez/audio/device0" org.bluez.audio.Headset.Play
method return sender=:1.13 -> dest=:1.67 reply_serial=2

The headset beeps, and the following log messages appear:

Sep 23 16:08:06 localhost audio[13046]: /org/bluez/audio/device0: org.bluez.audio.Headset.Play()
Sep 23 16:08:06 localhost audio[13046]: State changed /org/bluez/audio/device0: CONNECTED -> STREAM_STARTING
Sep 23 16:08:06 localhost NetworkManager: <debug> [1190556486.912004] nm_hal_device_added(): New device added (hal udi is '/org/freedesktop/Hal/devices/usb_device_df6_2200_noserial_if0_bluetooth_hci_bluetooth_hci_0'). 
Sep 23 16:08:08 localhost audio[13046]: SCO socket opened for headset /org/bluez/audio/device0
Sep 23 16:08:08 localhost audio[13046]: SCO fd=9
Sep 23 16:08:08 localhost audio[13046]: State changed /org/bluez/audio/device0: STREAM_STARTING -> STREAMING

Up to this point everything seems OK. Now if I try to record some audio
from the headset:

$ arecord -D bluetooth -f S16_LE test.wav

the following messages appear in the log:

Sep 23 16:12:51 localhost audio[13046]: Accepted new client connection on unix socket (fd=10)
Sep 23 16:12:51 localhost audio[13046]: Package PKT_TYPE_CFG_REQ:0
Sep 23 16:12:51 localhost audio[13046]: fd=9, fd_opt=0, pkt_len=48, sample_size=2, rate=8000
Sep 23 16:12:51 localhost audio[13046]: 30 bytes sent
Sep 23 16:12:51 localhost audio[13046]: 1 bytes sent
Sep 23 16:12:59 localhost audio[13046]: Unix client disconnected (fd=10)
Sep 23 16:12:59 localhost audio[13046]: State changed /org/bluez/audio/device0: STREAMING -> DISCONNECTED
Sep 23 16:13:00 localhost NetworkManager: <debug> [1190556780.191909] nm_hal_device_removed(): Device removed (hal udi is '/org/freedesktop/Hal/devices/usb_device_df6_2200_noserial_if0_bluetooth_hci_bluetooth_hci_0'). 

After I interrupt arecord, an "empty" 44 bytes test.wav file is all I
have. I have tried to run arecord with diverse format options, but it
fails unless the format is set to 8000hz, S16_LE, mono. I also tried to
limit the recording time with the -d option, but it hangs and must
eventually be interrupted by hand, leaving also a 44 byte file.

On the other hand, something like

$ aplay -D bluetooth-resample /usr/share/sounds/ekiga/ring.wav

run after issuing the Connect and Play methods, plays the file correctly
through the headset.

Does anyone have a clue of what's going on here?

Thanks a lot,

M. S.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
