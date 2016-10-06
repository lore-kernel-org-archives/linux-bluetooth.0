Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1475737388.5772.1.camel@gmail.com>
Subject: Re: Bluetooth not working anymore due to too agressive PM in
 hci_bcm ? (was: [PATCH v5 5/5] Bluetooth: hci_bcm: Add suspend/resume
 runtime PM functions)
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Loic Poulain <loic.poulain@intel.com>, Marcel Holtmann
 <marcel@holtmann.org>,  linux-bluetooth@vger.kernel.org
Cc: Frederic Danis <frederic.danis@intel.com>
Date: Thu, 06 Oct 2016 09:03:08 +0200
In-Reply-To: <1475702165.5992.4.camel@gmail.com>
References: <1475533357.2947.3.camel@gmail.com>
	 <da9a4059-4164-e455-a451-83c97e57ad71@intel.com>
	 <1475702165.5992.4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> > I remember Frederic had some gpio/irq polarity issues:>
> > 5cebdfea32b89911d4540440c1c2854a1a3d591e
> > Bluetooth: hci_bcm: Fix IRQ polarity for T100
> > Maybe the ACPI table is not correct on some devices.
> 
> 
> I had seen that patch indeed. I'm attaching the ACPI table I had shared on
> the list a long time ago for the ThinkPad Tablet 8. Is there anything that
> looks suspicious in there and that you could link to a similar gpio/irq
> polarity issue maybe?
> 
> If you think there is a good chance that this could be the issue as well,
> I
> will try to build a similar patch for this ThinkPad product and share my
> results.

Just to let you know, after finding the right DMI values to simply adapt the
above patch for my ThinkPad tablet, I can confirm that a quick local kernel
modification indeed fixes the issue.

I will need a bit more time to propose a proper patch, adding this other
impacted tablet instead of replacing the above Asus one, and supporting
potentially even more products facing the same polarity issue.

Is hard-coding such exceptions / polarity issues manually the only way to go
or could there be a way to detect this programmatically instead?

Regards,
Jérôme
