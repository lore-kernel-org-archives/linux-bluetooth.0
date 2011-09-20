Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 06/14] Bluetooth: Create hci_cancel_inquiry()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:33:03 +0200
In-Reply-To: <1316468136-12472-7-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-7-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316521985.1937.78.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a function to hci_core to cancel an ongoing inquiry.
> 
> According to the Bluetooth spec, the inquiry cancel command should
> only be issued after the inquiry command has been issued, a command
> status event has been received for the inquiry command, and before
> the inquiry complete event occurs.
> 
> As HCI_INQUIRY flag is only set just after an inquiry command status
> event occurs and it is cleared just after an inquiry complete event
> occurs, the inquiry cancel command should be issued only if HCI_INQUIRY
> flag is set.
> 
> Additionally, cancel inquiry related code from stop_discovery() were
> replaced by a hci_cancel_inquiry() call.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   10 ++++++++++
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b7c070b..4a79a50 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -915,5 +915,6 @@ void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
>  void hci_le_ltk_neg_reply(struct hci_conn *conn);
>  
>  int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> +int hci_cancel_inquiry(struct hci_dev *hdev);
>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ebfd963..f62b465 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2422,3 +2422,13 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
>  
>  	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
>  }
> +
> +int hci_cancel_inquiry(struct hci_dev *hdev)
> +{
> +	BT_DBG("%s", hdev->name);
> +
> +	if (!test_bit(HCI_INQUIRY, &hdev->flags))
> +		return -EPERM;
> +
> +	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> +}
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 4f77468..d84f242 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1674,7 +1674,7 @@ static int stop_discovery(struct sock *sk, u16 index)
>  		goto failed;
>  	}
>  
> -	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> +	err = hci_cancel_inquiry(hdev);
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);
>  

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


