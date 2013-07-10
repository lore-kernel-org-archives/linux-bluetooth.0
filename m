Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 17:55:41 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
Message-ID: <20130710165541.GE2952@joana>
References: <20130709170502.GA32765@debian.seek.priv>
 <20130710154623.GD2952@joana>
 <20130710162418.GA16548@debian.seek.priv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710162418.GA16548@debian.seek.priv>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

* Gianluca Anzolin <gianluca@sottospazio.it> [2013-07-10 18:24:18 +0200]:

> Hello,
> 
> On Wed, Jul 10, 2013 at 04:46:23PM +0100, Gustavo Padovan wrote:
> > Hi Gianluca,
> > 
> > haven't looked into detail into these patches, but to get rfcomm patches
> > upstream you would first need the tty maintainer to accept this patch you are
> > mentioning since our side would depend on it. It seems to be a regression
> > caused by aa27a094e2c and your patch seems to be the right fix.
> 
> Thank you for pointing that out. These patches were also sent to Marcel Holtman
> who seems to be the maintainer by looking at the source and by using the script
> get_maintainers.pl and I'm waiting for a reply.
> 
> The source mentions also Maxim Krasnyansky, I didn't include him since the
> maintainers script didn't return his name anymore. Should I send the patches
> also to him?

No, just keep sending the bluetooth patches here. Once you get the drivers/tty
patch applied we can go ahead with the bluetooth ones. It helps if you also
use git formatted patches. 

	Gustavo
