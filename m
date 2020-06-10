Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F1B20734
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgFJPn4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:43:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57301 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgFJPnx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 11:43:53 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 45D4CCECE7;
        Wed, 10 Jun 2020 17:53:41 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4] sco:Add support for BT_PKT_STATUS CMSG data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200610143122.15453-1-alainm@chromium.org>
Date:   Wed, 10 Jun 2020 17:43:50 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F08A06C8-34C7-4B01-8870-4E1D71864E85@holtmann.org>
References: <20200610143122.15453-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds support for reporting the BT_PKT_STATUS to the socket
> CMSG data to allow the implementation of a packet loss correction on
> erronous data received on the SCO socket.
> 
> The patch was partially developed by Marcel Holtmann and validated by
> Hsin-yu Chao
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> Changes in v4:
> - Addressing feedback from Marcel
> 
> include/net/bluetooth/bluetooth.h | 11 ++++++++++
> net/bluetooth/af_bluetooth.c      |  3 +++
> net/bluetooth/hci_core.c          |  1 +
> net/bluetooth/sco.c               | 34 +++++++++++++++++++++++++++++++
> 4 files changed, 49 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 3fa7b1e3c5d9..ff7258200efb 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -147,6 +147,11 @@ struct bt_voice {
> #define BT_MODE_LE_FLOWCTL	0x03
> #define BT_MODE_EXT_FLOWCTL	0x04
> 
> +#define BT_PKT_STATUS          16
> +
> +/* CMSG flags */
> +#define BT_CMSG_PKT_STATUS	0x0003
> +

I have the feeling that I confused you more than I made clear on how this should be done.

So the public available constant names should be BT_SCM_PKT_STATUS and we can keep that as u8 here for simplification and to not waste space for each SCO socket message.

> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> @@ -275,6 +280,7 @@ struct bt_sock {
> 	struct sock *parent;
> 	unsigned long flags;
> 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
> +	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
> };
> 
> enum {
> @@ -324,6 +330,10 @@ struct l2cap_ctrl {
> 	struct l2cap_chan *chan;
> };
> 
> +struct sco_ctrl {
> +	u8	pkt_status;
> +};
> +
> struct hci_dev;
> 
> typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
> @@ -350,6 +360,7 @@ struct bt_skb_cb {
> 	u8 incoming:1;
> 	union {
> 		struct l2cap_ctrl l2cap;
> +		struct sco_ctrl sco;
> 		struct hci_ctrl hci;
> 	};
> };
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 3fd124927d4d..d0abea8d08cc 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		if (msg->msg_name && bt_sk(sk)->skb_msg_name)
> 			bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
> 						&msg->msg_namelen);
> +
> +		if (bt_sk(sk)->skb_put_cmsg)
> +			bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
> 	}
> 
> 	skb_free_datagram(sk, skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 51d399273276..7b5e46198d99 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	if (conn) {
> 		/* Send to upper protocol */
> +		bt_cb(skb)->sco.pkt_status = flags & 0x03;
> 		sco_recv_scodata(conn, skb);
> 		return;
> 	} else {
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index c8c3d38cdc7b..abcefa00ae11 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -66,6 +66,7 @@ struct sco_pinfo {
> 	bdaddr_t	dst;
> 	__u32		flags;
> 	__u16		setting;
> +	unsigned long	cmsg_mask;

I would keep this as __u32 cmsg_mask similar to what HCI has. And using SCO_CMSG_PKT_STATUS 0x0001 is fine here. This is just internal and it doesn’t make a difference what value is used.

Actually we could reduce this to __u8 cmsg_mask also for HCI since a) it is all internal and b) we don’t need the extra size right now.

> 	struct sco_conn	*conn;
> };
> 
> @@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
> 	sco_sock_kill(sk);
> }
> 
> +static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
> +			     struct sock *sk)
> +{
> +	if (test_bit(BT_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask))
> +		put_cmsg(msg, SOL_BLUETOOTH, BT_CMSG_PKT_STATUS,
> +			 sizeof(bt_cb(skb)->sco.pkt_status),
> +			 &bt_cb(skb)->sco.pkt_status);
> +}
> +
> static void sco_sock_init(struct sock *sk, struct sock *parent)
> {
> 	BT_DBG("sk %p", sk);
> @@ -457,6 +467,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
> 		sk->sk_type = parent->sk_type;
> 		bt_sk(sk)->flags = bt_sk(parent)->flags;
> 		security_sk_clone(parent, sk);
> +	} else {
> +		bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
> 	}
> }
> 
> @@ -797,6 +809,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 	int len, err = 0;
> 	struct bt_voice voice;
> 	u32 opt;
> +	int pkt_status;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -846,6 +859,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 		sco_pi(sk)->setting = voice.setting;
> 		break;
> 
> +	case BT_PKT_STATUS:
> +		if (get_user(pkt_status, (int __user *)optval)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		if (pkt_status)
> +			set_bit(BT_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask);
> +		else
> +			clear_bit(BT_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask);
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;
> @@ -923,6 +948,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 	int len, err = 0;
> 	struct bt_voice voice;
> 	u32 phys;
> +	int pkt_status;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -969,6 +995,14 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 			err = -EFAULT;
> 		break;
> 
> +	case BT_PKT_STATUS:
> +		pkt_status = test_bit(BT_CMSG_PKT_STATUS,
> +				      &(sco_pi(sk)->cmsg_mask));
> +
> +		if (put_user(pkt_status, (int __user *)optval))
> +			err = -EFAULT;
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;

Regards

Marcel

