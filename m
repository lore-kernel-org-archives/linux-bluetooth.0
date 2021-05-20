Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E2C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE81611C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 06:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhETGsS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 02:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 02:48:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA7C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 23:46:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j10so550802edw.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VHR8dGlq9oUeqX9AB7vmimqVa0/r1GalRu9euSJsxoI=;
        b=fv97r4ZzKAEEAZWjTd4AbGAKYCufa2v+0UiDZGuz0ivwmob2+r4QmXHstns8zAK0SC
         0UXCZvpCU/h9WY/JYzBv35kwwY3oLECVZLWD4oyOTEWJ5bQ14flZnqndUR3+HorI0IHY
         UwjdTMw5qyxzKALkdWFp+XvaF34Y8wHDWvpV1LTdzfqiWs0Pmgc11f3icnGVVRXn3ygE
         5BPea0RgDOcYb9EaEpkGxiVxnkwsCSx2vnilx6XUf/gzabpT3/f4e8aJCPv+hfXIcKHz
         6xnOSj6cYCu9dx9GAv+0tUT1sSnCRfB/WM3DXwrfNDtoGwEYgc4XIV4cChSwVR9RWhod
         mAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VHR8dGlq9oUeqX9AB7vmimqVa0/r1GalRu9euSJsxoI=;
        b=GaQLgCtN4JPsYMj23+zyCFkmunRG/ovoZRFVvSO8DAci9nVCSHzXVEuR5XsnRfwhUA
         8F2CfGvy8nrEGAcY1yu62H9ntpwJYdCBFDyCYViLT5K+xR1qis5hlYo0XESu5V1++WDT
         BZJOwYkNakWeKsubRLBVdFBJVaXG9CWB69iqWxA71psqE5eilt12/qkfhCZNXO4KNgXs
         HaLe+JhK3gGZNoLPituFIgH1F1uDkl1zLjljKchm0qYiU33dBqyJ+ksPpYxhN8yfVsvy
         dOK6sqmIc3hs1vwj+qUxQMhupCO5LhzOdcvcaqgloK5NUEe+uQQ5It30yTbcen5ioWXJ
         2M/g==
X-Gm-Message-State: AOAM532/24hp30Or8y9/AAFtcDppg8sTwU2NbA/cDapLKKxaugQyI+ck
        u+j3GWZqzP1K230qBzkF3WNrSNoDiepUCRU5rAMS0D79bUK7Hw==
X-Google-Smtp-Source: ABdhPJyfn+YeO25rCFzOq2rqJx+Y8AOq1Kysh+Cxi29wDlnzdbvJWIvQtDWsxJ2SwZ1skWtg7dLtDohsJ8U9vLjc1I4=
X-Received: by 2002:a05:6402:12cf:: with SMTP id k15mr3319185edx.332.1621493213698;
 Wed, 19 May 2021 23:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210511152320.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
 <609a3528.1c69fb81.be1d6.e4de@mx.google.com>
In-Reply-To: <609a3528.1c69fb81.be1d6.e4de@mx.google.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Thu, 20 May 2021 14:46:42 +0800
Message-ID: <CAPHZWUf-yoBWGRtqHwL7sShgVpJT3UjRFT=sWK=g7TYnp6XuVA@mail.gmail.com>
Subject: Re: [Bluez,v1] core: Add RSSI sampling period in system parameter
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linux-Bluez,
Gentle ping

On Tue, May 11, 2021 at 3:41 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480039
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.64 seconds
> GitLint                       PASS      0.14 seconds
> Prep - Setup ELL              PASS      48.69 seconds
> Build - Prep                  PASS      0.13 seconds
> Build - Configure             PASS      8.38 seconds
> Build - Make                  PASS      210.10 seconds
> Make Check                    PASS      8.80 seconds
> Make Dist                     PASS      12.42 seconds
> Make Dist - Configure         PASS      5.25 seconds
> Make Dist - Make              PASS      84.75 seconds
> Build w/ext ELL - Configure   PASS      8.56 seconds
> Build w/ext ELL - Make        PASS      198.40 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> core: Add RSSI sampling period in system parameter
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #74: FILE: src/main.c:148:
> +static const char *advmon_options[] = {
>
> - total: 0 errors, 1 warnings, 93 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] core: Add RSSI sampling period in system parameter" has style problems, please review.
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
