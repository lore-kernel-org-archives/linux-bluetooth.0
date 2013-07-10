Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 13:24:46 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Mathias Hasselmann <mathias.hasselmann@kdab.com>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
Message-ID: <20130710112446.GA9592@debian.seek.priv>
References: <20130709170502.GA32765@debian.seek.priv>
 <51DD1897.5020408@mentor.com>
 <1373445561.4594.21.camel@smarty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373445561.4594.21.camel@smarty>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 10, 2013 at 10:39:21AM +0200, Mathias Hasselmann wrote:
> > Is this failure easy to reproduce ?
> 
> Just setup a RFCOMM tty and then violently break the link, by killing
> the rfcomm tool, by plugging the bt adapter, by turning off one
> peer, ... As soon as timeouts occur on the still running side you'll get
> the panic. Almost 100% reproducible.

Hi,

yes indeed that's the easiest way to reproduce the issue. I was wondering
why so few people hit these bugs since they're so easy to trigger.

Did you have a chance to test the two patches I sent?

Ciao,
Gianluca

> 
> Ciao,
> Mathias
> -- 
> Mathias Hasselmann | mathias.hasselmann@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel. Germany +49-30-521325470, Sweden (HQ) +46-563-540090
> KDAB - Qt Experts - Platform-independent software solutions
> 
> 
