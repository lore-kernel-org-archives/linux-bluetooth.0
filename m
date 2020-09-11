Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F118AC43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28A22075E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtHGzHGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgIKMwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgIKMuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 08:50:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30231C061786
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:50:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so11388483wrv.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHXq+qbTwT1oiw0iWkZ04umRIfDUZBSQvLrUtjixjAE=;
        b=QtHGzHGRHluMVpFObRS8xYeQNADcXN58be9Ho4YCS9cGv5yZyJIm6mRGBlBuliuRwz
         thjhLpUqfJok9kRurUrdVW+VofJUnJjv2WC5La6pSXDYIhWKrwxbxfoFPuSwyhGETisu
         TyWpRTnyngPZxRYSq9wNXMMglWrVTYTpP6d+T9pQ2s+6tJOYY4mdD1lEZPhXkpNYroHM
         0vZZzMsOefGtN425P+/8bXAIOXYG8bc4z+ArGCfQqizU9a/CJBxzx/f+lRuXrZtKYL2c
         z7BveapoqZUpqwWUTAcLS+ePQDGHfvmJ0b3F9V+QOjhMsxOrNkeqFyMT/LFfdRmgKL/W
         Tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHXq+qbTwT1oiw0iWkZ04umRIfDUZBSQvLrUtjixjAE=;
        b=GCjKt7vjdI3JFgM8d0Ni+s1T1AYSFJhT+STDF3XEd+tDQlVabYHIzOx60fZrJodGRf
         Nqc9BGB7cwimcnOry8sFTUO3yydxFy/opPoFCfFIChrT8G5a8RcJ+XY1jX/98g2FEblx
         n2uBDWoKndXnAXm6fMZE3D+E4QwfG9t4Yw752pqoU/SUcktV9F+4oA0SlFLezve9FYWc
         lCZhigwbtoCwvQbhalRi+oreaf26cBRYTFzsZ0Ego9yTENujqU2PDZeYLRVgPCG0B7AD
         62LfwzvkHqDWOXqW/miUDeSqPE+pfda6/I3Z2pth1TxnjfiPpkJB60jpyEpv2XO8W+g0
         s4MQ==
X-Gm-Message-State: AOAM533fdSmdVqKBlz1Li/O30kwH4jvtUlDMbpV3lyuxHhTmIsqkgf0q
        VSWA2CLL8kAA79u/XZJ0nD6/+v2arHxilCAkQ1K5/t/jxZR3+w==
X-Google-Smtp-Source: ABdhPJwqxbeXO3d2lKd3Bo2RUBD9VFkl3yBYi8Z2STHJhfinRqdeyGrESTFYSa6n7VQ0h5hX/hAIRkFnIhUstpjf3rs=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr1917679wrm.120.1599828618505;
 Fri, 11 Sep 2020 05:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200901115913.Bluez.v2.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
In-Reply-To: <20200901115913.Bluez.v2.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 11 Sep 2020 20:50:07 +0800
Message-ID: <CAJQfnxEx8E0Gt-em5CPX0hBRTkr_eLB6KSzyPoM17v=hrehaeg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] audio/transport: Don't set volume if it's invalid
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

Could you take another look at this patch?

Thanks,
Archie

On Tue, 1 Sep 2020 at 12:00, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Adding a check inside media_transport_update_volume to prevent
> the volume being updated with an invalid value.
> ---
>
> Changes in v2:
> * Move the check from media.c:set_configuration
>
>  profiles/audio/transport.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a2c4f7dfb..dd1c553a2 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -941,6 +941,9 @@ void media_transport_update_volume(struct media_transport *transport,
>  {
>         struct a2dp_transport *a2dp = transport->data;
>
> +       if (volume < 0)
> +               return;
> +
>         /* Check if volume really changed */
>         if (a2dp->volume == volume)
>                 return;
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
