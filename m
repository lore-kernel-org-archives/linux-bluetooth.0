Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9184FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5864820855
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgLVVSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgLVVSA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 16:18:00 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C2C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 13:17:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id f132so16122955oib.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRuL9BQhchjhxwdNRcM/iUBr+uZCI6nNE/ji7rn3sZE=;
        b=ecWmCrcPt1XQSjc0B8s8/T4urwG3tPxrMqAMaC3mK9loAVJkxVuuChpWYYmFCzehIU
         knpnfcGjhTyJ7E9otcwU6lYqzGMn6AbcqNE9UHtAv4BhsykEsONH8qJFdHm8IXYMSBo9
         HcjEy8UqX1Zsy6nMbBgf1tgCpW52b5wn+bI7QePk7aG4RWx5j+g5rjLMWFzrYbqzY5dJ
         ZmbJa/kImKji9g+NbbFCC1Dc+9hYI5Yv6PMmkSu7301qxDynaXpNGDAG5gSgRSmK5ySj
         sqoJktwf5tHQoK9xB4VPmQc/SetGwQMqYSkGKBRyLDaT15qy5hsLDyr5QQOAYc0aVBTP
         Khug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRuL9BQhchjhxwdNRcM/iUBr+uZCI6nNE/ji7rn3sZE=;
        b=TVKQ9xBwmhAqGWYae40mfXQccMaPnyuN5ku7feSl9vky3v1US1Cl6PKMpawMDgifwF
         A1+WI0x+6gqrzWbfFPECBL00l6VLplD0cwV7r6h9DIIWQPjlCpNhUs53dkB2+mnFDRfN
         taMR+NCgLVs13Wux8JwbVLgziPlgZyKZBnycRJPWv8Hb4hyWdVBUIRYvtmg0U+zfrV0v
         0Xky+8ZsETr16rrLRELul5y9aVyGlSLT5/Cz3SghugEx5dXOBQ2CDJ/2IU4jboopD8GT
         JDTWuA8JZAQkZGTKf+ypLfMHbJKLxV2vtie2Bl9+tATe8zf3L1MLbpS9IiYAFCwBstHl
         DX7g==
X-Gm-Message-State: AOAM532051y02CTMujA0lDUC0li2D9Foge6elTElXay6OU6/2kkO+8UL
        8LSzO0zKCuajkYBxFOns1Kf4iJlBjhVSpSH20SA=
X-Google-Smtp-Source: ABdhPJzQ55G+vANLyM4RsM5hLxna0TEeEqQU7tuwa85emD8GXH7JI2sgY1V0goUFN9y/Ed3aAtt3c/afVFobuWyH9W8=
X-Received: by 2002:aca:1917:: with SMTP id l23mr15668328oii.64.1608671839302;
 Tue, 22 Dec 2020 13:17:19 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
 <20201222110424.19368-1-marius@devup.no>
In-Reply-To: <20201222110424.19368-1-marius@devup.no>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Dec 2020 13:17:08 -0800
Message-ID: <CABBYNZ+=vC78xKmn=242+Le1w9f6Zg3srWLmvv+w+JYbf4q2Dw@mail.gmail.com>
Subject: Re: [PATCH v3] sbc_primitives: Fix build on non-x86.
To:     Marius Bakke <marius@devup.no>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marius Bakke <marius@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marius,

On Tue, Dec 22, 2020 at 3:07 AM Marius Bakke <marius@devup.no> wrote:
>
> From: Marius Bakke <marius@gnu.org>
>
> Don't call __builtin_cpu_init unless targeting i386 or x86_64.
> Otherwise we get an error at link time:
>
>   CC       sbc/sbc_primitives.lo
> sbc/sbc_primitives.c: In function =E2=80=98sbc_init_primitives_x86=E2=80=
=99:
> sbc/sbc_primitives.c:596:2: warning: implicit declaration of function =E2=
=80=98__builtin_cpu_init=E2=80=99; did you mean =E2=80=98__builtin_irint=E2=
=80=99? [-Wimplicit-function-declaration]
> [...]
>   CCLD     src/sbcdec
> ld: sbc/.libs/libsbc-private.a(sbc_primitives.o): in function `sbc_init_p=
rimitives':
> sbc_primitives.c:(.text+0x3a30): undefined reference to `__builtin_cpu_in=
it'
> ---
>  sbc/sbc_primitives.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index 97a75be..09c214a 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -593,6 +593,7 @@ static int sbc_calc_scalefactors_j(
>
>  static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
>  {
> +#if defined(__x86_64__) || defined(__i386__)
>         __builtin_cpu_init();
>
>  #ifdef SBC_BUILD_WITH_MMX_SUPPORT
> @@ -604,6 +605,7 @@ static void sbc_init_primitives_x86(struct sbc_encode=
r_state *state)
>         if (__builtin_cpu_supports("sse4.2"))
>                 sbc_init_primitives_sse(state);
>  #endif
> +#endif
>  }
>
>  /*
> --
> 2.29.2

Applied, thanks.

--=20
Luiz Augusto von Dentz
