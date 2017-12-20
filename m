Return-Path: <briannorris@chromium.org>
Date: Wed, 20 Dec 2017 10:53:09 -0800
From: Brian Norris <briannorris@chromium.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, marcel@holtmann.org,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Daniel Drake <drake@endlessm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] Revert "Bluetooth: btusb: fix QCA Rome
 suspend/resume"
Message-ID: <20171220185308.GA176644@google.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220110008.11856-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 20, 2017 at 07:00:07PM +0800, Kai-Heng Feng wrote:
> This reverts commit fd865802c66bc451dc515ed89360f84376ce1a56.
> 
> This commit causes a regression on some QCA ROME chips. The USB device
> reset happens in btusb_open(), hence firmware loading gets interrupted.

Oh, did you really confirm that's the root of the problem? I was only
hypothesizing, with some informed observation and code review; but I
didn't fully convince myself. If so, that's interesting.

> Furthermore, this commit stops working after commit
> ("a0085f2510e8976614ad8f766b209448b385492f Bluetooth: btusb: driver to
> enable the usb-wakeup feature"). Reset-resume quirk only gets enabled in
> btusb_suspend() when it's not a wakeup source.
> 
> If we really want to reset the USB device, we need to do it before
> btusb_open(). Let's handle it in drivers/usb/core/quirks.c.
> 
> Cc: stable@vger.kernel.org
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Looks good to me. Definitely a regression and we need to clear that up
in mainline and stable before reintroducing the intended fix:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Thanks!

> ---
> 
> Daniel, Cc you because this also affects your original quirk patch for
> Realtek btusb.
> 
>  drivers/bluetooth/btusb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f7120c9eb9bd..da353c4acdc7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3117,12 +3117,6 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (id->driver_info & BTUSB_QCA_ROME) {
>  		data->setup_on_usb = btusb_setup_qca;
>  		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> -
> -		/* QCA Rome devices lose their updated firmware over suspend,
> -		 * but the USB hub doesn't notice any status change.
> -		 * Explicitly request a device reset on resume.
> -		 */
> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
>  	}
>  
>  #ifdef CONFIG_BT_HCIBTUSB_RTL
> -- 
> 2.14.1
> 
