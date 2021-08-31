Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C136C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 08:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5326761029
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 08:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhHaIgs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:36:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36115 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhHaIgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 04:36:47 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE990CECD5;
        Tue, 31 Aug 2021 10:35:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC 1/4] Bluetooth: Add bt_skb_sendmsg helper
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210831011528.225877-1-luiz.dentz@gmail.com>
Date:   Tue, 31 Aug 2021 10:35:51 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6AEBD579-90BB-486E-9915-614F7935880E@holtmann.org>
References: <20210831011528.225877-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> bt_skb_sendmsg helps takes care of allocation the skb and copying the
> the contents of msg over to the skb while checking for possible errors
> so it should be safe to call it without holding lock_sock.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 9125effbf448..1bfb5d3d24dd 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -420,6 +420,29 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
> 	return NULL;
> }
> 
> +/* Shall not be called with lock_sock held */
> +static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
> +					     struct msghdr *msg,
> +					     size_t len, int reserve)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
> +	if (!skb)
> +		return ERR_PTR(err);
> +
> +	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> +		kfree_skb(skb);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	skb_reserve(skb, reserve);
> +	skb->priority = sk->sk_priority;

have you tested this? I remember vaguely (really vaguely actually) that skb_reserve needs to be called before you do any changes to the buffer via skb_put and others. Especially since bt_skb_send_alloc already calls skb_reserve in the first place.

Regards

Marcel

