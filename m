Return-Path: <cyrus@holtmann.org>
Message-ID: <50A36DD1.1080507@invoxia.com>
Date: Wed, 14 Nov 2012 11:09:21 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com> <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

First thank you for this RFC. Defer (or something similar) is a must 
have for mSBC vs CVSD connection accept from multiple device management, 
at least for HFP case.
some comments / ideas:
- can't we take the opportunity to configure the whole set of eSCO 
parameters (bandwith / latency / retransmission effort) instead of only 
getting the possibility to change the voice settings
- can we introduce a better way to change the voice settings, instead of 
modifying the adapter config (hdev->voice_setting)
- any possibility to reject the eSCO creating (for 'connection rejected 
due to limited resources' reason)

I will try to find some time to try your patch.

regards,
arnaud



On 11/13/2012 07:20 PM, Frédéric Dalleau wrote:
> In order to authenticate and later configure an incoming SCO connection, the
> BT_DEFER_SETUP option is added.
> When an connection is requested, the listening socket is unblocked but the
> effective connection setup happens only on first recv.
> Any send between accept and recv fails with -ENOTCONN.
> ---
>   include/net/bluetooth/hci_core.h |   15 +++++++
>   net/bluetooth/hci_event.c        |   47 +++++++++++++++++++-
>   net/bluetooth/sco.c              |   88 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 145 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ef5b85d..2ee0ecb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -377,6 +377,7 @@ extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
>   			      u16 flags);
>   
>   extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +extern int sco_defer(struct hci_dev *hdev, bdaddr_t *bdaddr);
>   extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
>   extern void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
>   extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
> @@ -577,6 +578,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
>   int hci_conn_del(struct hci_conn *conn);
>   void hci_conn_hash_flush(struct hci_dev *hdev);
>   void hci_conn_check_pending(struct hci_dev *hdev);
> +void hci_conn_accept(struct hci_conn *conn, int mask);
>   
>   struct hci_chan *hci_chan_create(struct hci_conn *conn);
>   void hci_chan_del(struct hci_chan *chan);
> @@ -796,6 +798,19 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>   	}
>   }
>   
> +static inline int hci_proto_defered(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								__u8 type)
> +{
> +	switch (type) {
> +	case SCO_LINK:
> +	case ESCO_LINK:
> +		return sco_defer(hdev, bdaddr);
> +
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
>   {
>   	switch (conn->type) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9f5c5f2..167eca0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2047,15 +2047,54 @@ unlock:
>   	hci_conn_check_pending(hdev);
>   }
>   
> +void hci_conn_accept(struct hci_conn *conn, int mask)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	BT_DBG("conn %p", conn);
> +
> +	if (!lmp_esco_capable(hdev)) {
> +		struct hci_cp_accept_conn_req cp;
> +
> +		conn->state = BT_CONNECT;
> +		bacpy(&cp.bdaddr, &conn->dst);
> +
> +		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
> +			cp.role = 0x00; /* Become master */
> +		else
> +			cp.role = 0x01; /* Remain slave */
> +
> +		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp),
> +			     &cp);
> +	} else /* lmp_esco_capable(hdev)) */ {
> +		struct hci_cp_accept_sync_conn_req cp;
> +
> +		conn->state = BT_CONNECT;
> +		bacpy(&cp.bdaddr, &conn->dst);
> +		cp.pkt_type = cpu_to_le16(conn->pkt_type);
> +
> +		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> +		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> +		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +		cp.content_format = cpu_to_le16(hdev->voice_setting);
> +		cp.retrans_effort = 0xff;
> +
> +		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
> +			     sizeof(cp), &cp);
> +	}
> +}
> +
>   static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   {
>   	struct hci_ev_conn_request *ev = (void *) skb->data;
>   	int mask = hdev->link_mode;
> +	int defered;
>   
>   	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
>   	       ev->link_type);
>   
>   	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
> +	defered = hci_proto_defered(hdev, &ev->bdaddr, ev->link_type);
>   
>   	if ((mask & HCI_LM_ACCEPT) &&
>   	    !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
> @@ -2085,7 +2124,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   
>   		hci_dev_unlock(hdev);
>   
> -		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev)) {
> +		if (ev->link_type == ACL_LINK ||
> +				(!defered && !lmp_esco_capable(hdev))) {
>   			struct hci_cp_accept_conn_req cp;
>   
>   			bacpy(&cp.bdaddr, &ev->bdaddr);
> @@ -2097,7 +2137,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   
>   			hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp),
>   				     &cp);
> -		} else {
> +		} else if (!defered) {
>   			struct hci_cp_accept_sync_conn_req cp;
>   
>   			bacpy(&cp.bdaddr, &ev->bdaddr);
> @@ -2111,6 +2151,9 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   
>   			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
>   				     sizeof(cp), &cp);
> +		} else {
> +			hci_proto_connect_cfm(conn, 0);
> +			hci_conn_put(conn);
>   		}
>   	} else {
>   		/* Connection rejected */
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 450cdcd..416801a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -662,16 +662,57 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>   	return err;
>   }
>   
> +static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> +			      struct msghdr *msg, size_t len, int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	struct sco_pinfo *pi = sco_pi(sk);
> +
> +	lock_sock(sk);
> +
> +	if (sk->sk_state == BT_CONNECT &&
> +			test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> +		hci_conn_accept(pi->conn->hcon, 0);
> +		sk->sk_state = BT_CONNECT2;
> +
> +		release_sock(sk);
> +		return 0;
> +	}
> +
> +	release_sock(sk);
> +
> +	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
> +}
> +
>   static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
>   {
>   	struct sock *sk = sock->sk;
>   	int err = 0;
> +	u32 opt;
>   
>   	BT_DBG("sk %p", sk);
>   
>   	lock_sock(sk);
>   
>   	switch (optname) {
> +
> +	case BT_DEFER_SETUP:
> +		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (get_user(opt, (u32 __user *) optval)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		if (opt)
> +			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> +		else
> +			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> +		break;
> +
>   	default:
>   		err = -ENOPROTOOPT;
>   		break;
> @@ -753,6 +794,19 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
>   	lock_sock(sk);
>   
>   	switch (optname) {
> +
> +	case BT_DEFER_SETUP:
> +		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
> +			     (u32 __user *) optval))
> +			err = -EFAULT;
> +
> +		break;
> +
>   	default:
>   		err = -ENOPROTOOPT;
>   		break;
> @@ -874,7 +928,10 @@ static void sco_conn_ready(struct sco_conn *conn)
>   		hci_conn_hold(conn->hcon);
>   		__sco_chan_add(conn, sk, parent);
>   
> -		sk->sk_state = BT_CONNECTED;
> +		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
> +			sk->sk_state = BT_CONNECT;
> +		else
> +			sk->sk_state = BT_CONNECTED;
>   
>   		/* Wake up parent */
>   		parent->sk_data_ready(parent, 1);
> @@ -912,6 +969,32 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
>   	return lm;
>   }
>   
> +int sco_defer(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct sock *sk;
> +	struct hlist_node *node;
> +	int defer = 0;
> +
> +	BT_DBG("hdev %s, bdaddr %pMR", hdev->name, bdaddr);
> +
> +	/* Find listening sockets */
> +	read_lock(&sco_sk_list.lock);
> +	sk_for_each(sk, node, &sco_sk_list.head) {
> +		if (sk->sk_state != BT_LISTEN)
> +			continue;
> +
> +		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr) ||
> +		    !bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
> +			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
> +				defer = 1;
> +			break;
> +		}
> +	}
> +	read_unlock(&sco_sk_list.lock);
> +
> +	return defer;
> +}
> +
>   void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
>   {
>   	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
> @@ -992,7 +1075,7 @@ static const struct proto_ops sco_sock_ops = {
>   	.accept		= sco_sock_accept,
>   	.getname	= sco_sock_getname,
>   	.sendmsg	= sco_sock_sendmsg,
> -	.recvmsg	= bt_sock_recvmsg,
> +	.recvmsg	= sco_sock_recvmsg,
>   	.poll		= bt_sock_poll,
>   	.ioctl		= bt_sock_ioctl,
>   	.mmap		= sock_no_mmap,
> @@ -1036,7 +1119,6 @@ int __init sco_init(void)
>   			BT_ERR("Failed to create SCO debug file");
>   	}
>   
> -	BT_INFO("SCO socket layer initialized");
>   
>   	return 0;
>   

