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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 03:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D32A61056
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 03:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhICDts (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 23:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhICDtr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 23:49:47 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19AC061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 20:48:47 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i23so3358959vsj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 20:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6wSiuQtL8BT8ehHD0vsqL/zzDwZ/IJUysSNbV7vbOM=;
        b=ASihg+IZF85OaYGRc45KlNiMHgfJFT1cIFKEd11GzxIvNkb2JVkrd8FniBjj+c0o67
         Fvcg7dLlJCQ/Yt9wvyhtq8D7Kr9K/xP3NONAicNhV4OTQuyN/5V2okhsKpHzDo8bRePR
         LKE3qA6eMV/sG8XpZhGkDdHhWx7lJOym0PJ9QrIHnooxSRw6j34yKkeWoNI+NgrOv2hi
         Z6qOBQtbrXtGZ3I4ePuSQ+zwRxa0CrTaKLmCdMU8jZ1dSlBMJT/X+9ZF4t//nXh/Ms95
         eIyCKjY2KdGJJ+ickG1dVYAnW94CHiq6K/PwOcsANyED8zlyVar5QiBALfy/+cL37epd
         Fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6wSiuQtL8BT8ehHD0vsqL/zzDwZ/IJUysSNbV7vbOM=;
        b=MSadkX/vBUUW4ymUHKzq3gPOjZh6SyAF8hT3soKi4n8eA+twbY+2fHP9fKnx8sK2Lj
         unNzfSwECzYPaUzkCRrxrZhNFxSdMSNohvQ45BBuP2GPrd/DRGnh17UmTQP3hKvgdhbd
         dfpxMV19tmZQvInl3uNrAUAIzLnHknSWOUWtyLw+XE3ofP3ZlcT5uFjVc0KS0A/vZzan
         BjO2hKKiIqdkb2egXXS5nxMNHwesGYPmgsl5qQWpNQK6GzerLIQy9zNewYVd7w55h/pr
         zHmbWpKUHvJ3vVaPLE3+USEuS6d+VPzyqOcOJpNpbevNY7nh/1dzargxjfZdHTXnZOz7
         j61g==
X-Gm-Message-State: AOAM533GCrE3n8gAKRuaK2wuWfADkByjXfFfLy7rAn8AwH5E+pslNrOk
        dapkxE4p1o/SEIL1C7kCpeRX7LjZUa4XKkblm4A=
X-Google-Smtp-Source: ABdhPJy0HXwrSYz50SqNC69/CnCchN7ciAYYeCHDAVEi/nBxUfFi1qCJBu2w5g7/1LTUNbmN2ZWRFx6hgHnUkEWQLI8=
X-Received: by 2002:a67:1d07:: with SMTP id d7mr1137417vsd.25.1630640926675;
 Thu, 02 Sep 2021 20:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
 <c998d16d-f45a-8be4-2898-9e94509cb2ea@i-love.sakura.ne.jp> <60f604f8-2a89-fd3f-996f-9d9e4a229427@i-love.sakura.ne.jp>
In-Reply-To: <60f604f8-2a89-fd3f-996f-9d9e4a229427@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Sep 2021 20:48:35 -0700
Message-ID: <CABBYNZK-JvPcB_T39_NUE-O6ztE6crNEfmFxszEtAu3OkrKF2A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: avoid page fault from sco_send_frame()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LinMa <linma@zju.edu.cn>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Thu, Sep 2, 2021 at 7:44 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since userfaultfd mechanism allows sleeping with kernel lock held,
> avoiding page fault with kernel lock held where possible will make
> the module more robust. This patch just brings memcpy_from_msg() calls
> to out of sock lock.
>
> This patch is an instant mitigation for CVE-2021-3640. To fully close
> the race window for this use-after-free problem, we need more changes.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/bluetooth/sco.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index d9a4e88dacbb..e4b079b31ce9 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -273,7 +273,7 @@ static int sco_connect(struct sock *sk)
>         return err;
>  }
>
> -static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
> +static int sco_send_frame(struct sock *sk, const void *buf, int len, int flags)
>  {
>         struct sco_conn *conn = sco_pi(sk)->conn;
>         struct sk_buff *skb;
> @@ -285,14 +285,11 @@ static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
>
>         BT_DBG("sk %p len %d", sk, len);
>
> -       skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
> +       skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
>         if (!skb)
>                 return err;
>
> -       if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> -               kfree_skb(skb);
> -               return -EFAULT;
> -       }
> +       memcpy(skb_put(skb, len), buf, len);
>
>         hci_send_sco(conn->hcon, skb);
>
> @@ -714,6 +711,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>                             size_t len)
>  {
>         struct sock *sk = sock->sk;
> +       void *buf;
>         int err;
>
>         BT_DBG("sock %p, sk %p", sock, sk);
> @@ -725,14 +723,23 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>         if (msg->msg_flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> +       buf = kmalloc(len, GFP_KERNEL | __GFP_NOWARN);
> +       if (!buf)
> +               return -ENOMEM;
> +       if (memcpy_from_msg(buf, msg, len)) {
> +               kfree(buf);
> +               return -EFAULT;
> +       }

There is a set already handing this sort of problem:

https://patchwork.kernel.org/project/bluetooth/patch/20210901002621.414016-3-luiz.dentz@gmail.com/

>         lock_sock(sk);
>
>         if (sk->sk_state == BT_CONNECTED)
> -               err = sco_send_frame(sk, msg, len);
> +               err = sco_send_frame(sk, buf, len, msg->msg_flags);
>         else
>                 err = -ENOTCONN;
>
>         release_sock(sk);
> +       kfree(buf);
>         return err;
>  }
>
> --
> 2.30.2
>
>


-- 
Luiz Augusto von Dentz
