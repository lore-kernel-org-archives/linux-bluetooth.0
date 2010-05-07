Return-Path: <cyrus@holtmann.org>
Subject: Re: Data transmission and reconnections in HDP
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: =?ISO-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
References: <201005071302.36198.jcaden@libresoft.es>
	 <20100507120859.GD12461@vigoh>
	 <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 07 May 2010 20:39:07 +0200
Message-ID: <1273257547.1912.10.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paul,

El vie, 07-05-2010 a las 15:25 -0300, João Paulo Rechi Vita escribió:
> Hello Jose!
> 
> On Fri, May 7, 2010 at 09:08, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> > Hi José,
> >
> > * José Antonio Santos Cadenas <jcaden@libresoft.es> [2010-05-07 13:02:36 +0200]:
> >
> >> Hi all,
> >>
> >> I start this thread to discuss the alternatives to move the data from the
> >> application to the l2cap socket in HDP. Till now we have the following
> >> alternatives (please, add more if we missed something)
> >>
> >> Reconnections options:
> >>
> >>  Option 1: Implicit reconnections: The application is not concern about the
> >> disconnections or reconnections of the data channel until it is deleted.
> >>
> >>       We prefer this option because fixes more with a manager philosophy. A
> >> 20601 manager sould not perceive temporal disconnections because this way can
> >> hold it state if it perceives a disconnection, next time it reconnects it will
> >> need to exchange again apdus for association.
> >>
> >>  Option 2: Reconnections by the application. The applications are notified when
> >> a data channel is disconnected and should perform a reconnection before using
> >> it again.
> >>
> 
> The HDP Implementation Guidance Whitepaper clearly states that
> transport (HDP) disconnection / reconnection should be transparent for
> the data layer (IEEE 11073-20601), so I guess option 2 here would
> break the spec.

You're rigth, we consider that option 1 is the best approach. But it's
better try get consensus ;)
In addition, option 2 pass MCAP logic to application layer
(connection-reconnection), and 11073-20601 should be independent of such
transport specific characteristics.

> 
> >> Data transmission options:
> >>
> >>  Option 1: Fd_passing the l2cap socket of the data channel to the client. The
> >> problem with this is that some data can be lost by d-bus if the channel is
> >> disconnected. (We have to check how fd-passing works).
> >
> > DBus just pass the fd and then don't touch the fd anymore, data can't be
> > lost by DBus.
> >
> 
> I guess the problem Jose tried to address here is the case that HDP
> had temporarily disconnected the data channel and then the application
> try to write to the FD (which will be closed). Some data may be lost
> by the application on this process.
> 
> >>
> >>  Option 2: Fd_passing a pipe and HDP will write the data in the l2cap data
> >> chanel socket. The problem with this is that we need 2 pipes for each data
> >> channel, but no data will be lost because HDP controls the data flow with the
> >> sockets and resend data not correctly sent.
> >>
> >>       We think that the easier way for implicit reconnections is option 2.
> >> Because the application can always write on the socket it have (the pipe).
> >> Once written, the HDP layer tries to write it in the l2cap socket, if it
> >> fails, perform a reconnection operation over the data channel.
> >>
> 
> Considering the drawbacks of the other alternatives and taking into
> account that implicit reconnection is the right approach, this seems
> the better option. I can't see any problems on having 2 pipes per data
> channel, but I personally have never worked with splice directly so I
> can't address much issues of this approach.

We are considering this approach depending of comments got from this
thread, it isn't a final design yet... but may be, we need study more
alternatives.

> 
> >>  Option 3: Transmiting the data by d-bus. We think that this option is bad for
> >> d-bus, because of the overload of the system bus.
> >
> > Pretty bad ;)
> >
> 
> As Gustavo said, transmitting data over d-bus would be very bad. On
> some embedded platforms d-bus can be really slow and even for the
> desktop case this is unnecessary overhead.

We descarted this option from first time, but it appeared in other
e-mail so we should search consensus here too.

Thank a lot for your comments.

Best regards.



