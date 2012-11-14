Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 11:17:41 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
Message-ID: <20121114091739.GB9443@aemeltch-MOBL1>
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Nov 13, 2012 at 07:20:25PM +0100, Frédéric Dalleau wrote:
> In order to authenticate and later configure an incoming SCO connection, the
> BT_DEFER_SETUP option is added.
> When an connection is requested, the listening socket is unblocked but the
> effective connection setup happens only on first recv.
> Any send between accept and recv fails with -ENOTCONN.
> ---

Apart from other comments..

> +static inline int hci_proto_defered(struct hci_dev *hdev, bdaddr_t *bdaddr,

I think we do not use "inline" anymore.

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

maybe some comments about those numbers

> +		cp.content_format = cpu_to_le16(hdev->voice_setting);
> +		cp.retrans_effort = 0xff;
> +
> +		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
> +			     sizeof(cp), &cp);
> +	}
> +}
> +

...

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

I think set/get sockopt might be implemented in a separate patch.
Maybe you can also break even into more logical chunks so this would be
easier to understand.

Best regards 
Andrei Emeltchenko 

