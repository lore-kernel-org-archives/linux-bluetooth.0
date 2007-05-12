Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4646071D.6020303@gentoo.org>
Date: Sat, 12 May 2007 21:27:41 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] a2dpd getting into an endless loop when it fails to
 get a socket and not dying on CTRL+c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0906016714=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0906016714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DBE2B839BF7B8FC1A47FF12"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DBE2B839BF7B8FC1A47FF12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

betelgeuse@pena ~ $ a2dpd -n -v -o -g -b
A2DPD[21:17:29.577]: init_ipc: Selected IPC: inet, addr=3D127.0.0.1,
bcst=3D127.0.0.255, port=3D8000
A2DPD[21:17:29.577]: make_daemon_process: a2dpd [May 12 2007 19:46:25]
starting ...
A2DPD[21:17:29.577]: main: (errno=3D13:Permission denied)a2dpd
addr=3D00:13:17:70:3E:A0 timer=3D0 us [May 12 2007 19:46:26]
A2DPD[21:17:29.577]: a2dpd_signal_init: Getting on DBUS
A2DPD[21:17:29.579]: a2dpd_signal_init: Installing watch
A2DPD[21:17:29.579]: add_dbus_watch: Added watch 0 0x80a3770 disabled
A2DPD[21:17:29.579]: add_dbus_watch: Added watch 1 0x80a3798 enabled
A2DPD[21:17:29.579]: a2dpd_signal_init: Registering object path:
/com/access/a2dpd
A2DPD[21:17:29.579]: a2dpd_signal_init: Acquiring service: com.access.a2d=
pd
A2DPD[21:17:29.580]: a2dpd_signal_init: OK
A2DPD[21:17:29.580]: a2dpd_signal_init: OK
A2DPD[21:17:29.580]: a2dpd_register_sdp: Start
A2DPD[21:17:29.580]: add_avrtg:
A2DPD[21:17:29.580]: add_a2source:
A2DPD[21:17:29.580]: a2dpd_register_sdp: OK
A2DPD[21:17:29.580]: main_loop:
A2DPD[21:17:29.581]: make_server_socket:
A2DPD[21:17:29.581]: a2dp_make_listen_socket: (errno=3D13:Permission
denied)Cannot bind socket 6 for psm 25
A2DPD[21:17:29.581]: main_loop: Cannot get AVDTP socket
A2DPD[21:17:30.581]: main_loop:
A2DPD[21:17:30.581]: make_server_socket:
A2DPD[21:17:30.581]: main_loop: (errno=3D98:Address already in use)Cannot=

get UNIX socket
A2DPD[21:17:31.581]: main_loop:
A2DPD[21:17:31.581]: make_server_socket:
A2DPD[21:17:31.581]: main_loop: (errno=3D98:Address already in use)Cannot=

get UNIX socket
A2DPD[21:17:32.581]: main_loop:
A2DPD[21:17:32.581]: make_server_socket:
A2DPD[21:17:32.581]: main_loop: (errno=3D98:Address already in use)Cannot=

get UNIX socket
A2DPD[21:17:33.514]: sigint_handler: handling SIGINT
A2DPD[21:17:33.514]: main_loop: (errno=3D4:Interrupted system call)
A2DPD[21:17:33.514]: make_server_socket:
A2DPD[21:17:33.514]: main_loop: (errno=3D98:Address already in use)Cannot=

get UNIX socket
A2DPD[21:17:33.968]: sigint_handler: handling SIGINT

Basically it seems to go into an endless loop when it can't get the
socket and I must then kill it with kill -9 <pid>.

I tried to change various things in .a2pdrc but didn't make a difference.=


Regards,
Petteri


--------------enig2DBE2B839BF7B8FC1A47FF12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRgcdcxLzpIGCsLQRAl+LAKCRRWJZefBfL1ua+0h0rdzV2g9fbgCePs8P
wvlHXU3bVs4BPXGVP1IcKrQ=
=9pW3
-----END PGP SIGNATURE-----

--------------enig2DBE2B839BF7B8FC1A47FF12--


--===============0906016714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0906016714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0906016714==--
