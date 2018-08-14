Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: Make BT_HCIUART_RTL configuration option
 depend on ACPI
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAK8P3a3QN9oo+vo=aTZGEABj7Q8igWwZh7R+p6vRMKWoK7Hg=A@mail.gmail.com>
Date: Tue, 14 Aug 2018 12:36:09 +0200
Cc: Hans de Goede <hdegoede@redhat.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Message-Id: <023F3FC8-EE26-444E-BA0F-4F50317A7530@holtmann.org>
References: <20180814095707.5674-1-hdegoede@redhat.com>
 <CAK8P3a3QN9oo+vo=aTZGEABj7Q8igWwZh7R+p6vRMKWoK7Hg=A@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

>> At the moment we only support ACPI enumeration for serial port attached
>> RTL bluetooth controllers.
>> 
>> This commit adds a dependency on ACPI to the BT_HCIUART_RTL configuration
>> option, fixing the following warning when ACPI is not enabled:
>> 
>> drivers/bluetooth/hci_h5.c:920:22: warning: 'rtl_vnd' defined but not used
>> 
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This fixes the warning,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I wonder whether CONFIG_BT_HCIUART_3WIRE should also
> depend on ACPI and/or become a silent option, since it's currently
> useless when either ACPI or BT_HCIUART_RTL are disabled,
> and it seems possible that things break differently when another
> back-end gets added there.

why would it be useless? There is still a line discipline mode that it can be used for. Moving this all to the new bt3wire.c driver would have been cleaner and less Kconfig messy.

Regards

Marcel
