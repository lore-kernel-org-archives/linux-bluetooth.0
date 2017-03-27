Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1490635125.708.21.camel@linux.intel.com>
Subject: Re: [PATCH v1] Bluetooth: hci_bcm: Support platform enumeration
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	 <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, Jarkko Nikula
	 <jarkko.nikula@linux.intel.com>
Date: Mon, 27 Mar 2017 20:18:45 +0300
In-Reply-To: <5C21C940-1B45-4949-BF3E-9417DE5AAC71@holtmann.org>
References: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
	 <5C21C940-1B45-4949-BF3E-9417DE5AAC71@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-03-27 at 16:01 +0200, Marcel Holtmann wrote:
> Hi Andy,
> 
> > Until now the driver supports only ACPI enumeration. Nevertheless
> > Intel Edison SoM has Broadcom Wi-Fi + BT chip and neither ACPI nor
> > DT
> > enumeration mechanism.
> > 
> > Enable pure platform driver in order to support Intel Edison SoM.
> 
> explain to me what this the case. Didn’t we enabled also DT for
> Edison? And I assumed in general we planned to move away from platform
> drivers in favour of DT.

Nope. It's SFI based device which basically means platform data only.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
