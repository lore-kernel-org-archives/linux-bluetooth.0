Return-Path: <nacc@us.ibm.com>
Date: Wed, 2 Feb 2005 16:25:02 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net,
   kernel-janitors@lists.osdl.org
Subject: Re: [PATCH 19/20] bluetooth/bluecard_cs: remove interruptible_sleep_on_timeout() usage
Message-ID: <20050203002502.GB2546@us.ibm.com>
References: <20050202225855.GY2546@us.ibm.com> <1107386189.11944.21.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1107386189.11944.21.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Feb 03, 2005 at 12:16:29AM +0100, Marcel Holtmann wrote:
> Hi Nish,
> 
> > Please consider applying.
> > 
> > Description: Remove deprecated interruptible_sleep_on_timeout() function calls
> > and replace with direct wait-queue usage. Some naming conflicts occurred, which
> > I tried to resolve appropriately. Patch is compile-tested.
> 
> you introduce more code than you remove. Is our code a special case or
> why don't exists a simple API function as replacement?

Yes, I do. *sleep_on*() was the API, which has been replaced with wait_event*().
However, wait_event*() explicitly needs a condition (the "event"), which in
thise case does not exist. If I had more background, I would have gone the
wait_event*() route. I am looking into a better API to mask away all of the
DEFINE_WAIT(), prepare_to_wait(), schedule()/schedule_timeout(), finish_wait()
additions (the KJ list can attest to how many of these replacements I'm doing),
but there simply does not exist such an API right now.

Any input you could provide, though, would be greatly appreciated.

-Nish
