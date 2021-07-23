Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64249C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4858960EB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhGWVDo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhGWVDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 17:03:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83813C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:44:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s19so4443461ybc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUy1oZnM6RNvMpb2+bHYMmzWgswuKT9Lw5j6bTFEt34=;
        b=LPrzbZCtPqSX5Ou2702VYVgwHGSvkOWDbeVNiLhFUDMic+otwF9c0E/oK6MOAlXIez
         fJzuYy91rRQtX5eboJokPrks8/Kh7Zeyl4N3ctnfNsG2/dg8EQFgXczgaGSqSiX85kpA
         dyiv06Mwg/k33wQl8vX4pJ15bs9im8V+mFek1WGPuILgMKOXGQMyQmQGGhaaYrabQVYi
         7OPGNy26e+6DI/Pi4j+7AfVmP4QHA6WG5PMO2O+KVZItCIm105QI+/V1vT3OB05ej2f3
         feWImZQ/Z7/XmxdQSEyYSinSWenOq1gsd95XJltS4EiTEN5LO0BAA8LIe8bw5ELOWIbN
         AJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUy1oZnM6RNvMpb2+bHYMmzWgswuKT9Lw5j6bTFEt34=;
        b=tFtySn2YMjk9s6vnnaZkO+8F7UpA+pNXmC6VHZfMe36TQlC6e/XBAPKIW8ApzQ+LqQ
         pL6y12Afk71dQP6B/4vhH/rxUHy9uPscYfSwmepKzkEtdUS4GAJAIRVL1akLx9WtgREt
         mP7Qac41PxNRtWZEGj0lX0sn8RddWtgG62tIZhc0GQMoY/gTiqb3S2SL+rkUWn7QJ3Ty
         K3VsUK0uByv4Iem0IiFqTAH+40RAD/i2VBMgsR5DwNcMHuZAvl3I6vU7GprA7zM3Ue37
         IufPO2MjNvYO3t7UqLNzX1KIVRUXU4j3w7AF109JEyR424gFnW7FjHbADOe7QDEoJfUW
         syCQ==
X-Gm-Message-State: AOAM532yWyU4OQ3CzJxocttB9b3MyRlAI65D75xWId5y/g7bnNZaqiah
        hf8BUGaLlT1oHUYVsXVAyx6scvsqD5JQWPyqLIw=
X-Google-Smtp-Source: ABdhPJxRvDpYIZxcJUZkEPjjjrgOdhkpAOqfVsZUPaCKVfEL33a1EtovHgfnD6Piv30X6EF6xNW+vTg/58zeE0T/H14=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr9577344ybu.282.1627076655711;
 Fri, 23 Jul 2021 14:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210722074208.8040-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20210722074208.8040-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jul 2021 14:44:05 -0700
Message-ID: <CABBYNZKmF7vODFxkDyRwFsTd933mNNB3vwVOCcxsgof_St=ORw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: reorganize functions from hci_sock_sendmsg()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Thu, Jul 22, 2021 at 12:42 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since userfaultfd mechanism allows sleeping with kernel lock held,
> avoiding page fault with kernel lock held where possible will make
> the module more robust. This patch just brings memcpy_from_msg() calls
> to out of sock lock.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

> ---
>  net/bluetooth/hci_sock.c | 50 +++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index ef7fc3e9d471..7fac44fb771f 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1535,10 +1535,8 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>         return err ? : copied;
>  }
>
> -static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> -                       struct msghdr *msg, size_t msglen)
> +static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf, size_t msglen)
>  {
> -       void *buf;
>         u8 *cp;
>         struct mgmt_hdr *hdr;
>         u16 opcode, index, len;
> @@ -1552,15 +1550,6 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
>         if (msglen < sizeof(*hdr))
>                 return -EINVAL;
>
> -       buf = kmalloc(msglen, GFP_KERNEL);
> -       if (!buf)
> -               return -ENOMEM;
> -
> -       if (memcpy_from_msg(buf, msg, msglen)) {
> -               err = -EFAULT;
> -               goto done;
> -       }
> -
>         hdr = buf;
>         opcode = __le16_to_cpu(hdr->opcode);
>         index = __le16_to_cpu(hdr->index);
> @@ -1657,11 +1646,10 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
>         if (hdev)
>                 hci_dev_put(hdev);
>
> -       kfree(buf);
>         return err;
>  }
>
> -static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
> +static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int flags)
>  {
>         struct hci_mon_hdr *hdr;
>         struct sk_buff *skb;
> @@ -1676,14 +1664,11 @@ static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
>         if (len < sizeof(*hdr) + 3)
>                 return -EINVAL;
>
> -       skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
> +       skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
>         if (!skb)
>                 return err;
>
> -       if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> -               err = -EFAULT;
> -               goto drop;
> -       }
> +       memcpy(skb_put(skb, len), buf, len);
>
>         hdr = (void *)skb->data;
>
> @@ -1753,19 +1738,28 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>         struct hci_dev *hdev;
>         struct sk_buff *skb;
>         int err;
> +       void *buf;
> +       const unsigned int flags = msg->msg_flags;
>
>         BT_DBG("sock %p sk %p", sock, sk);
>
> -       if (msg->msg_flags & MSG_OOB)
> +       if (flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> -       if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_NOSIGNAL|MSG_ERRQUEUE|
> -                              MSG_CMSG_COMPAT))
> +       if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
>                 return -EINVAL;
>
>         if (len < 4 || len > HCI_MAX_FRAME_SIZE)
>                 return -EINVAL;
>
> +       buf = kmalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +       if (memcpy_from_msg(buf, msg, len)) {
> +               kfree(buf);
> +               return -EFAULT;
> +       }
> +
>         lock_sock(sk);
>
>         switch (hci_pi(sk)->channel) {
> @@ -1776,13 +1770,13 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>                 err = -EOPNOTSUPP;
>                 goto done;
>         case HCI_CHANNEL_LOGGING:
> -               err = hci_logging_frame(sk, msg, len);
> +               err = hci_logging_frame(sk, buf, len, flags);
>                 goto done;
>         default:
>                 mutex_lock(&mgmt_chan_list_lock);
>                 chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
>                 if (chan)
> -                       err = hci_mgmt_cmd(chan, sk, msg, len);
> +                       err = hci_mgmt_cmd(chan, sk, buf, len);
>                 else
>                         err = -EINVAL;
>
> @@ -1801,14 +1795,11 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>                 goto done;
>         }
>
> -       skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
> +       skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
>         if (!skb)
>                 goto done;
>
> -       if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> -               err = -EFAULT;
> -               goto drop;
> -       }
> +       memcpy(skb_put(skb, len), buf, len);
>
>         hci_skb_pkt_type(skb) = skb->data[0];
>         skb_pull(skb, 1);
> @@ -1880,6 +1871,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>
>  done:
>         release_sock(sk);
> +       kfree(buf);
>         return err;
>
>  drop:
> --
> 2.18.4
>


-- 
Luiz Augusto von Dentz
