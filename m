Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Jochem <rainer@graphics.cs.uni-sb.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20030927133225.GB24422@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Subject: [Bluez-users] Re: snd-bluez-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 27 Sep 2003 15:32:25 +0200


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Okies.=20

Meanwhile I've played around a little bit more - here's some=20
additional information I've produced (dunno if it's useful, but
here it is):

root@marvin:# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Audigy [Sound Blaster Audigy], device 0: emu10k1 [EMU10K1]
  Subdevices: 31/32
  Subdevice #0: subdevice #0
[...lots of other subdevices...]
  Subdevice #31: subdevice #31
card 0: Audigy [Sound Blaster Audigy], device 3: emu10k1 [EMU10K1
FX8010]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
[...]
  Subdevice #7: subdevice #7
**** List of PLAYBACK Hardware Devices ****
card 1: V8233Pre [VIA 8233-Pre], device 0: VIA 8233-Pre [VIA 8233-Pre]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
[...]
  Subdevice #3: subdevice #3
card 1: V8233Pre [VIA 8233-Pre], device 1: VIA 8233-Pre [VIA 8233-Pre]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
**** List of PLAYBACK Hardware Devices ****
card 2: Headset [Bluez Headset], device 0: Bluez SCO PCM [Bluez SCO
PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


root@marvin:# alsaplayer -d plughw:Headset /home/rainer/tmp/rootbeer.pcm=20
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: [8000 8192000]
PERIOD_SIZE: (352 361268)
PERIOD_BYTES: (1408 1445072)
PERIODS: (0 1027)
BUFFER_TIME: (7981 8191996)
BUFFER_SIZE: [352 361267]
BUFFER_BYTES: [1408 1445068]
TICK_TIME: 10000
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: [8000 8192000]
PERIOD_SIZE: (352 361268)
PERIOD_BYTES: (1408 1445072)
PERIODS: (0 1027)
BUFFER_TIME: (7981 8191996)
BUFFER_SIZE: [352 361267]
BUFFER_BYTES: [1408 1445068]
TICK_TIME: 10000
failed to configure output device...trying OSS


=20
> Perhaps you could try adding some debugging printf()s to the
> find_hwdep_device() function to try to identify whether it is finding the
> snd-bluez-sco device, and if so, what hwdep interface type it is
> reporting.

Hmm... I'll try it.=20

> I haven't yet tried the code against alsa 0.9.7, so it's possible there
> may be some incompatabilities.

Might be possible too.


--=20
http://graphics.cs.uni-sb.de/~rainer/



--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/dZFpH/5+6U9F1qYRAoowAKCFOVKcmii0El5BECb+61nAsHlKmgCgxC3k
+fmgE3EiKno54vIP4OxhZ9U=
=wtl3
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
