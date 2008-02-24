Return-Path: <cyrus@holtmann.org>
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 23 Feb 2008 23:13:56 -0500
Message-Id: <1203826436.8021.20.camel@pc.ilinx>
Mime-Version: 1.0
Subject: [Bluez-users] how to use bluez-audio with "point-and-click" audio
	selection	applications
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1065073156=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1065073156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GwnEdIeYD7r68eKf6Wwp"


--=-GwnEdIeYD7r68eKf6Wwp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've seen it mentioned time and time again that using bluez-audio, the
bluetooth headset will not be enumerated as a sound device as other
devices are, like sound cards.  The answer seems to be always, "just
type in bluetooth where it wants a device selection".  Well, I guess
that's fine for an application that provides that.

But how does one deal with this problem with devices that enumerate
sound devices and provide a point-and-click-menu type interface for
them.  One example of such is Ekiga.

Despite my previous posting about my troubles with getting a BT headset
working on Ubuntu Hardy (my desktop workstation), I did manage to get it
working on Ubuntu Gutsy on my laptop.  i.e. I can successfully do:

$ arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

and hear myself.  I'd like to use this headset with Ekiga though.  Any
ideas?

BTW: what's with the long pause opening the headset for playback?

20228 23:14:06 socket(PF_FILE, SOCK_STREAM, 0) =3D 3
20228 23:14:06 connect(3, {sa_family=3DAF_FILE, path=3D@/org/bluez/audio}, =
110) =3D 0
20228 23:14:06 pipe([4, 5])             =3D 0
20228 23:14:06 fcntl64(4, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
20228 23:14:06 fcntl64(5, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
20228 23:14:06 send(3, "00:1A:45:1B:19:89\0\0\0\0\f\1\0\0\0\0\0\0\0\0\0"...=
, 34, 0) =3D 34
20228 23:14:06 recv(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\10\0010\=
0\2"..., 30, 0) =3D 30
20228 23:14:10 recvmsg(3, {msg_name(0)=3DNULL, msg_iov(1)=3D[{"m", 1}], msg=
_controllen=3D16, {cmsg_len=3D16, cmsg_level=3DSOL_SOCKET, cmsg_type=3DSCM_=
RIGHTS, {6}}, msg_flags=3D0}, 0) =3D 1
20228 23:14:10 recv(6, 0x8062324, 48, MSG_DONTWAIT) =3D -1 EAGAIN (Resource=
 temporarily unavailable)

Notice the 4 seconds between sending and receiving a message on
the /org/bluez/audio socket.

b.


--=-GwnEdIeYD7r68eKf6Wwp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwO8El3EQlGLyuXARAgUiAJ985tQ1DK9nqM3CpeqLVINgFS3Z9QCgy9d7
3mu9cGLV7qKp6gA7LbmI18k=
=T154
-----END PGP SIGNATURE-----

--=-GwnEdIeYD7r68eKf6Wwp--



--===============1065073156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1065073156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1065073156==--
