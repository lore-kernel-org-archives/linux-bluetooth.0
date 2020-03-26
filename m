Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF463C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAAF20719
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOA0Gxbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZVJH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:09:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37704 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZVJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id g23so7549056otq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsQRerX0cT9L8utjKt5AM3/uTMou2QKNVYAs290O/C0=;
        b=QOA0GxbtgM3K9NgwylSqhtjivsc3LOvUHO91ocbAL1/iWuhXs0Gun7GY/En7PS2tvi
         PhUZzZ8zUShegvYkK70ymuK+TR2kLk7Doq2G9Ee6/zPgHG4hj2Hv/TfaDCZ9WLiIqf7K
         KOvDT6S00hoZMxxLZCp4VYWNXca/wud2woD+GAQBgZip4uDEon5xJ5umwVw2Lr7YJ+p8
         gVfN0opqkv2fQuMFST0wDM5wja11xxiu/rkYgiouOYJ/EuBAiwAkkzpf5MXZpba6VdGU
         CxzLDwKJnZ3WMzufssBkabbE7opTTmJsl3vyApE8W3HzWAFNEqpc4BLwJAv5OdIXH+zT
         v8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsQRerX0cT9L8utjKt5AM3/uTMou2QKNVYAs290O/C0=;
        b=FvaAqm6ACK7LSounTvuOofoQSpkn2C1BXBT1RNl2v6oTwTbzPKh1RwdK/OgEA1SJMz
         y83WgivpbSyg7KtJS1svLm2bzRosWfYpGD7I20eGS6shxOL0FPgWGKYlC7yxmt0dsSX8
         mmFJI9zepvhHEXAQ7FWWN2wh3fVUo7uho7x5IJdG+QN78hpqtKhUJ8z/H40ghp0pL2vl
         6zXDnEbrRwenFIvCxluIzOaMXKuWIWzsCTGw5FSGXuUpYgVmpDU5JKCCVLbeXQddDTed
         PhVXLw8J9YTYRJPV7qr14CUA0fx6lhJY+4F5Ji5HnaxGN/j/Vw2ZYInf1WGFfzgKAZCz
         7k9w==
X-Gm-Message-State: ANhLgQ255mEpblQe+/u8xBcVlMq2GylKbnrt6PRUdx112kmhYexrQa9X
        BxwvXn/RBThm1FQ1ODQRu/B2raxUomO+/1wXlsT2wg==
X-Google-Smtp-Source: ADFU+vveGg6fjqv92egs7fLTvzQovpM4dbQTzuZhYbh+Yrp4zpt90NohM1QqwxPi7uWp4K44D7Xx/Nl86a2Wz5GV3yg=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr7110915otj.177.1585256945337;
 Thu, 26 Mar 2020 14:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOxioNmHcCTkc1MA6Zw8WTPBHCTpE9XZyzfOeuj97EP2NeBw=A@mail.gmail.com>
 <CAOxioN=7jGXxp+=c674Ai3bU5N3f-qRpd3zHDuOdSO93W3dnwQ@mail.gmail.com>
In-Reply-To: <CAOxioN=7jGXxp+=c674Ai3bU5N3f-qRpd3zHDuOdSO93W3dnwQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Mar 2020 14:08:53 -0700
Message-ID: <CABBYNZLTj2OjtbVfasAFEzQCGmEpcHzvsbozP2WzPP_UQN29pA@mail.gmail.com>
Subject: Re: [PATCH] autopair: Fix compiler warning
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Mar 26, 2020 at 10:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi BlueZ maintainers,
>
> Could you take a look at this fix? Thank you!
>
> On Tue, Mar 24, 2020 at 12:49 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > With clang, comparing an array with NULL generates a warning because the
> > value is always non-NULL. With maintainer mode enabled, this becomes a
> > compilation error.
> > ---
> >  plugins/autopair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/plugins/autopair.c b/plugins/autopair.c
> > index 043bd9b9d..3089430a8 100644
> > --- a/plugins/autopair.c
> > +++ b/plugins/autopair.c
> > @@ -75,7 +75,7 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
> >          btd_device_get_product (device));
> >
> >      /* The iCade shouldn't use random PINs like normal keyboards */
> > -    if (name != NULL && strstr(name, "iCade") != NULL)
> > +    if (strstr(name, "iCade") != NULL)
> >          return 0;
> >
> >      /* This is a class-based pincode guesser. Ignore devices with an
> > --
> > 2.17.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
