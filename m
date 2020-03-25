Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDCC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D2D20719
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCYVPC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:15:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54886 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYVPC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 17:15:02 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C88EECECD6;
        Wed, 25 Mar 2020 22:24:31 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 2/2] Bluetooth: Add BT_MODE socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200325193754.13950-2-luiz.dentz@gmail.com>
Date:   Wed, 25 Mar 2020 22:14:59 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0C7A165A-3C33-4E7D-949C-8DABB2E1DF05@holtmann.org>
References: <20200325193754.13950-1-luiz.dentz@gmail.com>
 <20200325193754.13950-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds BT_MODE socket option which can be used to set L2CAP modes,
> including modes only supported over LE which were not supported using
> the L2CAP_OPTIONS.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |   8 ++
> net/bluetooth/l2cap_sock.c        | 120 +++++++++++++++++++++++++++++-
> 2 files changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 1576353a2773..3fa7b1e3c5d9 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -139,6 +139,14 @@ struct bt_voice {
> #define BT_PHY_LE_CODED_TX	0x00002000
> #define BT_PHY_LE_CODED_RX	0x00004000
> 
> +#define BT_MODE			15
> +
> +#define BT_MODE_BASIC		0x00
> +#define BT_MODE_ERTM		0x01
> +#define BT_MODE_STREAMING	0x02
> +#define BT_MODE_LE_FLOWCTL	0x03
> +#define BT_MODE_EXT_FLOWCTL	0x04
> +
> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 117ba20ea194..07f8d60953f2 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -395,6 +395,24 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
> 	return sizeof(struct sockaddr_l2);
> }
> 
> +static int l2cap_get_mode(struct l2cap_chan *chan)
> +{
> +	switch (chan->mode) {
> +	case L2CAP_MODE_BASIC:
> +		return BT_MODE_BASIC;
> +	case L2CAP_MODE_ERTM:
> +		return BT_MODE_ERTM;
> +	case L2CAP_MODE_STREAMING:
> +		return BT_MODE_STREAMING;
> +	case L2CAP_MODE_LE_FLOWCTL:
> +		return BT_MODE_LE_FLOWCTL;
> +	case L2CAP_MODE_EXT_FLOWCTL:
> +		return BT_MODE_EXT_FLOWCTL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
> 				     char __user *optval, int __user *optlen)
> {
> @@ -424,6 +442,13 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
> 			break;
> 		}
> 
> +		/* L2CAP_MODE_LE_FLOWCTL and L2CAP_MODE_EXT_FLOWCTL are not
> +		 * supported by L2CAP_OPTIONS.
> +		 */
> +		if (chan->mode == L2CAP_MODE_LE_FLOWCTL ||
> +				chan->mode == L2CAP_MODE_EXT_FLOWCTL)

this is the wrong kernel indentation.

> +			return -EINVAL;
> +
> 		memset(&opts, 0, sizeof(opts));
> 		opts.imtu     = chan->imtu;
> 		opts.omtu     = chan->omtu;
> @@ -508,7 +533,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> 	struct bt_security sec;
> 	struct bt_power pwr;
> 	u32 phys;
> -	int len, err = 0;
> +	int len, mode, err = 0;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -624,6 +649,27 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> 			err = -EFAULT;
> 		break;
> 
> +	case BT_MODE:
> +		if (!enable_ecred) {
> +			err = -ENOPROTOOPT;
> +			break;
> +		}
> +
> +		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		mode = l2cap_get_mode(chan);
> +		if (mode < 0) {
> +			err = mode;
> +			break;
> +		}
> +
> +		if (put_user(mode, (u8 __user *) optval))
> +			err = -EFAULT;
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;
> @@ -763,6 +809,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
> 	return err;
> }
> 
> +static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
> +{
> +	switch (mode) {
> +	case BT_MODE_BASIC:
> +		if (bdaddr_type_is_le(chan->src_type))
> +			return -EINVAL;
> +		mode = L2CAP_MODE_BASIC;
> +		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
> +		break;
> +	case BT_MODE_ERTM:
> +		if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> +			return -EINVAL;
> +		mode = L2CAP_MODE_ERTM;
> +		break;
> +	case BT_MODE_STREAMING:
> +		if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> +			return -EINVAL;
> +		mode = L2CAP_MODE_STREAMING;
> +		break;
> +	case BT_MODE_LE_FLOWCTL:
> +		if (!bdaddr_type_is_le(chan->src_type))
> +			return -EINVAL;
> +		mode = L2CAP_MODE_LE_FLOWCTL;
> +		break;
> +	case BT_MODE_EXT_FLOWCTL:
> +		/* TODO: Add support for ECRED PDUs to BR/EDR */
> +		if (!bdaddr_type_is_le(chan->src_type))
> +			return -EINVAL;
> +		mode = L2CAP_MODE_EXT_FLOWCTL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	chan->mode = mode;
> +
> +	return 0;
> +}
> +
> static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
> 				 char __user *optval, unsigned int optlen)
> {
> @@ -968,6 +1053,39 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
> 
> 		break;
> 
> +	case BT_MODE:
> +		if (!enable_ecred) {
> +			err = -ENOPROTOOPT;
> +			break;
> +		}
> +
> +		BT_DBG("sk->sk_state %u", sk->sk_state);
> +
> +		if (sk->sk_state != BT_BOUND) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (get_user(opt, (u8 __user *) optval)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		BT_DBG("opt %u", opt);
> +
> +		err = l2cap_set_mode(chan, opt);
> +		if (err)
> +			break;
> +
> +		BT_DBG("mode 0x%2.2x", chan->mode);
> +
> +		break;
> +

So do we want BT_MODE as u8 or just simply as int?

Regards

Marcel

