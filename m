Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D17895.6050001@xmission.com>
Date: Wed, 02 Aug 2006 22:16:21 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>	<44D0350A.8090904@xmission.com>
	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>
In-Reply-To: <3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
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

keith

>>> Sample Rate:44100
>>> Channels:1
>>
>>try something in stereo just in case we don't set things right for mono.
> 
> I tried a stereo file and now it works! 

ok, maybe what we're calling "directive 8" is a reconfigure request
because the set doesn't like mono. if we're doing it right then it's
another case of a set that drifts from the spec.

>     >     So probably, the headset is trying to connect on AVRCP, which
>     we reject.
> 
>     good find here.
> 
>     Keith, could you run
>     sdptool add AVRTG
>     ./avrecv
>     and see if the headset is sending avrcp messages?
> 
> 
> I tried those commands and it looks like no luck.  The output is below.
>   A little about the headset, it comes in a pack with a bluetooth
> transmitter that hooks into the ipod nano.  The headset has controls for
> volume and also for track forward and track backward.   I don't know if
> these commands are part of the headset profile, so that might make this
> headset a bit off the standard.

these buttons are what avrcp is about. it is optional but it's pretty
much expected from any current set. avrecv listens for an avrcp
connection coming back from the set. most sets will turn around and try
to connect back using avrcp when the stream is opened. you can also try
avsnd to initiate the avrcp connection to the set and listen for events.

> Ok, so now on to my next mission to get the alsa plugin to work.  Here
> is the error I am experiencing now with the alsa plugin.
> 
> 
> preston@ubuntu:~/bluetooth/btsco/alsa-plugins$ aplay -B 1000000 -D
> pcm.headphone ~/music/41_30sec.wav
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
> DEBUG: a2dp_alloc: init
> DEBUG: a2dp_connect: a2dp 0x8076478 (sk=0, control_sk=0)
> DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00
> DEBUG: detect_a2dp: retrying sdp connect: Interrupted system call
> DEBUG: detect_a2dp: Found A2DP Sink
> DEBUG: connect_stream: Found A2DP Sink at the destination
> DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
> DEBUG: connect_stream: Sent the Stream End Point Discovery Command
> DEBUG: connect_stream: couldn't get avdtp_discover

it doesn't like the value of size of the avdtp_discover response.

there's code in a2play.c but not in pcm_a2dp that retries this call if
the size read is short (2 bytes) instead of the full response. would you
like to try to modify pcm_a2dp.c to contain this exception? Look for
"blueant" in a2play.c.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
