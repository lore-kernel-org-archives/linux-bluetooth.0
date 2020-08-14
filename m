Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76205C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 20:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD162074D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 20:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbWjM8o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNU5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgHNU5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 16:57:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74069C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 13:57:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r21so8609062ota.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OTgAFgKEoxzSV29z4pMnxFk0J4VZgiMtd7nFNa4KdY=;
        b=GbWjM8o7D8CSRP4Vml3v/oCPfSfdOOJeQyzvnn/8jKkzkVn703MCxflUG6uCpTGRTl
         fI+wtEsCFjfnxHWWDTa24RZzNAXUZ4fC3fljQCfXjUahZzSefhdqtOPhsSrHEOCbw+tS
         LilN4/UMa5G1ubftgPFypu5DB1l6U24GP9fWCK2SVqJkF3OO/Ol4hdwzo9bV+BDiO3jt
         MZLwJyD44qgqZmiiEMLH7dL7LxfS20RjULVl0aV1bvuuUw1whaidvxxdyvL5K1pHd7LZ
         GJDgcImt8rdRua4i2Kmd9mhwCYxPyyorM/e/GK3R8uNBbWFiZ58z7iRapsAQJiuqpOgm
         mE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OTgAFgKEoxzSV29z4pMnxFk0J4VZgiMtd7nFNa4KdY=;
        b=kxiqfNEPy4Z9R8dY6I/QlHbe0SNl91I1uSS+ae8NxqoSqvyG+jTl2K2irZ8rh/uOzF
         FCS0ygK86Q4LZKMnBZ+5qlCu+80CaolORp8VfaUsobUjEMmOUFVlqwIqFjB9gqqvACHa
         ZHd9B1vDpZrKaXoLI5g7lKzRYZTff9H7/PKAIKmR/YDPChfSyxr/y2Zj8csN0Ryc/C62
         DwY758HT3U64ARz6u5CHgoFkCHWqjfL45sLy96ugBa1DDSMpnsqJxzzsAMqyvshgVKzD
         R9ak4kHCgxJUgWAMHDACmYMnHwM3g8ElFtc6+Y8cX++AsENISmaRSfrmCeaJh3yJHc3l
         5xGQ==
X-Gm-Message-State: AOAM531V9NSjsQcgd6u15QDJu8RJtfCEVHjUmlg10beUiAvkDh2987Zb
        c4wdD45Z9RsK1BdCeWV7VhuPeRY+fWdOTnXkAHxoTubxNQI=
X-Google-Smtp-Source: ABdhPJysemBbRsxg1OJi9T1j8NWw3ToQqNXPdzZcm+ECMcdcbCFo6mUDKLeb9OFCPcNw4uFN1dLk32gnAYvbwt+ZTEM=
X-Received: by 2002:a9d:429:: with SMTP id 38mr3079328otc.88.1597438623827;
 Fri, 14 Aug 2020 13:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200811181623.3683374-1-luiz.dentz@gmail.com> <93FEE5B2-F495-40C4-9386-E44DF132C49D@holtmann.org>
In-Reply-To: <93FEE5B2-F495-40C4-9386-E44DF132C49D@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Aug 2020 13:56:53 -0700
Message-ID: <CABBYNZK0mJCRpkAgKrWQ+TQJbrPDkzEX+AkTum62sUQR0Tw6mg@mail.gmail.com>
Subject: Re: [PATCH SBC 1/3] sbc: Add initial code for SSE primitives
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Aug 12, 2020 at 5:48 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >
> > ---
> > Makefile.am              |   1 +
> > sbc/sbc_primitives.c     |  20 ++-
> > sbc/sbc_primitives_sse.c | 361 +++++++++++++++++++++++++++++++++++++++
> > sbc/sbc_primitives_sse.h |  38 +++++
> > 4 files changed, 417 insertions(+), 3 deletions(-)
> > create mode 100644 sbc/sbc_primitives_sse.c
> > create mode 100644 sbc/sbc_primitives_sse.h
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 342043d..7ff0c7d 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -14,6 +14,7 @@ sbc_headers = sbc/sbc.h
> >
> > sbc_sources = sbc/sbc.c sbc/sbc_private.h sbc/sbc_math.h sbc/sbc_tables.h \
> >               sbc/sbc_primitives.h sbc/sbc_primitives.c \
> > +             sbc/sbc_primitives_sse.h sbc/sbc_primitives_sse.c \
> >               sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
> >               sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
> >               sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
> > diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> > index ff343cf..97a75be 100644
> > --- a/sbc/sbc_primitives.c
> > +++ b/sbc/sbc_primitives.c
> > @@ -33,6 +33,7 @@
> > #include "sbc_tables.h"
> >
> > #include "sbc_primitives.h"
> > +#include "sbc_primitives_sse.h"
> > #include "sbc_primitives_mmx.h"
> > #include "sbc_primitives_iwmmxt.h"
> > #include "sbc_primitives_neon.h"
> > @@ -590,6 +591,21 @@ static int sbc_calc_scalefactors_j(
> >       return joint;
> > }
> >
> > +static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
> > +{
> > +     __builtin_cpu_init();
> > +
> > +#ifdef SBC_BUILD_WITH_MMX_SUPPORT
> > +     if (__builtin_cpu_supports("mmx"))
> > +             sbc_init_primitives_mmx(state);
> > +#endif
> > +
> > +#ifdef SBC_BUILD_WITH_SSE_SUPPORT
> > +     if (__builtin_cpu_supports("sse4.2"))
> > +             sbc_init_primitives_sse(state);
> > +#endif
>
> lets keep the ifdef in the primitive functions they belong. This should be consistent across all primitives and not spread in two places.

I guess you mean moving #ifdef SBC_BUILD_WITH_SSE_SUPPORT into
sbc_primitives_sse.c, same for mmx, right? I will fix that, although I
was thinking on not even compiling those files when the config option
is not enabled which would result in undefined symbols, I can however
have alternative versions when its options are not enabled which
basically does nothing.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
