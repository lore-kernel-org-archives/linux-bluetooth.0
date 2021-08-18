Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D7EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 06:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2A660FA0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 06:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHRGW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhHRGWY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 02:22:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDBC0611C3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 23:20:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u1so1181303plr.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mzuWMmFvaDKqoRjpTdx1R4zQU9Dcz/+vija694Krx0=;
        b=hsSfMNBfpMJZQUwP7krzcrajdFjt0cdu3YnhzycHv1nhEnyOXQ+rQUT2MtXGodb6TN
         rOPpkBL8n/it/2fFKQbdouufQnqbHvhoXFWYhoSzpi8to0dZebRo1BiYrrRUcexkbe8O
         4huwsPsmCx41UPL0bMGC6WCLO0rNbpXHctTdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mzuWMmFvaDKqoRjpTdx1R4zQU9Dcz/+vija694Krx0=;
        b=cZ4zxhm+2QOEPi87Cfgr1L0zXyCvIcGW957fIkWgwhNniulzTrkEAHC1W2hXAOAsiR
         osP+5AO9iVgnUOiZ6YPFV3ISw4VMJQJvOV/SC/mga9i0ytMboe6VF5BeH5lC1J5hbrhm
         qG22dCk2kJLwhBE6/E4cncXZ21XBppbfRCzPIGArGizb4cfkSc5FX2KueOF5chchLqzw
         Rab9Mh2g6tlmPbQhHjVdlNHjGYwzafez6BXq+hJZ0zXB3cBDlqxGGen3Yj34KezIUq+h
         Qa6qSTM4yQ93AtWwmfjoG3sJ3qXh2806iyCG8VJqR7yshdn96wMsmz21sCm/cYgGy1rF
         ebaw==
X-Gm-Message-State: AOAM5309aXDVh81yQZ0RGk2DdQF5DcPfFQtVQCxTn6gHjETs7rwh+cbP
        yyaB1lkbsYs5JK8yNx9CNtGInhKfIh2qNQ==
X-Google-Smtp-Source: ABdhPJwEYRocfwAm020qswZynKHQBjWWdEB7X82DwvqrsfIby9Eep2H6wtNGudxjZsqSDtGlF6gpuQ==
X-Received: by 2002:a17:90a:cc12:: with SMTP id b18mr7857496pju.192.1629267608413;
        Tue, 17 Aug 2021 23:20:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o24sm4013500pjs.49.2021.08.17.23.20.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:20:07 -0700 (PDT)
Date:   Tue, 17 Aug 2021 23:20:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: mgmt: Pessimize compile-time bounds-check
Message-ID: <202108172317.EF48B9961@keescook>
References: <20210818043912.1466447-1-keescook@chromium.org>
 <611c97c5.1c69fb81.86d43.fcad@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611c97c5.1c69fb81.86d43.fcad@mx.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 17, 2021 at 10:16:53PM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!

... I think I will though. :)

> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=533133
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      0.46 seconds
> GitLint                       FAIL      0.11 seconds
> BuildKernel                   PASS      536.10 seconds
> TestRunner: Setup             PASS      347.74 seconds
> TestRunner: l2cap-tester      PASS      2.56 seconds
> TestRunner: bnep-tester       PASS      1.90 seconds
> TestRunner: mgmt-tester       PASS      30.68 seconds
> TestRunner: rfcomm-tester     PASS      2.08 seconds
> TestRunner: sco-tester        PASS      2.02 seconds
> TestRunner: smp-tester        FAIL      2.06 seconds
> TestRunner: userchan-tester   PASS      1.98 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL - 0.46 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: mgmt: Pessimize compile-time bounds-check
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #11: 
>     inlined from 'read_local_oob_ext_data_complete' at net/bluetooth/mgmt.c:7210:12:

This is a literal gcc warning output, so wrapping shouldn't happen.

> 
> total: 0 errors, 1 warnings, 0 checks, 8 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] Bluetooth: mgmt: Pessimize compile-time bounds-check" has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> ##############################
> Test: GitLint - FAIL - 0.11 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: mgmt: Pessimize compile-time bounds-check
> 8: B1 Line exceeds max length (84>80): "    inlined from 'read_local_oob_ext_data_complete' at net/bluetooth/mgmt.c:7210:12:"
> 9: B1 Line exceeds max length (121>80): "./include/linux/fortify-string.h:54:29: warning: '__builtin_memcpy' offset 5 is out of the bounds [0, 3] [-Warray-bounds]"

Same.

> 
> 
> ##############################
> Test: BuildKernel - PASS - 536.10 seconds
> Build Kernel with minimal configuration supports Bluetooth
> 
> 
> ##############################
> Test: TestRunner: Setup - PASS - 347.74 seconds
> Setup environment for running Test Runner
> 
> 
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.56 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.90 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 30.68 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 445 (99.3%), Failed: 0, Not Run: 3
> 
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.08 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.02 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.06 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
> 
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.021 seconds

? Any details on this?

> 
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.98 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 



-- 
Kees Cook
