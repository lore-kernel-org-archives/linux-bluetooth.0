Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 27 Dec 2017 15:17:55 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Frederic Danis <frederic.danis.oss@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
Message-ID: <20171227141755.GA3197@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Dec 26, 2017 at 09:50:30PM +0100, Marcel Holtmann wrote:
> > +static int bcm_gpio_set_device_wake(struct bcm_device *dev, bool awake)
> > +{
> > +	int err = 0;
> > +
> > +	if (x86_apple_machine)
> > +		err = bcm_apple_set_low_power(dev, !awake);
> > +	else if (dev->device_wakeup)
> > +		gpiod_set_value(dev->device_wakeup, awake);
> > +	else
> > +		return 0;
> > +
> > +	bt_dev_dbg(dev, "%s, delaying 15 ms", awake ? "resume" : "suspend");
> > +	mdelay(15);
> 
> Any chance for a comment here on why a delay of 15ms is needed?

The delay was introduced by your commit 118612fb9165 ("Bluetooth:
hci_bcm: Add suspend/resume PM functions").

Could you provide a rationale for it?  Perhaps 15 ms is the time
after which the controller auto-suspends following deassertion of
the device wake pin (which forces it into "on" state AFAIUI)?

Is there public documentation on this controller? I've tried to
search for it but my google-fu is failing me.

Thanks,

Lukas
