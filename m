Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F1C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DABE22208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk5XAoHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPXge (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIPXgb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:36:31 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC7C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:36:30 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v20so321424oiv.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEEqKPIelJrYe7KB747zLJeJa6uzs/9sM6BKF6loCK0=;
        b=Yk5XAoHKQJHShNP7OnJHXxIOT0dp2+SmDYvczGF/ih5M+zSRsYO2bzGkToWBAUgp5K
         Hny4d+b4P0TSB8AOPrtxQ2fG4mOD5S793ObNpHHO1MFh+gq0WuIMQF7DF5/wrjoIcCqM
         sJgMr4Jd02X/KV9/lNwAyJFarJHrZVfj0jO9NqZ7rZCryxXHNY8u8e7d+VKZ9HYQr8wQ
         NTKGx+6BBnPEhTwrdji4EAO2zX6yzetlS5do5yF/6u/iO8E972SO3STERFS4m8j7jI1j
         1hmJ0KWLrQzEqmboL4R3fscDotoIyXZRdqM03bHgpRZbtDxHCzwKyCdaLNfI1c5ascrj
         aorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEEqKPIelJrYe7KB747zLJeJa6uzs/9sM6BKF6loCK0=;
        b=jJ7gJjftLOaQGnCWtYMVR+CB9VIbACIQoAEbQuAieY/8usLyP583tXhq1S8oAU7SjW
         5xGzcJduWWVe6jDKaMJ3r45Yy6gAjs69a5Bi18JhNdR3iTYS71QY8DP5g4FhNFNzmWN+
         tN6gSSed1BAVdpFhAwCx7u+5EO3H4P1xD4UhTEukZC4elpcmU4FULirMuKRC+qFhTHRO
         wmsYI2f7bNzxPX7iMiJoB6JryUDgNkbbEqGw/DKyuJl8TP5elGuu1mHDB5SM/5Z8lJEY
         BIHVvG0LLPkE+iICykr8AsP33goEqoVe+z3k7WGWasWI2b7rVaa1anA1B76u4cReT/Dl
         hL3A==
X-Gm-Message-State: AOAM533ztmMd43/n9T6mISbgpdDT8aH8D/Y/w8r6ypk9Q8jwaKCRVd4g
        mBlyzvERwwSedcVAGtUPL+2FzraZCBZl/LRhFlCRunG1
X-Google-Smtp-Source: ABdhPJwVMaS92EjHb3dCx4HGB12tJfy8nI/CMDc28j286BZUwfZiPiT9YyMqZlV9Kxc8mSja1oeSpuglHC7/XDwJ7jQ=
X-Received: by 2002:aca:38d7:: with SMTP id f206mr4278793oia.48.1600299390104;
 Wed, 16 Sep 2020 16:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232924.129991-1-sonnysasaka@chromium.org>
In-Reply-To: <20200916232924.129991-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Sep 2020 16:36:18 -0700
Message-ID: <CABBYNZ+CVzVW+L7eC3=f3siDZwqdpxecZ7r6oZ410MPhqj2omQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/coding-style: Allow spaces after tabs for
 indenting wrapped lines
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 16, 2020 at 4:31 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> The "only tabs for indentation" rule was enforced long ago to align with
> Linux kernel net coding style. This is no longer the case today so we
> are relaxing the coding style to allow spaces after tabs if it can
> increase readability.
>
> ---
>  doc/coding-style.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/doc/coding-style.txt b/doc/coding-style.txt
> index f0bf880e3..6a7415847 100644
> --- a/doc/coding-style.txt
> +++ b/doc/coding-style.txt
> @@ -104,9 +104,16 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
>  void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
>                                                         btd_adapter_pin_cb_t cb)
>
> +5)
> +void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> +                                btd_adapter_pin_cb_t cb)
> +
>  The referred style for line wrapping is to indent as far as possible to the
>  right without hitting the 80 columns limit.
>
> +It is acceptable to add padding with spaces after tabs to increase
> +readability, for example to indent function arguments at the parenthesis.
> +

@Marcel: Any thoughts on this change? Id like to apply this so we make
the life of people contributing to both kernel and userspace easier.

>  M5: Space when doing type casting
>  =================================
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
