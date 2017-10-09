Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 9 Oct 2017 10:06:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>,
	gustavo@padovan.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, frederic.danis.oss@gmail.com,
	robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com,
	Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org,
	Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH v3 2/2] serdev: Update drivers/bluetooth/Kconfig for ACPI
 serdev support
Message-ID: <20171009080606.GO2618@localhost>
References: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e@gmail.com>
 <427a95f6-feda-e93e-9a0f-a05b7b339ee6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427a95f6-feda-e93e-9a0f-a05b7b339ee6@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 09, 2017 at 11:43:31AM +1100, Ian W MORRISON wrote:
> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly
> since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for
> serdev. This is only possible if serdev support is compiled in as the code
> hooks into TTY. Otherwise PM will silently break as the corresponding
> platform devices would no longer be registered and as the tty class
> device is also gone and hciattach (btattach) will also fail.
> 
> This patch set addresses this by making BT_HCIUART_BCM dependent on
> SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS
> and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Ok, so you didn't even bother to write two distinct commit messages for
your two patches, and my comments to the first patch apply also here.

> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index fae5a74dc737..8d432ee9f4bd 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -171,6 +171,7 @@ config BT_HCIUART_BCM
>  	depends on BT_HCIUART_SERDEV
>  	select BT_HCIUART_H4
>  	select BT_BCM
> +	select SERIAL_DEV_CTRL_TTYPORT

I think

	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)

or just

	depends on SERIAL_DEV_CTRL_TTYPORT

is what we want here, but that's still being discussed.

[ In general, select should be avoided as you could end up with options
enabled without their dependencies also being enabled. In this case,
we're fine as BT_HCIUART_BCM as depends on SERIAL_DEV_BUS via
BT_HCIUART_SERDEV, and your first patch ruled out SERIAL_DEV_BUS=y, but
that's not obvious. ]

>  	help
>  	  The Broadcom protocol support enables Bluetooth HCI over serial
>  	  port interface for Broadcom Bluetooth controllers.

Johan
