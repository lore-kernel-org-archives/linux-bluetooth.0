Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Best way to communicate with hidden devices
From: Stephen Crane <jscrane@maths.tcd.ie>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <432850B5.1050302@comcast.net>
References: <432850B5.1050302@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UWbrBg0K/G5sn7rjQ9z9"
Message-Id: <1126723067.7194.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 14 Sep 2005 19:37:47 +0100


--=-UWbrBg0K/G5sn7rjQ9z9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 at 10:32 -0600, Noel Paz wrote:
> I have a BT weight scale and I want to communicate to it. Problem is I=20
> think it is set to be un discoverable.  According to it's scant=20
> documentation it uses the BT serial protocol and a 128 bit encyrption=20
> and a PIN. - that it expects to start communication.  Supposedly, after=20
> it weighs something,  it tries to find an ACCESS point, see if the=20
> Access Point has the same PIN and if it does it transmits data packets=20
> which are very discrete

This sounds like a very strange way of doing things. I'm sure they had
their reasons though.

> hcitool --scan and sdptool --browse cannot find it (yes I have made sure=20
> it can find other devices). I've turned hcidump too too make sure I can=20
> sniff it but to no avail

What did you browse for?

> Honestly, I am new to BlueZ and have been devouring as much=20
> documentation as I can. My thoughts are setting up a PAN with an access=20
> point role using rfcomm. If anybody has worked on one way traffic=20
> bluetooth devices, let me know. I really have no way of knowing whether=20
> this weight scale  has a broken radio, although I can experiment with=20
> making my other devices undiscoverable with a PIN. Unfortunately their=20
> support is for Windoze only and require you to buy a container full of=20
> weight scales before their engineers will talk to you.

I did a bit of experimentation with a GPS device, documented here:
http://www.maths.tcd.ie/~jscrane/gps/

As described, this device provides a service to which you must connect
before it will spit out GPS data.

> BTW there is a little sticker which seems to be the bdaddr.

You could try running l2ping against that bdaddr: that should tell you
if its working.

Steve
--=20
Stephen Crane <jscrane@maths.tcd.ie>

--=-UWbrBg0K/G5sn7rjQ9z9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKG37psgfUm82ChQRAo8fAKCt9XbKZUrynC5LmwwEmRstmXsM0QCfe4ky
d0zv+EuYFgE6oiDi/jmi7Mw=
=7rSx
-----END PGP SIGNATURE-----

--=-UWbrBg0K/G5sn7rjQ9z9--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
