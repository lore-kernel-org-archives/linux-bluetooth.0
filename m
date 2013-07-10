Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 12:43:10 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
Message-ID: <20130710104310.GA9365@debian.seek.priv>
References: <20130709170502.GA32765@debian.seek.priv>
 <51DD1897.5020408@mentor.com>
 <20130710093724.GA8829@debian.seek.priv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710093724.GA8829@debian.seek.priv>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 10, 2013 at 11:37:24AM +0200, Gianluca Anzolin wrote:
> Linux kernel 3.10, but I see the issue is reproducible also on 3.9 because
> other people reported it a while ago: have a look at this thread
> 
> http://marc.info/?t=136868685500006&r=1&w=2

Oh wait, it seems you were already aware of this issue, since you were part of
that discussion too...

Sorry if I didn't CC you directly when I sent the patches.

Ciao,
Gianluca
