Return-Path: <sre@kernel.org>
Date: Tue, 7 Mar 2017 16:55:08 +0100
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
Subject: Re: [PATCH 07/10] serdev: add serdev_device_wait_until_sent
Message-ID: <20170307155508.olbiecapfs7ep6xm@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-8-sre@kernel.org>
 <CAL_Jsq+BCE1u6Ysz0FOdh--wHm-PZxqcmqTgQMyDcvQNkYp3gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5vnixjkpbvf6nj5"
In-Reply-To: <CAL_Jsq+BCE1u6Ysz0FOdh--wHm-PZxqcmqTgQMyDcvQNkYp3gw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--d5vnixjkpbvf6nj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 07, 2017 at 09:34:49AM -0600, Rob Herring wrote:
> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Add method, which waits until the transmission buffer has been sent.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  drivers/tty/serdev/core.c           | 11 +++++++++++
> >  drivers/tty/serdev/serdev-ttyport.c | 15 ++++++++++++++-
> >  include/linux/serdev.h              |  3 +++
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index f4c6c90add78..a63b74031e22 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_=
device *serdev, bool enable)
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
> >
> > +void serdev_device_wait_until_sent(struct serdev_device *serdev, long =
timeout)
> > +{
> > +       struct serdev_controller *ctrl =3D serdev->ctrl;
> > +
> > +       if (!ctrl || !ctrl->ops->wait_until_sent)
> > +               return;
> > +
> > +       ctrl->ops->wait_until_sent(ctrl, timeout);
> > +}
> > +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> > +
> >  static int serdev_drv_probe(struct device *dev)
> >  {
> >         const struct serdev_device_driver *sdrv =3D to_serdev_device_dr=
iver(dev->driver);
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/s=
erdev-ttyport.c
> > index d05393594f15..db2bc601e554 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/serdev.h>
> >  #include <linux/tty.h>
> >  #include <linux/tty_driver.h>
> > +#include <linux/poll.h>
> >
> >  #define SERPORT_ACTIVE         1
> >
> > @@ -47,10 +48,13 @@ static void ttyport_write_wakeup(struct tty_port *p=
ort)
> >         struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> >
> >         if (!test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags))
> > -               return;
> > +               goto out;
> >
> >         if (test_bit(SERPORT_ACTIVE, &serport->flags))
> >                 serdev_controller_write_wakeup(ctrl);
> > +
> > +out:
> > +       wake_up_interruptible_poll(&port->tty->write_wait, POLLOUT);
>=20
> Shouldn't this be separate patch?

That change is needed for tty_wait_until_sent to work correctly, which
starts with a wait_event_interruptible_timeout() on write_wait.

-- Sebastian

--d5vnixjkpbvf6nj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli+19gACgkQ2O7X88g7
+po/Dg/+Lc+HV/AnuGNS86mcWDpTy4vnuO0kBGVV1HNIIQDbjF+iP55WNP3fznfE
H5YSznVCzHe4YGpImqkRmiu+u6Ffdr+Y75gx0UrG0yIqWTWUT2u45KyzGtw23Km0
3bMPk7kye6hYawhGwCeKqECd1l8uBcnQOitHBqCDmb6OoxQELn3Z0SkAesS9Ui6a
KZrj8L16f6d/msSXoMbJqmFG9yblStavqAYbHI3m0699hlbGE7jUC85CVsqO4UYB
pgekUZqzsNP8OZWMaSUlxomV2Axb/5MN1QYSfX/MPzwueZh+n4IaXHghDfgElG0Q
AQ48UAn4cBm3NcVGzAOF5xN0YMzpvqBqhtXPqo5GbeqfDjOjgC+iPUzlXvVOcy2C
JRHqQANmXgbY/Rqx+fTG7BdCTPo2xRjFZKGXkeC0fPTkmhlFym1iZiqaB4DzBp03
KxUrfAZgiABeYxHO+umHg5g6GaNzlpZqLSPDiEuluXMT4nb3VbeeE6e0QM2VxT05
4YcLRN+YSZMCpL0LlamkNlcDQEyk9DUZEnKhpLv3O/7YAU00E1waprNKXy0fMzBc
897H0Ol99yY9atAgI2JIkBQvmGvnLg1rkdGmQErKJhhA2O5HaoY6mULyZw7XLXBb
NUgFKvqVHGlS+LBguGA4CsahQxJyCqdm8oc9kxcsoBm/+2/sNMU=
=N8fg
-----END PGP SIGNATURE-----

--d5vnixjkpbvf6nj5--
