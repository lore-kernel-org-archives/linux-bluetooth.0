Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 19:54:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 09/10] Bluetooth: hci_bcm: Handle errors properly
Message-ID: <20180103185422.GA17983@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <a91a911d570345ea15935f3db8ddd66aa8986661.1514916630.git.lukas@wunner.de>
 <1514995722.7000.578.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514995722.7000.578.camel@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 03, 2018 at 06:08:42PM +0200, Andy Shevchenko wrote:
> On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> > +	int err = 0;
> 
> Obviously redundant assignment.

No, you need to look at it in the context of patch [10/10], which changes
the following portion of bcm_gpio_set_power():

-	gpiod_set_value(dev->shutdown, powered);
+	if (x86_apple_machine)
+		err = bcm_apple_set_power(dev, powered);
+	else
+		gpiod_set_value(dev->shutdown, powered);
+	if (err)
+		goto err_clk_disable;

I need to set err = 0 in case the gpiod_set_value() code path is chosen.

Of course I could only declare "int err;" in this patch and change it to
"int err = 0;" in the next patch, but then I would expect an objection
along the lines of:  You're changing code you've just added in the prior
patch, this is silly.

Long term the gpio API will be changed such that gpiod_set_value()
returns a negative errno or 0 (instead of void), as we're already
doing for gpiod_get_value().  *Then* I can change this to declare
"int err;" and set "err = gpiod_set_value(...)".


> > +#ifdef CONFIG_PM
> > +	bcm->dev->hu = NULL;
> > +#endif
> 
> Hmm... There is no field in !PM case?

Yes, there isn't.

Thanks for the review!

Lukas
