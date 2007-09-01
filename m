Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 31 Aug 2007 20:55:56 -0400 (EDT)
From: David MacCormack <djm-list@maccormack.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1188569138.13373.90.camel@violet>
Message-ID: <Pine.LNX.4.61.0708311934050.31862@gur-jnyy.znppbeznpx.arg>
References: <Pine.LNX.4.61.0708310929010.31862@gur-jnyy.znppbeznpx.arg>
	<1188569138.13373.90.camel@violet>
MIME-Version: 1.0
Subject: Re: [Bluez-users] 3.16 + alsa + headset problems...
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


Hi Marcel.  Thanks for the quick response (and the great software ;)).

>
> if you headset supports A2DP then it should pick that before using the
> SCO channels. However you can add "profile a2dp" to .asoundrc to force
> it to use A2DP.
>

After adding "profile a2dp", I get the following error from alsa (using 
both mplayer and aplay):
     ALSA lib pcm_bluetooth.c:978:(bluetooth_cfg) Error 22 while
     configuring device aplay: main:545: audio open error: Invalid argument

I just tested "profile voice" and it works as before so I guess my headset 
doesn't support A2DP (Logitech Mobile Express), though I was led to 
believe it did based on some googling.  Rats.  Is it possible that A2DP is 
somehow just not enabled?  Im using alsa-lib-1.0.14a-r1 (Gentoo), 
bluez-libs-3.16, bluez-utils-3.16.  I checked the ebuild and I've 
configured bluez-utils with the following configure flags:
     --enable-inotify --enable-glib --disable-obex
     --enable-network --enable-serial --enable-input --enable-audio
     --disable-sync --enable-hcid --enable-configfiles
     --disable-initscripts --disable-pcmciarules --enable-bccmd
     --enable-avctrl --enable-hid2hci --enable-dfutool

My guess is that A2DP is handled by --enable-audio and that I'm just SOL 
but maybe you see something in there that makes A2DP disabled or 
otherwise wonky?

>> OK.  That's problem #1, and I bring it up because it may be related to
>> problem #2 (and the main reason I'm playing with a bluetooth headset).  I
>> tried to use my headset with Ekiga (aka gnomemeeting).  It uses alsa, so
>> encouraging it to use the headset was pretty easy, but the problem is that
>> it barfed with an error about requiring a full duplex device.  I'm just
>> getting started with this whole bluetooth thing so I guess the first
>> question is is it/can it be full duplex?  And, if so, how do I go about
>> convincing alsa that it is.
>
> It is full duplex by definition, but we just started to make voice
> headsets work. So there might be still problems.
>

I thought that might be the case.  No biggie.  I'll try again when the 
next release rolls out.  If there's any info that you'd like me to give 
you -- alsa output, trying patches, etc... -- let me know.

Hmmm... wait a tick.  I just tried arecord -Ddjm testbt.wav and got the 
following:
     Recording WAVE 'testbt.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
     ALSA lib pcm_bluetooth.c:306:(bluetooth_hsp_hw_params) Protocol not
     available (92)

It leaves behind an "empty" (44 byte) WAV file.  So it appears that 
recording is just not working at all.  I "hear" that it's trying to 
record.  That is, I hear a low-level of white noise in the headset just as 
I do whenever it's playing.  And arecord sits there like it normally would 
when successfully recording (e.g. recording from my soundcard, which 
works fine).  But, there's nothing in the output WAV. Here's the relevant 
syslog entries:

Aug 31 20:35:28 spooranch audio[23839]: Accepted new client connection on unix socket (fd=8)
Aug 31 20:35:28 spooranch audio[23839]: Package PKT_TYPE_CFG_REQ:0
Aug 31 20:35:28 spooranch audio[23839]: State changed /org/bluez/audio/device0: DISCONNECTED -> CONNECTING
Aug 31 20:35:29 spooranch hcid[23833]: link_key_request (sba=00:11:F6:0A:E6:25, dba=00:0D:FD:0A:5F:C5)
Aug 31 20:35:29 spooranch audio[23839]: /org/bluez/audio/device0: Connecting to 00:0D:FD:0A:5F:C5 channel 1
Aug 31 20:35:30 spooranch audio[23839]: State changed /org/bluez/audio/device0: CONNECTING -> CONNECTED
Aug 31 20:35:30 spooranch audio[23839]: /org/bluez/audio/device0: Connected to 00:0D:FD:0A:5F:C5
Aug 31 20:35:30 spooranch audio[23839]: State changed /org/bluez/audio/device0: CONNECTED -> STREAM_STARTING
Aug 31 20:35:30 spooranch audio[23839]: SCO socket opened for headset /org/bluez/audio/device0
Aug 31 20:35:30 spooranch audio[23839]: SCO fd=10
Aug 31 20:35:30 spooranch audio[23839]: fd=10, fd_opt=2, channels=1, pkt_len=48,sample_size=2, rate=8000
Aug 31 20:35:30 spooranch audio[23839]: 31 bytes sent
Aug 31 20:35:30 spooranch audio[23839]: 22 bytes sent
Aug 31 20:35:30 spooranch audio[23839]: State changed /org/bluez/audio/device0: STREAM_STARTING -> STREAMING
Aug 31 20:35:36 spooranch audio[23839]: Unix client disconnected (fd=8)
Aug 31 20:35:36 spooranch audio[23839]: State changed /org/bluez/audio/device0: STREAMING -> DISCONNECTED


Here's my .asoundrc:

pcm.bluetooth {
    type bluetooth
    device 00:0D:FD:0A:5F:C5
#   profile a2dp
#   profile voice
}

ctl.bluetooth {
    type bluetooth
    device 00:0D:FD:0A:5F:C5
}

pcm.djm {
     type plug
     slave {
         pcm "bluetooth"
     }
}

I have to use the djm PCM because I need plug to do rate conversions. 
Otherwise, everything is played "slow" (e.g. not resampled to 8000) like 
its stuck in a jar of molasas.  And if I try to arecord directly from
pcm.bluetooth I get "arecord: set_params:900: Sample format non 
available".  Using plug does the trick, though.

So, any idea what the problem might be?  Maybe the "Protocol not 
available" bit?

Thanks,

Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
