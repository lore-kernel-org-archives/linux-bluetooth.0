Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F2CC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 18:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF460724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 18:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhHJSRo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhHJSPh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 14:15:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F305C04A4D8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 10:52:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p4so6172728yba.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Rj40gEjIcjiaRY6qNmQv/7Ri+d/48/sCbtqVru+j/w=;
        b=QD5D56CDX/i7bHc6y64sG6i6hnzD4PIvbo9u5pvU1ef4HaDtF0JaUpnf92gQskRZwP
         e6dRGchOEK2tSu/IdfDg21B7FGHzGOWCVPgBcjmZ3tHlpULfMFkwucKlim7nzzH6V3PX
         JYoJCG3Nl6ErNyWoXoH7N52oe20oNfqgPW9GUAMjFpdceUAWbuDdy60z9Gcw4cdeGrYj
         ahbS3M37mNXmppnyRnJGDgil7aeRbeKDDNHnxqAw477nD9GkwJAmAc9snr9oWZk4XWkg
         Cyvyn48XMP5po2Zzh68nUxv1ZlJB2WXFmyRjNFZNTLjfZxTV6DXmLr14vVpQtcRSxgMk
         IIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Rj40gEjIcjiaRY6qNmQv/7Ri+d/48/sCbtqVru+j/w=;
        b=tYTL7iylRnd4mO/Y4DICpTHP3yKnt5P7MaIkITwtXGhn0GLPn5EoYE3IWXaW8Zbb6k
         UCBBokLJ2KzKoWxS+7ZrhVP1479va+a/BwRybgJpccCKIm9BQt2suMYzNofItVj1UyzC
         J8dvLRbzO9ZHYLwMX9CfVOqoTq38AhbY6lcusGflowl7KO0HYn7O2PnjkPotCIXnhO34
         XWh5QkkRD29yUHyKA6jN/1uWZNzyjcZ3uoYZX9hR8LEWwmNaHA/+C/HKRVT5fEbWYODi
         MRUAE23R+Ltnq/YZl6oxYIsyfma66ZHA8vgTa4kaoYNxIbr7TJx41AQ0k4M0huTj8G/t
         On4A==
X-Gm-Message-State: AOAM533xVCzkYwyTUdvJqamd/beo3hofZEYOzjjwTz9OkvLF3uEBXj6v
        LjHFKOPQNR9COHQJ0P1MnMKL8Bj90A0hrwOnPF1Gp9g5
X-Google-Smtp-Source: ABdhPJyK3fe84ApuBnS5zpgSS8YvBg7Q0smi1e/YoDdWn+q/ply/vsUByY41UBCHuAkMTn2ggoUze/gnZvZVmiR4+K4=
X-Received: by 2002:a25:d6c6:: with SMTP id n189mr41121395ybg.432.1628617926155;
 Tue, 10 Aug 2021 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210810041410.142035-2-desmondcheongzx@gmail.com> <61120b20.1c69fb81.2d117.2206@mx.google.com>
In-Reply-To: <61120b20.1c69fb81.2d117.2206@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Aug 2021 10:51:55 -0700
Message-ID: <CABBYNZLrwegQ1mX5WDZAZoUrE1iYJLb-y2qFfrhj4Fpao0b5fQ@mail.gmail.com>
Subject: Re: Bluetooth: fix locking and socket killing in SCO and RFCOMM
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Desmond,

On Tue, Aug 10, 2021 at 1:52 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=528879
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      2.07 seconds
> GitLint                       FAIL      0.10 seconds
> BuildKernel                   PASS      508.13 seconds
> TestRunner: Setup             PASS      334.98 seconds
> TestRunner: l2cap-tester      PASS      2.57 seconds
> TestRunner: bnep-tester       PASS      1.92 seconds
> TestRunner: mgmt-tester       PASS      30.57 seconds
> TestRunner: rfcomm-tester     PASS      2.06 seconds
> TestRunner: sco-tester        PASS      2.01 seconds
> TestRunner: smp-tester        FAIL      2.06 seconds
> TestRunner: userchan-tester   PASS      1.91 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 2.07 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: fix repeated calls to sco_sock_kill
> WARNING: Unknown commit id '4e1a720d0312', maybe rebased or not pulled?
> #6:
> In commit 4e1a720d0312 ("Bluetooth: avoid killing an already killed
>
> WARNING: Unknown commit id '4e1a720d0312', maybe rebased or not pulled?
> #34:
> Fixes: 4e1a720d0312 ("Bluetooth: avoid killing an already killed socket")
>
> total: 0 errors, 2 warnings, 0 checks, 31 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] Bluetooth: fix repeated calls to sco_sock_kill" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.10 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: schedule SCO timeouts with delayed_work
> 42: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=9089d89de0502e120f234ca0fc8a703f7368b31e [1]"
>
>
> ##############################
> Test: BuildKernel - PASS - 508.13 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 334.98 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.57 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.92 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 30.57 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 445 (99.3%), Failed: 0, Not Run: 3
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.06 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.01 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.06 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.020 seconds
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.91 seconds
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
