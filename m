Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_bcm: Switch to
 devm_acpi_dev_add_driver_gpios()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
Date: Fri, 9 Jun 2017 18:47:04 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <33720796-6543-486F-BBD7-EF4CFFF069DE@holtmann.org>
References: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Switch to use managed variant of acpi_dev_add_driver_gpios() to simplify
> error path and fix potentially wrong assingment if ->probe() fails.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

