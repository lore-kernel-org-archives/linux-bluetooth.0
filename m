Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
To: Lukas Wunner <lukas@wunner.de>, Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Frederic Danis <frederic.danis.oss@gmail.com>,
 Loic Poulain <loic.poulain@linaro.org>, Max Shavrick <mxms@me.com>,
 Leif Liddy <leif.liddy@gmail.com>,
 Daniel Roschka <danielroschka@phoenitydawn.de>,
 Ronald Tschalaer <ronald@innovation.ch>,
 "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
 <20171228071551.GA31236@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <aa3ebfae-7721-85bb-0f55-ca0cf2f54fa5@redhat.com>
Date: Thu, 28 Dec 2017 13:40:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171228071551.GA31236@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 28-12-17 08:15, Lukas Wunner wrote:
> On Tue, Dec 26, 2017 at 09:50:30PM +0100, Marcel Holtmann wrote:
>>> +}
>>> +
>>> +static int bcm_apple_set_power(struct bcm_device *dev, bool enable)
>>> +{
>>> +	return ACPI_SUCCESS(acpi_evaluate_object(enable ? dev->btpu : dev->btpd,
>>> +						 NULL, NULL, NULL))
>>> +								 ? 0 : -EFAULT;
>>
>> Same here. Trying to mush everything in a single statement seems overkill.
>> And btw. why -EFAULT? Is that standard error practice with ACPI?
> 
> -EFAULT was just chosen as a generic error because we don't really know
> what went wrong with the ACPI call.  It seems there's no function to
> convert an ACPI exception code to an errno, only a function to convert it
> to a human-readable string, acpi_format_exception().  If you have a
> different preference than -EFAULT I'd be happy to change it.

In that case please use e.g. -EIO, or something else similar, EFAULT
has a very clear definition: userspace has called us with an invalid
address (which would cause a segfault when used from userspace code
directly), so please do not use it for anything else.

Regards,

Hans
