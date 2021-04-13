Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15599C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4CD6128E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbhDMVZM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348464AbhDMVZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 17:25:08 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C474C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:24:48 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4157460ooe.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl7s6WDFgNqYx7r5mFxfo999afx2zjCYP912c6el3U0=;
        b=eZmD2lRGgi/bVfER9S1ZEmrzPG3jCgTLqw0s92jBPg1VZdlNVgZ7T5PGmzIawPzdTs
         rkce+JmVruKHO9omRoMgIOJGwpYoxrsgVVJCBct7v5hBYLAwEx/2w4Uc32ky+hadQqHB
         wFnjxFVfX4Jn+SFKVzrG/Gp0R1FyHkqwZUdCQ0sTWSyvc0Da2RD15WSbjZ4KBpW1YCNk
         Bi+oLSXoXEikJcdH2tU5uOiW4InVJHH0vcN97nnOFuOuL67gcVu0wbwuPXP27L7f1ncN
         JFkGr+RGwtGrLl+dPve0jqqjd7+D3foXPXb8Lf7nMUoM/1ZVL4SfoFhElbid9JP/Gpxe
         rZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl7s6WDFgNqYx7r5mFxfo999afx2zjCYP912c6el3U0=;
        b=qCOphbe0HalY2mumYCvzeRP4fvQj+BRLZM3hk7AMlb+zLoPXYzS888PsgyxjUI8bjN
         qmxSsX29rz4PILrCT/a5/NM0HHtO8Zv7Bt33D50QrYRgQR8gvsZ0f94+SUzU0PzYw2zn
         OUcMwhMoFPshPzMEHvAAfkoetd7LNa7KMsyJqQ/WUhQeXe5YAsVYzY2LG4s/XSlwrW0A
         yC+UdN91yuKbcvLDRrfi5UCF9MMa+C5w9zaA4U98kJKT5I7wSfWJO5gEjNx/B6Vt79bZ
         JpyXXFVfEyHfA3dUOeA+gJENET49Gq4d8ODoJbYOlH1Ysvog+CYGCIGKMMv9D7whUPY7
         Z9rQ==
X-Gm-Message-State: AOAM531kAzec2Rf3+aWzYENxR8HjZJtGjApfOBZUrZaFQrMYMzoqnIRU
        obgpQI2s11sgDyvT7hWW6zXfn+VatXAdwamFfxRlCCtJetE=
X-Google-Smtp-Source: ABdhPJwmwMvIFGYyjzkN78OWztODlpwQxJ2iI8ZDCrI2Q1j8VzJfoEMgkp1wLgmsF7c0RjRAD2FGvLLfJg12q7gT1S8=
X-Received: by 2002:a4a:c316:: with SMTP id c22mr28508797ooq.65.1618349087607;
 Tue, 13 Apr 2021 14:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210412203426.213872-1-curtis@maves.io> <6074b1ff.1c69fb81.287ef.5b83@mx.google.com>
In-Reply-To: <6074b1ff.1c69fb81.287ef.5b83@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Apr 2021 14:24:36 -0700
Message-ID: <CABBYNZJwrTWqPeU1khDMUj9m=bKXTo+u0CKG6skzNGxfoXxDNA@mail.gmail.com>
Subject: Re: [Bluez,v2] gatt: Either notify or indicate, do not do both
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Curtis <curtis@maves.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Curtis,

On Tue, Apr 13, 2021 at 12:07 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=465885
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.30 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      40.34 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.08 seconds
> Build - Make                  PASS      168.14 seconds
> Make Check                    PASS      8.33 seconds
> Make Dist                     PASS      11.23 seconds
> Make Dist - Configure         PASS      4.40 seconds
> Make Dist - Make              PASS      68.95 seconds
> Build w/ext ELL - Configure   PASS      7.14 seconds
> Build w/ext ELL - Make        PASS      161.10 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
>
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
>
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
