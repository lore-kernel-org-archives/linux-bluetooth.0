Return-Path: <sre@kernel.org>
Date: Wed, 22 Mar 2017 23:48:30 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 09/11] Bluetooth: add nokia driver
Message-ID: <20170322224830.bzlsrrl65nx6olou@earth>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-10-sre@kernel.org>
 <CAL_Jsq+UXxocmpSJwJ8dVY0ZSLn1Rk+GfTRKP7Wqvo-_cE4qPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rccjul55cibclxh4"
In-Reply-To: <CAL_Jsq+UXxocmpSJwJ8dVY0ZSLn1Rk+GfTRKP7Wqvo-_cE4qPg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--rccjul55cibclxh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 04:26:28PM -0500, Rob Herring wrote:
> On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > This adds a driver for the Nokia H4+ protocol, which is used
> > at least on the Nokia N9, N900 & N950.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
>=20
> > +       btdev->wakeup_host =3D devm_gpiod_get(dev, "host-wakeup", GPIOD=
_IN);
> > +       if (IS_ERR(btdev->wakeup_host)) {
> > +               err =3D PTR_ERR(btdev->wakeup_host);
> > +               dev_err(dev, "could not get host wakeup gpio: %d", err);
> > +               return err;
> > +       }
> > +
> > +       btdev->wake_irq =3D gpiod_to_irq(btdev->wakeup_host);
>=20
> Missed this in the binding review, but generally, we make these
> interrupts rather than gpios in the binding.

I also read the state of the GPIO. AFAIK it's not possible to read
the state of an IRQ, so I can't switch to IRQ.

> > +
> > +       err =3D devm_request_threaded_irq(dev, btdev->wake_irq, NULL,
> > +               wakeup_handler,
> > +               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESH=
OT,
> > +               "wakeup", btdev);
> > +       if (err) {
> > +               dev_err(dev, "could request wakeup irq: %d", err);
> > +               return err;
> > +       }

-- Sebastian

--rccjul55cibclxh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljS/zsACgkQ2O7X88g7
+pq/Ww//UADQNmd/5kZQubaCvi54xIxmQy26acsz4jjiuAANnzDRIePzRZiW6Nei
d6AiW54GVz42LAkJ5LGKsExmxtjdhUA+ILMnTXJwuCKtN+PGWUFsGLWurXAlkEbw
JZydDy21+hcepGJyFuKiMa7sIDw7xg5wTIhMZ4PyVNLazWQvq+CS9wfW00820upn
M5cHlfDhCgdPu6ghMsKP+JQtmNxhytkPpAzRdpxsTT7JBY2k6SsU6ts5HgCsu4mm
/NbVCFTWc2hmJ4rgM5AohTOo7xbyDL6uC8DT+wrlzcDY+VtGdK7dRkpOUqk5xSY1
eGmATnv8UB5yFX4RqFLoCVQAsQTN3JTXnFAG7u3bEoGJRIRRCmatfRsFmSA/Qt5a
Hf7LUXbkc2CKkl8QB9DUzq5k/NahbPTMmA7n/HQPuYYB0kvWLbi2l0VnI1P0nwrg
07sk2GmFHq/gUWBmpaii5JpApZ1UIMMEb5X5PyyBYDi/Ayu1o8+ajaXKuqEZwAKW
FlZZhwDF1WvTybaWS/MRSqlEoTF68rYVO33qzvXtj1nEbbrdNdpV50ajWIIQmia5
61N0QAtLMwNv/i6QpYc1368yOMJY2JZQsQ/S7oAsmHtxlSNKbbgEyYZX9HyWADtX
s+6Z4sN7PS4xQQikH/NwgU4L/15Tnlz3K5FK7WZDpAWWbDL9Zyc=
=2jsv
-----END PGP SIGNATURE-----

--rccjul55cibclxh4--
