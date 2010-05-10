Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: Data transmission and reconnections in HDP
Date: Mon, 10 May 2010 09:47:00 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh> <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
In-Reply-To: <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005100947.00418.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Friday 07 May 2010 20:25:17 João Paulo Rechi Vita escribió:
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

That's exactly what I tried to expose. If you do fd-passing with the l2cap socket, it 
is possible that the client writes data in a closed socket. If HDP fd-pass a pipe socket,
the client will write on the pipe, this way the client perceives just one file descriptor
which is exactly what we wanted if reconnections are implicit.


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

That's the best option for us too. As I said above, this way the client perceives
the same socket during the whole live of the connection, perfect for 
implicit reconnections.

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
> 
> >>
> >>  Option 4: Other IPC alternatives (more alternative here?)
> >>
> 
> 
