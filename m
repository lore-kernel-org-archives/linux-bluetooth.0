Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Matthias Kretz <kretz@kde.org>
To: hal@lists.freedesktop.org
Date: Thu, 23 Aug 2007 20:56:18 +0200
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<200708231906.50942.kretz@kde.org>
	<1187893205.15402.75.camel@violet>
In-Reply-To: <1187893205.15402.75.camel@violet>
MIME-Version: 1.0
Message-Id: <200708232056.19885.kretz@kde.org>
Cc: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mztfg@0pointer.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [patch] spec: Update alsa namespace to include
	virtual device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1484928366=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1484928366==
Content-Type: multipart/signed; boundary="nextPart1211328.XhJVxA7Uen";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1211328.XhJVxA7Uen
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 23 August 2007, Marcel Holtmann wrote:
> when it comes to Bluetooth and other virtual devices with no real
> hardware as backend the world changes a bit. You really do have to
> change your way of thinking here since ALSA isn't the central place of
> information anymore. Actually ALSA has no clue whatsoever.
>
> The Bluetooth audio support is designed around a central audio daemon
> that takes care of mono headsets and high quality stereo headsets. This
> daemon does all needed protocol handling and can be controlled via
> D-Bus. Without this daemon you don't get any sound at all. This daemon
> however handles only the control part of the audio protocol. All the
> real audio data encoding and decoding is done in a plugin. Besides the
> currently existing ALSA plugin, we have plans for GStreamer and
> PulseAudio plugins.
>
> In case of the ALSA plugin you can use it to connect to the default
> headset or using a specific remote device address. This all works in the
> background and yes, if you get the hint listing right it would show up
> in applications that can list virtual devices. However the .asoundrc is
> user specific and not touched by the audio daemon. The daemon is a
> system process that can handle multiple headsets at one time which could
> be used by different users on the same system.
>
> So for the audio daemon, we don't know anything about the user and its
> settings and we actually don't care at all. We know that we have a
> configured device that can be used via the ALSA plugin with this
> specific Bluetooth address. That is what we know and that is what we
> will give to HAL. What the user does with this information is fully up
> to the user and not the daemons responsibility.
>
> This means whatever kind of hint system you have or don't have, it
> doesn't give us any advantage. Please remember that virtual sounds cards
> are totally dynamic. They come and go as they like. The daemon is fully
> integrated into the Bluetooth authorization framework and for example a
> headset can decide to connect back to your machine when you press its
> button and it becomes available and usable at exactly that point.
> The .asoundrc is to static for this. The only unique identifier that can
> be used to identify a Bluetooth headset is its address. The profile to
> use (mono or stereo) can be a second parameter, but the daemon can
> determine the best profile to use by itself.

Thanks a lot. I think I understand the issue a bit better now.

Questions:
=2D the entry in .asoundrc as documented on=20
http://wiki.bluez.org/wiki/HOWTO/AudioDevices#Alsaconfiguration is optional
=2D using the ALSA plugin a bluetooth audio device can always (when it's=20
connected and authorized) be accessed=20
using "bluetooth:<address>[,parameter]"?

If that is so, then I suggest to list a bluetooth device advertising its au=
dio=20
capabilities (this possibly means to say what parameters are supported) and=
=20
its address. Then an application can construct the ALSA "device" string=20
itself or, if it has the support, use that information to talk with the=20
bluetooth device directly.

That would mean those devices don't show up as ALSA devices in HAL at all.

=2D-=20
________________________________________________________
Matthias Kretz (Germany)                            <><
http://Vir.homelinux.org/
MatthiasKretz@gmx.net, kretz@kde.org,
Matthias.Kretz@urz.uni-heidelberg.de

--nextPart1211328.XhJVxA7Uen
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGzdhTyg4WnCj6OIoRAtliAKCNX74lJS6TMigrQH5ht8XVs1uw/gCcDqN9
nE1TpzBdOcK380zS6TPOpX0=
=pUHr
-----END PGP SIGNATURE-----

--nextPart1211328.XhJVxA7Uen--


--===============1484928366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1484928366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1484928366==--
