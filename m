Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B8CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiCKNlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCKNlN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 08:41:13 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5412A75F
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 05:40:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o26so7485837pgb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJPnVIMSU+IrQ9w0O2hqLwzd9dxtAvfXm0oaAs1Cu+o=;
        b=KyHQnFWzijooxhm4+qEClaFTQnEh1kFr5/0X6dBynGp50rRU03p/aEaHySlTcLLpML
         N0HWi23HXrJPFZNrUjwzzK3VnbpzBrSp9Shhvljosnj3JI/kxNP6wU6pjcuTuZ7dcVjx
         liJOt/SOw8J6okyDGeurWLW49JV+Eb2j4ZbojSFQP/CyO2g7enBbQoAhFtasV6sUBBIr
         LX/DHfsT2qlfLFhfQ79u1hsJZIAmNU6Xj1uWDTt/GN+/gw5kiLcNvGYc/DwKztEP2O3J
         JIV4lrsGnRq2UVntgxzw18B/RVWt9dBeEFW4jeHsj2glVNDlA2kW29O/FgG5Nvpy5jtj
         adxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJPnVIMSU+IrQ9w0O2hqLwzd9dxtAvfXm0oaAs1Cu+o=;
        b=yomQusQ70h4tVZrN+dduG6cJv4+JYvDNluLyzsy2tAaeG4lhuDs+/N7mJu27mbBmaa
         ZUo1aLXCO0y09E+HDHlyMHaa+wcUNRbDyp2moTqh9UoGYZSHZrf2XNWSFAtMSwn76q2C
         fg2KDnXpeCw4rT+CbF4HirMI7/FNKV2tGhvZ+GZ5RUNUZrpdMKwh88vrSB8eP+q9GCTl
         Xckvxeen+2V2ZyGlWImiAkOpw4dLCvyYrgYa+pc7c2jAAXeCimpgXtSIgEXBVxKtAchd
         MCHu6ogSHUpWHRB3bwA+vQt6SsLC1dx9Cy8+Ion1D1inRQXwHNoA42MITVd5fOnwOXFf
         agRA==
X-Gm-Message-State: AOAM53268ItZ+AW/LS6wrKwkNvlvxzljAewNCxC9l1iPIBMphnOEdPh7
        PZ0zWuEUpqdfCJja+5zXpRwAVzogUOO9eJkuyGtsgg==
X-Google-Smtp-Source: ABdhPJx4GJU+1g8Uc2yFPdnKGb6haWmbhQxzW0xSrGlkccKHqf6BpPTBeJ3wRN6VG158WX8XHwf24SeVKo+jdecgXDs=
X-Received: by 2002:a63:5c0f:0:b0:374:4a37:48f9 with SMTP id
 q15-20020a635c0f000000b003744a3748f9mr8659467pgb.470.1647006010014; Fri, 11
 Mar 2022 05:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20220224100641.2449550-1-gavin@matician.com> <71D25C8F-67D1-4EC0-9160-5F61C832F0AF@holtmann.org>
 <CACB127+s8mj2-Hkt4yZXRZ_cQ9CbAK0r3y709-8Cb3awpVJm9Q@mail.gmail.com>
In-Reply-To: <CACB127+s8mj2-Hkt4yZXRZ_cQ9CbAK0r3y709-8Cb3awpVJm9Q@mail.gmail.com>
From:   Gavin Li <gavin@matician.com>
Date:   Fri, 11 Mar 2022 05:39:58 -0800
Message-ID: <CACB127+XwPBWOL_VL7Xq+FvD5zFhn0ZUDURvVvV6OdN0oYpvUQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Please let me know what you think with regards to the comments above.

Best,
Gavin


On Thu, Feb 24, 2022 at 12:56 PM Gavin Li <gavin@matician.com> wrote:
>
> Hi Marcel,
>
> Thanks for reviewing this quickly.
>
> > > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > > index ee319779781e6..69374321130e4 100644
> > > --- a/net/bluetooth/af_bluetooth.c
> > > +++ b/net/bluetooth/af_bluetooth.c
> > > @@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
> > > EXPORT_SYMBOL(bt_sock_wait_state);
> > >
> > > /* This function expects the sk lock to be held when called */
> > > -int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> > > +int bt_sock_wait_ready(struct sock *sk, unsigned int flags)
> >
> > can we then also do s/flags/msg_flags/ then.
> I prefer keeping it as flags because all other net code also uses
> flags, msg_flags only appears
> in msg->msg_flags.
>
> > > @@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> > >
> > >       BT_DBG("sk %p", sk);
> > >
> > > -     timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> > > +     timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
> >
> > Since sock_sndtimeo() is taking a bool. This might be better !!(flags & MSG_DONTWAIT).
> It appears to be well-known in the net code that sock_sndtimeo takes a
> bool, since no other
> uses of it do the "!!" conversion.
>
> Let me know what you think. I can make the changes if needed but I was
> just trying my best
> to match the currently existing convention.
>
> Best,
> Gavin
