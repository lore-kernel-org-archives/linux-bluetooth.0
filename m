Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:32:52 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 4/9] Bluetooth: Add User Passkey Response handling
Message-ID: <20111121153252.GA2552@joana>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
 <1321480400-17397-5-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321480400-17397-5-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-16 13:53:15 -0800]:

> For some MITM protection pairing scenarios, the user is
> required to enter or accept a 6 digit passkey.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 73 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c06a05c..7a23f21 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1618,7 +1618,15 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
>  	}
>  
>  	/* Continue with pairing via HCI */
> -	err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
> +	if (hci_op == HCI_OP_USER_PASSKEY_REPLY) {
> +		struct hci_cp_user_passkey_reply cp;
> +
> +		bacpy(&cp.bdaddr, bdaddr);
> +		cp.passkey = passkey;
> +		err = hci_send_cmd(hdev, hci_op, sizeof(cp), &cp);
> +	} else
> +		err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
> +
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);
>  
> @@ -1660,6 +1668,37 @@ static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
>  			HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
>  }
>  
> +static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
> +{
> +	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
> +									EINVAL);
> +
> +	return user_pairing_resp(sk, index, &cp->bdaddr,
> +			MGMT_OP_USER_PASSKEY_REPLY,
> +			HCI_OP_USER_PASSKEY_REPLY, cp->passkey);
> +}
> +
> +static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
> +									u16 len)
> +{
> +	struct mgmt_cp_user_passkey_neg_reply *cp = (void *) data;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +									EINVAL);
> +
> +	return user_pairing_resp(sk, index, &cp->bdaddr,
> +			MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +			HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
> +}
> +
>  static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
>  								u16 len)
>  {
> @@ -2117,6 +2156,13 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  		err = user_confirm_neg_reply(sk, index, buf + sizeof(*hdr),
>  									len);
>  		break;
> +	case MGMT_OP_USER_PASSKEY_REPLY:
> +		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len);
> +		break;
> +	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
> +		err = user_passkey_neg_reply(sk, index, buf + sizeof(*hdr),
> +									len);
> +		break;
>  	case MGMT_OP_SET_LOCAL_NAME:
>  		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
>  		break;
> @@ -2477,6 +2523,18 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  									NULL);
>  }
>  
> +int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct mgmt_ev_user_passkey_request ev;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	bacpy(&ev.bdaddr, bdaddr);
> +
> +	return mgmt_event(MGMT_EV_USER_PASSKEY_REQUEST, hdev, &ev, sizeof(ev),
> +									NULL);
> +}
> +
>  static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  							u8 status, u8 opcode)
>  {
> @@ -2511,6 +2569,20 @@ int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
>  					MGMT_OP_USER_CONFIRM_NEG_REPLY);
>  }
>  
> +int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								u8 status)
> +{
> +	return user_pairing_resp_complete(hdev, bdaddr, status,
> +						MGMT_OP_USER_PASSKEY_REPLY);
> +}
> +
> +int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
> +						bdaddr_t *bdaddr, u8 status)
> +{
> +	return user_pairing_resp_complete(hdev, bdaddr, status,
> +					MGMT_OP_USER_PASSKEY_NEG_REPLY);
> +}
> +

You have to export these functions in hci_core.h right here in this commit.

	Gustavo
