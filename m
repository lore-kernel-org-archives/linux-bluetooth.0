Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Add SMP support to user_confirm_reply
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Nov 2011 07:26:23 +0900
In-Reply-To: <1320866027-14202-2-git-send-email-bgix@codeaurora.org>
References: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>
	 <1320866027-14202-2-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320877587.15441.352.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> to enable User Confirmation during LE-SMP pairing.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a6720c6..6c35f8d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1423,6 +1423,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  	u16 mgmt_op, hci_op;
>  	struct pending_cmd *cmd;
>  	struct hci_dev *hdev;
> +	struct hci_conn *conn;
>  	int err;
>  
>  	BT_DBG("");
> @@ -1446,20 +1447,35 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  
>  	if (!test_bit(HCI_UP, &hdev->flags)) {
>  		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
> -		goto failed;
> +		goto done;
> +	}
> +
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
> +	if (!conn) {
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
> +		if (!conn) {
> +			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
> +			goto done;
> +		}
> +
> +		/* Forward Confirm response to SMP */
> +
> +		err = cmd_status(sk, index, mgmt_op, 0);
> +		goto done;
> +
>  	}

I am a bit lost why we are trying to find an ACL_LINK here first.

Regards

Marcel


