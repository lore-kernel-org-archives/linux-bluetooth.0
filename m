Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: pHilipp Zabel
	<philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
In-Reply-To: <4A6D7A47.8050001@pengutronix.de>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
	 <74d0deb30902271435u1d2ac128ob09896a86abbff64@mail.gmail.com>
	 <4A6D7A47.8050001@pengutronix.de>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 12:13:31 +0200
Message-Id: <1248689611.28545.196.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wolfram,

> > On Fri, Feb 27, 2009 at 5:54 PM, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> pcmcia_loop_config returns 0 on success.
> >>
> >> Signed-off-by: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/bluetooth/dtl1_cs.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> >> index 901bdd9..e0ee642 100644
> >> --- a/drivers/bluetooth/dtl1_cs.c
> >> +++ b/drivers/bluetooth/dtl1_cs.c
> >> @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
> >>
> >>        /* Look for a generic full-sized window */
> >>        link->io.NumPorts1 = 8;
> >> -       if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
> >> +       if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
> >>                goto failed;
> >>
> >>        i = pcmcia_request_irq(link, &link->irq);
> >> --
> >> 1.5.6.5
> > 
> > with this change my Nokia DTL-1 CF card gets detected, but the
> > interface stays down.
> 
> I am reviewing patches which came through the pcmcia-list since the last 
> upstream commit last year.
> 
> IMHO the above patch could be queued, even though there seem to be further 
> issues with the driver. What do you think?
> 
> So, for the above patch:
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

can we change it into if (pcmcia_loop_config(...) < 0) to it perfectly
clear here.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


