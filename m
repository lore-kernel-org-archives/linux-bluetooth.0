Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1515006492.7000.639.camel@linux.intel.com>
Subject: Re: [PATCH v2 09/10] Bluetooth: hci_bcm: Handle errors properly
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 21:08:12 +0200
In-Reply-To: <20180103185422.GA17983@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
         <a91a911d570345ea15935f3db8ddd66aa8986661.1514916630.git.lukas@wunner.de>
         <1514995722.7000.578.camel@linux.intel.com>
         <20180103185422.GA17983@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-01-03 at 19:54 +0100, Lukas Wunner wrote:
> On Wed, Jan 03, 2018 at 06:08:42PM +0200, Andy Shevchenko wrote:
> > On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> > > +	int err = 0;
> > 
> > Obviously redundant assignment.
> 
> No, you need to look at it in the context of patch [10/10], which
> changes
> the following portion of bcm_gpio_set_power():

Then why this assignment here?

Move it to related patch.

> 
> -	gpiod_set_value(dev->shutdown, powered);
> +	if (x86_apple_machine)
> +		err = bcm_apple_set_power(dev, powered);
> +	else
> +		gpiod_set_value(dev->shutdown, powered);
> +	if (err)
> +		goto err_clk_disable;
> 
> I need to set err = 0 in case the gpiod_set_value() code path is
> chosen.
> 
> Of course I could only declare "int err;" in this patch and change it
> to
> "int err = 0;" in the next patch, but then I would expect an objection
> along the lines of:  You're changing code you've just added in the
> prior
> patch, this is silly.

Nope. Assignment belongs to when code really needs it. It overrides
ping-ponging style in this case I suppose.

> Long term the gpio API will be changed such that gpiod_set_value()
> returns a negative errno or 0 (instead of void), as we're already
> doing for gpiod_get_value().  *Then* I can change this to declare
> "int err;" and set "err = gpiod_set_value(...)".

It's a good roadmap, though out of scope of the current approach AFAICS.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
