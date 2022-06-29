Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC272C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 23:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiF2XtX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2XtW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 19:49:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E831FCE7
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 16:49:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y16so6870223lfb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRqKGZIPCwJu9Mb6nlFshvHpgNgTRDaT54Kj8uGI4Uw=;
        b=EEEALgMH/YQ8H2M+TKFukr1cAUwCRnMsSrBExuoMXP6EXtxasR6ZA1uFxn6YYYa+3K
         0R2PqdoquHtTTBzs1AQY1DCqn7dJEBljdUomrEG/vZynajDI+NZa47WyyWWx6q0P9z+N
         sRwI+KvV8CLhMXBuRZABVe86KnsTR9Qd98RJZoQ5FPdEO4iBuAxjexC9ouqqSBLg0Bzh
         E1PkkFkCq2wEfX4u7B/s5E51QGmbmLgZ1dPqF9HtfxFlHpCiC4dZjFwPAWKc/MVTsHrk
         a7jEVSNwQedFAhOfpRT6jQzU+EC7WZndrLxxH11CKUDk/aXqmL9cGrtlzi9PBxFnTEgX
         fguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRqKGZIPCwJu9Mb6nlFshvHpgNgTRDaT54Kj8uGI4Uw=;
        b=VX1tEsx/lKvHt8noXPctkMRufn2Ff9NwTnsZ7f1aaonVpY92CWZ51XPHnO1rXeqJLK
         wub1iJy9yey/Ex6fu+mJ9H3pfneweA4xIFempcaKjLjgQ5c0fElgNgfy28Cbq37t9cek
         N/BM/u5Cnr4pGANKKWVI7V7nKYyUnJql893NLOgMdll4ujB0wQGfn27Rppu3cQZDLJao
         XKpLZkNnXbA/Z/VT34JB4CHPSeR/qn6yVL3pxYgXBip4CSSrF90cQ6+QTlD2r3OvXihU
         5OtjT2mGyjm6Iq6RIpbeGj7HAcBB+g7niUgG6y/mkyF+kIMqfFB838PvdC76FPDSrtOA
         5/EA==
X-Gm-Message-State: AJIora9RJhXiV65Oyd8JSl3mFYh6/fl1r/fkOnmnYdWTJKvaShnNnsPb
        XyTs2K0ERjxrKfCFaOosHmTOfqZ4Y2NZexJP608=
X-Google-Smtp-Source: AGRyM1t3VIwNGiCAP7EWZ2hjGBKA+i8hnpl7cUnzOQWSGS2JnS9sfs81YBSX9bkDOQKuRa0SetLzQlamWgl+a7Lf2UA=
X-Received: by 2002:a05:6512:2392:b0:47f:b8f8:5052 with SMTP id
 c18-20020a056512239200b0047fb8f85052mr3577828lfv.106.1656546559848; Wed, 29
 Jun 2022 16:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220629191943.17326-1-brian.gix@intel.com>
In-Reply-To: <20220629191943.17326-1-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Jun 2022 16:49:08 -0700
Message-ID: <CABBYNZLLy2oo8E=1x-TnqLth=0H64qFyWPGrqYDJhtQ5cTpFgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: fix usage of size_t %z formater
To:     Brian Gix <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        luiz.von.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Wed, Jun 29, 2022 at 12:49 PM Brian Gix <brian.gix@intel.com> wrote:
>
> Some versions of GCC use strict typing for the %z formater, so passing
> an argument of type uint64_t instead of size_t throws an error.
> ---
>  monitor/l2cap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/l2cap.h b/monitor/l2cap.h
> index 00a8ffbbd..86113e59d 100644
> --- a/monitor/l2cap.h
> +++ b/monitor/l2cap.h
> @@ -291,7 +291,7 @@ static inline bool l2cap_frame_print_be64(struct l2cap_frame *frame,
>                 return false;
>         }
>
> -       print_field("%s: 0x%zx", label, u64);
> +       print_field("%s: 0x%zx", label, (size_t)u64);
>
>         return true;
>  }
> @@ -320,7 +320,7 @@ static inline bool l2cap_frame_print_le64(struct l2cap_frame *frame,
>                 return false;
>         }
>
> -       print_field("%s: 0x%zx", label, u64);
> +       print_field("%s: 0x%zx", label, (size_t)u64);
>
>         return true;
>  }
> --
> 2.36.1

I suspend we need to use something like PRIu64 macros, like we already
do in some of our code e.g.:

src/adapter.c:          sscanf(rand, "%" PRIu64, &ltk->rand);


-- 
Luiz Augusto von Dentz
