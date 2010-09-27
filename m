Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 08:15:50 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linus.walleij@stericsson.com, Pavan Savoy <pavan_savoy@sify.com>
Subject: Re: [PATCH 1/6] This patch adds support for the ST-Ericsson CG2900
Message-ID: <20100927151550.GC13754@opensource.wolfsonmicro.com>
References: <AANLkTin9Qji_bdyd3yqrP_-ti5xRT9jJ4je2fPM=uHFX@mail.gmail.com>
 <20100924141046.GA26454@sirena.org.uk>
 <AANLkTin=PPfgnD5tKBPR1QXf2OeBKBH-kXtoT+s-KPhk@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTin=PPfgnD5tKBPR1QXf2OeBKBH-kXtoT+s-KPhk@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 27, 2010 at 10:16:11AM +0200, Par-Gunnar Hjalmdahl wrote:
> 2010/9/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Sep 24, 2010 at 03:46:44PM +0200, Par-Gunnar Hjalmdahl wrote:

> >> +static irqreturn_t cg2900_devices_interrupt(int irq, void *dev_id)
> >> +{
> >> +     disable_irq_nosync(irq);
> >> +     if (cg2900_dev_callback && cg2900_dev_callback->interrupt_cb)
> >> +             cg2900_dev_callback->interrupt_cb();
> >> +
> >> +     return IRQ_HANDLED;
> >> +}

> > Why is there this callback mechanism - I'd expect the users of this code
> > to just be using the standard IRQ infrastructure?

> This is our local IRQ which is handled in cg2900_uart.c by creating a work:

I can tell it's an IRQ - that's my point; the kernel has an interrupt
handling subsystem which this isn't using.

> I understand your concern that client implementing the
> cg2900_dev_callback->interrupt_cb();
> might not know realized that this is irq context which might cause problems.

No, you're misunderstanding my point.  The kernel has facilities for
representing interrupt controllers which this is not using.

> If not then suggest what is expected way of handling it ? eg. moving
> workqueue down to cg2900_devices
> or other solution?

Use the standard kernel IRQ framework to report interrupts to the
clients - there's quite a few examples of using this in the drivers/mfd
code.  This will make your code more idiomatic and give you access to
all the diagnostic infrastructure the kernel provides for interrupts.
