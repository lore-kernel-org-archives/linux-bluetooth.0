Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: Make BT_HCIUART_RTL configuration option
 depend on ACPI
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180814095707.5674-1-hdegoede@redhat.com>
Date: Tue, 21 Aug 2018 16:37:40 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-Id: <1B665CCB-4334-44B3-9785-2C9C20979264@holtmann.org>
References: <20180814095707.5674-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> At the moment we only support ACPI enumeration for serial port attached
> RTL bluetooth controllers.
> 
> This commit adds a dependency on ACPI to the BT_HCIUART_RTL configuration
> option, fixing the following warning when ACPI is not enabled:
> 
> drivers/bluetooth/hci_h5.c:920:22: warning: 'rtl_vnd' defined but not used
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied bluetooth-stable tree.

Regards

Marcel
