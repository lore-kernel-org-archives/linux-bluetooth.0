Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1220906328.24928.9.camel@cookie.hadess.net>
References: <1220904984.8005.8.camel@pancake.floe.gotdns.org>
	<1220906328.24928.9.camel@cookie.hadess.net>
Date: Fri, 12 Sep 2008 09:14:06 +0200
Message-Id: <1221203646.4280.5.camel@bernd.floe.gotdns.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can't connect to Trust Bluetooth mouse..
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0394581730=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0394581730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LFSMt6r1hx9p1xFHEPt6"


--=-LFSMt6r1hx9p1xFHEPt6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > I just bought a Trust Bluetooth Mouse 15351. However, I can't connect t=
o
> > it via bluez-gnome, nor via hcitool. Here's what hcidump shows when I
> > try:
> <snip>
> > Unfortunately, I have to admit I can't really make sense out of this,
> > except that it seems that the mouse terminates the connection after the
> > "Remote Name Request" command.. I have bluez 3.36 installed.
> In my experience with a similarly cheap Trust mouse, my advice is:
> change the batteries to known working ones, check that they make contact
> properly.
Thanks for the hint; I've used new batteries and checked the contacts.
Still, no luck. However, it looks like the problem is of a different
sort than I previously thought. IIRC connecting via hcitool isn't really
supposed to work for input devices anyway. When I try to connect via
bluetooth-applet, hcidump shows:

< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 11:11:12:11:1F:06 mode 1 clkoffset 0x1d51 class 0x002580
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

And nothing else anymore, even after I click the connect button. Just an
empty window labeled "connecting to device..", but nothing else happens
(especially no bluetooth communication). In the console,
bluetooth-properties shows:

** (bluetooth-properties:7171): CRITICAL **: dbus_g_proxy_begin_call:
assertion `DBUS_IS_G_PROXY (proxy)' failed

So I'm getting suspicious that this is in fact a DBus problem.. any
ideas?

Many thanks, Yours, Florian

--=-LFSMt6r1hx9p1xFHEPt6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjKFr4ACgkQ7CzyshGvatgHjwCgkHDzk+K/m/Ak5NEmt8ttGZng
6K8AoNsUz7EpDNwxVOsGRKs8SD3tTLHe
=ZUsb
-----END PGP SIGNATURE-----

--=-LFSMt6r1hx9p1xFHEPt6--



--===============0394581730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0394581730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0394581730==--
