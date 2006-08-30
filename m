Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F55B85.6010800@palmsource.com>
Date: Wed, 30 Aug 2006 11:33:57 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F55552.4050502@ipb.pt>
In-Reply-To: <44F55552.4050502@ipb.pt>
Subject: Re: [Bluez-devel] Some tests with the userland ALSA plugin for
 A2DP: problem with changing tracks
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
There exists another alsa driver for a2dp. It's based upon the previous =

but uses a daemon instead of being standalone. It really miss =

documentation, but you can have a look at :
http://sourceforge.net/mailarchive/forum.php?thread_id=3D20199009&forum_id=
=3D1881
You'll need the latest cvs.

If your headset support AVRCP (next/prev buttons) you may also use it, =

see somewhere in this thread :
http://sourceforge.net/mailarchive/forum.php?thread_id=3D29326874&forum_id=
=3D1881

Let us know if it works!
Fr=E9d=E9ric

Rui Pedro Lopes a =E9crit :
> Hi,
>
> I've been experimenting with the user land ALSA plugin for A2DP from
> bluetooth-alsa project on Sourceforge.
>
> It works fine (tried it with xmms and rhythmbox through gstreamer-alsa)
> but there is a problem when changing tracks. When a song ends and xmms
> jumps to the next track on the playlist, the sound no longer arrives the
> headphones. If I press Stop and the Play, it starts playing again.
> I send in attach the log of the debug messages for this behavior
> (current.log).
>
>
> I then tried commenting the line for registering the close action like th=
is:
> static snd_pcm_ioplug_callback_t a2dp_callback =3D {
>         .start                  =3D a2dp_start,
>         .stop                   =3D a2dp_stop,
>         .pointer                =3D a2dp_pointer,
>         .transfer               =3D a2dp_transfer2,
>         //.close                        =3D a2dp_close,
>         .hw_params              =3D a2dp_params,
>         .prepare                =3D a2dp_prepare,
>         .drain                  =3D a2dp_drain,
>         .poll_descriptors_count =3D a2dp_descriptors_count,
>         .poll_descriptors       =3D a2dp_descriptors,
>         .poll_revents           =3D a2dp_poll,
> };
>
>
> It no longer fails when changing tracks. Apparently, it works
> flawlessly. I also send the log for debug messages in attach (no_close.lo=
g).
>
>
> Cheers,
>
> /rp
>   =

