Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1514453177.7000.320.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Frederic Danis
 <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,  Leif
 Liddy <leif.liddy@gmail.com>, Daniel Roschka
 <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>,
 "Peter Y. Chuang" <peteryuchuang@gmail.com>,
 linux-bluetooth@vger.kernel.org
Date: Thu, 28 Dec 2017 11:26:17 +0200
In-Reply-To: <20171228091805.GA1559@wunner.de>
References: 
	<5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
	 <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
	 <1514450477.7000.302.camel@linux.intel.com>
	 <20171228091805.GA1559@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-12-28 at 10:18 +0100, Lukas Wunner wrote:
> On Thu, Dec 28, 2017 at 10:41:17AM +0200, Andy Shevchenko wrote:
> > On Tue, 2017-12-26 at 17:07 +0200, Lukas Wunner wrote:
> > > Loading hci_bcm with CONFIG_GPIOLIB=n results in the following
> > > splat
> > > when calling gpiod_to_irq() from bcm_get_resources():
> > > 
> > >     WARNING: CPU: 0 PID: 1006 at
> > > ./include/linux/gpio/consumer.h:450
> > > bcm_get_resources+0x50/0x80
> > >     CPU: 0 PID: 1006 Comm: kworker/u8:4 Tainted:
> > > G       A         4.15.0-rc4custom+ #4
> > >     Hardware name: Apple Inc. MacBook8,1/Mac-BE0E8AC46FE800CC,
> > > BIOS
> > > MB81.88Z.0168.B00.1708080033 08/08/2017
> > >     Call Trace:
> > >     bcm_serdev_probe+0x8b/0xc0
> > >     driver_probe_device+0x202/0x310
> > >     __driver_attach+0x85/0x90
> > >     ? driver_probe_device+0x310/0x310
> > >     bus_for_each_dev+0x57/0x80
> > >     async_run_entry_fn+0x2c/0xd0
> > >     process_one_work+0x1d2/0x3d0
> > >     worker_thread+0x26/0x3c0
> > >     ? process_one_work+0x3d0/0x3d0
> > >     kthread+0x10c/0x130
> > >     ? kthread_create_on_node+0x40/0x40
> > >     ret_from_fork+0x1f/0x30
> > > 
> > > We could call gpiod_to_irq() only if IS_ENABLED(CONFIG_GPIOLIB)
> > > but
> > > without GPIOLIB, the driver's power saving features can't be used,
> > > so selecting GPIOLIB seems more appropriate.
> > > 
> > > The same issue is present in hci_intel.c and hci_nokia.c, fix
> > > those up
> > > as well.
> > > 

> > > +	select GPIOLIB
> > 
> > This is wrong solution. GPIOLIB is meant for GPIO providers, not
> > consumers.
> > 
> > That's why after I did BT support for Intel MID (commit d4d96990)
> > the necessity of exporting gpiod_add_lookup_table() had been arisen
> > (commit 020e0b1c8f19f).
> 
> Hm okay, Documentation/gpio/consumer.txt says:
> 
>     Guidelines for GPIOs consumers
>     ==============================
> 
>     Drivers that can't work without standard GPIO calls should have
>     Kconfig entries that depend on GPIOLIB.
> 
> So a "depends on GPIOLIB" would be more appropriate, right?

Yes, but still wrong for this certain driver. It *can* work w/o GPIOLIB.
Now you have done unnecessary dependency for that case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
