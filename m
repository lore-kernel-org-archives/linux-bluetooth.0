Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: fix Realtek suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432218230-11370-1-git-send-email-drake@endlessm.com>
Date: Thu, 21 May 2015 22:04:09 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Carlo Caione <carlo@endlessm.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	champion_chen@realsil.com.cn
Message-Id: <121114DC-BCD3-40ED-B0C2-961A41305937@holtmann.org>
References: <1432218230-11370-1-git-send-email-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Realtek btusb devices don't currently work after suspend/resume because
> the updated firmware is quietly lost - the USB hub doesn't notice any
> status change upon resume, but some kind of reset has definitely
> happened as the LMP subversion has reverted to its original value.
> 
> Set the reset_resume flag to trigger probe and upload the new firmware
> again.
> 
> Like the vendor code, I assume this is not needed when the device is
> selected as a wakeup source and hence will retain power during suspend.
> On the 2 products I have to hand, when trying this configuration the
> hardware seems unable to keep the device powered up during suspend.
> The USB hub then detects a status change on resume and does a reset,
> so we do not end up in broken state.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> drivers/bluetooth/btusb.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b9f2821..9c42cb5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -328,6 +328,7 @@ static const struct usb_device_id blacklist_table[] = {
> #define BTUSB_FIRMWARE_LOADED	7
> #define BTUSB_FIRMWARE_FAILED	8
> #define BTUSB_BOOTING		9
> +#define BTUSB_RESET_RESUME	10
> 
> struct btusb_data {
> 	struct hci_dev       *hdev;
> @@ -2766,8 +2767,15 @@ static int btusb_probe(struct usb_interface *intf,
> 	}
> 
> #ifdef CONFIG_BT_HCIBTUSB_RTL
> -	if (id->driver_info & BTUSB_REALTEK)
> +	if (id->driver_info & BTUSB_REALTEK) {
> 		hdev->setup = btrtl_setup_realtek;
> +
> +		/* Realtek devices lose their updated firmware over suspend,
> +		 * but the USB hub doesn't notice any status change.
> +		 * Explicitly request a device reset on resume.
> +		 */
> +		set_bit(BTUSB_RESET_RESUME, &data->flags);
> +	}
> #endif
> 
> 	if (id->driver_info & BTUSB_AMP) {
> @@ -2900,6 +2908,14 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> 	btusb_stop_traffic(data);
> 	usb_kill_anchored_urbs(&data->tx_anchor);
> 
> +	/* Optionally request a device reset on resume, but only when
> +	 * wakeups are disabled. If wakeups are enabled we assume the
> +	 * device will stay powered up throughout suspend.
> +	 */
> +	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
> +	    !device_may_wakeup(&data->udev->dev))
> +		data->udev->reset_resume = 1;
> +
> 	return 0;

with all the discussion happening about request_firmware and resuming without have the userspace ready, this patch seems incomplete. If we just reset and run through probe() again, we will be causing the same problem. Unless the firmware is actually cached in this case.

Maybe implemented reset_resume callback support here is actually something we do need. Not sure how this will look like, but maybe it is enough to just signal the Bluetooth core that the setup routine needs to be executed again.

Running through disconnect() and probe() means that the hci_dev goes away and comes back. Is that something we really want or would just reloading the firmware be enough. It might be well that we finally need to do more in hci_suspend_dev and hci_resume_dev than we are doing right now.

Regards

Marcel

