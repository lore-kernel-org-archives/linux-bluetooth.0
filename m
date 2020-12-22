Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20774C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 01:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6C122B3B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 01:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLVB63 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 20:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVB63 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 20:58:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC7C061282
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 17:57:48 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d203so13326889oia.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 17:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tEzG8mU/H/GM0H8Bs5Y0ZZ3bxMatpry/ISQJUr41xBo=;
        b=W/E00IDM9UcYOJl/2na6TDAoOzDjSmGKKR8y0sUw6eWgo3eESHPUwkNmg5pD5d/XMb
         vLMzN4s9HvZ5pgcE9PogP7BzocoHX2wCKEjnfOiW69vl7UX+n+DEcLEIyAN/bAoGEzJZ
         XR09BIzNdTcIyx7TXarz42leUm80K8geAVhOkLrZOz/deNhOGX75bjKzah5Hl4hYYu/P
         C3kVO0mDU4Qqz75CzDbGQBoOFkb5Gz6xi9fqBstaScBVs1HU168y1A1lvKHH6pElsGLt
         iA4OYdbnMXx37CxANwW/vD+5VlWZJWKuRgFq17JAGk/2e56mE6x/K92e96Wytl5TuME9
         cFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tEzG8mU/H/GM0H8Bs5Y0ZZ3bxMatpry/ISQJUr41xBo=;
        b=lX2eheJb1IBxxpZ1HtLTi938RIcWzs77eksUPwlYDln1AIaPbDR+TpLFHENpfpxrJP
         z/weM29DWikdvyaVU8pEJw+HraFO26Lbl4STdIhMLFZDmHG1QjLy1OgTG/RIjSZpwqwG
         yEMZBbM/Z7wmrsMygsDMX8Snxvb0g1ubQIRIA3Tg1oEfRwHspt/ve5t7Z6irLr63/xQr
         bf7XnwrACtCTnxTEsJyjRh8L7Z6e9QMvMPB0ukXVh03jM+ACKj6lSPkRR4/lgefDXoKl
         9PahQ9pARESHxw1Pc2Co3eE06LvFOXfDZv7QKWngn72J0uekDo8sjtL+GFttq155ChOJ
         b7ow==
X-Gm-Message-State: AOAM533xhClf0vQnHOJ/XaM5c0O0VRBorqCsMzXYJstmbczb/DSzOIbg
        Va5NCRtX8PL7kF5wZbiEVVgKFM0yzUoiP9Qzmk0AQhSm
X-Google-Smtp-Source: ABdhPJynIQP0wG9THXi4eVJN4yIDJsFq8tImoucT87wlkdvti0XqJmEy7Oj3j0WpYJKTRyJZwd4f2yEMz1f9v+kgrL8=
X-Received: by 2002:aca:1917:: with SMTP id l23mr12991794oii.64.1608602268424;
 Mon, 21 Dec 2020 17:57:48 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB51269918A2B84A3120EBD8E4D3C00@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20201221184114.1300-1-marius@gnu.org>
In-Reply-To: <20201221184114.1300-1-marius@gnu.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Dec 2020 17:57:37 -0800
Message-ID: <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
Subject: Re: [PATCH v2] sbc_primitives: Fix build on non-x86.
To:     marius@gnu.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marius Bakke <marius@devup.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marius,

On Mon, Dec 21, 2020 at 10:45 AM <marius@gnu.org> wrote:
>
> From: Marius Bakke <marius@devup.no>
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
> index 97a75be..d8e166a 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -593,7 +593,9 @@ static int sbc_calc_scalefactors_j(
>
>  static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
>  {
> +#if defined(__x86_64__) || defined(__i386__)
>         __builtin_cpu_init();

I would probably have the entire function under the #if here.

> +#endif
>
>  #ifdef SBC_BUILD_WITH_MMX_SUPPORT
>         if (__builtin_cpu_supports("mmx"))
> --
> 2.29.2
>


--=20
Luiz Augusto von Dentz
