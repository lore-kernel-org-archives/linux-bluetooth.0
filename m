Return-Path: <cyrus@holtmann.org>
Message-ID: <1373445561.4594.21.camel@smarty>
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
From: Mathias Hasselmann <mathias.hasselmann@kdab.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Gianluca Anzolin <gianluca@sottospazio.it>, marcel@holtmann.org,
	gustavo@padovan.org, linux-bluetooth@vger.kernel.org
Date: Wed, 10 Jul 2013 10:39:21 +0200
In-Reply-To: <51DD1897.5020408@mentor.com>
References: <20130709170502.GA32765@debian.seek.priv>
	 <51DD1897.5020408@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, den 10.07.2013, 09:17 +0100 schrieb Dean Jenkins:
> Hi Gianluca,
> 
> On 09/07/13 18:05, Gianluca Anzolin wrote:
> > In net/bluetooth/rfcomm/tty.c the struct tty is used without proper
> > refcounting. This leads to OOPS and panics triggered by the tty layer functions
> > which are invoked after the struct tty has already been destroyed.
> >
> > This happens for example when the bluetooth connection is lost because the host
> > goes down unexpectedly.
> >
> > The fix uses the tty_port_* helpers already in place.
> >
> > This patch depends on patch "Fix refcount leak in tty_port.c" already sent to
> > linux-kernel. [0]
> >
> > Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> >
> > [0] http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00600.html
> >
> 
> Do you have any backtraces of the OOPS and panics ?
> 
> In which kernel did you discover the failure ?
> 
> What platform were you using, I mean x86, ARM or something else ?
> 
> Is this failure easy to reproduce ?

Just setup a RFCOMM tty and then violently break the link, by killing
the rfcomm tool, by plugging the bt adapter, by turning off one
peer, ... As soon as timeouts occur on the still running side you'll get
the panic. Almost 100% reproducible.

Ciao,
Mathias
-- 
Mathias Hasselmann | mathias.hasselmann@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel. Germany +49-30-521325470, Sweden (HQ) +46-563-540090
KDAB - Qt Experts - Platform-independent software solutions
