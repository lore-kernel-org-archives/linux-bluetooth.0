Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiBXN2m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBXN2m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 08:28:42 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD3AEB0E85
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 05:28:10 -0800 (PST)
Received: from smtpclient.apple (p4fefc101.dip0.t-ipconnect.de [79.239.193.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2D79CED15;
        Thu, 24 Feb 2022 14:28:09 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: fix incorrect nonblock bitmask in
 bt_sock_wait_ready()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220224100641.2449550-1-gavin@matician.com>
Date:   Thu, 24 Feb 2022 14:28:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71D25C8F-67D1-4EC0-9160-5F61C832F0AF@holtmann.org>
References: <20220224100641.2449550-1-gavin@matician.com>
To:     gavin@matician.com
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gavin,

> Callers pass msg->msg_flags as flags, which contains MSG_DONTWAIT
> instead of O_NONBLOCK.
> 
> Signed-off-by: Gavin Li <gavin@matician.com>
> ---
> include/net/bluetooth/bluetooth.h | 2 +-
> net/bluetooth/af_bluetooth.c      | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index a647e5fabdbd6..87f0bba39b0f7 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -343,7 +343,7 @@ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
> __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
> int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
> int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
> -int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
> +int  bt_sock_wait_ready(struct sock *sk, unsigned int flags);
> 
> void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
> void bt_accept_unlink(struct sock *sk);
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index ee319779781e6..69374321130e4 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
> EXPORT_SYMBOL(bt_sock_wait_state);
> 
> /* This function expects the sk lock to be held when called */
> -int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> +int bt_sock_wait_ready(struct sock *sk, unsigned int flags)

can we then also do s/flags/msg_flags/ then.

> {
> 	DECLARE_WAITQUEUE(wait, current);
> 	unsigned long timeo;
> @@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> 
> 	BT_DBG("sk %p", sk);
> 
> -	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> +	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);

Since sock_sndtimeo() is taking a bool. This might be better !!(flags & MSG_DONTWAIT).

Regards

Marcel

