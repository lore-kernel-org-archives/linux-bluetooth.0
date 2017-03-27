Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v1] Bluetooth: hci_bcm: Support platform enumeration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490635125.708.21.camel@linux.intel.com>
Date: Mon, 27 Mar 2017 20:00:42 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-Id: <F9B2AE00-087D-4F2F-9F74-30CF991AF641@holtmann.org>
References: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
 <5C21C940-1B45-4949-BF3E-9417DE5AAC71@holtmann.org>
 <1490635125.708.21.camel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

>>> Until now the driver supports only ACPI enumeration. Nevertheless
>>> Intel Edison SoM has Broadcom Wi-Fi + BT chip and neither ACPI nor
>>> DT
>>> enumeration mechanism.
>>> 
>>> Enable pure platform driver in order to support Intel Edison SoM.
>> 
>> explain to me what this the case. Didn’t we enabled also DT for
>> Edison? And I assumed in general we planned to move away from platform
>> drivers in favour of DT.
> 
> Nope. It's SFI based device which basically means platform data only.

hold on, but SFI can be enumerated like ACPI. What am I missing here?

Regards

Marcel

