Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix rfkill functionality during the HCI setup stage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1378899239-5138-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Sep 2013 13:33:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <32FA1E78-97FE-42C1-9FA6-3DB0EED32BD8@holtmann.org>
References: <1378899239-5138-1-git-send-email-johan.hedberg@gmail.com> <1378899239-5138-3-git-send-email-johan.hedberg@gmail.com>
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
> index 70efa16..3ff99f2 100644
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

so explain to me how this actually works. If we add a HCI controller when RFKILL is currently blocking all radios. Which part is setting HCI_RFKILLED initially? Or does the RFKILL subsystem is calling into set_blocked by itself during registration?

Regards

Marcel

