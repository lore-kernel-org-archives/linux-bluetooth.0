Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v1] Bluetooth: hci_bcm: Support platform enumeration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
Date: Tue, 28 Mar 2017 13:11:00 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-Id: <5F950845-8182-4C29-9DFF-9771E68329E1@holtmann.org>
References: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Until now the driver supports only ACPI enumeration. Nevertheless
> Intel Edison SoM has Broadcom Wi-Fi + BT chip and neither ACPI nor DT
> enumeration mechanism.
> 
> Enable pure platform driver in order to support Intel Edison SoM.
> 
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 50 ++++++++++++++++++++++++++++++---------------
> 1 file changed, 33 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

