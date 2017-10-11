Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
To: Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
 Tobias Regnery <tobias.regnery@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20171011134640.3152236-1-arnd@arndb.de>
 <20171011134805.3207569-1-arnd@arndb.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ff49535c-61e1-f6da-8b2c-490dc55d5982@redhat.com>
Date: Wed, 11 Oct 2017 16:33:37 +0200
MIME-Version: 1.0
In-Reply-To: <20171011134805.3207569-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11-10-17 15:47, Arnd Bergmann wrote:
> It is no longer possible to build BT_HCIUART into the kernel
> when SERIAL_DEV_BUS is a loadable module, even if none of the
> SERIAL_DEV_BUS based implementations are selected:
> 
> drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
> hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
> hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'
> 
> This adds a dependency to avoid the broken configuration.
> 
> Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Another one I have on my TODO after the buildbot errors. In this case
I do not believe this is the proper fix though.

As pointed out in another thread discussing the series introducing
this problem, hci_ldisc.c really should not depend on serdev,
so the proper fix would be to have hci_bcm.c directly call
the serdev flowcontrol and rts functions when the hci is
backed by a serdev device, like hci_bcm.c is already doing
when setting the baudrate, see host_set_baudrate in hci_bcm.c,
so a similar host_set_flow_control should be added after which
the changes to hci_ldisc.c can be reverted.

If I understood Marcel correctly he prefers a single patch
fixing this which also removes the changes from hci_ldisc.c,
rather then a separate revert.

As said I've this on my todo, but feel free to beat me to it,
I likely will not get around to this before Friday anyways.

Regards,

Hans



> ---
>   drivers/bluetooth/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index fae5a74dc737..4427d54b7331 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -65,6 +65,7 @@ config BT_HCIBTSDIO
>   
>   config BT_HCIUART
>   	tristate "HCI UART driver"
> +	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
>   	depends on TTY
>   	help
>   	  Bluetooth HCI UART driver.
> @@ -79,7 +80,6 @@ config BT_HCIUART
>   config BT_HCIUART_SERDEV
>   	bool
>   	depends on SERIAL_DEV_BUS && BT_HCIUART
> -	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
>   	default y
>   
>   config BT_HCIUART_H4
> 
