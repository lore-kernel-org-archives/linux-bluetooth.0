Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47162FFD.3080408@pagema.net>
Date: Wed, 17 Oct 2007 17:53:33 +0200
From: maho+bluez <maho+bluez@pagema.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4716261D.40902@pagema.net>
In-Reply-To: <4716261D.40902@pagema.net>
Subject: Re: [Bluez-users] problem with alsa/bluetooth device
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

maho+bluez wrote:
> [...]
> Next, I have run:
> #v+
> maho@tereska:~/tmp$ aplay -v -Dbluetooth /tmp/ee.wav
> Playing WAVE '/tmp/ee.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
> available (92)
> Bluetooth Audio Device
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 1
>   rate         : 8000
>   exact rate   : 8000 (8000/1)
>   msbits       : 16
>   buffer_size  : 4008
>   period_size  : 24
>   period_time  : 3000
>   tick_time    : 0
>   tstamp_mode  : NONE
>   period_step  : 1
>   sleep_min    : 0
>   avail_min    : 24
>   xfer_align   : 24
>   start_threshold  : 4008
>   stop_threshold   : 4008
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 9025213653250473984
> aplay: pcm_write:1265: write error: Invalid argument
>   
And interesting thing: arecord reports the same error message...

#v+
maho@tereska:~/tmp$ LC_ALL=C arecord -D bluetooth -f S16_LE  > /tmp/eee.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
available (92)
#v-

, but /tmp/eee.wav contains properly recorded sound.

Any ideas?

regards

maHo



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
