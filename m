Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D58C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3C460F9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhG0WSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhG0WSA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:00 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EAFC061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 15:18:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v46so596328ybi.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGCwiPU3+7iN/YZTBh7199Tn/QpDqMh9eHwTpsbLn58=;
        b=lhI9aO3xcuYhtIo4IuxoE+0W1HcB1MJ3qMEuS1PZjfE9slRE0OHqAFiNguMqZvlema
         cytYP5xwaRF7yetFy6AjwlVGLPZ4BTh0Tn4GmMHOlSclDY66LaYuo2lQvqNzLszdTaml
         Tn8SWH6ZrTNLDmPODV+HCezSQWLmtJvCsoFfkj49aTBA41yKBDVxTfaybpgyGXIOFTfV
         sD6+jgruYtdTe2ACjMuSvNVlLMhAaJE6Be9Ob8WwTRY20AFqcm+TMDX26NADtcdDrwps
         aKcJU+BTPdbD17mwsJWE3YZOf8KLpCjgqmad55tMLGL4EJGahF4IIZzVrC68uaah9YMw
         WEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGCwiPU3+7iN/YZTBh7199Tn/QpDqMh9eHwTpsbLn58=;
        b=THk8PgdNmWL+wTh3gXsDYkHLhNstMTAT9MS4MHj/vcKHIFHYK+LXhtTYge5C8v1Lf0
         /nEyyty1ZTkh3KEirX9KoNLApqwlfvjqi2YWROUbqsIQ/ARk5RsNbVTOagW4qhuaNdeV
         hFZTiTECBf6TqcH1p/thn0dpxyXVJMHxmJeaTncjf6rEX+2AKvQKVeZvefyS5D0DhYmK
         NcG7cb2DGy/rh22idNEBT25HhBhLuajLbfqyCAo/pFZRxVZUh7QXf0U0F3kVKqMj61JV
         cwO3deGhgaC7onc/RZ1eYFrqlTQM7MUfUkPtS02gPxLD4YNywMWORU/cs6VDjCo7TbXg
         02BQ==
X-Gm-Message-State: AOAM5330ebQ4mkEr53LVMG6C9YkaGopIenq5T4RsgI5L7fozREkw1nKZ
        bpIdXrV/Cmx/WBoWcjMGwFSol5MF1ndNHETR8qQ=
X-Google-Smtp-Source: ABdhPJxnvGlZfx3iCYGXLzAhOSfDGZ2uqFoUAzywB1Xn3wGdRKlItm8l+30gtO8d9i6LdkphHD6M3JTnp/zu7YmUqUQ=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr35045810ybu.282.1627424279203;
 Tue, 27 Jul 2021 15:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
In-Reply-To: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jul 2021 15:17:48 -0700
Message-ID: <CABBYNZJkvaeuMJLKXueoLKq7hXBskxYSPbGujHEj72=qfF4+DQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt-db: fix service in range check
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Jul 27, 2021 at 4:53 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> If foreach_data->start < svc_start < foreach_data->end < svc_end,
> foreach_in_range runs foreach_service_in_range to this service.
>
> This patch fix the above bug.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
>  src/shared/gatt-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 8bff4d37aaa2..38d93f273a9e 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1349,7 +1349,7 @@ static void foreach_in_range(void *data, void *user_data)
>
>         if (!foreach_data->attr) {
>                 if (svc_start < foreach_data->start ||
> -                                       svc_start > foreach_data->end)
> +                                               svc_end > foreach_data->end)
>                         return;

Actually if I recall this check is correct, we want to iterate to
every service within the range of start to end, if the range is lets
say 1-9 and the service is 1-14 is still within the range since it
matches the range of 1-9, or perhaps you want to explain why that
would be a problem since that is not explained in the patch
description, if we do switch to strict matching it is probably worth
documenting that we would only match if the entire range of services
is within the range, anyway I would still keep svc_start >
foreach_data->end since that would stop iterating early instead of
continuing to all the list.

>                 return foreach_service_in_range(data, user_data);
>         }
> --
> 2.32.0.432.gabb21c7263-goog
>


-- 
Luiz Augusto von Dentz
