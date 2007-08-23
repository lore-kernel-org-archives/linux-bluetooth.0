Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Matthias Kretz <kretz@kde.org>
To: hal@lists.freedesktop.org
Date: Thu, 23 Aug 2007 19:06:46 +0200
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
In-Reply-To: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200708231906.50942.kretz@kde.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        Lennart Poettering <mztfg@0pointer.de>
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
Content-Type: multipart/mixed; boundary="===============1001070134=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1001070134==
Content-Type: multipart/signed; boundary="nextPart24754249.pMImLWLSvA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart24754249.pMImLWLSvA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 23 August 2007, Marc-Andr=E9 Lureau wrote:
> The following patch changes the "alsa" namespace so that "virtual
> devices" can also be described (a former approach was to use
> alsa.virtual or alsa_virtual new namespace, but alsa.virtual does not
> inherit alsa property, and both namespaces have a lot in common).
>
> Thus, a  mandatory property "is_hardware" is introduced. If this value
> is true, the current mandatory keys remain mandatory. If not, then the
> client should use "device_name" to "open" the device.
>
> Arguable:
> - should "device_name" be optional? (currently, application hard-code
> the prefix "hw")
> - "service" is used to make a difference between a2dp and hfp/hsp
> - "device_name", and "service" key naming

Hi,

I don't agree with this approach, i.e. the listing of virtual ALSA devices=
=20
through HAL, especially the forcing of the device_name. The application mig=
ht=20
be smarter than HAL, once it knows enough about the hardware. For example t=
he=20
hw: devices in many cases are not what you want...

Since libasound 1.0.14 we have snd_device_name_hint available to list virtu=
al=20
devices (they get listed once you add a hint section in your .asoundrc file=
).=20
What we're missing is a way to link virtual devices to hardware, meaning if=
=20
Hardware "xy" becomes available virtual device "foo" starts to be useful=20
(only "polling" works from what I know).

So what I'd like to see is something along the lines of:
=2D HAL notifies me that a Bluetooth device with audio support became avail=
able.
=2D With the id I get from HAL I can query libasound which virtual devices =
are=20
using this device, or if that's not possible iterate over all virtual devic=
es=20
that didn't work before and try to open them and see whether they work now.

You made the example "bluetooth:00:19:4F:DB:04:40,hifi" in the patch. Is it=
=20
possible to always access ALSA bluetooth devices that way? Then perhaps the=
=20
HAL entry on the bluetooth device should list give me the necessary hints t=
o=20
construct that string myself?

Anyway, great to hear that bluetooth ALSA support is progressing! I'm reall=
y=20
looking forward to supporting it (now all I need is bluetooth devices...)

=2D-=20
________________________________________________________
Matthias Kretz (Germany)                            <><
http://Vir.homelinux.org/
MatthiasKretz@gmx.net, kretz@kde.org,
Matthias.Kretz@urz.uni-heidelberg.de

--nextPart24754249.pMImLWLSvA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGzb6qyg4WnCj6OIoRAo1GAJ4w2zP4+504VPnM86ecBUZdD4dCrACg0Fuj
PtJcwT22F85xUkduWpuWT9Q=
=ZZoP
-----END PGP SIGNATURE-----

--nextPart24754249.pMImLWLSvA--


--===============1001070134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1001070134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1001070134==--
