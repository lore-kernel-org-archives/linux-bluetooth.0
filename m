Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68275C4707A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 May 2021 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4319660FE6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 May 2021 16:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEWQZm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 May 2021 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhEWQZl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 May 2021 12:25:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535FC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 09:24:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j6so34375263lfr.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcDBGL/ViOUuu39B8B4qd1g4NW5mYAVeEtxSwnGh5Xg=;
        b=dGnMdEXOlcH6zDhLvyOHwWEHGIzIc1DCN5g7C25tzVqtRuJ+6oKGnXAKB8uDgolcnD
         P2J0qsF+pWAmx0/rDFAYI45YIhcHkID0CEhBMdGwlINH0m2wzvhF1Lh0iy/BacZaD4NJ
         qHMT752weWa+oprSiem5cU5cZx8yH7HDNAXGJn9/XqXPYw6zBkC2ChD6kYzzxx3XFiAl
         O4F8BcyeTVQd5aAj5lMCo4iyDMSO1tEX+rtUebHg5jUZRxQmaFAfdXS1EXwjxpSPEfQI
         5x/bZiQF6xsWH5+c9/DRVh1Y3UfmBg0DCt94AkXWYGw9doXBxzz2ZldAPiRZ+hokz70Q
         gM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcDBGL/ViOUuu39B8B4qd1g4NW5mYAVeEtxSwnGh5Xg=;
        b=q2XG1D3Zvt0Ptm+JfSBCjW9bLPb0NsdRgZDW/d9dgxpPw/gg/8gtiq3frQ229hZMGM
         GYiPredxPGCqKZSfmfO6sNJxJ9V8FgftrySgdMHPTPSC2AdZFXkXtTM6hqNEyNKmOoSX
         +idRNx8y7y/bVsbNQG7U0sOrdBOARm7/096NUvFWVi9TyETvUWAJj7+R3i+3pT0TgyOh
         rrqhn94AvWjne+PjUrGXIrgS5c0LKG31F/upug9chkWbb2iUAVpg0O2TKuBB4cKBbxWD
         nRlQaDVHtM/d/ajk/fyqIepn7Gk5pzbNEXxNTLtyZltynZNj3NJGktp7ewEQP/f2Eixp
         0IMA==
X-Gm-Message-State: AOAM531Xy3AZ7O1B4r7R+8GGqf3yWSKF+Ti7OoL10FL9+mhWd3TDc6ap
        SCG+/QYgy/qp4PLX7eFKZxa7+GeAG9XZEsb0wtlM+cEUYz+4gA==
X-Google-Smtp-Source: ABdhPJxedbqlDAgNB4kBOC0JCrZ2wJtPM0XUbLNKrNIKkEDcvS4Unj1wwb4/r+XK789qe1F4F4XKj1QrTliHHKJXHQU=
X-Received: by 2002:a05:6512:34c7:: with SMTP id w7mr8404675lfr.82.1621787052895;
 Sun, 23 May 2021 09:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
In-Reply-To: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 24 May 2021 00:24:01 +0800
Message-ID: <CAJQfnxH8p+pffk49LTMN+JR2UvZwoOPTM_Dg44DCSDz3weOYSQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] lib/uuid: Fix string to uuid32 conversion
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

A friendly ping to review this patch. Thanks!

Cheers,
Archie

On Wed, 19 May 2021 at 16:21, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Use strtoul to prevent 32 bit overflow
>
> Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
> ---
>
>  lib/uuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index a09321dc6e..3d97dc8359 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -209,7 +209,7 @@ static int bt_string_to_uuid32(bt_uuid_t *uuid, const char *string)
>         uint32_t u32;
>         char *endptr = NULL;
>
> -       u32 = strtol(string, &endptr, 16);
> +       u32 = strtoul(string, &endptr, 16);
>         if (endptr && *endptr == '\0') {
>                 bt_uuid32_create(uuid, u32);
>                 return 0;
> --
> 2.31.1.751.gd2f1c929bd-goog
>
