Return-Path: <cyrus@holtmann.org>
Message-ID: <1386956161.23365.23.camel@pc.interlinx.bc.ca>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 13 Dec 2013 12:36:01 -0500
In-Reply-To: <CAJdJm_NMUP3gd1oABgXL9iYJPSwez=1DGCF2b8uKwVNosRS0ZQ@mail.gmail.com>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	 <1386949351.6234.0.camel@nuvo>
	 <1386949827.23365.9.camel@pc.interlinx.bc.ca> <1691350.CipnhsEWy0@uw000953>
	 <CAJdJm_POfMm8mtbRAWdG9W3F2PwT8kNYkiHYToVZeVz+D1F+TQ@mail.gmail.com>
	 <1386951737.23365.19.camel@pc.interlinx.bc.ca>
	 <CAJdJm_NMUP3gd1oABgXL9iYJPSwez=1DGCF2b8uKwVNosRS0ZQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cINLYTMgrzaCsCZ/Rep9"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-cINLYTMgrzaCsCZ/Rep9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-12-13 at 15:09 -0200, Anderson Lizardo wrote:
> Hi Brian,

Hi Anderson,

> Since BlueZ 5, the adapter power state (on/off) is not saved anymore
> by bluetoothd (on BlueZ 4, there were InitiallyPowered/RememberPowered
> options in main.conf that took care of powering up adapters; these
> options are gone in BlueZ 5). There should be an external component
> that takes care of powering up the adapter after it is attached.

Interesting.  I wonder if F20 itself is supposed to be doing this or if
it's expecting the desktop (i.e. via applet or whatever) to do it.

> As Bastien mentioned, it is built-in for GNOME.

Ahh.

> I don't use GNOME,

Me either.  I use MATE.  GNOME[3] is incapable of handling my video
configuration.  GNOME2 and thus MATE handles it just fine, FWIW.

> but
> in theory, once you enable Bluetooth on its settings, the adapter will
> be powered on once it is attached.

So, it seems that F20 *is* expecting the desktop model to handle that.

I wonder what the model is supposed to be for the likes of MATE.  I'm
not at all convinced that the MATE that's in F20 has been
bluetooth-enabled to handle this.

Cheers,
b.



--=-cINLYTMgrzaCsCZ/Rep9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSq0WCAAoJENrB0DQWy8ig798H/1X5mVbzwmj/YyQq+usaAMB2
PRCgq8UfJvpWPsQaQi+wqcwFBqWcdDvJYuH/8xUC/s014GXdomcwa9r4ou8TqV88
GDVxsymz6bLc47pXGsLdjB4vduRXH0v3eaTVXV0xQDber1nR8gdHcYkQ3vijj2Mq
sFeuVmgKL06c62mVAfDPEwo80j9LjPq4VwAUJSDqgj6chfWBvz7IqIPL9FFTDS57
wEEtf6a78LTotOyMDSpLaaRJkswKR+KMb0172Ctb55luphcrcqRSniZsOzT93M8v
1f/0DbDSzaMtVaSFpFHccUYpNo7VuI/QRnsYcy04lBqnfGlldZU+vkS+pNKfjOE=
=wSiY
-----END PGP SIGNATURE-----

--=-cINLYTMgrzaCsCZ/Rep9--

