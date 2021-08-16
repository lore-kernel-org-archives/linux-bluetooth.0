Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B16960F22
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 17:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhHPRuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHPRuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 13:50:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2EBC061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 10:49:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so34387028ybg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOveEF8yorJ4edhDN05O0CCMiXk6DR/cC7NBsArLnf8=;
        b=Gx1ezd1M6NpviAAZ5++0s+9Sj87+0p3mXMuCubYCfLWV8Fu8kUvXBjZBZPL/FEJpPo
         wjxg6znKmCqG7va0tvmyIUgU+LS7icn25krxo58wWdo8rsm4pQSlKHa/s0RRNUEBjWcU
         Df7L2pWaA+zhyilsi12VItt2rLHx1Y71k1RxwO4fcklJDXHtmiLniD5Iy+DGdWdscyCI
         Ne0ARiNfLZ7QhMo4oBJeILc2EiOfT+jXo43zImtL4b7fCgFXF8uHGFHMovW9AwL0s85i
         OPUs9ZSRB05eCrgta/ZxqUDkfDEpSnCwdmPC6kjI6irb5DxkAAJfkoUhUTQb0M6wqC+I
         sT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOveEF8yorJ4edhDN05O0CCMiXk6DR/cC7NBsArLnf8=;
        b=bKZsiJ9u7A1kaJg7jK3/Blfro73yndr1phGK+DEsf2Ml0ZC0mO6NmCc1cfD1vaLqWb
         0Kje6yXvJKcC+4Q/A04S7gDEp5aQDTSdLXvih5KI1VQD6MEZ6DjjLaBAtfM/FJ3oePSd
         PmbbZ6t/HnUjVUxicvseoS7qoYSB7M6MrSD0M1u4cuz+FsOq/24DrPRxx/SAMKobqsXh
         lssRSQ1J1+gsOvH8UBOzCs2ukUwcnGxlfpQ0m16DKWIZhFBb2MHRKmBXDxbEzLwW4Q2X
         x0re16pj3uhtux5OEqBfVAnBKEZYZIM0mdU+BYaiYXfoqJHCK5max9tx1F2aEg5sYwaS
         Akaw==
X-Gm-Message-State: AOAM533P6DNkQOAwwjfAGMabnYsmBzvsISuQZbzSVItjilS5XvfGWFz3
        V/O54lsnAcKgKSEzSJNVneUSVpSmFWZtLUUJyIkNRfll2w0=
X-Google-Smtp-Source: ABdhPJwFA2SCfnZhSM/k+lxzs8DDjcQ4iSpZZKPZPYVOXz2Pdy6udV1nu2Y5C1RRkCdIJ6o24cs1CEv5xPTDxTpqoGA=
X-Received: by 2002:a25:be02:: with SMTP id h2mr22772150ybk.91.1629136190463;
 Mon, 16 Aug 2021 10:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
 <61191554.1c69fb81.89ead.b7d9@mx.google.com>
In-Reply-To: <61191554.1c69fb81.89ead.b7d9@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Aug 2021 10:49:39 -0700
Message-ID: <CABBYNZLcEctR6=ovTK_CABqkKgU8UCKQQ30VsVsAJkdEA+xY0A@mail.gmail.com>
Subject: Re: [v9,1/5] Bluetooth: btusb: disable Intel link statistics
 telemetry events
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Sun, Aug 15, 2021 at 6:25 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=531683
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.92 seconds
> GitLint                       PASS      0.61 seconds
> BuildKernel                   PASS      598.41 seconds
> TestRunner: Setup             PASS      394.12 seconds
> TestRunner: l2cap-tester      PASS      2.89 seconds
> TestRunner: bnep-tester       PASS      2.07 seconds
> TestRunner: mgmt-tester       FAIL      30.94 seconds
> TestRunner: rfcomm-tester     PASS      2.31 seconds
> TestRunner: sco-tester        PASS      2.20 seconds
> TestRunner: smp-tester        FAIL      2.27 seconds
> TestRunner: userchan-tester   PASS      2.09 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 2.92 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.61 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 598.41 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 394.12 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.89 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 2.07 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 30.94 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 444 (99.1%), Failed: 1, Not Run: 3
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.012 seconds

Looks like there is a regression on mgmt-tester:

Read Exp Feature - Success - run
  Sending Read Experimental Features Information (0x0049)
  Test condition added, total 1
  Read Experimental Features Information (0x0049): Success (0x00)
  Invalid cmd response parameter size
Read Exp Feature - Success - test failed

>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.31 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.20 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.27 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.024 seconds
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 2.09 seconds
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
Luiz Augusto von Dentz
