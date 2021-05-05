Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FA613D6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEEWUz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEEWUv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 18:20:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCC8C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 15:19:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v39so4765701ybd.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DJe5TIYQeg5VqcMzsPnQPLHEekbbgQXPelpcsaNN7lU=;
        b=E+z8Fc3bnqxmzyo71u07VgA4fcu6p9rl/f27I+Ku0uvGW2OtifV5JD4Swjk4Vzj3qU
         6s5zB9Utejdlbk6tWNPTwrIYKI5ESnwDGYQhsuZRQ+bV/cILb9FzD+zI4ZOp1z6actlE
         FYhVZ2aym/SkNufz2DYaQoIRqwCuA/fXVbSuuOe7/bhxyKSRTSSoDmjWHEBJPHo+c9bC
         5w37ZptBghRZGERx8Y0gUubGu1GUect6VQqtDd6cZbApyr5TE1mzkhNd8B+6qePsgF5v
         s+YiO0kuNBouY3RaEFXFRTgWN3k9XMj78GAyk+HhGt33v62GW1KxJPuQG+Q6ErIkGFed
         KUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DJe5TIYQeg5VqcMzsPnQPLHEekbbgQXPelpcsaNN7lU=;
        b=lzaD3oHlgBi9SkuxrZ1i+ocp6Ak6yurvUS/IM63TeA2KD9HoI//gOKY4uT4n1m5DXT
         j8ta7MMP8cSzwuR39p+OsAlER9390nfEeBNUoIuxSf2Ibam+sBvNhQIe9b9byKweW45A
         UKijOaeonPlU880GiWf5iVvhYIYrgp7lXqgaHFGDot0lNUdf7bvUHGrcxt6Z/bu/0Nkk
         1cEdnW+kw7sRelPnMGCNyEacHnNxhPrHCaYmppzxFfHifH9VZpZDOeRssCeGKrvrrQMK
         W+keC96MiQO5gpAo7oaU60rnt9Yzejblv4Iu2ao4vVgWh/3sXqs8qBYK0rt3ALPqs6gj
         iOMA==
X-Gm-Message-State: AOAM532vQiQ5QfJkWAaXuusUZ9KqfTRjBJoWE6hRRrV7Eh+5cPzLC4yQ
        1RhGRdQ/nUbo1g0EEnamT9K5k7XGDJer+r8WnY8bgrLA
X-Google-Smtp-Source: ABdhPJxWcn1ZOE+bZ9nyT46DXAdMy5NoUnkmV6AbunI8cJYO96Fy1jjBBgl7GIkqa3f5uhAztPjm0VJRIpBebi2KvWs=
X-Received: by 2002:a25:a466:: with SMTP id f93mr1364456ybi.264.1620253191863;
 Wed, 05 May 2021 15:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210501003717.7553-1-luiz.dentz@gmail.com> <608caffe.1c69fb81.c1efc.36ef@mx.google.com>
In-Reply-To: <608caffe.1c69fb81.c1efc.36ef@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 May 2021 15:19:40 -0700
Message-ID: <CABBYNZ+cDx6m1bTdO4WGpztioF6Yq-1CuFuB2qBmcYbsBdv6vg@mail.gmail.com>
Subject: Re: [BlueZ,1/3] avdtp: Fix accepting invalid/malformed capabilities
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Apr 30, 2021 at 6:33 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=475947
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.63 seconds
> GitLint                       FAIL      0.31 seconds
> Prep - Setup ELL              PASS      40.36 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      6.95 seconds
> Build - Make                  PASS      173.87 seconds
> Make Check                    PASS      9.34 seconds
> Make Dist                     PASS      10.67 seconds
> Make Dist - Configure         PASS      4.33 seconds
> Make Dist - Make              PASS      69.15 seconds
> Build w/ext ELL - Configure   PASS      7.06 seconds
> Build w/ext ELL - Make        PASS      160.06 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> monitor/avdtp: Fix decoding of reject type
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #11:
>       AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0
>
> - total: 0 errors, 1 warnings, 10 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] monitor/avdtp: Fix decoding of reject type" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> monitor/avdtp: Fix decoding of reject type
> 8: B1 Line exceeds max length (85>80): "      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0"
>
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

Pushed.

-- 
Luiz Augusto von Dentz
