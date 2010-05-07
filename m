Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 May 2010 16:57:04 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Data transmission and reconnections in HDP
Message-ID: <20100507195704.GC4857@vigoh>
References: <201005071302.36198.jcaden@libresoft.es>
 <20100507120859.GD12461@vigoh>
 <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

* João Paulo Rechi Vita <jprvita@gmail.com> [2010-05-07 15:25:17 -0300]:

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
> >>  Option 1: Implicit reconnections: The application is not concern about the
> >> disconnections or reconnections of the data channel until it is deleted.
> >>
> >>       We prefer this option because fixes more with a manager philosophy. A
> >> 20601 manager sould not perceive temporal disconnections because this way can
> >> hold it state if it perceives a disconnection, next time it reconnects it will
> >> need to exchange again apdus for association.
> >>
> >>  Option 2: Reconnections by the application. The applications are notified when
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
> >>  Option 1: Fd_passing the l2cap socket of the data channel to the client. The
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

If you are using Streming Mode you really don't care, if ERTM an error
will be reported and the application will get notified. ;)

-- 
Gustavo F. Padovan
http://padovan.org
