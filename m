Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E34461158
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbhIHROh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352434AbhIHROf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 13:14:35 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A85C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 10:13:25 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id bf15so2724826vsb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+q/rfkz/M3nlsIMVBFbnTrBFEeVkJ7HjHw0Ttc6Xt/Q=;
        b=IjvEh0RW6lKAcq/+ELlvSWdNHrOG5XFmq8GZoRl1JhlTvOLvcvwpOYttMWbiXzokO5
         HJhyXEPWiqZB0be7OmnT64HJemQ5AcBVGsx/SeE5H/5U3bhpjq5R9pm6eAoa4ihQq13A
         AfqhrkmHrU/IMW2lOcTuFUpA63rhniSZPlzsPZ2DiAaN35sLaDj8FCkmVTnYzPdcyDpX
         RQAcio2ZTxlJbBgsTIyohJqo6xYqSvUdi1pkbKCHcNDFmBpIyM3cwDIVx0fC4imf67ga
         hOJcwKelUvER7ERRkGCk1TIfjW1m1wl+eDZAUL0jfUCWpa8CtDyh+ERAo44fq280NKjk
         PIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+q/rfkz/M3nlsIMVBFbnTrBFEeVkJ7HjHw0Ttc6Xt/Q=;
        b=6myOyotwXqH4URLT5yPlppvgMsl7iihR3pOQpagCQvn5KX1I1wODUiRdOeqH+wN/Nx
         f+UcCx813W3a8zwvCEpXVRimgCknTet8CvYYX8TTkWTzbmMqD8bZBeZ3UYk1Bqd4MmUT
         BxUHv0WpJkHzRj1mxj2Js3p0DrPIcgwD6fhEaC9zDRhklJHwMNtqqlH8idDdP/rzgIm8
         8Pg2SG1ndIma/XPbubjVmkLQc1qrJEJnSfilDSK6qLjvSDK0zmMC8FRyt/Jb1tx55K97
         ul2YlIx88cN5XxJ2vigJVukiMtxQ7eYOBrEjh6sYaNuzud7hZUIOGC5hGTwK54WLT+qZ
         o73Q==
X-Gm-Message-State: AOAM5323HZsiTWg8Tj3usJemG0UOdIUOUkbKDmtVMI9aZMv/vBsyDOiW
        GtXmcM6GNhZMVS4uvd5KvFgl5H42r6pMNlC5N+PXAAFC
X-Google-Smtp-Source: ABdhPJynODqDBM10TvixViim10+93QGJHz9LZAoZYVEI2NIqHEgrEZK3Tft+FGPxPtKSiHm5wzlEcT5Zi1SUaaojTuc=
X-Received: by 2002:a67:d604:: with SMTP id n4mr3283068vsj.39.1631121203887;
 Wed, 08 Sep 2021 10:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210903222732.1472560-1-luiz.dentz@gmail.com>
In-Reply-To: <20210903222732.1472560-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Sep 2021 10:13:13 -0700
Message-ID: <CABBYNZK4WwrC53udCCXa4m2mzfV=eKLwSULDkFjpZ+z5MUdJGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: Add bt_skb_sendmsg helper
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Sep 3, 2021 at 3:27 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> bt_skb_sendmsg helps takes care of allocation the skb and copying the
> the contents of msg over to the skb while checking for possible errors
> so it should be safe to call it without holding lock_sock.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 9125effbf448..aa6f8fe897ce 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -420,6 +420,34 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
>         return NULL;
>  }
>
> +/* Shall not be called with lock_sock held */
> +static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
> +                                            struct msghdr *msg,
> +                                            size_t len, size_t mtu,
> +                                            size_t headroom, size_t tailroom)
> +{
> +       struct sk_buff *skb;
> +       size_t size = min_t(size_t, len, mtu);
> +       int err;
> +
> +       skb = bt_skb_send_alloc(sk, size + headroom + tailroom,
> +                               msg->msg_flags & MSG_DONTWAIT, &err);
> +       if (!skb)
> +               return ERR_PTR(err);
> +
> +       skb_reserve(skb, headroom);
> +       skb_tailroom_reserve(skb, mtu, tailroom);
> +
> +       if (!copy_from_iter_full(skb_put(skb, size), size, &msg->msg_iter)) {
> +               kfree_skb(skb);
> +               return ERR_PTR(-EFAULT);
> +       }
> +
> +       skb->priority = sk->sk_priority;
> +
> +       return skb;
> +}
> +
>  int bt_to_errno(u16 code);
>
>  void hci_sock_set_flag(struct sock *sk, int nr);
> --
> 2.31.1

Any comments on this set? I did incorporate the skb_tailroom_reserver as well.


-- 
Luiz Augusto von Dentz
