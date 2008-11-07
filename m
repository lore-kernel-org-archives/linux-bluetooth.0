Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Nov 2008 17:27:41 +0100
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: btusb+sco: unable to install hw params (set_params:979)
Message-ID: <20081107162741.GA8182@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I am trying to get btusb to work with my two SCO headsets (BT250 and BT500v=
) on
two different machines (i386 and amd64), both running 2.6.26. I am
pretty much following the instructions at
http://wiki.bluez.org/wiki/HOWTO/AudioDevices, which are "valid for
bluez-utils-3.16 or newer". I am using Debian's 3.36-1 on both
machines.

My .asoundrc has this content:

  pcm.bt250 {
    type bluetooth
    device "00:07:A4:01:AB:A3"
    profile "sco"
  }
  ctl.bt250 {
    type bluetooth
  }

and I put the headset into pairing mode, then ran this command:

  $ strace -f -o /tmp/arecord.strace arecord -f S16_LE -D bt250 >/tmp/test.=
wav
  Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono

This caused bluetooth-applet to prompt me for the passkey and
finally to tell me that the bonding had been established, just as
there's a little tone in the headset to acknowledge the connection.

However, /tmp/test.wav won't grow, and after a few seconds, arecord
exits with $?=3D0 (!!) after spouting to the terminal:

ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION =
failed : Input/output error(5)
arecord: set_params:979: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: [0 0]

/tmp/test.wav is size 0. :(

I see precisely the same behaviour with any combination of the two
machines, the two headsets and three bluetooth dongles. Yes, I tried
them all. Yes, I am somewhat desperate by now.

I have bluez-audio installed, but /etc/bluetooth/audio.conf is
default. No PulseAudio or anything other than plain ALSA here...

Any clues what could be going on?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i wish i hadn't slept all day, it's really lowered my productivity"
                                                   -- robert mcqueen
=20
spamtraps: madduck.bogus@madduck.net

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkUbH0ACgkQIgvIgzMMSnXxYwCgljA1hOSIkkHnFAzTVwWka1BJ
xN8AnjYstDpNZahYaOvogIlAUZBeAKEm
=OYi2
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
