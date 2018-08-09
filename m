Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 9 Aug 2018 20:53:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Introduce BT_HCIUART_RTL configuration
 option
Message-ID: <20180809175313.GA25757@x1c.home>
References: <20180809083307.29127-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809083307.29127-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

On Thu, Aug 09, 2018, Hans de Goede wrote:
> From: Marcel Holtmann <marcel@holtmann.org>
> 
> Like all the other UART protocols, introduce a configuration option for
> Realtek based serial devices.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2 (Hans de Goede)
> -Keep the depends on BT_HCIUART_SERDEV for BT_HCIUART_3WIRE even if we #ifdef
>  the btrtl bits we still need it for hci_uart_[un]register_device()
> -Add #ifdef CONFIG_BT_HCIUART_RTL checks to hci_h5.c so that it does not
>  reference the rtlbt.c code when BT_HCIUART_RTL is not set, this fixes linker
>  errors when BT_HCIUART_RTL is not set, BT_HCIUART_3WIRE=y (builtin) and
>  BT_HCIBTUSB_RTL=m, which selects BT_RTL=m, which would end up having the
>  btrtl symbols in a module with builtin code referencing it
> ---
>  drivers/bluetooth/Kconfig  | 13 +++++++++++++
>  drivers/bluetooth/hci_h5.c |  4 ++++
>  2 files changed, 17 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
