Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43A06108D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbhIGWH2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhIGWH2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:07:28 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B64C061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:06:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so203888ilm.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGMX7XACZS9txCZM/X+5UALxRlWFZi2g359Y5ZZuY1g=;
        b=NpnAKT/8xLNDDDZTAPMQOrjzQdjxutlHDlBy4bzBfkHCwSiQzX038KJQeBc+mIQCkK
         bIfoAZIUf+2Z0r51Ib1qZzIPYA6hlqQjN0aWFptq/KR4oaIoO3+rYMUjHHzszfqRUlTJ
         ttkmaFru8y/VZ8xrITVB20j6mAL9yQDMAL79f3WJPQSDNRgrpcZCTv7lX9EqulZ5F8Cz
         /Mw9l00N1Fj7JW5ESIuc2tarP7cr+GJAEfMkrvh8qNMVW5ZnxnAE65/3Vq2z9+gWAqx7
         2W5lB+AfibNwNKnP7Cnqxk0RacL+I/fjYgO8427yoAmX2di9EKPxmx0MgZkKfTwDuB0Y
         stXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGMX7XACZS9txCZM/X+5UALxRlWFZi2g359Y5ZZuY1g=;
        b=LYByzsJ97Pn5D8Blj6U5gDWbjUJ3adYWeVqww/qz91mA24G/JkCbKNzlwARTuB3Zi/
         zDGoGj44qjyvWFOCdeUBMATCSuuh6/YVpW3ZHmMW1eRwUzM1tsOWWIy1jJUHApkY8pVs
         KHw3/WCnwFCQxHLn3YgBNL5i4qgfWVf7c6tm/7H/o/C8wEc5pGvaxA3TyUnm6K1cmZ5o
         WPjHq4fl5XZ9n7sa1l2/tleQs/87ZOc6zYIst9tLoHhK90ZgdD6jZheC7YUDjsGhEve0
         69ic/mEGSTdb7QRsgKQZ9q7NrDNqgXfQ7t88nYrTWtzy7X1hJucl880Me+BHcbhAJFy0
         nsKA==
X-Gm-Message-State: AOAM5337iDP2iAppg6HVSfl0MGHPioS52HrfVyM6ASDRl5cp2U9l2/9d
        CkGfaVOpNNsV+i9/d0sY+roOJBGGN+CxwjUEaLjN4rhG
X-Google-Smtp-Source: ABdhPJwOw5BO64Egzouon8IcP2SX+U9Ok/TV45FxOqvsRnZwbyx97xWNDdg5uWnCyEuHD+1+/i33XIF9ZEkdEqefXuk=
X-Received: by 2002:a92:6e12:: with SMTP id j18mr321781ilc.243.1631052380568;
 Tue, 07 Sep 2021 15:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210907101249.7323-1-kiran.k@intel.com> <61374762.1c69fb81.d157d.6304@mx.google.com>
In-Reply-To: <61374762.1c69fb81.d157d.6304@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Sep 2021 15:06:09 -0700
Message-ID: <CABBYNZLDX1vZS6M+ewgdvQhOOQOTE9yeLP355QiN7=WrcgPb7g@mail.gmail.com>
Subject: Re: [v15,01/13] Bluetooth: Enumerate local supported codec and cache details
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Sep 7, 2021 at 4:07 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=543031
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.52 seconds
> GitLint                       FAIL      0.77 seconds
> BuildKernel                   PASS      548.49 seconds
> TestRunner: Setup             PASS      366.22 seconds
> TestRunner: l2cap-tester      PASS      2.59 seconds
> TestRunner: bnep-tester       PASS      1.93 seconds
> TestRunner: mgmt-tester       FAIL      31.19 seconds
> TestRunner: rfcomm-tester     PASS      2.13 seconds
> TestRunner: sco-tester        PASS      2.07 seconds
> TestRunner: smp-tester        PASS      2.19 seconds
> TestRunner: userchan-tester   PASS      1.93 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.52 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: Enumerate local supported codec and cache details
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #126:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 0 checks, 313 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] Bluetooth: Enumerate local supported codec and cache details" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.77 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command
> 1: T1 Title exceeds max length (76>72): "Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command"
>
>
> ##############################
> Test: BuildKernel - PASS - 548.49 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 366.22 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.59 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.93 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 31.19 seconds
> Run test-runner with mgmt-tester
> Total: 452, Passed: 451 (99.8%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.012 seconds
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.13 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.07 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - PASS - 2.19 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.93 seconds
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
