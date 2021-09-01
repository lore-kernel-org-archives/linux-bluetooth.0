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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB8C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0B66102A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhIAAVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIAAVY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:21:24 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545CC061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:20:28 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id g16so409196uam.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PBrnOfpSpsLcdyizov2AGaRx94T+b/3Ln0qscuha5o=;
        b=PqKW6pug6ncZXwFN6zzhguOrVEt5/Wg7PiqwRLVa+Fe4cMXKUf+g6zwqCHXrLleCtC
         jTQgFN2rGFhoxPB9Fs/IvIBV1d/kS2MdxIr3n+o0yPrG4OAshuPgLKcLpeZjvc7N1fyN
         84Bj3FM304ZjZRdHpQjR/tM0+atLW9dyc2aBWmq4t5ACUCYhSrz9+MRWXVnJHEUvOLIY
         Pkk3adq2l/tdi2wcO4YbOcGLwFIAshPNszoNwfkds1oQyGNI3BFuYk4HHpK2rAmwDXWR
         hK58eYbtzqt0nPCIsay4AvU+yjgtVImOB4ndDfunUr5ZLqYkHOtXU5j8a9+io6+pY9Ip
         qVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PBrnOfpSpsLcdyizov2AGaRx94T+b/3Ln0qscuha5o=;
        b=CMEaAuBUj3c/2Kw/LYRh9OJI90Opko7j2r2Lfy+VZ4FXNkzWly3QDSOGBuTvKWmGR+
         Qc2TCi7p5UqM1owyoesaLaaq22RuhBB0XEdbpWhK3EwdBUbLua5WnpY6yKQbpOq6q0J+
         hj1cdVCbnq7oONGD8KBSbvcPcuxzz4FYABIL/yXdzcfDOhtibwCpFpMD4xtBiGhlKPOl
         vugHKNXAoG4SPE5b4PulFlgxYvCgXEanDePAEm9M6wMhrslWkeU8MBnWf+UscJWPZHPB
         RpAb0hIeFCZxdMYTjOEus3L/LNHP4JpKYytIemjCKVJHH9tvlAlnFf3r5ZDFczOBsmVx
         ywuQ==
X-Gm-Message-State: AOAM530mgVtT0OCKgMQwRY4URIXJtDFpu48Yqcg4eywaS54btXLgmfbb
        EwxZEKtW0ZOqOsDJnuxF+fUuflXhSplgBNfUZOUNDq0i
X-Google-Smtp-Source: ABdhPJzM0UGreW8UqnwbwGS1GxwTQNvAw0Jztjz5fBdE9HWZ7LUIi59/ZbgMreFnhu0f62Mupk2stNBoArI+1FFf1VM=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr21779129uar.3.1630455627835;
 Tue, 31 Aug 2021 17:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210831011528.225877-1-luiz.dentz@gmail.com> <6AEBD579-90BB-486E-9915-614F7935880E@holtmann.org>
In-Reply-To: <6AEBD579-90BB-486E-9915-614F7935880E@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Aug 2021 17:20:17 -0700
Message-ID: <CABBYNZ+LqknNZWaQkDY0E9QG5Q3JyMpp5=z-vNMEtVEC4mFnLg@mail.gmail.com>
Subject: Re: [RFC 1/4] Bluetooth: Add bt_skb_sendmsg helper
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Aug 31, 2021 at 1:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > bt_skb_sendmsg helps takes care of allocation the skb and copying the
> > the contents of msg over to the skb while checking for possible errors
> > so it should be safe to call it without holding lock_sock.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h | 23 +++++++++++++++++++++++
> > 1 file changed, 23 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 9125effbf448..1bfb5d3d24dd 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -420,6 +420,29 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
> >       return NULL;
> > }
> >
> > +/* Shall not be called with lock_sock held */
> > +static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
> > +                                          struct msghdr *msg,
> > +                                          size_t len, int reserve)
> > +{
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
> > +     if (!skb)
> > +             return ERR_PTR(err);
> > +
> > +     if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> > +             kfree_skb(skb);
> > +             return ERR_PTR(-EFAULT);
> > +     }
> > +
> > +     skb_reserve(skb, reserve);
> > +     skb->priority = sk->sk_priority;
>
> have you tested this? I remember vaguely (really vaguely actually) that skb_reserve needs to be called before you do any changes to the buffer via skb_put and others. Especially since bt_skb_send_alloc already calls skb_reserve in the first place.

Yep, that and the fact that we need both a header and footer size to
be given separately since the len should only account for the payload
itself, anyway I will send an update shortly and Ive now tested with
rfcomm-tester and they are all passing.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
