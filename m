Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100924141046.GA26454@sirena.org.uk>
References: <AANLkTin9Qji_bdyd3yqrP_-ti5xRT9jJ4je2fPM=uHFX@mail.gmail.com>
	<20100924141046.GA26454@sirena.org.uk>
Date: Mon, 27 Sep 2010 10:16:11 +0200
Message-ID: <AANLkTin=PPfgnD5tKBPR1QXf2OeBKBH-kXtoT+s-KPhk@mail.gmail.com>
Subject: Re: [PATCH 1/6] This patch adds support for the ST-Ericsson CG2900
From: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linus.walleij@stericsson.com, Pavan Savoy <pavan_savoy@sify.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again Mark,

I've not got an answer from the developer of the particular piece of code.

2010/9/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Sep 24, 2010 at 03:46:44PM +0200, Par-Gunnar Hjalmdahl wrote:
>
>> +static irqreturn_t cg2900_devices_interrupt(int irq, void *dev_id)
>> +{
>> +     disable_irq_nosync(irq);
>> +     if (cg2900_dev_callback && cg2900_dev_callback->interrupt_cb)
>> +             cg2900_dev_callback->interrupt_cb();
>> +
>> +     return IRQ_HANDLED;
>> +}
>
> Why is there this callback mechanism - I'd expect the users of this code
> to just be using the standard IRQ infrastructure?
>

This is our local IRQ which is handled in cg2900_uart.c by creating a work:

static void cg2900_devices_irq_cb(void)
{
 /* Create work and leave irq context. */
 (void)create_work_item(uart_info->wq, handle_cts_irq, NULL);
}


I understand your concern that client implementing the
cg2900_dev_callback->interrupt_cb();
might not know realized that this is irq context which might cause problems.

My motivation for doing like this that we do not expect other clients
of this code, so there
is no such risk. We create work in cg2900_uart and leave function.

Let me know if it is ok.
If not then suggest what is expected way of handling it ? eg. moving
workqueue down to cg2900_devices
or other solution?

Best regards,
/Lukasz via P-G
