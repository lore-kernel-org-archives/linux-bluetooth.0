Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix rfkill functionality during the HCI setup stage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1378978153-5683-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Sep 2013 09:18:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FE488305-3048-4515-96D7-ADBFE077ED5D@holtmann.org>
References: <1378978153-5683-1-git-send-email-johan.hedberg@gmail.com> <1378978153-5683-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to let the setup stage complete cleanly even when the HCI device
> is rfkilled. Otherwise the HCI device will stay in an undefined state
> and never get notified to user space through mgmt (even when it gets
> unblocked through rfkill).
> 
> This patch makes sure that hci_dev_open() can be called in the HCI_SETUP
> stage, that blocking the device doesn't abort the setup stage, and that
> the device gets proper powered down as soon as the setup stage completes
> in case it was blocked meanwhile.
> 
> The bug that this patch fixed can be very easily reproduced using e.g.
> the rfkill command line too. By running "rfkill block all" before
> inserting a Bluetooth dongle the resulting HCI device goes into a state
> where it is never announced over mgmt, not even when "rfkill unblock all"
> is run.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
> net/bluetooth/hci_core.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d0d6cf8..433820a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1148,7 +1148,11 @@ int hci_dev_open(__u16 dev)
> 		goto done;
> 	}
> 
> -	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
> +	/* Check for rfkill but allow the HCI setup stage to proceed
> +	 * (which in itself doesn't cause any RF activity).
> +	 */
> +	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) &&
> +	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
> 		ret = -ERFKILL;
> 		goto done;
> 	}
> @@ -1599,7 +1603,8 @@ static int hci_rfkill_set_block(void *data, bool blocked)
> 
> 	if (blocked) {
> 		set_bit(HCI_RFKILLED, &hdev->dev_flags);
> -		hci_dev_do_close(hdev);
> +		if (!test_bit(HCI_SETUP, &hdev->dev_flags))
> +			hci_dev_do_close(hdev);
> 	} else {
> 		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
> 	}
> @@ -1624,6 +1629,11 @@ static void hci_power_on(struct work_struct *work)
> 		return;
> 	}
> 
> +	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
> +		clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
> +		hci_dev_do_close(hdev);
> +	}
> +

this might be better extend with

	} else if (test_bit(HCI_AUTO_OFF, ...)

> 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
> 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
> 				   HCI_AUTO_OFF_TIMEOUT);

Makes the code a little bit more readable for the reason that I want to add a return from the function to the HCI_RFKILLED check every time I read it, but that would be actually wrong.

Regards

Marcel

