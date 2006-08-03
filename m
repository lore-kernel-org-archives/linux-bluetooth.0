Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>
Date: Thu, 3 Aug 2006 09:47:46 -0500
From: "keith preston" <keithpre@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D17895.6050001@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7208_25649061.1154616466596"
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>
	<44D0350A.8090904@xmission.com>
	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>
	<44D17895.6050001@xmission.com>
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_7208_25649061.1154616466596
Content-Type: multipart/alternative;
	boundary="----=_Part_7209_9984725.1154616466596"

------=_Part_7209_9984725.1154616466596
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > preston@ubuntu:~/bluetooth/btsco/alsa-plugins$ aplay -B 1000000 -D
> > pcm.headphone ~/music/41_30sec.wav
> > DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0
> > DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
> > DEBUG: a2dp_alloc: init
> > DEBUG: a2dp_connect: a2dp 0x8076478 (sk=0, control_sk=0)
> > DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00
> > DEBUG: detect_a2dp: retrying sdp connect: Interrupted system call
> > DEBUG: detect_a2dp: Found A2DP Sink
> > DEBUG: connect_stream: Found A2DP Sink at the destination
> > DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
> > DEBUG: connect_stream: Sent the Stream End Point Discovery Command
> > DEBUG: connect_stream: couldn't get avdtp_discover
>
> it doesn't like the value of size of the avdtp_discover response.
>
> there's code in a2play.c but not in pcm_a2dp that retries this call if
> the size read is short (2 bytes) instead of the full response. would you
> like to try to modify pcm_a2dp.c to contain this exception? Look for
> "blueant" in a2play.c.
>
> brad



I took you suggestion and this corrected the problem.  Attached is a patch.



Now on to other problems.  I can play audio out of xmms, but it will only
play the first track I play in XMMS,  Once I go to another track, the a2dp
connection stays, but all I hear is silence.    I am using just a bunch of
different sample audio files (not really a standardized collection like most
people have), but I tested it with quite a few different combinations.  Here
is the debug output

