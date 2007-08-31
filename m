Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 31 Aug 2007 09:57:02 -0400 (EDT)
From: David MacCormack <djm-list@maccormack.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0708310929010.31862@gur-jnyy.znppbeznpx.arg>
MIME-Version: 1.0
Subject: [Bluez-users] 3.16 + alsa + headset problems...
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


Hi fellow bluezers.  I followed the instructions from
    http://wiki.bluez.org/wiki/HOWTO/AudioDevices

and I can successfully play audio on my headset via mplayer and alsa 
(yea!).  However, I'm having a few problems.  The first is the following 
error that mplayer spits out:
     [AO_ALSA] alsa-lib: pcm_bluetooth.c:306:(bluetooth_hsp_hw_params)
     Protocol not available (92)

I plays the audio, but I get that error (consitantly).  I peaked at the 
source and it looks as though you're intentionally ignoring the error. 
Any idea why I'm seeing it?  Here's what I see in /var/log/messages:

Aug 31 09:30:13 spooranch audio[22006]: Accepted new client connection on unix socket (fd=8)
Aug 31 09:30:13 spooranch audio[22006]: Package PKT_TYPE_CFG_REQ:0
Aug 31 09:30:13 spooranch audio[22006]: State changed /org/bluez/audio/device0: DISCONNECTED -> CONNECTING
Aug 31 09:30:17 spooranch hcid[22000]: link_key_request (sba=00:11:F6:0A:E6:25, dba=00:0D:FD:0A:5F:C5)
Aug 31 09:30:17 spooranch audio[22006]: /org/bluez/audio/device0: Connecting to 00:0D:FD:0A:5F:C5 channel 1
Aug 31 09:30:18 spooranch audio[22006]: State changed /org/bluez/audio/device0: CONNECTING -> CONNECTED
Aug 31 09:30:18 spooranch audio[22006]: /org/bluez/audio/device0: Connected to 00:0D:FD:0A:5F:C5
Aug 31 09:30:18 spooranch audio[22006]: State changed /org/bluez/audio/device0: CONNECTED -> STREAM_STARTING
Aug 31 09:30:18 spooranch audio[22006]: SCO socket opened for headset /org/bluez/audio/device0
Aug 31 09:30:18 spooranch audio[22006]: SCO fd=10
Aug 31 09:30:18 spooranch audio[22006]: fd=10, fd_opt=2, channels=1, pkt_len=48,sample_size=2, rate=8000
Aug 31 09:30:18 spooranch audio[22006]: 31 bytes sent
Aug 31 09:30:18 spooranch audio[22006]: 22 bytes sent
Aug 31 09:30:18 spooranch audio[22006]: State changed /org/bluez/audio/device0: STREAM_STARTING -> STREAMING
Aug 31 09:34:08 spooranch audio[22006]: Unix client disconnected (fd=8)
Aug 31 09:34:08 spooranch audio[22006]: State changed /org/bluez/audio/device0: STREAMING -> DISCONNECTED

>>From what I can see, alsa is using the headset profile by default.  Is 
there something I can put in my .asoundrc to force a2dp?  I'd like to see 
what the quality is like.

OK.  That's problem #1, and I bring it up because it may be related to 
problem #2 (and the main reason I'm playing with a bluetooth headset).  I 
tried to use my headset with Ekiga (aka gnomemeeting).  It uses alsa, so 
encouraging it to use the headset was pretty easy, but the problem is that 
it barfed with an error about requiring a full duplex device.  I'm just 
getting started with this whole bluetooth thing so I guess the first 
question is is it/can it be full duplex?  And, if so, how do I go about 
convincing alsa that it is.

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
