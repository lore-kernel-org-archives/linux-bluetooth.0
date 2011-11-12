Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/5] Bluetooth: Add SMP support to user_confirm_reply
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 12 Nov 2011 15:52:56 +0900
In-Reply-To: <1321057441-7921-2-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
	 <1321057441-7921-2-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321080780.15441.425.camel@aeonflux>
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
> index 5562c21..129424e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1445,6 +1445,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  	u16 mgmt_op, hci_op;
>  	struct pending_cmd *cmd;
>  	struct hci_dev *hdev;
> +	struct hci_conn *conn;
>  	int err;
>  
>  	BT_DBG("");
> @@ -1468,20 +1469,35 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  
>  	if (!test_bit(HCI_UP, &hdev->flags)) {
>  		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
> -		goto failed;
> +		goto done;
> +	}
> +
> +	/* Route command to HCI (if ACL Link) or SMP (if LE Link) */

actually this is only have of what you are doing here. So something like
this would be better (feel free to make it sounds nicer):

	/*
	 * Check for an existing ACL link, if present use paring via
	 * HCI commands.
	 *
	 * If no ACL link is present, check for an LE link and if
	 * present, forward pairing handling to SMP engine.
	 *
	 * If neither ACL nor LE links are present, fail with error.
	 */

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
>  	}
>  

	/* Continue with pairing via HCI */

>  	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
>  	if (!cmd) {
>  		err = -ENOMEM;
> -		goto failed;
> +		goto done;
>  	}

Since I stumbled over the logic already twice and had to twist my brain
to ensure that it is correct, a comment is really needed.

Regards

Marcel


