Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 17:21:28 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/16] Bluetooth: Periodic Inquiry and mgmt discovering
 event
Message-ID: <20110713202128.GD23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
 <1310418719-12296-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310418719-12296-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2011-07-11 18:11:44 -0300]:

> By using periodic inquiry command we're not able to detect correctly
> when the controller has started inquiry.
> 
> Today we have this workaround in inquiry result event handler to set
> the HCI_INQUIRY flag when it sees the first inquiry result event.
> This workaround isn't enough because the device may be performing
> an inquiry but the HCI_INQUIRY flag is not set. For instance, if
> there is no device in range, no inquiry result event is generated,
> consequently, the HCI_INQUIRY flags isn't set when it should so.
> 
> We rely on HCI_INQUIRY flag to implement the discovery procedure
> properly. So, as we aren't able to clear/set the HCI_INQUIRY flag in
> a reliable manner, periodic inquiry events shouldn't change the
> HCI_INQUIRY flag. In future, if needed, we might add a new flag (e.g.
> HCI_PINQUIRY) to know if the controller is performing periodic
> inquiry.
> 
> Thus, due to that issue and in order to keep compatibility with
> userspace, periodic inquiry events shouldn't send mgmt discovering
> events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   46 ++++++++++++--------------------------------
>  1 files changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a40170e..cf0efe5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -58,13 +58,13 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
>  	if (status)
>  		return;
>  
> -	if (test_bit(HCI_MGMT, &hdev->flags) &&
> -				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> -		mgmt_discovering(hdev->id, 0);
> +	clear_bit(HCI_INQUIRY, &hdev->flags);
>  
>  	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
>  
>  	hci_conn_check_pending(hdev);
> +
> +	mgmt_discovering(hdev->id, 0);
>  }
>  
>  static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -76,10 +76,6 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
>  	if (status)
>  		return;
>  
> -	if (test_bit(HCI_MGMT, &hdev->flags) &&
> -				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> -		mgmt_discovering(hdev->id, 0);
> -
>  	hci_conn_check_pending(hdev);
>  }
>  
> @@ -959,10 +955,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>  		return;
>  	}
>  
> -	if (test_bit(HCI_MGMT, &hdev->flags) &&
> -					!test_and_set_bit(HCI_INQUIRY,
> -							&hdev->flags))
> -		mgmt_discovering(hdev->id, 1);
> +	set_bit(HCI_INQUIRY, &hdev->flags);
> +
> +	mgmt_discovering(hdev->id, 1);
>  }
>  
>  static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
> @@ -1340,13 +1335,16 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
>  
>  	BT_DBG("%s status %d", hdev->name, status);
>  
> -	if (test_bit(HCI_MGMT, &hdev->flags) &&
> -				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> -		mgmt_discovering(hdev->id, 0);
> +	hci_conn_check_pending(hdev);
> +
> +	if (!test_bit(HCI_INQUIRY, &hdev->flags))
> +		return;
> +
> +	clear_bit(HCI_INQUIRY, &hdev->flags);

this can be test_and_clear_bit

	Gustavo
