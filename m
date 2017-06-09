Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v1 2/2] Bluetooth: hci_intel: Add GPIO ACPI mapping table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170606144718.77620-2-andriy.shevchenko@linux.intel.com>
Date: Fri, 9 Jun 2017 18:47:05 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <69F06FBE-77A0-430D-AD3B-F7BBEA3B405B@holtmann.org>
References: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
 <20170606144718.77620-2-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> In order to make GPIO ACPI library stricter prepare users of
> gpiod_get_index() to correctly behave when there no mapping is
> provided by firmware.
> 
> Here we add explicit mapping between _CRS GpioIo() resources and
> their names used in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

