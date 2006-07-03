Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 3 Jul 2006 20:01:30 +0200
From: martin f krafft <madduck@madduck.net>
To: bluez users list <bluez-users@lists.sourceforge.net>
Message-ID: <20060703180130.GA19929@piper.madduck.net>
MIME-Version: 1.0
Subject: [Bluez-users] btsco and not hearing or recording anything
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0546282920=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0546282920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just tried btsco for the first time with my BT250 headset,
connected by Bluetooth to a USB dongle plugged directly into a main
USB bus of the machine.

I can pair fine and see output, volume control and the 'answer call'
button cause btsco to receive events, but I cannot play or record
anything.

Here's what I do to record:

  piper:/usr/local/stow> arecord -D plughw:Headset bla.wav
  Recording WAVE 'bla.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

btsco now says:

  speaker volume: 11 mic volume: 15
  i/o needed: connecting sco...
  connected SCO channel
  Done setting sco fd

then the headset beeps briefly, then btsco says:

  recieved AT+VGS=3D11
  Sending up speaker change 11

and then arecord and btsco just sit there and do nothing.

When I ctrl-c out of arecord, the generated file always has 44
bytes:

  -rw-r--r-- 1 madduck staff 44 2006-07-03 20:00 bla.wav

and btsco says:

  speaker volume: 11 mic volume: 15
  driver is not in use
  disconnected SCO channel

I checked the mixer and confirmed that the volume is up (75 for both
master and mic), and there's also AGC and Loopback controls, both of
which are muted (but unmuting makes no difference).

What am I overlooking?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"the surest way to corrupt a youth is to instruct him to hold in
 higher esteem those who think alike than those who think
 differently."
                                              -- friedrich nietzsche

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEqVt6IgvIgzMMSnURAuJhAJ9AY7vW/5p2gvUn4EY0YMSyTYjHbACglfqV
t0vJ2ahvFCLKAcktkCy+6Xk=
=69yw
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


--===============0546282920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0546282920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0546282920==--
