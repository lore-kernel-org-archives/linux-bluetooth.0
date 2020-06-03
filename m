Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6939EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A3120734
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJMy/dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFCVHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgFCVHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 17:07:32 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83597C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 14:07:32 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v3so821204oot.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5FORqc+EUVb5WlGChJvjWCJ0ixpP4w3mh88Usd214k=;
        b=MUJMy/dRsFzl/FjHZLZhQprwk8Kh1Adad2oCOCBAgqD8oxZcx1NW80fFLr4X1bVj/9
         ntM8W7++0suQIo7MRzKxyvXuxjSWujG1W4UtmPzEXFVvN9euvnAIP3v4w/9rkuH+DwnJ
         bZeEHIJ/EW5Dyn8c7ghpBNGeU7XKdIrz62C6vf30UVrTrcQ5RKVX425YojGzbTixsZnc
         lS+iR1lfNkuH0cfHcL/zp/ghthDwV8O3xn+SULVQPoDrlHxJDAodEXUoDdo1tVIZyZJO
         wBo8QQqaoX9zw6svJnoemN8IPKCXl9qJvPofNstroLuoOtIE7J6TlfzqXYXPg3nHQK2Z
         aWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5FORqc+EUVb5WlGChJvjWCJ0ixpP4w3mh88Usd214k=;
        b=oroI8xMtTk1n5fjIjc4GL7KSD/Rmy6oKfgMIRtHCFJSHettSLTPaVR196nV1iYm3X6
         oMvOb2LepnHEjdC7f22mq7nKJ0SXsD0aS894xHXduJ8iBlCyD98DrxLw0HD3Rv3PGZSj
         /Xf+OxyfUsC5lDSAf5koKzG2IO+QgKlrTGyJ2xkN/lN89aDX55XKEp3TVLAs+dRqltSl
         9bH2ORb1JtpB2uXhaSBNHLrFH4dclz4hzQr23hIlyttj5qAxxb4WjXUiJBlsNLarW6qk
         mz4VJtbrBlY9xKHmIphJmLiMVI3UGYAbdrSidAnaw6vkQTykJ2Om+u84+unKXHQ8jwtk
         rclA==
X-Gm-Message-State: AOAM532iy0Uj3LKIvDzTCVyrIUnnircmNMO5pwH2zGhrNWlzNSO0g6PK
        ULs+GuMOr8E7Gr0SRmEqXrsMXMErl7bXqwE12xtRqg==
X-Google-Smtp-Source: ABdhPJyCjg8JTU5l7V/izxYMqPFCPMeT8wkhx4dvAUpuocqzF9GYdcfR5L8ArWkEuZCbDYLwfJwfhMnbm82F3bCk9uI=
X-Received: by 2002:a4a:3811:: with SMTP id c17mr1378508ooa.91.1591218451881;
 Wed, 03 Jun 2020 14:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200603175600.3006-1-sonnysasaka@chromium.org>
In-Reply-To: <20200603175600.3006-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jun 2020 14:07:20 -0700
Message-ID: <CABBYNZ+Z4L3hR37mEhyHTHQdGYRj9vMiNL4Wy7fSeBZmZjuU=A@mail.gmail.com>
Subject: Re: [PATCH] shared/util: Fix undefined behavior of left shift
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jun 3, 2020 at 10:58 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> When left-shifting 1, we should be explicit that it is an unsigned 1.
> ---
>  src/shared/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 330a0722a..3b976fa16 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -140,7 +140,7 @@ uint8_t util_get_uid(unsigned int *bitmap, uint8_t max)
>         if (!id || id > max)
>                 return 0;
>
> -       *bitmap |= 1 << (id - 1);
> +       *bitmap |= 1u << (id - 1);
>
>         return id;
>  }
> @@ -151,7 +151,7 @@ void util_clear_uid(unsigned int *bitmap, uint8_t id)
>         if (!id)
>                 return;
>
> -       *bitmap &= ~(1 << (id - 1));
> +       *bitmap &= ~(1u << (id - 1));
>  }
>
>  static const struct {
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
