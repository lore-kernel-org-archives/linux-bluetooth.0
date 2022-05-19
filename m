Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89082C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiESUS0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiESUSY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:18:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6A7354C
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:18:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p12so6081254pfn.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWk9rCtHM8WxFMpku6SnqP5gs2RN0avF3Higue4AodM=;
        b=jkgkV+U7O2/B3foltyd1pF8OCQl9HTaai2zcROEPJhhU4LjC4V/O4n6ErRe7YiPRRM
         nYj9ZY1Wv0UtrsyTj6dXIc8QzxqfcFg/9brXjt543upficZLyoSY/dD+ae5ccqV0YelV
         Nr20w36w9xI10O7rDzqkVHiIg5Cm+FOWDy8Lp1RkHqRcuBJb3lf/dcyvXeWLGN9HzEM7
         iam7suB969MgFlbpAr7Xh0Qrt0NPPe/ddEgvBF0ZCURo6zkNvOG4u7WLiQvIMYtOfOMz
         pSQLTK3NBKMyZZaUJYQ33kZ11M01p9UOPYsh+5I20XYcsRWNT+gm0sPkKaNl5o8QHwAK
         dcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWk9rCtHM8WxFMpku6SnqP5gs2RN0avF3Higue4AodM=;
        b=aILzb3BVmf3aXOnDiVUSLsMnkPZ3La75yV84gC9j+f7fCIyOMO9RmY+br7VF+4t2/J
         3LHDW3ZV/mc+PohPPv24tVKS+CIUeAQmUjvE9Lk/kKU1URxdunh3A7zSwwD/VGKJ/8Yd
         rq+7GnZeP1eX2pY5LGdZ8uOmLQGP70CxkT7IhsWm6n9yiN7BAQ6l8YBLH8Y712ANrJe8
         pYtSdfU9/sPbIePrywmhAYLfj38X8aPKT6zOmnJw3JQbW0FzB0So5YGEXAy8VhqxTo95
         d4FisHnJ2sNYFD7qds8MN9LDJXm2+q54qQHRYxVxtlzBefH0BKMr6RGp2Q7ky9LFrcnP
         8YSg==
X-Gm-Message-State: AOAM531TSYwl4SaES4VFvJ+GvOpnRw3FGG+nZt1NWdfUNJF0D8pQdWz2
        7+yVJYSKIb+uXh5sovFgeSeVOIX+nLh7kWNzs+B3uB3B
X-Google-Smtp-Source: ABdhPJwN2S/XUluNXdq22Wvp+BrwFECvoFypChKx9C1QW+mJP7ph7+N4HxypbeYg5o72BlXlF3wavzvmM53bsB2bdq0=
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id
 q9-20020a056a00088900b0051091e66463mr6306788pfj.58.1652991503102; Thu, 19 May
 2022 13:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220513234611.1360704-1-luiz.dentz@gmail.com> <83CE64EC-65DE-4DE9-994B-4729A35A6F64@holtmann.org>
In-Reply-To: <83CE64EC-65DE-4DE9-994B-4729A35A6F64@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 May 2022 13:18:11 -0700
Message-ID: <CABBYNZ+Pd-5VbptVNwyd+7J2cFYr3rPUtPPc+L2s8cqzbBkKLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Add bt_status
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, May 19, 2022 at 11:07 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds bt_status which can be used to convert Unix errno to
> > Bluetooth status.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h |  1 +
> > net/bluetooth/lib.c               | 71 +++++++++++++++++++++++++++++++
> > 2 files changed, 72 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 6b48d9e2aab9..cfe6159f26bc 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -521,6 +521,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
> > }
> >
> > int bt_to_errno(u16 code);
> > +__u8 bt_status(int err);
> >
> > void hci_sock_set_flag(struct sock *sk, int nr);
> > void hci_sock_clear_flag(struct sock *sk, int nr);
> > diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> > index 5326f41a58b7..469a0c95b6e8 100644
> > --- a/net/bluetooth/lib.c
> > +++ b/net/bluetooth/lib.c
> > @@ -135,6 +135,77 @@ int bt_to_errno(__u16 code)
> > }
> > EXPORT_SYMBOL(bt_to_errno);
> >
> > +/* Unix errno to Bluetooth error codes mapping */
> > +__u8 bt_status(int err)
> > +{
> > +     /* Don't convert if already positive value */
> > +     if (err >= 0)
> > +             return err;
> > +
> > +     switch (err) {
> > +     case -EBADRQC:
> > +             return 0x01;
> > +
> > +     case -ENOTCONN:
> > +             return 0x02;
> > +
> > +     case -EIO:
> > +             return 0x03;
> > +
> > +     case -EHOSTDOWN:
> > +             return 0x04;
> > +
> > +     case -EACCES:
> > +             return 0x05;
> > +
> > +     case -EBADE:
> > +             return 0x06;
> > +
> > +     case -ENOMEM:
> > +             return 0x07;
> > +
> > +     case -ETIMEDOUT:
> > +             return 0x08;
> > +
> > +     case -EMLINK:
> > +             return 0x09;
> > +
> > +     case EALREADY:
> > +             return 0x0b;
> > +
> > +     case -EBUSY:
> > +             return 0x0c;
> > +
> > +     case -ECONNREFUSED:
> > +             return 0x0d;
> > +
> > +     case -EOPNOTSUPP:
> > +             return 0x11;
> > +
> > +     case -EINVAL:
> > +             return 0x12;
> > +
> > +     case -ECONNRESET:
> > +             return 0x13;
> > +
> > +     case -ECONNABORTED:
> > +             return 0x16;
> > +
> > +     case ELOOP:
> > +             return 0x17;
> > +
> > +     case -EPROTONOSUPPORT:
> > +             return 0x1a;
> > +
> > +     case -EPROTO:
> > +             return 0x19;
> > +
> > +     default:
> > +             return 0x1f;
> > +     }
> > +}
> > +EXPORT_SYMBOL(bt_status);
> > +
>
> why are exporting this?

Isn't it supposed to be exported since it is part of lib.c? All
functions in this file use it.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
