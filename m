Return-Path: <foo00@h08.hostsharing.net>
Date: Thu, 28 Dec 2017 08:15:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
Message-ID: <20171228071551.GA31236@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 26, 2017 at 09:50:30PM +0100, Marcel Holtmann wrote:
> > +}
> > +
> > +static int bcm_apple_set_power(struct bcm_device *dev, bool enable)
> > +{
> > +	return ACPI_SUCCESS(acpi_evaluate_object(enable ? dev->btpu : dev->btpd,
> > +						 NULL, NULL, NULL))
> > +								 ? 0 : -EFAULT;
> 
> Same here. Trying to mush everything in a single statement seems overkill.
> And btw. why -EFAULT? Is that standard error practice with ACPI?

-EFAULT was just chosen as a generic error because we don't really know
what went wrong with the ACPI call.  It seems there's no function to
convert an ACPI exception code to an errno, only a function to convert it
to a human-readable string, acpi_format_exception().  If you have a
different preference than -EFAULT I'd be happy to change it.

D'accord on all your other comments, will respin in the coming days.

Thanks,

Lukas
