Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A7ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F9F20B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAM60LhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfJIPBb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:01:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44672 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIPBa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 11:01:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so1968342otj.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPmZjbMRO97076yxan4uJRu96cxZv8ENuVLRa5136I8=;
        b=SAM60LhJ/6nE7ZwwBBZ4BaSnF84UpFNTzH3kM9XGDVuZJHO/qSQBj0nlYEevAwZ1nM
         h/Ayvr6J4eYglC3cyWlfZaNSzpGxI0JOthPzbho36iB4vIoiAWQPvWpxsMOGgr9kPKbW
         sU5HCWTEyV5HE8EiasnNmf2pkaX5qd+mquz9ntCckQ6rid7L8YQCXyHiP9/0uwGS04FK
         KXYPnXrXxSxvaprk85aBtgO45SiBOm7gwgMJIt+PUbFGyTVBFw0ikw6YMSPkmwvEptRL
         iYwGTefPh6Tm8Pfmls+MX9Ij74aDwP5qSUlgURdAe2G6Hc2F0vTNJ5ssnBWWpTQDwxWB
         Afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPmZjbMRO97076yxan4uJRu96cxZv8ENuVLRa5136I8=;
        b=MRwGhFmSBoI8MKoGbfUirQfJJeZMVVLnFkBZtMsI8igwzYxJqUwMpJHE9HFPbbA4k2
         YUAIOsJ7h8b71yhCLUUBhswiRGIqguq+nOplLBghwcG2wpj+Gk12PbRfdBWJ4iVr61KV
         Syjg3YGXVK8jvZyin4atoFevbet5VkBqwWzPh6u3H1wov9zLT9o+5zjeef1whBKekppG
         n5yUc8+ltn4RREKmB8xkfA8wqaDq9L2XmLnLe148hy30jrZ11nL47p9qdT3NpQhHStDz
         ofgoUhaLORA3q8MYZ/pQlAd65Jc9+ZeMsHWAvNhrFsl1K7dU0p+bBn76sfGrlTnU2VBW
         zRPQ==
X-Gm-Message-State: APjAAAV0/KkrGxzytuEVxlX6FVmJoxoJ2mVZ2Qc0qbIXTz996FyaTrjz
        vFb6KsgwT0V90PT3rFxxX6LefObihZuvpOpUxMYA8UR/xfU=
X-Google-Smtp-Source: APXvYqzCfJTH8+/tB5/SfKtZwsrnAQ4AhxN1i3qT+taa33i/xiedjt4J1sC0oKewwTAn4BzxKIYOandWebhjhac/W6A=
X-Received: by 2002:a9d:7842:: with SMTP id c2mr3120749otm.177.1570633288525;
 Wed, 09 Oct 2019 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191008095832.3473-1-ross.burton@intel.com>
In-Reply-To: <20191008095832.3473-1-ross.burton@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 18:01:17 +0300
Message-ID: <CABBYNZJpmJARG9Qi7HFtPJAvoNFHDLcr3aw_gU7wwoXsp6pZUw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Makefile.obexd: add missing mkdir in builtin.h generation
To:     Ross Burton <ross.burton@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ross,

On Tue, Oct 8, 2019 at 1:03 PM Ross Burton <ross.burton@intel.com> wrote:
>
> In parallel out-of-tree builds it's possible that obexd/src/builtin.h is
> generated before the target directory has been implicitly created. Solve this by
> creating the directory before writing into it.
> ---
>  Makefile.obexd | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index d36874770..de59d297b 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -104,6 +104,7 @@ BUILT_SOURCES += obexd/src/builtin.h
>  obexd/src/plugin.$(OBJEXT): obexd/src/builtin.h
>
>  obexd/src/builtin.h: obexd/src/genbuiltin $(obexd_builtin_sources)
> +       $(AM_V_at)$(MKDIR_P) $(dir $@)
>         $(AM_V_GEN)$(srcdir)/obexd/src/genbuiltin $(obexd_builtin_modules) > $@
>
>  CLEANFILES += obexd/src/builtin.h $(builtin_files) obexd/src/obex.service
> --
> 2.20.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
