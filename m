Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B28C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9958E61186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 18:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhIOSrj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhIOSri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 14:47:38 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC50C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 11:46:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id n17so3079462vsr.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+v+PXKVfC0ArJtPl8fsPZEgvlLbpVR2xlEgp04GaGQ=;
        b=AfiooLL9cFfzQhg6qMR/Gl7zUqYyKDj+ShATDazePGtFESOpW/Ogv2OiUgXlfI/W1c
         Cg+TpKo3BRkJepxxoPlwLBWepgFg/bJ96PLBOGJA3WjhNWsJ8qoWhsIB9XAAcUEcuYEe
         4fVMfZqeW10s6m3xVfZ4Vq6ref5fiks9+UiCzpbtyDmSUSULp77OYI1SfY0wHrt5WEqd
         E6cx1zTrZ4tSHsjXdAhS+XkMeQFAV0qJofmStcTmX1JuMLz1M72pZivIEc4yOYbxP6k4
         JNl0nNIIFw5aonu751/s+huBEx/4Gg4Fm9QT2dob+fyJ1fGsWjaxEeUZazVmo6arRp91
         KAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+v+PXKVfC0ArJtPl8fsPZEgvlLbpVR2xlEgp04GaGQ=;
        b=Y3OSjaDUlq6zd+YKuTxE0WZWSk9RSIhhQGrIhGmwx8TgaNBQCt0Ke6O/ihsjnNBJFL
         KTT6+x1ImqBtGBL8WVBAL2M7qw7Xs9HGQTaxSrQE6ZEC+FF2qLs6h4z6J2/IMtjTxyD7
         c9QzvlTthurASZCWVo/ntfM+3YHJyXKGq9lfM47oHXVAfH2dlL4mmuIUwZo75ZfUW3dm
         wvv5sHCFsN6ULAauB+hF0E4ozrXtm65pq0ws4uIJQpTg9KAdQqSoKXUpfSWsEaDI7wnQ
         yMHzRTOvaOpJDk3UJhSkU5Sj0B+c8/7kAXwmBVPFcQQu3EJ4I7eVXbFmHK0ND3Lukxzm
         NEIA==
X-Gm-Message-State: AOAM530QsYyCN1ITG6j/3yHLc6VK/0Ey7XHk9juvASafvdi8HOEMvAWu
        KsnYVMIlUCrwMGrN3tVSwg42mZ0dQ2v3RYooUS9gURcwulQ=
X-Google-Smtp-Source: ABdhPJwwE5rQbc5AjenuP72WSx222eqCMELkSK9aXPRXdwg7RVV3UPY1bk+StV+jAsYD40ojwNhI8T3OueEIChjCjM8=
X-Received: by 2002:a67:ec4f:: with SMTP id z15mr1624916vso.39.1631731578420;
 Wed, 15 Sep 2021 11:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210915092546.GA4603@kili>
In-Reply-To: <20210915092546.GA4603@kili>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Sep 2021 11:46:07 -0700
Message-ID: <CABBYNZJ4tdr8tnGhdCrBbpu6jYHVKPfkEWt93oBp7XWFBBPnzQ@mail.gmail.com>
Subject: Re: [bug report] Bluetooth: RFCOMM: Replace use of memcpy_from_msg
 with bt_skb_sendmmsg
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Wed, Sep 15, 2021 at 2:27 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Luiz Augusto von Dentz,
>
> The patch 81be03e026dc: "Bluetooth: RFCOMM: Replace use of
> memcpy_from_msg with bt_skb_sendmmsg" from Sep 3, 2021, leads to the
> following
> Smatch static checker warning:
>
>         net/bluetooth/rfcomm/sock.c:587 rfcomm_sock_sendmsg()
>         warn: passing zero to 'PTR_ERR'
>
> net/bluetooth/rfcomm/sock.c
>     556 static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>     557                                size_t len)
>     558 {
>     559         struct sock *sk = sock->sk;
>     560         struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
>     561         struct sk_buff *skb;
>     562         int sent;
>     563
>     564         if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
>     565                 return -ENOTCONN;
>     566
>     567         if (msg->msg_flags & MSG_OOB)
>     568                 return -EOPNOTSUPP;
>     569
>     570         if (sk->sk_shutdown & SEND_SHUTDOWN)
>     571                 return -EPIPE;
>     572
>     573         BT_DBG("sock %p, sk %p", sock, sk);
>     574
>     575         lock_sock(sk);
>     576
>     577         sent = bt_sock_wait_ready(sk, msg->msg_flags);
>     578
>     579         release_sock(sk);
>     580
>     581         if (sent)
>     582                 return sent;
>     583
>     584         skb = bt_skb_sendmmsg(sk, msg, len, d->mtu, RFCOMM_SKB_HEAD_RESERVE,
>     585                               RFCOMM_SKB_TAIL_RESERVE);
>     586         if (IS_ERR_OR_NULL(skb))
>
> When a function returns both error pointers and NULL then that means
> the feature is optional and can be turned off by the user.
>
>         blinking_lights = get_blinking_lights();
>
> We should report the error to the user.
>
>         if (IS_ERR(blinking_lights))
>                 return PTR_ERR(blinking_lights);
>
> However, some users maybe want a smaller kernel with no blinking lights
> so they disable it.  In that case the driver has to check for NULL, and
> not print an error message but instead continue as best as possible
> without that feature enabled.
>
> The bt_skb_sendmmsg() cannot return NULL.  But if it did return NULL
> then PTR_ERR(NULL) is success so that's not right...  All the callers
> of bt_skb_sendmmsg() have the same issue.

It should never be NULL though:

skb = bt_skb_send_alloc(sk, size + headroom + tailroom,
msg->msg_flags & MSG_DONTWAIT, &err);
if (!skb)
return ERR_PTR(err);

So I guess using IS_ERR_OR_NULL is misleading since we use the err
that comes from sock_alloc_send_skb so we might as well replace that
with IS_ERR instead.

> --> 587                 return PTR_ERR(skb);
>     588
>     589         sent = rfcomm_dlc_send(d, skb);
>     590         if (sent < 0)
>     591                 kfree_skb(skb);
>     592
>     593         return sent;
>     594 }
>
> regards,
> dan carpenter



-- 
Luiz Augusto von Dentz