libmikmod.so.2: cannot open shared object file: No such file or directory
Message: device: pcm.headphone
total-tracks: 1
testing-track: 0
total-tracks: 1
testing-track: 0
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x8278b48 (sk=0, control_sk=0)
DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination
DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: Discovery Response is Wrong Size, Trying Read Again
DEBUG: connect_stream: Got a Stream End Point Discovery Response
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: SEID = 1
DEBUG: process_seid: Requested Capabilities for SEID = 1
DEBUG: process_seid: Got capabilities response
DEBUG: process_seid: Sent set configurations command
DEBUG: process_seid: Set configurations command accepted
DEBUG: process_seid: Sent open stream command
DEBUG: process_seid: Got open stream confirm
DEBUG: do_connect: Connected [imtu 672, omtu 674, flush_to 65535]
DEBUG: connect_stream: Sent stream start
DEBUG: connect_stream: Got start stream confirm
DEBUG: a2dp_constraint: TEST a2dp 0x8278b48
DEBUG: a2dp_params: a2dp 0x8278b48
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048
buffer_size 4096
DEBUG: a2dp_prepare: a2dp 0x8278b48
Listen thread running
Awaiting command
DEBUG: a2dp_stop: a2dp 0x8278b48
DEBUG: a2dp_stop: Listen thread terminating Thread in signal handler 14
Error while receiving -1 (errno=4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_prepare: a2dp 0x8278b48
MP4 - 2 channels @ 44100 Hz
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [26703 bps]
<<<<<<<<<<<<<< This is where I skip tracks in xmms
DEBUG: a2dp_stop: a2dp 0x8278b48
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x8278b48
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x8278b48
DEBUG: a2dp_close: OK
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
DEBUG: a2dp_constraint: TEST a2dp 0x8278b48
DEBUG: a2dp_params: a2dp 0x8278b48
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048
buffer_size 4096
DEBUG: a2dp_prepare: a2dp 0x8278b48
SBC Bandwidth = 24 kbps [25461 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [26703 bps]
DEBUG: a2dp_stop: a2dp 0x8278b48
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x8278b48
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x8278b48
DEBUG: a2dp_close: OK


Just as a side note (maybe this deserves a new thread).   I'm been looking a
lot through the archives, but I am still wondering what is the current state
of progress in the bluetooth-alsa project?  What work still need to be
done?   I have interest in furthering the project and more notably, my
employer also has interest.   We are working on support for embedded arm
platform and are looking for integration possible with gstreamer as most of
our audio framework will use gstreamer.

Keith Preston

------=_Part_7209_9984725.1154616466596
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&gt; preston@ubuntu:~/bluetooth/btsco/alsa-plugins$ aplay -B 1000000 -D<br>&gt; 
pcm.headphone ~/music/41_30sec.wav<br>&gt; DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0<br>&gt; DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50<br>&gt; DEBUG: a2dp_alloc: init<br>&gt; DEBUG: a2dp_connect: a2dp 0x8076478 (sk=0, control_sk=0)
<br>&gt; DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00<br>&gt; DEBUG: detect_a2dp: retrying sdp connect: Interrupted system call<br>&gt; DEBUG: detect_a2dp: Found A2DP Sink<br>&gt; DEBUG: connect_stream: Found A2DP Sink at the destination
<br>&gt; DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]<br>&gt; DEBUG: connect_stream: Sent the Stream End Point Discovery Command<br>&gt; DEBUG: connect_stream: couldn't get avdtp_discover<br><br>it doesn't like the value of size of the avdtp_discover response.
<br><br>there's code in a2play.c but not in pcm_a2dp that retries this call if<br>the size read is short (2 bytes) instead of the full response. would you<br>like to try to modify pcm_a2dp.c to contain this exception? Look for
<br>&quot;blueant&quot; in a2play.c.<br><br>brad</blockquote><div><br><br>I took you suggestion and this corrected the problem.&nbsp; Attached is a patch.<br><br><br><br>Now on to other problems.&nbsp; I can play audio out of xmms, but it will only play the first track I play in XMMS,&nbsp; Once I go to another track, the a2dp connection stays, but all I hear is silence.&nbsp;&nbsp;&nbsp; I am using just a bunch of different sample audio files (not really a standardized collection like most people have), but I tested it with quite a few different combinations.&nbsp; Here is the debug output
<br><br>libmikmod.so.2: cannot open shared object file: No such file or directory<br>Message: device: pcm.headphone<br>total-tracks: 1<br>testing-track: 0<br>total-tracks: 1<br>testing-track: 0<br>DEBUG: _snd_pcm_a2dp_open: name 
pcm.headphone mode 1<br>DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50<br>DEBUG: a2dp_alloc: init<br>DEBUG: a2dp_connect: a2dp 0x8278b48 (sk=0, control_sk=0)<br>DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00
<br>DEBUG: detect_a2dp: Found A2DP Sink<br>DEBUG: connect_stream: Found A2DP Sink at the destination<br>DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]<br>DEBUG: connect_stream: Sent the Stream End Point Discovery Command
<br>DEBUG: connect_stream: Discovery Response is Wrong Size, Trying Read Again<br>DEBUG: connect_stream: Got a Stream End Point Discovery Response<br>DEBUG: connect_stream: received 1 capabilities<br>DEBUG: process_seid: SEID = 1
<br>DEBUG: process_seid: Requested Capabilities for SEID = 1<br>DEBUG: process_seid: Got capabilities response<br>DEBUG: process_seid: Sent set configurations command<br>DEBUG: process_seid: Set configurations command accepted
<br>DEBUG: process_seid: Sent open stream command<br>DEBUG: process_seid: Got open stream confirm<br>DEBUG: do_connect: Connected [imtu 672, omtu 674, flush_to 65535]<br>DEBUG: connect_stream: Sent stream start<br>DEBUG: connect_stream: Got start stream confirm
<br>DEBUG: a2dp_constraint: TEST a2dp 0x8278b48<br>DEBUG: a2dp_params: a2dp 0x8278b48<br>DEBUG: a2dp_params: format S16_LE rate 44100 channels 2<br>DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buffer_size 4096
<br>DEBUG: a2dp_prepare: a2dp 0x8278b48<br>Listen thread running<br>Awaiting command<br>DEBUG: a2dp_stop: a2dp 0x8278b48<br>DEBUG: a2dp_stop: Listen thread terminating Thread in signal handler 14 Error while receiving -1 (errno=4:Interrupted system call)
<br>listen_thread: ending perfeclty<br>DEBUG: a2dp_stop: Listen thread terminated<br>DEBUG: a2dp_stop: OK<br>DEBUG: a2dp_prepare: a2dp 0x8278b48<br>MP4 - 2 channels @ 44100 Hz<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]
<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]
<br>SBC Bandwidth = 26 kbps [26703 bps]<br>&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt; This is where I skip tracks in xmms<br>DEBUG: a2dp_stop: a2dp 0x8278b48<br>DEBUG: a2dp_stop: Listen thread terminating<br>
DEBUG: a2dp_stop: Listen thread terminated<br>DEBUG: a2dp_stop: OK<br>DEBUG: a2dp_stop: a2dp 0x8278b48<br>DEBUG: a2dp_stop: Listen thread terminating<br>DEBUG: a2dp_stop: Listen thread terminated<br>DEBUG: a2dp_stop: OK<br>
DEBUG: a2dp_close: a2dp Destroying 0x8278b48<br>DEBUG: a2dp_close: OK<br>DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1<br>DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50<br>DEBUG: a2dp_constraint: TEST a2dp 0x8278b48
<br>DEBUG: a2dp_params: a2dp 0x8278b48<br>DEBUG: a2dp_params: format S16_LE rate 44100 channels 2<br>DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buffer_size 4096<br>DEBUG: a2dp_prepare: a2dp 0x8278b48
<br>SBC Bandwidth = 24 kbps [25461 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]
<br>SBC Bandwidth = 26 kbps [27324 bps]<br>SBC Bandwidth = 26 kbps [26703 bps]<br>DEBUG: a2dp_stop: a2dp 0x8278b48<br>DEBUG: a2dp_stop: Listen thread terminating<br>DEBUG: a2dp_stop: Listen thread terminated<br>DEBUG: a2dp_stop: OK
<br>DEBUG: a2dp_stop: a2dp 0x8278b48<br>DEBUG: a2dp_stop: Listen thread terminating<br>DEBUG: a2dp_stop: Listen thread terminated<br>DEBUG: a2dp_stop: OK<br>DEBUG: a2dp_close: a2dp Destroying 0x8278b48<br>DEBUG: a2dp_close: OK
<br><br><br>Just as a side note (maybe this deserves a new thread).&nbsp;&nbsp; I'm been looking a lot through the archives, but I am still wondering what is the current state of progress in the bluetooth-alsa project?&nbsp; What work still need to be done?&nbsp;&nbsp; I have interest in furthering the project and more notably, my employer also has interest.&nbsp;&nbsp; We are working on support for embedded arm platform and are looking for integration possible with gstreamer as most of our audio framework will use gstreamer.&nbsp; 
<br><br>Keith Preston<br></div><br></div><br>