> ------------------------------------------------------------------------
>
> =3D=3D=3D=3D Starting xmms
> Message: device: pcm.headphone
>
> =3D=3D=3D=3D Pressing play
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_alloc: init
> DEBUG: a2dp_connect: a2dp 0x825e1c8 (sk=3D0, control_sk=3D0)
> DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
> DEBUG: detect_a2dp: Found A2DP Sink
> DEBUG: connect_stream: Found A2DP Sink at the destination
> DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
> DEBUG: connect_stream: Sent the Stream End Point Discovery Command
> DEBUG: connect_stream: Got a Stream End Point Discovery Response
> DEBUG: connect_stream: received 1 capabilities
> DEBUG: process_seid: SEID =3D 1
> DEBUG: process_seid: Requested Capabilities for SEID =3D 1
> DEBUG: process_seid: Got capabilities response
> DEBUG: process_seid: Sent set configurations command
> DEBUG: process_seid: Set configurations command accepted
> DEBUG: process_seid: Sent open stream command
> DEBUG: process_seid: Got open stream confirm
> DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
> DEBUG: connect_stream: Sent stream start
> DEBUG: connect_stream: Got start stream confirm
> DEBUG: a2dp_constraint: TEST a2dp 0x825e1c8
> DEBUG: a2dp_params: a2dp 0x825e1c8
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x825e1c8
> Listen thread running
> Awaiting command
> SBC Bandwidth =3D 27 kbps [27945 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> Awaiting command
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> Awaiting command
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
>
> =3D=3D=3D=3D Pressing Stop
> DEBUG: a2dp_stop: a2dp 0x825e1c8
> DEBUG: a2dp_stop: Listen thread terminating
> Thread in signal handler 14
> Error while receiving -1 (errno=3D4:Interrupted system call)
> listen_thread: ending perfeclty
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x825e1c8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_close: a2dp Destroying 0x825e1c8
> DEBUG: a2dp_close: OK
>
> =3D=3D=3D=3D Pressing Play
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_alloc: init
> DEBUG: a2dp_connect: a2dp 0x823ff68 (sk=3D0, control_sk=3D0)
> DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
> DEBUG: detect_a2dp: Found A2DP Sink
> DEBUG: connect_stream: Found A2DP Sink at the destination
> DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
> DEBUG: connect_stream: Sent the Stream End Point Discovery Command
> DEBUG: connect_stream: Got a Stream End Point Discovery Response
> DEBUG: connect_stream: received 1 capabilities
> DEBUG: process_seid: SEID =3D 1
> DEBUG: process_seid: Requested Capabilities for SEID =3D 1
> DEBUG: process_seid: Got capabilities response
> DEBUG: process_seid: Sent set configurations command
> DEBUG: process_seid: Set configurations command accepted
> DEBUG: process_seid: Sent open stream command
> DEBUG: process_seid: Got open stream confirm
> DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
> DEBUG: connect_stream: Sent stream start
> DEBUG: connect_stream: Got start stream confirm
> DEBUG: a2dp_constraint: TEST a2dp 0x823ff68
> DEBUG: a2dp_params: a2dp 0x823ff68
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x823ff68
> Listen thread running
> Awaiting command
> SBC Bandwidth =3D 19 kbps [19872 bps]
> SBC Bandwidth =3D 27 kbps [27945 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
>
> =3D=3D=3D=3D Pressing Next Track
> DEBUG: a2dp_stop: a2dp 0x823ff68
> DEBUG: a2dp_stop: Listen thread terminating
> Thread in signal handler 14
> Error while receiving -1 (errno=3D4:Interrupted system call)
> listen_thread: ending perfeclty
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x823ff68
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_close: a2dp Destroying 0x823ff68
> DEBUG: a2dp_close: OK
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_constraint: TEST a2dp 0x823ff68
> DEBUG: a2dp_params: a2dp 0x823ff68
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x823ff68
> SBC Bandwidth =3D 23 kbps [24219 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> ------ no sound on the headphones ------
>
> =3D=3D=3D=3D Terminating xmms
> DEBUG: a2dp_stop: a2dp 0x823ff68
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x823ff68
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_close: a2dp Destroying 0x823ff68
> DEBUG: a2dp_close: OK
>   =

> ------------------------------------------------------------------------
>
> =3D=3D=3D=3D Starting xmms
> Message: device: pcm.headphone
>
> =3D=3D=3D=3D Pressing Play
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_alloc: init
> DEBUG: a2dp_connect: a2dp 0x824ffc8 (sk=3D0, control_sk=3D0)
> DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
> DEBUG: detect_a2dp: Found A2DP Sink
> DEBUG: connect_stream: Found A2DP Sink at the destination
> DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
> DEBUG: connect_stream: Sent the Stream End Point Discovery Command
> DEBUG: connect_stream: Got a Stream End Point Discovery Response
> DEBUG: connect_stream: received 1 capabilities
> DEBUG: process_seid: SEID =3D 1
> DEBUG: process_seid: Requested Capabilities for SEID =3D 1
> DEBUG: process_seid: Got capabilities response
> DEBUG: process_seid: Sent set configurations command
> DEBUG: process_seid: Set configurations command accepted
> DEBUG: process_seid: Sent open stream command
> DEBUG: process_seid: Got open stream confirm
> DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
> DEBUG: connect_stream: Sent stream start
> DEBUG: connect_stream: Got start stream confirm
> DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
> DEBUG: a2dp_params: a2dp 0x824ffc8
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x824ffc8
> Listen thread running
> Awaiting command
> SBC Bandwidth =3D 27 kbps [27945 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> Awaiting command
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
>
> =3D=3D=3D=3D Pressing Stop
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> Thread in signal handler 14
> Error while receiving -1 (errno=3D4:Interrupted system call)
> listen_thread: ending perfeclty
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
>
> =3D=3D=3D=3D Pressing Play
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
> DEBUG: a2dp_params: a2dp 0x824ffc8
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x824ffc8
> SBC Bandwidth =3D 20 kbps [21114 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
>
> =3D=3D=3D=3D Pressing Next Track
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
> DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
> DEBUG: a2dp_params: a2dp 0x824ffc8
> DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
> DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
> DEBUG: a2dp_prepare: a2dp 0x824ffc8
> SBC Bandwidth =3D 24 kbps [25461 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> SBC Bandwidth =3D 26 kbps [26703 bps]
> SBC Bandwidth =3D 26 kbps [27324 bps]
> ------ There is sound, since the connection is not closed ------
>
> =3D=3D=3D=3D Terminating xmms
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
> DEBUG: a2dp_stop: a2dp 0x824ffc8
> DEBUG: a2dp_stop: Listen thread terminating
> DEBUG: a2dp_stop: Listen thread terminated
> DEBUG: a2dp_stop: OK
>   =

> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
