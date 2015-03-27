Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 3/3] Bluetooth: bnep: Add support to extended headers of control frames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427444231-25010-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Fri, 27 Mar 2015 16:15:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C894FD4D-ED14-4687-88FC-91E649DFF33D@holtmann.org>
References: <1427444231-25010-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1427444231-25010-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> Handling extended headers of control frames is required BNEP
> functionality. Previously setup success response was handled in user
> space and whole extended header was omitted. This patch allows to
> handle setup success response and parsing extended headers in control
> messages.
> 
> Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
> ---
> net/bluetooth/bnep/bnep.h |  3 +++
> net/bluetooth/bnep/core.c | 55 +++++++++++++++++++++++++++++++++++++----------
> 2 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
> index d19831e..bd8cde2 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -83,6 +83,9 @@
> /* Features */
> #define BNEP_SETUP_RSP_FEAT	0x01
> 
> +/* Session flags */
> +#define BNEP_SETUP_RSP_FLAG	0x00000000
> +

if these are just internal flags, then this should be an enum.

	enum {
		BNEP_SETUP_RSP_SENT,
	};

> struct bnep_setup_conn_req {
> 	__u8 type;
> 	__u8 ctrl;
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index c627817..eb459da 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -231,7 +231,13 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
> 		break;
> 
> 	case BNEP_SETUP_CONN_REQ:
> -		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
> +		/* Successful response should be sent only once */
> +		if (test_and_clear_bit(BNEP_SETUP_RSP_FLAG, &s->flags))
> +			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
> +					    BNEP_SUCCESS);
> +		else
> +			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
> +					    BNEP_CONN_NOT_ALLOWED);
> 		break;

Lets use a positive method of actually setting the flag and not clearing it.

> 
> 	default: {
> @@ -292,29 +298,55 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
> {
> 	struct net_device *dev = s->dev;
> 	struct sk_buff *nskb;
> -	u8 type;
> +	u8 type, ctrl_type;
> 
> 	dev->stats.rx_bytes += skb->len;
> 
> 	type = *(u8 *) skb->data;
> 	skb_pull(skb, 1);
> +	ctrl_type = *(u8 *)skb->data;
> 
> 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
> 		goto badframe;
> 
> 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
> -		bnep_rx_control(s, skb->data, skb->len);
> -		kfree_skb(skb);
> -		return 0;
> -	}
> +		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
> +			dev->stats.tx_errors++;
> +			kfree_skb(skb);
> +			return 0;
> +		}
> 
> -	skb_reset_mac_header(skb);
> +		if (!(type & BNEP_EXT_HEADER)) {
> +			kfree_skb(skb);
> +			return 0;
> +		}
> 
> -	/* Verify and pull out header */
> -	if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
> -		goto badframe;
> +		/* Verify and pull ctrl message since it's already processed */
> +		switch (ctrl_type) {
> +		case BNEP_SETUP_CONN_REQ:
> +			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
> +			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
> +				goto badframe;
> +			break;
> +		case BNEP_FILTER_MULTI_ADDR_SET:
> +		case BNEP_FILTER_NET_TYPE_SET:
> +			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
> +			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
> +				goto badframe;
> +			break;
> +		default:
> +			kfree_skb(skb);
> +			return 0;
> +		}
> +	} else {
> +		skb_reset_mac_header(skb);
> 
> -	s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
> +		/* Verify and pull out header */
> +		if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
> +			goto badframe;
> +
> +		s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
> +	}

Doesn't it make sense to refactor this first and then add the handling for setup_conn_req instead of intermixing this.

> 
> 	if (type & BNEP_EXT_HEADER) {
> 		if (bnep_rx_extension(s, skb) < 0)
> @@ -566,6 +598,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
> 	s->sock  = sock;
> 	s->role  = req->role;
> 	s->state = BT_CONNECTED;
> +	s->flags = req->flags;

Intermixing userspace flags here with kernel internal states is a really bad idea. You really want to keep that separate.

Since we have flags for HIDP userspace, I think this should be pretty much the same for BNEP now.

#define BNEP_HANDLE_SETUP_RSP	0

Also when we start using the flags, we should return EINVAL error for unsupported flags. That should be the first patch that enforce this from now on. Something that might also needs fixing in HIDP and CMTP.

Regards

Marcel

