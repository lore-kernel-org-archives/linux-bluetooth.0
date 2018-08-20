Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180814095707.5674-1-hdegoede@redhat.com>
In-Reply-To: <20180814095707.5674-1-hdegoede@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Aug 2018 22:54:50 +0200
Message-ID: <CAMuHMdUbbgtEEdZ-nm5i+Z7QejnaK7LQWtMUe_ysYau_08gg0w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Make BT_HCIUART_RTL configuration option
 depend on ACPI
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, jeremy@jcline.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2018 at 12:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
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

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
