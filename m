Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_bcm: For serdev case close serdev
 on failure to set power
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180122115325.28960-2-hdegoede@redhat.com>
Date: Mon, 22 Jan 2018 13:02:13 +0100
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Message-Id: <6C1ACEC1-1A7E-44CC-9DB8-843CE5C41BA2@holtmann.org>
References: <20180122115325.28960-1-hdegoede@redhat.com>
 <20180122115325.28960-2-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Commit 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> introduced error checking for the bcm_gpio_set_power() call in bcm_open()
> but the error-path it introduces unsets dev->hu, which is correct for
> platform_device instantiated bcm_dev-s but not for serdev instantiated
> devs. For serdev instantiated devs serdev_device_close() should be called
> instead (and dev->hu should be left set).
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Fixes: 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

