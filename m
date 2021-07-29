Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDBAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C606860F46
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhG2RwO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2RwM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 13:52:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33945C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 10:52:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o5so12138024ejy.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iFn4wnHG6BQQwLSA8yVZsntpcZkw1CJJ/NWK/yNV0Tg=;
        b=GuYN3kc7MUQ8QpL4oPDZsGbqmMBjObrYBR4Q3rNw0nTxbdrm6Ui27rKEzFqcKWX0jx
         Em+DI2Gtz1cjuFwB2YYPP4Q4IDkk4NmTHj4/9cj0YhLRnnxNHZ+7Cw9zs0WfyWxhzPc6
         kXQkCDzx6b9KH/884CUFRWFSonE1eo8lfOo40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iFn4wnHG6BQQwLSA8yVZsntpcZkw1CJJ/NWK/yNV0Tg=;
        b=NQbILvaNsBcfj6emMXnKZoXWo4Dmii6OYrDU3RYKJzGsesCRSai4HjCz4zjnN+TXOO
         DPHGaErQG9uIQKODQ7oTGr3j9PaBuiysCD/GidvRa9cHC1RegXDFp27fKQSSmkLSVsW0
         oAYnLiKOmx+7CnrFEdbvKwm1gFiRYB6tMbb5zP1R4+thWZkL/vL0+IoiVeOUyJ7huinO
         0eIec3gIFJkhK1szkNFo6ZvNlInH6eJE5OR15eUqsGvfHr5fWgPW4EMDErAyRWGprXiw
         j0+bDIoMutQ20X1NQ/pDxNZHSA6T2u5KDkLmS7xZLj5uY8NK9V0Yhdk4mxEHBTVaJqLf
         us0A==
X-Gm-Message-State: AOAM531JqB0sMmf/ALg3z9hcXFlxTID5k7JoNTibw9pmF1aqzotw9z6l
        bJZdoOD7Qv4gurRBCg+zt13g7V96G8Pf9Qvj
X-Google-Smtp-Source: ABdhPJwQDSNYnFJnZIUMCQVAPrjtm0hKHq5EiTrAdZr4NzwVXVkMJjmM/+paG8x6h6p+3gy3ZHiRlg==
X-Received: by 2002:a17:906:e0ce:: with SMTP id gl14mr5798566ejb.168.1627581127670;
        Thu, 29 Jul 2021 10:52:07 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id d8sm1514858edj.19.2021.07.29.10.52.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 10:52:07 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id h14so7912011wrx.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 10:52:07 -0700 (PDT)
X-Received: by 2002:adf:e101:: with SMTP id t1mr6223878wrz.215.1627581126745;
 Thu, 29 Jul 2021 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210715003521.2222-1-sonnysasaka@chromium.org> <60ef8eb2.1c69fb81.6fb78.9241@mx.google.com>
In-Reply-To: <60ef8eb2.1c69fb81.6fb78.9241@mx.google.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 29 Jul 2021 10:51:55 -0700
X-Gmail-Original-Message-ID: <CAO271m=0yH_9oBMGeHSCWAQFpZPiLxx+ejCZyBpbFuKYhAky6A@mail.gmail.com>
Message-ID: <CAO271m=0yH_9oBMGeHSCWAQFpZPiLxx+ejCZyBpbFuKYhAky6A@mail.gmail.com>
Subject: Re: [BlueZ] monitor: Print EIR of Extended Advertisement Report
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Maintainers,

Friendly ping to review this simple patch. Thanks!


On Wed, Jul 14, 2021 at 6:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515781
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.24 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      39.40 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.11 seconds
> Build - Make                  PASS      170.91 seconds
> Make Check                    PASS      8.82 seconds
> Make Distcheck                PASS      204.00 seconds
> Build w/ext ELL - Configure   PASS      6.98 seconds
> Build w/ext ELL - Make        PASS      161.16 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> monitor: Print EIR of Extended Advertisement Report
> ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
> #9:
> Change-Id: I4805e589837733e7ecf9d33218e4135e8f822a7c
>
> - total: 1 errors, 0 warnings, 7 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] monitor: Print EIR of Extended Advertisement Report" has style problems, please review.
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
>
