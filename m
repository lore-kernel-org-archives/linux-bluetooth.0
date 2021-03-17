Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3298C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E0E64E74
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhCQUnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQUmf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 16:42:35 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6BC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 13:42:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y7so319592oih.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jh6fTUc9OYBl1APlGkxGWhQ+2RX4EQosgV2lfs7Wjw=;
        b=Hx+T6fI9yGYM7AB8DaBq0tF++m8gbAZLtt2XhMKWGN1yAhTfZF9ISb2fD7NbhKUPdi
         FBUo0Ki+gIWMN01wpczhisWzYcqDTHl2f2rYPUenbEUrouqWDX6Txe+l6cYGZ9hsRmUR
         cGJL9+8BTKL/jWmhPIeSA0nBaWs10XveYuXYlZdadLEjmYW/pai2qsZ28BIosePz9pCb
         P26Oa7rb9jZr545J5HWvMlbp0kC6t8xINQDjZ5HPV9s/CCSmOtiI1DDI1mMsmnkTplF5
         /JW1xh9iCsWlHNmF5uBrWpAbqIIorVmBBcQtLTHd+ghnSutUk/OzzUzmqL2hiVhgh7HW
         73OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jh6fTUc9OYBl1APlGkxGWhQ+2RX4EQosgV2lfs7Wjw=;
        b=QsFbOunCSOplcLda5ILFpNRYs/YuJUcRB/LbueuAMdWOpbtUegB4LIOawcc3EwBKCi
         oby1p/mFgqO0tZ12+94+w9kDsk2hKdhqWK/Udue6elU1zC6nzdo4LBRqEJlOiGX1XH2J
         3ha5Uy5CO4SNNFWezTjCFxPOh+TdRQYc9BDCxvSWy/g+Ea3ZWTTYhw1ys1IH8viZjn+Z
         53JSo4TTXHmVFU8Gyr8BNj9bKE8Th7LVY07g1faxQF7ROHYRMipbE31QlFGjR8/p5CxI
         zEbfTixODC4dfYBMiqd3IykCzO0E/ZQuSbXSqHCb+Nh6FBBUSxIEOGPrHIsLykvS7rJx
         ceEA==
X-Gm-Message-State: AOAM5316JwAsUisMls4FX8YERNeJV72zpMvDTsMxu63av5Mhu74yQXhv
        lJyKhywHz5Stt9NP84lfpqPZU+o1/WlIgSyblznVIeIbpktsvQ==
X-Google-Smtp-Source: ABdhPJxemlthjVncpUuB/2RVAWh8Cv7dFtZ4GvOHBiquKG8jXQNHvEEAVBSeo8kb/iBbVFLOXizxEBFBLKmWGuhA1rY=
X-Received: by 2002:a54:468f:: with SMTP id k15mr515265oic.58.1616013754380;
 Wed, 17 Mar 2021 13:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210316205838.2164464-1-luiz.dentz@gmail.com>
 <FD38AD5A-FADA-4EBB-AC7C-BD91F50EE248@holtmann.org> <CABBYNZ+zmuN+UKOXvSgh7EMbsoZTp=9gZ7-CCPpr0V3BT+qkbg@mail.gmail.com>
In-Reply-To: <CABBYNZ+zmuN+UKOXvSgh7EMbsoZTp=9gZ7-CCPpr0V3BT+qkbg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Mar 2021 13:42:23 -0700
Message-ID: <CABBYNZ+-VHu-GAb7g6XF15V3fm9XzrvXV6c_V6Uj1-1SgivQ2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix build with latest tree
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 17, 2021 at 11:29 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel,
>
> On Wed, Mar 17, 2021 at 1:38 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Luiz,
> >
> > > Latest ell tree has introduced useful.h and main-private.h which are
> > > required to build:
> > >
> > > ell/cert-crypto.c:35:10: fatal error: useful.h: No such file or
> > > directory
> > >   35 | #include "useful.h"
> > >         |          ^~~~~~~~~~
> > > ...
> > > ---
> > > Makefile.am | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index ff0df2196..7fce2e7c0 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -135,7 +135,9 @@ ell_headers = ell/util.h \
> > >                       ell/asn1-private.h \
> > >                       ell/cert-private.h \
> > >                       ell/pem-private.h \
> > > -                     ell/uuid.h
> > > +                     ell/uuid.h \
> > > +                     ell/useful.h \
> > > +                     ell/main-private.h
> > >
> >
> > this is the wrong fix. It will break in the tarballs. ELL will not install ell/useful.h ever. So every tarball needs to ensure that ell/useful.h is included. Which means you need to follow the fix from iwd here.
>
> Are you talking about this:
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=ed05585063f2e6d8f2fcd5f008b861062ac7a429
>
> Shall we use the same mechanism to link the headers?

I tried with distcheck to see what would be included in the tarball,
both useful.h and main-private.h do appear to be included, perhaps you
are saying that when we use non-built-in/shared ell
(--enable-external-ell) those headers are not installed, but I guess
in that case we don't need the private header as we won't be using the
built-in sources, or I'm missing something. That said perhaps this is
different in case of iwd as it seems to be using useful.h directly:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=17cf4da72613e80d08d51401399d02683ba8664b

-- 
Luiz Augusto von Dentz
