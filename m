Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CA4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8BA60F59
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhG1Ag5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhG1Ag5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 20:36:57 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0EEC061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:36:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q15so1078273ybu.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlfGspcNuYWAc7KzVgWeT8wJfw4XRHzjGQwhI3l8gX4=;
        b=fCiPZgnL1gO4TqTXD4B3rm07EGm8FVD+aowXbcdTPZl3WFDHbTAZMKhlW+SSQLW+vG
         LEAPKVuwJy58GQWfJe6koQogDaA1rdrTRYYpPH9FNkaN18jP9qTLD1BVaKbBuIyn3Kt+
         v4r9dyQ3GLng7CppxgpLrBYvzCBaSTzTDDbFPlPMO9NbVU3knKixTBU7GJq6sO7AKBOa
         gxMWGlJzmiu7G1hjhVXyK9S4xd20gFO9vzYELpFsskyHMWRd9HGTMpEiHX1JVO+TgjbV
         IWDzkyMJA5MeeLhMmJprzc2w7a7YcO0CiPwjoLV3onwCcEna3hQakF24+ezDDEm8WxM2
         PmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlfGspcNuYWAc7KzVgWeT8wJfw4XRHzjGQwhI3l8gX4=;
        b=tDbHucWlTjZv3pqG3Rj744ZKp9AjPKQm2kWqMTSM02ALgH5Qmit6n6T2hf2uh2xJul
         x/ynYaFGkOM+Jy/AjARqPnszIvCa3U/GFQlF2msANbkIsi0vM72gjaN1e5sj8GpryPBR
         gV2muAOkvqQ8cT76ceqCkxSGWB7IzgrytG78NWVd+ZhmllKMcheVhf0+LHu2vaiot8oW
         SFaGutSFTpIT6YL9//xVCWfTg+KKmucxU0tA/+Yxi7gdfqDPhd3GjcL/Ocz5naNJnW51
         MG/sLjsJ2yrE6ic70mEoKmqe9gWddVfxvg/xYuifhzjqgokiPzLyofCBRwvh2ukI8IRC
         RZ0g==
X-Gm-Message-State: AOAM533sw9Z6p6LNZgFjR7pqvDXKgoN42w+2Ou2ozdLxBIVLr9F6TL6G
        vO+oCnc/+XnChoe6vTzJanjTrCvH60bd8AJk9OjolYMD
X-Google-Smtp-Source: ABdhPJyoucGNrjqUJOxSvhOO6eFFhPPizOOOu9HWZFCcuZMu4m8VVKIpqBzPtBy8Gv0j43y2aiZ4UffYmEOlyhipE5A=
X-Received: by 2002:a25:7647:: with SMTP id r68mr35905930ybc.432.1627432614586;
 Tue, 27 Jul 2021 17:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210726202236.136598-1-hj.tedd.an@gmail.com> <60ff6bf4.1c69fb81.3762c.5f37@mx.google.com>
In-Reply-To: <60ff6bf4.1c69fb81.3762c.5f37@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jul 2021 17:36:43 -0700
Message-ID: <CABBYNZKEkD6d0HojEZEXYpxbOHWoXeMxKAS2fN+3YZMAmLPPVg@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix wrong opcode in the response for add_adv cmd
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Jul 26, 2021 at 7:15 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=521535
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.47 seconds
> GitLint                       FAIL      0.11 seconds
> BuildKernel                   PASS      649.82 seconds
> TestRunner: Setup             PASS      421.83 seconds
> TestRunner: l2cap-tester      PASS      2.96 seconds
> TestRunner: bnep-tester       PASS      2.03 seconds
> TestRunner: mgmt-tester       PASS      33.97 seconds
> TestRunner: rfcomm-tester     PASS      2.49 seconds
> TestRunner: sco-tester        PASS      2.44 seconds
> TestRunner: smp-tester        FAIL      2.98 seconds
> TestRunner: userchan-tester   PASS      2.43 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 0.47 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: mgmt: Fix wrong opcode in the response for add_adv cmd
> WARNING: Unknown commit id 'cbbdfa6f33198', maybe rebased or not pulled?
> #10:
> Fixes: cbbdfa6f33198 ("Bluetooth: Enable controller RPA resolution using Experimental feature")
>
> total: 0 errors, 1 warnings, 0 checks, 8 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] Bluetooth: mgmt: Fix wrong opcode in the response for add_adv" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.11 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: mgmt: Fix wrong opcode in the response for add_adv cmd
> 6: B1 Line exceeds max length (95>80): "Fixes: cbbdfa6f33198 ("Bluetooth: Enable controller RPA resolution using Experimental feature")"
>
>
> ##############################
> Test: BuildKernel - PASS - 649.82 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 421.83 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.96 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 2.03 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 33.97 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 445 (99.3%), Failed: 0, Not Run: 3
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.49 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.44 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.98 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.032 seconds
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 2.43 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
