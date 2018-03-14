Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 14 Mar 2018 23:22:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4.16 REGRESSION fix 2/2] Bluetooth: hci_bcm: Set
 pulsed_host_wake flag in sleep parameters
Message-ID: <20180314222244.GC28738@wunner.de>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314220603.7559-3-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:06:03PM +0100, Hans de Goede wrote:
> The IRQ output of the bcm bt-device is really a level IRQ signal, which
> signals a logical high as long as the device's buffer contains data. Since
> the draining in the buffer is done in the tty driver, we cannot (easily)
> wait in a threaded interrupt handler for the draining, after which the
> IRQ should go low again.
> 
> So instead we treat the IRQ as an edge interrupt. This opens the window
> for a theoretical race where we wakeup, read some data and then autosuspend
> *before* the IRQ has gone (logical) low, followed by the device just at
> that moment receiving more data, causing the IRQ to stay high and we never
> see an edge.
> 
> Since we call pm_runtime_mark_last_busy() on every received byte, there
> should be plenty time for the IRQ to go (logical) low before we ever
> suspend, so this should never happen, but after commit 43fff7683468
> ("Bluetooth: hci_bcm: Streamline runtime PM code"), which has been reverted
> since, this was actually happening causing the device to get stuck in
> runtime suspend.
> 
> The bcm bt-device actually has a workaround for this, if we set the
> pulsed_host_wake flag in the sleep parameters, then the device monitors
> if the host is draining the buffer and if not then after a timeout the
> device will pulse the IRQ line, causing us to see an edge, fixing the
> stuck in suspend condition.
> 
> This commit sets the pulsed_host_wake flag to fix the (mostly theoretical)
> race caused by us treating the IRQ as an edge IRQ.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Good work, thanks.

> ---
>  drivers/bluetooth/hci_bcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index b089012a49f9..04b9a6c75c75 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -307,7 +307,7 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
>  	.usb_auto_sleep = 0,
>  	.usb_resume_timeout = 0,
>  	.break_to_host = 0,
> -	.pulsed_host_wake = 0,
> +	.pulsed_host_wake = 1,
>  };
>  
>  static int bcm_setup_sleep(struct hci_uart *hu)
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
