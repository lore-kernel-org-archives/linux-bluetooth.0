Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Aug 2008 22:03:14 +0100
From: martin f krafft <madduck@madduck.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080827210314.GA15253@lapse.rw.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
	<8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
	<20080826203451.GA13267@lapse.rw.madduck.net>
	<34CE4798-1CBA-4F76-BA4D-A5E814D84C0E@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <34CE4798-1CBA-4F76-BA4D-A5E814D84C0E@holtmann.org>
Subject: Re: [Bluez-devel] btusb+sco failing to play sound through
	Jabra	BT500v headset (was: SCO flowcontrol patch v4.4 on
	2.6.25/6 causes)	hardlocks when connecting to BT device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1954167090=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1954167090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2008.08.27.0618 +0100]:
> you don't have to. The bluez-utils-3.36 comes with an audio plugin
> that does all this for you. You just have to add 4 magic lines
> into .asoundrc. See wiki.bluez.org for these for it.

So I added

pcm.bluetooth {
   type bluetooth
   device 00:1A:45:14:EE:D7
}

to .asoundrc and if I try to play something with aplay, I am told that

  Playing WAVE '/usr/share/twinkle/ringback.wav' : Unsigned 8 bit,
  Rate 8287 Hz, Mono aplay: set_params:918: Sample format non
  available

Trying to use the device with twinkle, the programme starts up
taking ages trying to connect (http://bugs.debian.org/475962) and
eventually just says that it cannot access the speaker/microphone.
When twinkle tries to talk to the headset, the bluetooth LED starts
to blink, the headset makes the
noise it makes when a connection is established, and after a while,
twinkle tells me

  snd_pcm_hw_params failed: Invalid argument

and then

  snd_pcm_hw_params failed: Input/output error

The bluetooth LED continues blinking and the headset will not make
the disconnection sound until I turn bluetooth off. Once I turn it
back on, the headset disconnects, and the cycle repeats.

I am using 2.6.27-rc4 and bluez-utils 3.36-1.

Any ideas what may be wrong?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"it isn't pollution that's harming the environment.
 it's the impurities in our air and water that are doing it."=20
                                                          - dan quayle
=20
spamtraps: madduck.bogus@madduck.net

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki1wQ0ACgkQIgvIgzMMSnXBowCdEW84vJnEBZTD4KzEfRsoeBCC
6N4An2aN4Zr4RFOoqnEFR9S14ZEn613j
=U842
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--


--===============1954167090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1954167090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1954167090==--
