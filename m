Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 16:49:03 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/9] Bluetooth: User Pairing Response restructuring
Message-ID: <20111116184903.GI16865@joana>
References: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
 <1321164079-2216-4-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321164079-2216-4-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-12 22:01:13 -0800]:

> There are 4 possible User Responses to pairing requests,
> and they all share the same checks and handling. This
> restructures the handling of the two Confirm responses
> in preperation for the second two.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |   96 ++++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 69 insertions(+), 27 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5562c21..b1d4f05 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1438,28 +1438,14 @@ unlock:
>  	return err;
>  }
>  
> -static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
> -							u16 len, int success)
> +static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
> +					u16 mgmt_op, u16 hci_op, __le32 passkey)
>  {
> -	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
> -	u16 mgmt_op, hci_op;
>  	struct pending_cmd *cmd;
>  	struct hci_dev *hdev;
> +	struct hci_conn *conn;
>  	int err;
>  
> -	BT_DBG("");
> -
> -	if (success) {
> -		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
> -		hci_op = HCI_OP_USER_CONFIRM_REPLY;
> -	} else {
> -		mgmt_op = MGMT_OP_USER_CONFIRM_NEG_REPLY;
> -		hci_op = HCI_OP_USER_CONFIRM_NEG_REPLY;
> -	}
> -
> -	if (len != sizeof(*cp))
> -		return cmd_status(sk, index, mgmt_op, EINVAL);
> -
>  	hdev = hci_dev_get(index);
>  	if (!hdev)
>  		return cmd_status(sk, index, mgmt_op, ENODEV);
> @@ -1468,26 +1454,81 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  
>  	if (!test_bit(HCI_UP, &hdev->flags)) {
>  		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
> -		goto failed;
> +		goto done;
>  	}
>  
> -	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
> +	/*
> +	 * Check for an existing ACL link, if present pair via
> +	 * HCI commands.
> +	 *
> +	 * If no ACL link is present, check for an LE link and if
> +	 * present, pair via the SMP engine.
> +	 *
> +	 * If neither ACL nor LE links are present, fail with error.
> +	 */
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> +	if (!conn) {
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
> +		if (!conn) {
> +			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
> +			goto done;
> +		}
> +
> +		/* Continue with pairing via SMP */
> +
> +		err = cmd_status(sk, index, mgmt_op, 0);
> +		goto done;
> +	}
> +

Please split this patch in two, one the does the user_pairing_resp
restructuring and the other that actually add new code.

	Gustavo
