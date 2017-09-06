Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on
 Device1
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
Date: Wed, 6 Sep 2017 11:44:31 -0400
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <1AE5314A-1E01-43B7-AFA3-4D82DA9ED755@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
 <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com>
 <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Thanks for looking at my proposal.

> On Sep 6, 2017, at 10:14 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
> Your implementation is not really LE specific, in fact it will cause
> the clients to believe they connected over LE if the MTU appears,
> besides with cross transport pairing and dual mode topology this has
> to work either way or then we have to disable GATT completely on
> BR/EDR.

Of course, yes, my previous implementation is not appropriate for this =
new API.  There's differences of opinion about what the API should be, =
and I'm proposing a revised API to address feedback from yourself and =
others.  If there's consensus that my revised API is appropriate, I'll =
then propose an implementation.

>=20
> Also, the AcquireWrite and AcquireNotify should fulfil most of the use
> cases where GATT is used just as transport to another protocol, is
> that what you are intending to do?

I'm merely conforming to an existing protocol, which requires me to only =
publish GATT attributes which are length <=3D MTU - 3.  This is because =
we can't depend on Long Read and Long Write support from BTLE clients.  =
In cases where a larger MTU has been negotiated, I need to take =
advantage of it, for optimal throughput.

I didn't design the protocol, but it's out there in the wild, and I need =
to support it.

>=20
> Having an API just for a very specific use case that in the future may
> actually disappear with OSes adopting L2CAP CoC is not very nice.

We already have several LE-specific APIs (e.g. LEAdvertisingManager), so =
I don't understand this objection.  BTLE GATT will be with us =
essentially forever.  Also, I've proposed marking this dbus property as =
experimental, so I don't see the problem with trying it out.  It =
addresses a real need.

Best,

Jonah=
