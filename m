Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
References: <20180814095707.5674-1-hdegoede@redhat.com>
In-Reply-To: <20180814095707.5674-1-hdegoede@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Aug 2018 12:25:47 +0200
Message-ID: <CAK8P3a3QN9oo+vo=aTZGEABj7Q8igWwZh7R+p6vRMKWoK7Hg=A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Make BT_HCIUART_RTL configuration option
 depend on ACPI
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jeremy Cline <jeremy@jcline.org>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2018 at 11:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
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

This fixes the warning,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I wonder whether CONFIG_BT_HCIUART_3WIRE should also
depend on ACPI and/or become a silent option, since it's currently
useless when either ACPI or BT_HCIUART_RTL are disabled,
and it seems possible that things break differently when another
back-end gets added there.

     Arnd
