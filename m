Return-Path: <foo00@h08.hostsharing.net>
Date: Sat, 24 Mar 2018 09:02:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Don't change runtime-status when
 not using runtime-pm
Message-ID: <20180324080213.GB15184@wunner.de>
References: <20180319210237.26205-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319210237.26205-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:02:36PM +0100, Hans de Goede wrote:
> The pm_runtime_set_suspended() call in bcm_close() is intended as a
> counterpart to the pm_runtime_set_active() call from bcm_request_irq()
> (which gets called from bcm_setup()).
> 
> The pm_runtime_set_active() call only happens if our pre-requisites for
> doing runtime-pm are met. This commit adds the same check to the
> pm_runtime_set_suspended() call to avoid the runtime-pm state getting
> stuck in suspended after after a bcm_close().

Have you actually observed the state getting stuck in suspended?

I'm asking because I don't quite see how this could happen:
pm_runtime_set_suspended() becomes a no-op unless runtime PM is disabled.
Now, a few lines further up in bcm_close(), pm_runtime_disable() is only
called under the conditions you're adding here.  If it's not called,
pm_runtime_set_suspended() doesn't have any effect anyway so adding the
conditions is pointless.  Am I missing something?

Related:  I notice that bcm_resume() calls pm_runtime_set_active().
Doesn't that have the effect that if the device is not opened and
the system goes to sleep, the device is kept in runtime active state
after resume and thus prevents the UART from runtime suspending until
the device is opened?

Another thing that I find utterly confusing:  We set up the sleep
parameters on ->setup if and only if the device has an IRQ.
The sleep parameters influence how the wake pin is used (polarity etc).
However we toggle the pin *before* setting up the sleep parameters,
namely by calling bcm_gpio_set_power() in bcm_open(), bcm_probe() and
bcm_serdev_probe().  Is that actually correct?  Shouldn't we avoid
toggling the wake pin until the sleep parameters have been set up?
Would it be conceivable that the sleep parameters are somehow botched
when the device comes out of power-on reset, such that toggling the
wake pin before setting the sleep parameters to sane values causes
the device to become unresponsive or something like that?

Thanks,

Lukas

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index eee33b0e4d67..06e2434c9b3d 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -464,7 +464,7 @@ static int bcm_close(struct hci_uart *hu)
>  		err = bcm_gpio_set_power(bdev, false);
>  		if (err)
>  			bt_dev_err(hu->hdev, "Failed to power down");
> -		else
> +		else if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0)
>  			pm_runtime_set_suspended(bdev->dev);
>  	}
>  	mutex_unlock(&bcm_device_lock);
> -- 
> 2.14.3
> 
