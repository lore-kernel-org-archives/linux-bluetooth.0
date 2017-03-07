Return-Path: <sre@kernel.org>
Date: Tue, 7 Mar 2017 22:12:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] serdev: add serdev_device_get_cts
Message-ID: <20170307211243.zecbitmkbozd3s2j@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-9-sre@kernel.org>
 <CAL_Jsq+6NCC35zBMhvNhXug2sYmBqBoJ20pgdREhvRPGzePNkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgxp6za64zl6ol6z"
In-Reply-To: <CAL_Jsq+6NCC35zBMhvNhXug2sYmBqBoJ20pgdREhvRPGzePNkw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--xgxp6za64zl6ol6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Mar 07, 2017 at 10:03:37AM -0600, Rob Herring wrote:
> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Add method to get current CTS line state.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  drivers/tty/serdev/core.c           | 11 +++++++++++
> >  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++++
> >  include/linux/serdev.h              |  6 ++++++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index a63b74031e22..36eb3dfb1477 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -184,6 +184,17 @@ void serdev_device_wait_until_sent(struct serdev_d=
evice *serdev, long timeout)
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> >
> > +bool serdev_device_get_cts(struct serdev_device *serdev)
>=20
> I wonder if this should just be the wait for cts in the core. I think
> that would be the common use for reading the CTS state. IIRC, I saw
> some other device needing the same thing.

mh. I think it fits nicely to serdev_device_set_rts(). But I guess
it makes sense to have the wait feature directly in serdev. So I
suggest to add the function in addition to the simple get_cts
function. Does that make sense to you?

-- Sebastian

--xgxp6za64zl6ol6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli/IksACgkQ2O7X88g7
+pqtkxAAl6AhKIaDXJkM/F0M6njSh9jVXfoqiVYKveFVaAFqQHOL0AdrLg9NAGec
twzIhdzvFOU7bkvky0pU+amhHeQmqjvmjVA1F2XpHlQedO2UhseFeBE9OAnhvqIO
04vckI3NVa/Zi30J7WylLOiRyBIW5tGjs5OOPdfbxeScSIoeeBFOBFNwpIYngy4i
yCpbl5AVrVw/YDJ5rEU4x/dqco7vvaBorypO+nRFpC7krsHBEDeq2w5WEM64BaP1
UvorgbcTaW3LnZjqAcYAVhOJZ+y3Gwqc6hNQNbI4dEmhi8SGAjnCNczchDcbDN4N
b+IDOB9uSbsvznghWW1AkDUJ7wmG5CKiqyFV0+KAko3Po0F6a1R7ZjDGcGYRJpa+
1yI5jqx4ACCF7NxeVkAmI+5+RmHCmcVZUiwPauq6k6+PE0rWpxeALw7Z50pyYO8t
iUnhnp4Bc2tTPgDF1WCumCCnj3jqQSnkH2HxkJYckYpPilqjBCmo0sC8mEUKx1G5
yEYgoo1UL/iKTau3HqLVNxa1RV3/yitfoIFR57iyx6lGeoymFX5PNxg3+gdE0t5a
m2CivqtZky6NJZXN9rU9C9fBRQGTtD0GN8RhKIsUTMlWjbEoib/F6RZ/kcHX/YqW
mruMSF4Mi5U7OmRO5UUfpu+J8zjDcj2mqrTRT43SXg41ZZ3Zqes=
=jydG
-----END PGP SIGNATURE-----

--xgxp6za64zl6ol6z--
