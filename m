Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v2 03/10] Bluetooth: hci_bcm: Enable runtime PM despite
 absence of IRQ
To: Lukas Wunner <lukas@wunner.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Frederic Danis <frederic.danis.oss@gmail.com>,
 Loic Poulain <loic.poulain@linaro.org>, Max Shavrick <mxms@me.com>,
 Leif Liddy <leif.liddy@gmail.com>,
 Daniel Roschka <danielroschka@phoenitydawn.de>,
 Ronald Tschalaer <ronald@innovation.ch>,
 "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
References: <cover.1514916630.git.lukas@wunner.de>
 <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
Date: Tue, 2 Jan 2018 20:17:24 +0100
MIME-Version: 1.0
In-Reply-To: <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 02-01-18 20:08, Lukas Wunner wrote:
> Currently runtime PM is only enabled if a valid host wake IRQ was found.
> 
> However it is used in ways which seem unrelated to host wake:
> E.g., runtime PM is used to force the Bluetooth device on for 5 sec
> after a complete packet has been received.
> 
> Afford this functionality to devices which lack an IRQ by moving the
> code to enable runtime PM from bcm_request_irq() to bcm_setup().
> 

Hmm, this seems to not make much sense. If runtime_pm is not enabled
(no host wake irq) then the device never runtime suspends, so there
is no need to force the device on when we're sending / after a
complete packet has been received.

That you give "after a complete packet has been received" as condition
example illustrates nicely why I believe this commit is a bad idea,
if say a bluetooth keyboard wants to send a keypress HID report after
the runtime pm timeout has elapsed, how are we going to receive that
report since we're runtime suspended and there is no host wake irq
to tell us to wakeup the UART and enable receiving on it again?

I don't see how runtime pm can work without a host-wake IRQ,
so IMHO this commit is wrong. Tip when testing this, make sure
that you don't have the bluetooth config panel of e.g. gnome3
open as that continuously scans for new devices, so runtime pm
never kicks in. I've had a bad configured host IRQ pin on some
ASUS laptops using serdev bcm bt and the only way a bt keyboard
would work reliable was to keep the config panel open...

Regards,

Hans




> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de > ---
>   drivers/bluetooth/hci_bcm.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 4294d9df1d4d..d9ca27d3209a 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -221,12 +221,6 @@ static int bcm_request_irq(struct bcm_data *bcm)
>   
>   	device_init_wakeup(bdev->dev, true);
>   
> -	pm_runtime_set_autosuspend_delay(bdev->dev,
> -					 BCM_AUTOSUSPEND_DELAY);
> -	pm_runtime_use_autosuspend(bdev->dev);
> -	pm_runtime_set_active(bdev->dev);
> -	pm_runtime_enable(bdev->dev);
> -
>   unlock:
>   	mutex_unlock(&bcm_device_lock);
>   
> @@ -468,6 +462,11 @@ static int bcm_setup(struct hci_uart *hu)
>   	if (!bcm_request_irq(bcm))
>   		err = bcm_setup_sleep(hu);
>   
> +	pm_runtime_set_autosuspend_delay(bcm->dev->dev, BCM_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(bcm->dev->dev);
> +	pm_runtime_set_active(bcm->dev->dev);
> +	pm_runtime_enable(bcm->dev->dev);
> +
>   	return err;
>   }
>   
> 
