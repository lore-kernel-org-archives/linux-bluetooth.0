Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v4 07/26] Bluetooth: Add a define for the HCI persistent flags mask
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363198337-3896-8-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 15 Mar 2013 13:23:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <035D9C11-5F66-4584-AB2C-86DA558E2A2E@holtmann.org>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com> <1363198337-3896-8-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We'll need to use this mask also when powering off the HCI device
> so it's better to have this in a single and visible place.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |    5 +++++
> net/bluetooth/hci_event.c   |    2 +-
> 2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1e723c7..a09d5e9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -122,6 +122,11 @@ enum {
> 	HCI_PERIODIC_INQ,
> };
> 
> +/* A mask for the flags that are supposed to remain when a reset happens
> + * or the HCI device is closed.
> + */
> +#define HCI_PERSISTENT_MASK ~(BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ))
> +

didn't we agree and getting this fixed and moving the ~ to the actual call.

> /* HCI ioctl defines */
> #define HCIDEVUP	_IOW('H', 201, int)
> #define HCIDEVDOWN	_IOW('H', 202, int)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5f2d008..ec24d9a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -194,7 +194,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
> 	clear_bit(HCI_RESET, &hdev->flags);
> 
> 	/* Reset all non-persistent flags */
> -	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ));
> +	hdev->dev_flags &= HCI_PERSISTENT_MASK;

So this should be &= ~HCI_PERSISTENT_MASK

Regards

Marcel

