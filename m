Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Johan Brannlund <johan_brn@yahoo.com>
Date: Tue, 11 Dec 2007 02:06:55 +0000 (UTC)
Message-ID: <pan.2007.12.11.02.06.55@yahoo.com>
Mime-Version: 1.0
Subject: [Bluez-users] Headset not working with audio service
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

Hi. I can't get my motorola H300 headset to work with the bluez audio 
service - on older kernels, it did work with headsetd, once I'd applied 
the SCO flow control patch (the bluetooth controller on my laptop is one 
of those troublesome broadcom devices).

Here's what I did and what happened:

$ arecord -D headset -f S16_LE test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, 
Mono
ALSA lib pcm_bluetooth.c:370:(bluetooth_hsp_hw_params) Protocol not 
available (92)
Aborted by signal Interrupt...

Even though arecord complains about an error, I get a file test.wav that 
correctly recorded what I said and I can play it through my regular 
speakers. But when I try to play it back through the headset I get

$ aplay -D headset -f S16_LE test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:370:(bluetooth_hsp_hw_params) Protocol not 
available (92)
aplay: pcm_write:1265: write error: Invalid argument


and aplay exits almost immediately, without playing any sound. When I run 
the above aplay command, bluetoothd-service-audio outputs



audio[7384]: Accepted new client connection on unix socket (fd=8)
audio[7384]: Package PKT_TYPE_CFG_REQ:0
audio[7384]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[7384]: /org/bluez/audio/device0: Connecting to 00:XX:XX:XX:XX:XX 
channel 2
audio[7384]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[7384]: /org/bluez/audio/device0: Connected to 00:XX:XX:XX:XX:XX
audio[7384]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
audio[7384]: SCO socket opened for headset /org/bluez/audio/device0
audio[7384]: SCO fd=10
audio[7384]: fd=10, fd_opt=1, pkt_len=48, sample_size=2, rate=8000
audio[7384]: 30 bytes sent
audio[7384]: 1 bytes sent
audio[7384]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
audio[7384]: Unix client disconnected (fd=8)
audio[7384]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAYING -> HEADSET_STATE_DISCONNECTED


Any ideas? This is with bluez 3.22 and the very latest 2.6.24-based 
Ubuntu kernel. 2.6.24-rc3 gives the same result...

- Johan


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
