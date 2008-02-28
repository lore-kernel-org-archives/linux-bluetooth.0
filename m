Return-Path: <cyrus@holtmann.org>
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802281729.42989.Jens-E.Hansen@gis.de>
References: <200802252010.34296.Jens-E.Hansen@gis.de>
	<20080226080414.U82399@3miasto.net.pl>
	<200802281729.42989.Jens-E.Hansen@gis.de>
Date: Thu, 28 Feb 2008 17:43:01 -0500
Message-Id: <1204238581.4816.10.camel@pc.ilinx>
Mime-Version: 1.0
Subject: Re: [Bluez-users] rattling noise with bluefritz 2.0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0156981631=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0156981631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LrGAZS+OzhBgm+vluoGx"


--=-LrGAZS+OzhBgm+vluoGx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-02-28 at 17:29 +0100, Jens-Erik Hansen wrote:
>=20
> To get a bluetooth headset work with Twinkle/Ekiga/Skype I enhanced
> my .asoundrc at first.
> In several documents I read that you can use a pcm of type bluetooth

Yeah, that's what I did, but even with the patch you reference below for
pwlib, ekiga still barfs trying to open the audio device.  More on that
below, but for now, following your procedure...

> but that
> never worked for me so I have to use type sco (see pcm.headset).

I tried your configuration but ekiga complains, on trying to open the
audio devices:

ALSA lib pcm.c:2105:(snd_pcm_open_conf) Cannot open shared library /usr/lib=
/alsa-lib/libasound_module_pcm_sco.so
ALSA lib pcm.c:2105:(snd_pcm_open_conf) Cannot open shared library /usr/lib=
/alsa-lib/libasound_module_pcm_sco.so
ALSA lib pcm.c:2105:(snd_pcm_open_conf) Cannot open shared library /usr/lib=
/alsa-lib/libasound_module_pcm_sco.so

So obviously you have something providing that "sco" pcm module.

> To get ekiga working with this alsa devices please follow
> http://forums.droplinegnome.org/viewtopic.php?t=3D5538&sid=3Dca7c1f8a8b25=
9c2bf3a9fc6a42ba573c
> If you use a debian sid distribution

Ubuntu Gutsy in fact.

When I use instead:

pcm.headset {
   type bluetooth
   device 00:1A:45:1B:19:89
   profile "auto" #optional, supported profiles are: auto, hifi and voice
}

I can use arecord ... | aplay and I hear myself just fine, but ekiga
pukes out:

ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL headset
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL headset

and I do eventually get a connection and can hear on the headset but the
UI ends up hanging -- doesn't paint.

On a second invocation I get connected to a phone I have dialed but the
connection dies quite quickly and ekiga says:

(ekiga:24243): GLib-GObject-WARNING **: /build/buildd/glib2.0-2.14.1/gobjec=
t/gsignal.c:1715: handler `2996' of instance `0x8466978' is not blocked
ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring de=
vice
ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring de=
vice
ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring de=
vice

and I get the warning dialogs about not being able to play or record
from the soundcard.

b.


--=-LrGAZS+OzhBgm+vluoGx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHxzj1l3EQlGLyuXARAh0AAKCiXXvDGcF/4Y+I1nMaHQ/CSpfF8ACfeguU
ZCeKt2caM5P2J9/fjT906cc=
=XTqO
-----END PGP SIGNATURE-----

--=-LrGAZS+OzhBgm+vluoGx--



--===============0156981631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0156981631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0156981631==--
