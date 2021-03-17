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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35531C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C9E64F50
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhCQS3a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhCQS3N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 14:29:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C1C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:29:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so2724926ota.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kqTYSW1zkFhWoKd2whbj0DDf8cBivFoSa1nZoO0JCo=;
        b=XIrk/zfRYy3J2FN9ZcYTVnIozpEZuf2elW2OUs9LpkFQjfP9o3KX5YsivX2Iinj/sj
         WULU9yB8ykLKJpfAxZVnB7+Ra7RhuNzWqaUt7TdnISW2t9zydKWt6yOieAMO8DJEARU0
         bvwPXOyhE1C7gZMVVFRHcEcUxv0vbmmBTkNBJpMcOKP3JBKg+a3dusZyCbWgXiTAR3BS
         qtORkWXuqw4TTiPdpF/9cV9C8/bacDRIg+rQfqceaTbU9rodsDIx93yEWQ194Yz30Ujz
         JQTEXA8MD2iQhTq3F0vOcS3bOZ1UHX+jjvL7E0I9ViCcWdm9eIfHVVDiKIi8uYMHeUql
         EPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kqTYSW1zkFhWoKd2whbj0DDf8cBivFoSa1nZoO0JCo=;
        b=B2dl+4b0XgoPLevlh0+fZBxEThlXIwRc6LAPGB6PVZM547e7U7jxS8or+hVNQtmJDi
         dGpbbsJ7ntIuQTjsHFva21sw2kIePVP6BVTjBPo28enJDNapeW8MBtEM9Yv+wfhIou1v
         l2A31St8FDIpTDfVHvNvSgtoSMW9pASCyO1y4WWrJTRhBDdLu7wvMy2lvN9uErnVWB36
         OtR1e2lSqtkq6+f2gQ1sI2bryttOfysg5A5G2GuuzcSquYCn+qRuuNPcm82DFk3B8ROj
         nZvAA/YUo+zqHMNo8pPQEVW93O5akmU6w2UjS0c383wNUVIYHJKq+hJokx86ywl+WaL9
         hmgA==
X-Gm-Message-State: AOAM533SjUXh41aoLN9ZxUscJv0KVRv2iE6ZHO4zHrmcUC1BzlTrDX5F
        FK/eYfiTIW1pizOukwzTxUex567ciJzwBZ+Gh3UTayzN8OPB3A==
X-Google-Smtp-Source: ABdhPJwPnZvrHjHJErAlsnHM0A6A6mQ6FdIabHjpQT/73IHLJCQikTpWjpWA00YPRbFa8x1AEMjO517r2JRK7TwUWio=
X-Received: by 2002:a05:6830:619:: with SMTP id w25mr4377078oti.371.1616005752856;
 Wed, 17 Mar 2021 11:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210316205838.2164464-1-luiz.dentz@gmail.com> <FD38AD5A-FADA-4EBB-AC7C-BD91F50EE248@holtmann.org>
In-Reply-To: <FD38AD5A-FADA-4EBB-AC7C-BD91F50EE248@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Mar 2021 11:29:02 -0700
Message-ID: <CABBYNZ+zmuN+UKOXvSgh7EMbsoZTp=9gZ7-CCPpr0V3BT+qkbg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix build with latest tree
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 17, 2021 at 1:38 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > Latest ell tree has introduced useful.h and main-private.h which are
> > required to build:
> >
> > ell/cert-crypto.c:35:10: fatal error: useful.h: No such file or
> > directory
> >   35 | #include "useful.h"
> >         |          ^~~~~~~~~~
> > ...
> > ---
> > Makefile.am | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index ff0df2196..7fce2e7c0 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -135,7 +135,9 @@ ell_headers = ell/util.h \
> >                       ell/asn1-private.h \
> >                       ell/cert-private.h \
> >                       ell/pem-private.h \
> > -                     ell/uuid.h
> > +                     ell/uuid.h \
> > +                     ell/useful.h \
> > +                     ell/main-private.h
> >
>
> this is the wrong fix. It will break in the tarballs. ELL will not install ell/useful.h ever. So every tarball needs to ensure that ell/useful.h is included. Which means you need to follow the fix from iwd here.

Are you talking about this:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=ed05585063f2e6d8f2fcd5f008b861062ac7a429

Shall we use the same mechanism to link the headers?

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
