Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C76C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 21:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51ED60F5E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 21:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhIHVPR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhIHVPQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 17:15:16 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491EC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 14:14:08 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id d7so1250609vko.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ovi3EmYy2hCZfAntPoqHPTZ8oOnPqPlOA/UGBACHokQ=;
        b=iPnPJXStQhQS6GgaVQKiHN6ds5btj6ybROr+EsNR6xEPThWbpGl4o3fZC7Bz5mv3HI
         cKrI3wdWPAs7kilRxTAbpLUyhvB8eCIvXr6VKHoR7Xlo28VlsGbVjj1UQtMShaA5OQFb
         iXggTn6s3XW4sgQFQ1q2AEsu2D1d3BBvRit1yFagp1J56qkjxBVhltxbQ/TRsXPGSANS
         IerHBZiUzaLsaLcpz2O2D2yjBEaBeed4oRdmfv1XENieqnspRx4/Z/dA+PJNCUIW8H05
         88wtgk//jpZvTlrozXVG0p+jsvOm0AVbD2Recy+NOhZijNwuXvh3ucl3sEjwGQr9r/nO
         3Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ovi3EmYy2hCZfAntPoqHPTZ8oOnPqPlOA/UGBACHokQ=;
        b=nCkIotwBM6OA/XiA4Tkq91wdH1ai1KmZOJR0ut2+3h4g/vYDm8P/Hpu0TQ8hLyV+O+
         qeNA8Mmi1LY1Jhh8KhyCk6gkDnogS70FoBeBXRwUHOlosFelBZp5Ymi7OZ16/n1R07AQ
         WRy2qDZCsKDt4Z/kuxtDKx7nCBPNOXfS3TTx0qdQsYuamV8WFlPkVPy2IzvNcKamv7Wu
         qZNQ/dMNH6L4AZxsxxW0KPCyi0QM6PGDjxnySFKU28offsJjyZ2N39ludGWyyLCYk57t
         +nLV3AExz242MuXtBcDjquubW5K78jRQ+zpTj/TR7WtQH1ReDRUZD0DSQSZu3SfZYn/Z
         HikA==
X-Gm-Message-State: AOAM531sd450uGCeNXjMa4g2zGMKVRQrOXsWp6ZbZPMtFThwgkHrWtTG
        ZiKP/xnCG68fbUcmtljn665svYJvIy+K6Ga8P2buwSD3
X-Google-Smtp-Source: ABdhPJyNdC9GaoIvVXw5UgW/YzMPCB/54v+CuegNeD3/u9UZqCKHKMUrGG6fs2CXcJmrfCHaV+VGob2wOcAr8ThnApY=
X-Received: by 2002:a1f:5e58:: with SMTP id s85mr99488vkb.3.1631135647364;
 Wed, 08 Sep 2021 14:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210907223008.2322035-1-luiz.dentz@gmail.com> <6137ee1a.1c69fb81.2d1e8.27ab@mx.google.com>
In-Reply-To: <6137ee1a.1c69fb81.2d1e8.27ab@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Sep 2021 14:13:56 -0700
Message-ID: <CABBYNZKeCxZ0PON5asWoA=3hqWuMX3YY1F0v+pm1KxPkQMaDDA@mail.gmail.com>
Subject: Re: [BlueZ,1/5] adapter-api: Add Experimental property
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Sep 7, 2021 at 3:56 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=543375
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      2.03 seconds
> GitLint                       FAIL      0.62 seconds
> Prep - Setup ELL              PASS      48.33 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.39 seconds
> Build - Make                  PASS      208.28 seconds
> Make Check                    PASS      9.35 seconds
> Make Distcheck                PASS      246.88 seconds
> Build w/ext ELL - Configure   PASS      8.45 seconds
> Build w/ext ELL - Make        PASS      196.29 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> client: Add support for printing ExperimentalFeatures property
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #11:
>         Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)
>
> - total: 0 errors, 1 warnings, 64 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] client: Add support for printing ExperimentalFeatures" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> main.conf: Allow passing a list of UUIDs to Experimental
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #267: FILE: src/main.c:568:
> +static const char *valid_uuids[] = {
>
> - total: 0 errors, 1 warnings, 375 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] main.conf: Allow passing a list of UUIDs to Experimental" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> client: Add support for printing ExperimentalFeatures property
> 7: B3 Line contains hard tab characters (\t): " Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)"
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
