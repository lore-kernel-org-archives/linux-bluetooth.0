Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Nov 2012 18:30:29 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
Message-ID: <20121115203029.GA2026@joana>
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

* Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2012-11-13 19:20:25 +0100]:

> In order to authenticate and later configure an incoming SCO connection, the
> BT_DEFER_SETUP option is added.
> When an connection is requested, the listening socket is unblocked but the
> effective connection setup happens only on first recv.
> Any send between accept and recv fails with -ENOTCONN.
> ---
>  include/net/bluetooth/hci_core.h |   15 +++++++
>  net/bluetooth/hci_event.c        |   47 +++++++++++++++++++-
>  net/bluetooth/sco.c              |   88 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 145 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ef5b85d..2ee0ecb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -377,6 +377,7 @@ extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
>  			      u16 flags);
>  
>  extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +extern int sco_defer(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
>  extern void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
>  extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
> @@ -577,6 +578,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
>  int hci_conn_del(struct hci_conn *conn);
>  void hci_conn_hash_flush(struct hci_dev *hdev);
>  void hci_conn_check_pending(struct hci_dev *hdev);
> +void hci_conn_accept(struct hci_conn *conn, int mask);
>  
>  struct hci_chan *hci_chan_create(struct hci_conn *conn);
>  void hci_chan_del(struct hci_chan *chan);
> @@ -796,6 +798,19 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  	}
>  }
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
>  static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
>  {
>  	switch (conn->type) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9f5c5f2..167eca0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2047,15 +2047,54 @@ unlock:
>  	hci_conn_check_pending(hdev);
>  }
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
>  static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct hci_ev_conn_request *ev = (void *) skb->data;
>  	int mask = hdev->link_mode;
> +	int defered;
>  
>  	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
>  	       ev->link_type);
>  
>  	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
> +	defered = hci_proto_defered(hdev, &ev->bdaddr, ev->link_type);

I'm not really happy with this hci_proto thing. Weed need to think more on
this.

>  
>  	if ((mask & HCI_LM_ACCEPT) &&
>  	    !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
> @@ -2085,7 +2124,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  		hci_dev_unlock(hdev);
>  
> -		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev)) {
> +		if (ev->link_type == ACL_LINK ||
> +				(!defered && !lmp_esco_capable(hdev))) {
>  			struct hci_cp_accept_conn_req cp;
>  
>  			bacpy(&cp.bdaddr, &ev->bdaddr);
> @@ -2097,7 +2137,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  			hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp),
>  				     &cp);
> -		} else {
> +		} else if (!defered) {
>  			struct hci_cp_accept_sync_conn_req cp;
>  
>  			bacpy(&cp.bdaddr, &ev->bdaddr);
> @@ -2111,6 +2151,9 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
>  				     sizeof(cp), &cp);
> +		} else {
> +			hci_proto_connect_cfm(conn, 0);
> +			hci_conn_put(conn);
>  		}
>  	} else {
>  		/* Connection rejected */
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 450cdcd..416801a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -662,16 +662,57 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>  	return err;
>  }
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

I think you want to use BT_CONNECT2 here...

> +			test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> +		hci_conn_accept(pi->conn->hcon, 0);
> +		sk->sk_state = BT_CONNECT2;

and BT_CONFIG here.

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
>  static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
>  {
>  	struct sock *sk = sock->sk;
>  	int err = 0;
> +	u32 opt;
>  
>  	BT_DBG("sk %p", sk);
>  
>  	lock_sock(sk);
>  
>  	switch (optname) {
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

Please move the set/getsockopt to a separated patch and put it first in your
series.

>  	default:
>  		err = -ENOPROTOOPT;
>  		break;
> @@ -753,6 +794,19 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
>  	lock_sock(sk);
>  
>  	switch (optname) {
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
>  	default:
>  		err = -ENOPROTOOPT;
>  		break;
> @@ -874,7 +928,10 @@ static void sco_conn_ready(struct sco_conn *conn)
>  		hci_conn_hold(conn->hcon);
>  		__sco_chan_add(conn, sk, parent);
>  
> -		sk->sk_state = BT_CONNECTED;
> +		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
> +			sk->sk_state = BT_CONNECT;

Let's use BT_CONNECT2 here as this a incoming connection.

	Gustavo
