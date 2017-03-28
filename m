Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1490689193.708.24.camel@linux.intel.com>
Subject: Re: [PATCH v1] Bluetooth: hci_bcm: Support platform enumeration
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Bluez mailing list
 <linux-bluetooth@vger.kernel.org>,  Jarkko Nikula
 <jarkko.nikula@linux.intel.com>
Date: Tue, 28 Mar 2017 11:19:53 +0300
In-Reply-To: <F9B2AE00-087D-4F2F-9F74-30CF991AF641@holtmann.org>
References: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
	 <5C21C940-1B45-4949-BF3E-9417DE5AAC71@holtmann.org>
	 <1490635125.708.21.camel@linux.intel.com>
	 <F9B2AE00-087D-4F2F-9F74-30CF991AF641@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-03-27 at 20:00 +0200, Marcel Holtmann wrote:
> Hi Andy,
> 
> > > > Until now the driver supports only ACPI enumeration.
> > > > Nevertheless
> > > > Intel Edison SoM has Broadcom Wi-Fi + BT chip and neither ACPI
> > > > nor
> > > > DT
> > > > enumeration mechanism.
> > > > 
> > > > Enable pure platform driver in order to support Intel Edison
> > > > SoM.
> > > 
> > > explain to me what this the case. Didn’t we enabled also DT for
> > > Edison? And I assumed in general we planned to move away from
> > > platform
> > > drivers in favour of DT.
> > 
> > Nope. It's SFI based device which basically means platform data
> > only.
> 
> hold on, but SFI can be enumerated like ACPI. What am I missing here?

You missed a whole point. :-)

SFI so useless that you may just forget about it.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
