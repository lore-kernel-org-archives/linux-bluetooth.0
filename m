Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Add support for setting the local name
Date: Wed, 16 Mar 2011 11:09:07 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1300215293-30294-1-git-send-email-johan.hedberg@gmail.com> <1300215293-30294-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1300215293-30294-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103161109.08062.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds a new set_local_name management command as well as a
> local_name_changed management event. With these user space can both
> change the local name as well as monitor changes to it by others.
> 
> The management messages reserve 249 bytes for the name instead of 248
> (like in the HCI spec) so that there is always a guarantee that it is
> nul-terminated. That way it can safely be passed onto string
> manipulation functions.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/mgmt.h     |   10 +++++
>  net/bluetooth/hci_event.c        |    9 +++-
>  net/bluetooth/mgmt.c             |   76 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 441dadb..c77c082 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -767,6 +767,7 @@ int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
>  int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
>  								u8 status);
>  int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
> +int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
>  
>  /* HCI info for socket */
>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 4deeea1..f7d4df3 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -168,6 +168,11 @@ struct mgmt_rp_user_confirm_reply {
>  
>  #define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x0016
>  
> +#define MGMT_OP_SET_LOCAL_NAME		0x0017
> +struct mgmt_cp_set_local_name {
> +	__u8 name[249];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16 opcode;
> @@ -235,3 +240,8 @@ struct mgmt_ev_auth_failed {
>  	bdaddr_t bdaddr;
>  	__u8 status;
>  } __packed;
> +
> +#define MGMT_EV_LOCAL_NAME_CHANGED	0x0011
> +struct mgmt_ev_local_name_changed {
> +	__u8 name[249];
> +} __packed;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3fbfa50..e7f7cb0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -193,13 +193,16 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	BT_DBG("%s status 0x%x", hdev->name, status);
>  
> -	if (status)
> -		return;
> -
>  	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LOCAL_NAME);
>  	if (!sent)
>  		return;
>  
> +	if (test_bit(HCI_MGMT, &hdev->flags))
> +		mgmt_set_local_name_complete(hdev->id, sent, status);
> +
> +	if (status)
> +		return;
> +
>  	memcpy(hdev->dev_name, sent, 248);
>  }
>  
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 67529c8..6e84ab2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1258,6 +1258,46 @@ failed:
>  	return err;
>  }
>  
> +static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
> +								u16 len)

Can fit 1 more tab :)

> +{
> +	struct mgmt_cp_set_local_name *mgmt_cp = (void *) data;
> +	struct hci_cp_write_local_name hci_cp;
> +	struct hci_dev *hdev;
> +	struct pending_cmd *cmd;
> +	int err;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*mgmt_cp))
> +		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, EINVAL);
> +
> +	hdev = hci_dev_get(index);
> +	if (!hdev)
> +		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, ENODEV);
> +
> +

Not needed empty line.

> +	hci_dev_lock_bh(hdev);
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, index, data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	memcpy(hci_cp.name, mgmt_cp->name, sizeof(hci_cp.name));
> +	err = hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(hci_cp),
> +								&hci_cp);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +failed:
> +	hci_dev_unlock_bh(hdev);
> +	hci_dev_put(hdev);
> +
> +	return err;
> +}
> +
>  int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  {
>  	unsigned char *buf;
> @@ -1353,6 +1393,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
>  		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
>  		break;
> +	case MGMT_OP_SET_LOCAL_NAME:
> +		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
> +		break;
>  	default:
>  		BT_DBG("Unknown op %u", opcode);
>  		err = cmd_status(sk, index, opcode, 0x01);
> @@ -1649,3 +1692,36 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
>  
>  	return mgmt_event(MGMT_EV_AUTH_FAILED, index, &ev, sizeof(ev), NULL);
>  }
> +
> +int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +	struct mgmt_cp_set_local_name ev;
> +	int err;
> +
> +	memset(&ev, 0, sizeof(ev));
> +	memcpy(ev.name, name, 248);
> +
> +	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, index);
> +	if (!cmd)
> +		goto send_event;
> +
> +	if (status) {
> +		err = cmd_status(cmd->sk, index, MGMT_OP_SET_LOCAL_NAME, EIO);
> +		goto failed;
> +	}
> +
> +	err = cmd_complete(cmd->sk, index, MGMT_OP_SET_LOCAL_NAME, &ev,
> +								sizeof(ev));
> +	if (err < 0)
> +		goto failed;
> +
> +send_event:
> +	err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, index, &ev, sizeof(ev),
> +							cmd ? cmd->sk : NULL);
> +
> +failed:
> +	if (cmd)
> +		mgmt_pending_remove(cmd);
> +	return -err;

err is already < 0 here.

> +}
> 

And I agree with Anderson Lizardo about 248-249 case.
We should have define for spec name length and use 
__u8 name[HCIDEV_NAME_LEN + 1] and comment (at least in docs) why
and that it is guaranteed to be null terminated.

Would also be good to get rid of magic numbers from code (but this is
more generic issue:)

-- 
Szymon Janc