------=_Part_7209_9984725.1154616466596--

------=_Part_7208_25649061.1154616466596
Content-Type: application/octet-stream; name="incorrect_response_size.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="incorrect_response_size.patch"
X-Attachment-Id: f_eqf8rjkz

SW5kZXg6IGJ0c2NvL2Fsc2EtcGx1Z2lucy9wY21fYTJkcC5jDQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmls
ZTogL2N2c3Jvb3QvYmx1ZXRvb3RoLWFsc2EvYnRzY28vYWxzYS1wbHVnaW5zL3BjbV9hMmRwLmMs
dg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE0DQpkaWZmIC11IC1yMS4xNCBwY21fYTJkcC5jDQot
LS0gYnRzY28vYWxzYS1wbHVnaW5zL3BjbV9hMmRwLmMJMjggSnVsIDIwMDYgMjE6NTg6MDUgLTAw
MDAJMS4xNA0KKysrIGJ0c2NvL2Fsc2EtcGx1Z2lucy9wY21fYTJkcC5jCTMgQXVnIDIwMDYgMTQ6
MTY6NDAgLTAwMDANCkBAIC00NzgsNiArNDc4LDEyIEBADQogCQkJYnJlYWs7DQogCQl9DQogCX0N
CisJaWYgKHNpemUgPT0gMiAmJiBnZXRfcmVzcC5oZWFkZXIubWVzc2FnZV90eXBlID09IDAgJiYg
Z2V0X3Jlc3AuaGVhZGVyLnBhY2tldF90eXBlID09IDApIA0KKwl7DQorCQkvLyBUcnkgYWdhaW4g
aWYgdGhpcyBmYWlscyBvbmNlIChCbHVlQW50IGhlYWRzZXQpDQorCQlEQkcoIkRpc2NvdmVyeSBS
ZXNwb25zZSBpcyB0aGUgV3JvbmcgU2l6ZSwgVHJ5aW5nIFJlYWQgQWdhaW4iKTsNCisJCXNpemUg
PSByZWFkKGNtZGZkLCAmZ2V0X3Jlc3AsIHNpemVvZihnZXRfcmVzcCkpOw0KKwl9DQogCWlmIChz
aXplIDwgc2l6ZW9mKGdldF9yZXNwKSAtIE1BWF9BRERJVElPTkFMX0NPREVDX09DVEVUUykgew0K
IAkJREJHKCJjb3VsZG4ndCBnZXQgYXZkdHBfZGlzY292ZXIiKTsNCiAJCWNsb3NlKGNtZGZkKTsN
Cg==
------=_Part_7208_25649061.1154616466596
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_7208_25649061.1154616466596
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_7208_25649061.1154616466596--
