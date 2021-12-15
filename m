Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF4AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Dec 2021 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhLOWxR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOWxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 17:53:16 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D06C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 14:53:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so59283236ybg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBClSXSwxjYPaeVzUg9SmSnwkZIU2xOzgThCTCtbPHM=;
        b=G8wJ0Ok8t37o9+OQaAeB2pyxy+2NRZVeBQlBRb7K0fI92ud/fccwEh9PxWPkyZTnLl
         SWrGkM/OJ/b8MTnM9pN/Skac/KEwGey4bT1NfM2F2ssiqftr6aJgCF1uG06KHsLOy8P3
         rZK5gccR0ewpkHbL84P+DlylovDxUyuwJfK42IyNRHTDxjJVpFSz2DdIXSmlH4LlLG0e
         /bMxdstBsiT4OyqR6MLJQubfQXJaivDnfzDl/EkLZ+yWxvjvWjSgfC+1SOMRkW7s0i6y
         QDa1hXIe38oqcYMEwmSCF12wL5/s6YWgjifuirRMZUY3r5U8q3Lk3fXDOUnNnTPJACUq
         k5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBClSXSwxjYPaeVzUg9SmSnwkZIU2xOzgThCTCtbPHM=;
        b=xlz99pHW9xstVx/HPpUQn1rj0Bz/nco2PkyLj1B6Y/xdRXMzc6o+9vyNQ5bRXZSB3A
         Yyl8JgzC9kCQvz59F20t++cj6ZAcx5kRIOZU8uW0Pz/3BJ74o5ZBY+H7IS+16mzSz4A2
         xUPrzTv4j9fiEehQ8F1kfGWm0W1mvOnL5n57n8jEfRPYbomneaWVZF0BGhGPP2tBSiIm
         CNrSn6D3wlw4UU8kdoevWC7sd2pFfIkPtkxCYbGNhudXollpip4YvEbsJH0ZhiXj9nVE
         Elot3kXAD5Ep3bWYve6EWlfgh0qzjdU+GruxE1+cKfwoo7eRyY4tcNIUC498BryVlJ1b
         ZRFA==
X-Gm-Message-State: AOAM533SVsKMvf+BjF1YFYweU7XrVdtJUDhB1qLubbBYdfKaMXfssHQR
        BAestvh+J8jHvdKlezdbrQwwunS4s+JWI8PybSHLVYYh
X-Google-Smtp-Source: ABdhPJzJLKgCSZZS3hIy8xE3GosL2epv4aDd4R2vzs4beVShiXvO2DO7L9hE7/r1/yyALKZzNl9Di5M1QxfOAU4Gw5E=
X-Received: by 2002:a25:2344:: with SMTP id j65mr8726918ybj.293.1639608795107;
 Wed, 15 Dec 2021 14:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20211215180527.886481-1-claudio.takahasi@gmail.com> <61ba372b.1c69fb81.82f24.9d4f@mx.google.com>
In-Reply-To: <61ba372b.1c69fb81.82f24.9d4f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Dec 2021 14:53:04 -0800
Message-ID: <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
Subject: Re: [BlueZ] advertising: Fix reporting advertising properties
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Claudio Takahasi <claudio.takahasi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudio,

On Wed, Dec 15, 2021 at 12:50 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.47 seconds
> GitLint                       PASS      0.99 seconds
> Prep - Setup ELL              PASS      49.04 seconds
> Build - Prep                  PASS      0.61 seconds
> Build - Configure             PASS      9.40 seconds
> Build - Make                  PASS      209.53 seconds
> Make Check                    PASS      9.37 seconds
> Make Distcheck                PASS      248.72 seconds
> Build w/ext ELL - Configure   PASS      9.46 seconds
> Build w/ext ELL - Make        PASS      198.40 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
