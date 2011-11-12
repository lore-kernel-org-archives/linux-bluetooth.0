Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/5] Bluetooth: Add MGMT opcode for User Passkey entry
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 12 Nov 2011 15:57:32 +0900
In-Reply-To: <1321057441-7921-3-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
	 <1321057441-7921-3-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321081055.15441.428.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  include/net/bluetooth/hci.h  |    8 +++
>  include/net/bluetooth/mgmt.h |   11 +++
>  net/bluetooth/mgmt.c         |  143 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 139ce2a..ac107b5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -453,6 +453,14 @@ struct hci_rp_user_confirm_reply {
>  
>  #define HCI_OP_USER_CONFIRM_NEG_REPLY	0x042d
>  
> +#define HCI_OP_USER_PASSKEY_REPLY		0x042e
> +struct hci_cp_user_passkey_reply {
> +	bdaddr_t bdaddr;
> +	__u32	passkey;
> +} __packed;
> +
> +#define HCI_OP_USER_PASSKEY_NEG_REPLY	0x042f
> +
>  #define HCI_OP_REMOTE_OOB_DATA_REPLY	0x0430
>  struct hci_cp_remote_oob_data_reply {
>  	bdaddr_t bdaddr;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 8b07a83..190a9f5 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -233,6 +233,17 @@ struct mgmt_cp_set_fast_connectable {
>  	__u8 enable;
>  } __packed;
>  
> +#define MGMT_OP_USER_PASSKEY_REPLY	0x0020
> +struct mgmt_cp_user_passkey_reply {
> +	bdaddr_t bdaddr;
> +	__le32 passkey;
> +} __packed;
> +
> +#define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x0021
> +struct mgmt_cp_user_passkey_neg_reply {
> +	bdaddr_t bdaddr;
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16 opcode;

please split this part into a separate and then it is fine with me. Feel
free to add the ACK right away.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 129424e..f0f2ae2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1504,6 +1504,128 @@ done:
>  	return err;
>  }
>  
> +static int user_passkey_reply(struct sock *sk, u16 index, unsigned char *data,
> +									u16 len)
> +{
> +	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
> +	struct pending_cmd *cmd;
> +	struct hci_dev *hdev;
> +	struct hci_conn *conn;
> +	int err = 0;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
> +									EINVAL);
> +
> +	hdev = hci_dev_get(index);
> +	if (!hdev)
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
> +									ENODEV);
> +
> +	hci_dev_lock_bh(hdev);
> +
> +	if (!test_bit(HCI_UP, &hdev->flags)) {
> +		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
> +								ENETDOWN);
> +		goto done;
> +	}
> +
> +	/* Route command to HCI (if ACL Link) or SMP (if LE Link) */
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
> +	if (!conn) {
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
> +		if (!conn) {
> +			err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
> +								ENOTCONN);
> +			goto done;
> +		}
> +
> +		/* Forward Passkey response to SMP */
> +
> +		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY, 0);
> +		goto done;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_USER_PASSKEY_REPLY, hdev, data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	err = hci_send_cmd(hdev, HCI_OP_USER_PASSKEY_REPLY, len, cp);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +done:
> +	hci_dev_unlock_bh(hdev);
> +	hci_dev_put(hdev);
> +
> +	return err;
> +}
> +
> +static int user_passkey_neg_reply(struct sock *sk, u16 index,
> +						unsigned char *data, u16 len)
> +{
> +	struct mgmt_cp_user_passkey_neg_reply *cp = (void *) data;
> +	struct pending_cmd *cmd;
> +	struct hci_dev *hdev;
> +	struct hci_conn *conn;
> +	int err = 0;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +									EINVAL);
> +
> +	hdev = hci_dev_get(index);
> +	if (!hdev)
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +									ENODEV);
> +
> +	hci_dev_lock_bh(hdev);
> +
> +	if (!test_bit(HCI_UP, &hdev->flags)) {
> +		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +								ENETDOWN);
> +		goto done;
> +	}
> +
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
> +	if (!conn) {
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
> +		if (!conn) {
> +			err = cmd_status(sk, index,
> +					MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +					ENOTCONN);
> +			goto done;
> +		}
> +
> +		/* Forward Passkey response to SMP */
> +
> +		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY, 0);
> +		goto done;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_USER_PASSKEY_NEG_REPLY, hdev, data,
> +									len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	err = hci_send_cmd(hdev, HCI_OP_USER_PASSKEY_NEG_REPLY, len, cp);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +done:
> +	hci_dev_unlock_bh(hdev);
> +	hci_dev_put(hdev);
> +
> +	return err;
> +}

Actually passkey, passkey-neg, confirm, neg-confirm contain a lot of the
same code just with a different parameter. I can be all generalized into
a helper function. Only the initial parsing of the HCI command needs to
be different. So please clean this up.

Once we a nice common helper, the extra comments and also looking
becomes central in one single place. Way nicer.

Regards

Marcel


