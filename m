Return-Path: <nish.aravamudan@gmail.com>
Message-ID: <29495f1d050206141977a6b4fa@mail.gmail.com>
Date: Sun, 6 Feb 2005 14:19:29 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [KJ] Re: [PATCH 19/20] bluetooth/bluecard_cs: remove interruptible_sleep_on_timeout() usage
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kernel-janitors@lists.osdl.org,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <1107562301.6921.115.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050202225855.GY2546@us.ibm.com>
	 <1107386189.11944.21.camel@pegasus> <20050203002502.GB2546@us.ibm.com>
	 <1107562301.6921.115.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 05 Feb 2005 01:11:41 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nish,
> 
> > > > Please consider applying.
> > > >
> > > > Description: Remove deprecated interruptible_sleep_on_timeout() function calls
> > > > and replace with direct wait-queue usage. Some naming conflicts occurred, which
> > > > I tried to resolve appropriately. Patch is compile-tested.
> > >
> > > you introduce more code than you remove. Is our code a special case or
> > > why don't exists a simple API function as replacement?
> >
> > Yes, I do. *sleep_on*() was the API, which has been replaced with wait_event*().
> > However, wait_event*() explicitly needs a condition (the "event"), which in
> > thise case does not exist. If I had more background, I would have gone the
> > wait_event*() route. I am looking into a better API to mask away all of the
> > DEFINE_WAIT(), prepare_to_wait(), schedule()/schedule_timeout(), finish_wait()
> > additions (the KJ list can attest to how many of these replacements I'm doing),
> > but there simply does not exist such an API right now.
> >
> > Any input you could provide, though, would be greatly appreciated.
> 
> I gave your patch a shot and the oops below happens on a 2.6.11-rc3
> after plugging in the card. Without the patch it is working.

Sorry for the long delay without a response!

That looks like I may have missed some wake-up related issues. I'll
check on it and get back to you soon.

Thanks,
Nish
