Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F55552.4050502@ipb.pt>
Date: Wed, 30 Aug 2006 10:07:30 +0100
From: Rui Pedro Lopes <rlopes@ipb.pt>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Some tests with the userland ALSA plugin for A2DP:
 problem with changing tracks
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0391697757=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0391697757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8FE293AE7A59726D426B64CD"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FE293AE7A59726D426B64CD
Content-Type: multipart/mixed; boundary="------------050903050704060202060807"

This is a multi-part message in MIME format.
--------------050903050704060202060807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've been experimenting with the user land ALSA plugin for A2DP from
bluetooth-alsa project on Sourceforge.

It works fine (tried it with xmms and rhythmbox through gstreamer-alsa)
but there is a problem when changing tracks. When a song ends and xmms
jumps to the next track on the playlist, the sound no longer arrives the
headphones. If I press Stop and the Play, it starts playing again.
I send in attach the log of the debug messages for this behavior
(current.log).


I then tried commenting the line for registering the close action like th=
is:
static snd_pcm_ioplug_callback_t a2dp_callback =3D {
        .start                  =3D a2dp_start,
        .stop                   =3D a2dp_stop,
        .pointer                =3D a2dp_pointer,
        .transfer               =3D a2dp_transfer2,
        //.close                        =3D a2dp_close,
        .hw_params              =3D a2dp_params,
        .prepare                =3D a2dp_prepare,
        .drain                  =3D a2dp_drain,
        .poll_descriptors_count =3D a2dp_descriptors_count,
        .poll_descriptors       =3D a2dp_descriptors,
        .poll_revents           =3D a2dp_poll,
};


It no longer fails when changing tracks. Apparently, it works
flawlessly. I also send the log for debug messages in attach (no_close.lo=
g).


Cheers,

/rp

--------------050903050704060202060807
Content-Type: text/x-log;
 name="current.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="current.log"

=3D=3D=3D=3D Starting xmms
Message: device: pcm.headphone

=3D=3D=3D=3D Pressing play
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x825e1c8 (sk=3D0, control_sk=3D0)
DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination
DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: Got a Stream End Point Discovery Response
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: SEID =3D 1
DEBUG: process_seid: Requested Capabilities for SEID =3D 1
DEBUG: process_seid: Got capabilities response
DEBUG: process_seid: Sent set configurations command
DEBUG: process_seid: Set configurations command accepted
DEBUG: process_seid: Sent open stream command
DEBUG: process_seid: Got open stream confirm
DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
DEBUG: connect_stream: Sent stream start
DEBUG: connect_stream: Got start stream confirm
DEBUG: a2dp_constraint: TEST a2dp 0x825e1c8
DEBUG: a2dp_params: a2dp 0x825e1c8
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x825e1c8
Listen thread running
Awaiting command
SBC Bandwidth =3D 27 kbps [27945 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
Awaiting command
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
Awaiting command
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]

=3D=3D=3D=3D Pressing Stop
DEBUG: a2dp_stop: a2dp 0x825e1c8
DEBUG: a2dp_stop: Listen thread terminating
Thread in signal handler 14
Error while receiving -1 (errno=3D4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x825e1c8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x825e1c8
DEBUG: a2dp_close: OK

=3D=3D=3D=3D Pressing Play
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x823ff68 (sk=3D0, control_sk=3D0)
DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination
DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: Got a Stream End Point Discovery Response
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: SEID =3D 1
DEBUG: process_seid: Requested Capabilities for SEID =3D 1
DEBUG: process_seid: Got capabilities response
DEBUG: process_seid: Sent set configurations command
DEBUG: process_seid: Set configurations command accepted
DEBUG: process_seid: Sent open stream command
DEBUG: process_seid: Got open stream confirm
DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
DEBUG: connect_stream: Sent stream start
DEBUG: connect_stream: Got start stream confirm
DEBUG: a2dp_constraint: TEST a2dp 0x823ff68
DEBUG: a2dp_params: a2dp 0x823ff68
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x823ff68
Listen thread running
Awaiting command
SBC Bandwidth =3D 19 kbps [19872 bps]
SBC Bandwidth =3D 27 kbps [27945 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]

=3D=3D=3D=3D Pressing Next Track
DEBUG: a2dp_stop: a2dp 0x823ff68
DEBUG: a2dp_stop: Listen thread terminating
Thread in signal handler 14
Error while receiving -1 (errno=3D4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x823ff68
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x823ff68
DEBUG: a2dp_close: OK
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_constraint: TEST a2dp 0x823ff68
DEBUG: a2dp_params: a2dp 0x823ff68
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x823ff68
SBC Bandwidth =3D 23 kbps [24219 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
------ no sound on the headphones ------

=3D=3D=3D=3D Terminating xmms
DEBUG: a2dp_stop: a2dp 0x823ff68
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x823ff68
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x823ff68
DEBUG: a2dp_close: OK

--------------050903050704060202060807
Content-Type: text/x-log;
 name="no_close.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="no_close.log"

=3D=3D=3D=3D Starting xmms
Message: device: pcm.headphone

=3D=3D=3D=3D Pressing Play
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x824ffc8 (sk=3D0, control_sk=3D0)
DEBUG: connect_stream: Using address: 01:B7:43:44:0D:00
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination
DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: Got a Stream End Point Discovery Response
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: SEID =3D 1
DEBUG: process_seid: Requested Capabilities for SEID =3D 1
DEBUG: process_seid: Got capabilities response
DEBUG: process_seid: Sent set configurations command
DEBUG: process_seid: Set configurations command accepted
DEBUG: process_seid: Sent open stream command
DEBUG: process_seid: Got open stream confirm
DEBUG: do_connect: Connected [imtu 672, omtu 678, flush_to 65535]
DEBUG: connect_stream: Sent stream start
DEBUG: connect_stream: Got start stream confirm
DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
DEBUG: a2dp_params: a2dp 0x824ffc8
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x824ffc8
Listen thread running
Awaiting command
SBC Bandwidth =3D 27 kbps [27945 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
Awaiting command
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]

=3D=3D=3D=3D Pressing Stop
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
Thread in signal handler 14
Error while receiving -1 (errno=3D4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK

=3D=3D=3D=3D Pressing Play
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
DEBUG: a2dp_params: a2dp 0x824ffc8
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x824ffc8
SBC Bandwidth =3D 20 kbps [21114 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]

=3D=3D=3D=3D Pressing Next Track
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:43:B7:01
DEBUG: a2dp_constraint: TEST a2dp 0x824ffc8
DEBUG: a2dp_params: a2dp 0x824ffc8
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 buff=
er_size 4096
DEBUG: a2dp_prepare: a2dp 0x824ffc8
SBC Bandwidth =3D 24 kbps [25461 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
SBC Bandwidth =3D 26 kbps [26703 bps]
SBC Bandwidth =3D 26 kbps [27324 bps]
------ There is sound, since the connection is not closed ------

=3D=3D=3D=3D Terminating xmms
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x824ffc8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK

--------------050903050704060202060807--

--------------enig8FE293AE7A59726D426B64CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9VVUAhGrHSs5PNIRAmeBAKCHUjZ9a8yT19g00qu7amc39RljhwCgjuNp
nkp541cC9X3bEAvKOVdvpwg=
=1lcI
-----END PGP SIGNATURE-----

--------------enig8FE293AE7A59726D426B64CD--


--===============0391697757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0391697757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0391697757==--
