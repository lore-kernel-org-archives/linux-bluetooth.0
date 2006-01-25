Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D7270C.5020805@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] alsa plugin progress
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
Date: Wed, 25 Jan 2006 00:21:48 -0700

Marcel,

I've been tweaking the alsa plugin. How close was it when you had it?

For now, I am setting the socket to nonblocking and polling until the
connect succeeds (I keep trying when errno is EAGAIN). I can connect and
things seem to be working but there is no audio. It looks like there's a
mismatch with audio settings but I'm not sure where that's happening.

Brad

DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:08:F4:46:03:1C
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x805ac80
DEBUG: connect_l2cap: Can't connect to 1C:03:46:F4:08:00 on psm 25.
Resource temporarily unavailable(11)
DEBUG: connect_l2cap: Can't connect to 1C:03:46:F4:08:00 on psm 25.
Resource temporarily unavailable(11)
DEBUG: connect_l2cap: Can't connect to 1C:03:46:F4:08:00 on psm 25.
Resource temporarily unavailable(11)
DEBUG: connect_l2cap: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: retrying discover response read...
DEBUG: connect_stream: Got a Stream End Point Discovery Response
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: SEID = 1
DEBUG: process_seid: Requested Capabilities for SEID = 1
DEBUG: process_seid: Got capabilities response
DEBUG: process_seid: headset does not support this channel mode
DEBUG: process_seid: headset does not support this frequency
DEBUG: process_seid: headset does not support this allocation_method
DEBUG: process_seid: headset does not support this subbands setting
DEBUG: process_seid: Sent set configurations command
DEBUG: process_seid: Set configurations command rejected
DEBUG: process_seid: Sent open stream command
DEBUG: process_seid: Got open stream confirm
DEBUG: connect_l2cap: Can't connect to 1C:03:46:F4:08:00 on psm 25.
Resource temporarily unavailable(11)
DEBUG: connect_l2cap: Connected [imtu 672, omtu 0, flush_to 65535]
DEBUG: connect_stream: Sent stream start
DEBUG: connect_stream: Got start stream confirm
DEBUG: a2dp_constraint: a2dp 0x805ac80
Playing WAVE '/usr/lib/openoffice2/share/gallery/sounds/pluck.wav' :
Signed 16 bit Little Endian, Rate 11025 Hz, Mono
Warning: rate is not accurate (requested = 11025Hz, got = 44100Hz)
         please, try the plug plugin (-Dplug:pcm.headphone)
DEBUG: a2dp_params: a2dp 0x805ac80
DEBUG: a2dp_params: format S16_LE rate 44100 channels 1
DEBUG: a2dp_params: frame_bytes 2 period_bytes 8192 period_size 4096
buffer_size 8192
DEBUG: a2dp_prepare: a2dp 0x805ac80
DEBUG: a2dp_drain: a2dp 0x805ac80
DEBUG: a2dp_stop: a2dp 0x805ac80
DEBUG: a2dp_stop: a2dp 0x805ac80
DEBUG: a2dp_close: a2dp 0x805ac80


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
