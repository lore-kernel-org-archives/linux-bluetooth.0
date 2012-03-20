Return-Path: <cyrus@holtmann.org>
Message-ID: <1332258822.1870.17.camel@aeonflux>
Subject: Re: [RFC 2/4] Bluetooth: Add HCI_PINQUIRY to dev_flags
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Tue, 20 Mar 2012 08:53:42 -0700
In-Reply-To: <1332210772-13806-3-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
	 <1332210772-13806-3-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the HCI_PINQUIRY flag to dev_flags. This flag tracks
> if periodic inquiry is enabled or not.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_event.c   |   10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index d74645e..b3e89bf 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -102,6 +102,7 @@ enum {
>  	HCI_DISCOVERABLE,
>  	HCI_LINK_SECURITY,
>  	HCI_PENDING_CLASS,
> +	HCI_PINQUIRY,

call this HCI_PERIODIC_INQ. Since PINQUIRY is horrible to distinguish
from INQUIRY.

>  };
>  
>  /* HCI ioctl defines */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index af0c5a2..4d13843 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -75,6 +75,11 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
>  	__u8 status = *((__u8 *) skb->data);
>  
>  	BT_DBG("%s status 0x%x", hdev->name, status);
> +
> +	if (status)
> +		return;
> +
> +	set_bit(HCI_PINQUIRY, &hdev->dev_flags);
>  }
>  
>  static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -86,6 +91,8 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
>  	if (status)
>  		return;
>  
> +	clear_bit(HCI_PINQUIRY, &hdev->dev_flags);
> +
>  	hci_conn_check_pending(hdev);
>  }
>  
> @@ -200,7 +207,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
>  	hci_req_complete(hdev, HCI_OP_RESET, status);
>  
>  	/* Reset all non-persistent flags */
> -	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS));
> +	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
> +							BIT(HCI_PINQUIRY));

And as homework for another patch, we should have a simple mask define
for persistent or non-persistent flags that is defined right next to the
enum. This will otherwise get out of control.

>  
>  	hdev->discovery.state = DISCOVERY_STOPPED;
>  }

Other than the flag name change, this looks fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


