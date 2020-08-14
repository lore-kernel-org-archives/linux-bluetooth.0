Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2974B20675
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsDhPO8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHNTuB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgHNTuB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:50:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B1FC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:50:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h16so8486722oti.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3pZPWea4SVUhsA9E1hMWz0vj5oAgMBKq/U07Pmy2vY=;
        b=LsDhPO8ahOZ7WNKe7Ym4bWtLQGvbUiExDsIS1kWrZPpbDev3ce4hrtV9chbk1tIE4J
         r/J8ho4TThlutF4+NohZ8DXMk/UZGro87lX0EVwXXSUIQg71Kx1ZKTVUdlJORVi0iVA6
         SPjtHGkHIAw017SRLGSCODs6TErTxgEXcG80nlU1HI4SCm9TD/rB36sU0SnCLlVt4Pi3
         zz70Bj6oXUS+wyYSol38cdzhI0hZXo77BP+0kXYhl29+X7919oDdEi0LgO3OksZSNV9b
         RjishTVts9xZVMW7XmvQq2MAsG1/FDEXBVy5CIw8kSVXAkzik2i/TUVwRbEhLBTq5jQc
         /1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3pZPWea4SVUhsA9E1hMWz0vj5oAgMBKq/U07Pmy2vY=;
        b=qfNI4xadBDf7XbDVZNJmDucY9Ll93xmKvLWSafex7MMcKB4UY1eLSJ7BtvBnjbyxT+
         Ur3RoZsQO9DV22Z3EU6JwYPWSQoq+cJszreE5aEA1eoTAFY4VVA5gSSMcnG0s6YNCCTs
         LXacYyTENf/yXRekiB2zDWEfAtQUFlQ9NricuAbG2nfmeEbh9VlBx3gz88HC2TP+lqXs
         UHPr9yo0Gt1qqDE2mieJblqYKXEBAVfafBcD3tYEPXmWXA4FgKb2Bf7h7F13Y5/sip4J
         w20Vvc0q/GhEJfxHjn/BwFc88VvINRULaCP9OlcVe7h0ZDkPp8XOYC9MBy3lvqly6TM1
         4uQQ==
X-Gm-Message-State: AOAM532Uq0dN/SgNvHaa0l0IuilX92RflbA0g8W/X682eQ0Wyeu1Vzuv
        fz6jvM4BlQWkU/CZ9EG+ixa8azp0Xh3FWzk72Aw=
X-Google-Smtp-Source: ABdhPJxTDWUgfYrBZu3CStfX8xrinT4Q58vGDPAta0JtFOl1fflG/f9gkQ0fIzB4pHbfCCN3XO7SLVLwQq6uOkQnkRo=
X-Received: by 2002:a9d:24e7:: with SMTP id z94mr3076355ota.91.1597434600725;
 Fri, 14 Aug 2020 12:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200813233952.BlueZ.v1.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
In-Reply-To: <20200813233952.BlueZ.v1.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Aug 2020 12:49:50 -0700
Message-ID: <CABBYNZJeK4W2a3JLRZdXD=0bupY+V7DBGEtWiBpaycjWVKcy2g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] shared/ad: move MAX_ADV_DATA_LEN macro to the header
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

On Thu, Aug 13, 2020 at 11:43 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This moves MAX_ADV_DATA_LEN macro to src/shared/ad.h.
> ---
> Hi Maintainers,
>
> In order to avoid duplicate definition of the maximum data length of
> advertisement for the following series of advertisement monitor API,
> we'd like to reuse the one in shared/ad.
>
> Thanks,
> Miao
>
>  src/shared/ad.c | 2 --
>  src/shared/ad.h | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 8d276842e..6d882a9b3 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -33,8 +33,6 @@
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>
> -#define MAX_ADV_DATA_LEN 31
> -
>  struct bt_ad {
>         int ref_count;
>         char *name;
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 19aa1d035..dc92c89bc 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -27,6 +27,8 @@
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
>
> +#define MAX_ADV_DATA_LEN 31

Id suggest renaming this to BT_AD_MAX_DATA_LEN or something like that
so it is consistent with the prefixing we are using for bt_ad related
defines.

> +
>  #define BT_AD_FLAGS                    0x01
>  #define BT_AD_UUID16_SOME              0x02
>  #define BT_AD_UUID16_ALL               0x03
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
