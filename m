Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4316C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3746109D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhHMVF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHMVF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 17:05:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442BC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:05:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p4so21273968yba.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vmRx6El3VbfLjuHtzx2CmbnNigmCrJvlDluROyANj5A=;
        b=oEbVFBzj+GtQiKEtQqqJeIJV7O1YLBCrTJgj0LKkH7XMvGwbroChug3u8gwq4Nlc99
         i2EApNkq2gx52UBpcnWN9UPoV9HLmQ434PgzdxKSLQFRm5v5HPPKV7fZbUNIeA0/O8yC
         rvw8MgBxF8dERuKPagsx8jkNUWyvgOB5+tfsJPHpegBYpOxR7vbGP9+tDiTwi/9V13eR
         mZtCsgQxIgv8CMlyP/trtq6xo3Sn3J/ARnOlmJfOUWk22HpIck4JHA+NHPpXxuVAAs3p
         tanC22XickM6eOw12KjLksAngZnHSOxVvL/fYumU4Qls4qn4PUVxRj/Rw0I4wi3zglyF
         1ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vmRx6El3VbfLjuHtzx2CmbnNigmCrJvlDluROyANj5A=;
        b=bMqBOk99cR0lTbYBisIkdNh1cQB4v5mQTPAAzio9K0la0r0YL2DK36c/ZW3pB/e3h1
         O+rxSHTbXGqR+4Or/W8JAWosMuV5tIt/ZSmlYbbAtxtex2RS5cR6vX17FpeBMIix0xOI
         3io0YNUY4UCDDgmRBh+AqSr8eQzLh10PT6CUWnC/3r1SFwn8AouG3GxHitEK7qMPAEk2
         PN7629evmrf2IyjXlGbcHHINqzTPPbFMrNp0Xn/wrVEZfYDR6HQLBYeN3iP34dFuHToM
         yGwuxRpL+6eOe5eSd9CHAesWWOI+oW6PX/oEct9LtnMgOKgVAnoYKfLAJQMbF5dClGxL
         VyUA==
X-Gm-Message-State: AOAM531JN416vQd5xu2dpM6NaxG1cGCexbZTs25N5Ie+OThC6jmi5Lbw
        NL1YQyCYEmeKOTH99oW5bzxMMq3+iCNeZrqw0Ka1RdTD
X-Google-Smtp-Source: ABdhPJzno2M5uv3mAF3CDsByMlQvYrx8EKmV2wRHe+M8F2BIlQW6PppG3DvJVbpzaApop7ewdP3MhGPhzOlAju/VEjA=
X-Received: by 2002:a25:d6c6:: with SMTP id n189mr5606580ybg.432.1628888700220;
 Fri, 13 Aug 2021 14:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210813005739.1043743-1-luiz.dentz@gmail.com> <6115c99c.1c69fb81.abacf.ae31@mx.google.com>
In-Reply-To: <6115c99c.1c69fb81.abacf.ae31@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Aug 2021 14:04:49 -0700
Message-ID: <CABBYNZLphWQZ2Zqp7FpiCiiOy8YUpfKoQUa6SKv4nhcKmO2w2Q@mail.gmail.com>
Subject: Re: [BlueZ] bthost: Add bthost_debug and use it on smp.c
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 6:23 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=530891
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.34 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      40.10 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.08 seconds
> Build - Make                  PASS      175.43 seconds
> Make Check                    PASS      9.31 seconds
> Make Distcheck                PASS      209.33 seconds
> Build w/ext ELL - Configure   PASS      7.18 seconds
> Build w/ext ELL - Make        PASS      165.35 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> bthost: Add bthost_debug and use it on smp.c
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(2, 3) over __attribute__((format(printf, 2, 3)))
> #163: FILE: emulator/bthost.h:31:
> +                                       __attribute__((format(printf, 2, 3)));
>
> - total: 0 errors, 1 warnings, 210 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] bthost: Add bthost_debug and use it on smp.c" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
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
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
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

Pushed.


-- 
Luiz Augusto von Dentz
