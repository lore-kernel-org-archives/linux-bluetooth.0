Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF1C4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489A7610F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFWSXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWSXR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 14:23:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:20:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x1so3665729qkp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WOYoahjhHXn+RVIX8Ab6RDdxRoB2w0EEEvrDiqBU5Q=;
        b=niUyANZjP4c+um2NJaNu7gdLzRpJvWg1sFgaCwvUtdUV3cZwwYxFGB5cqZVFUQhP3S
         NIXHttHWkyQcIJDctPQDLLA4HtFNpnsoGzZL4h449M33zvy6LhDdaJ8Bjx+21n3xVqHE
         HIM/zOJ9p6Rv8sb/3QE9XJwne7VJVsuCE1glPIGbvJ/6KRk3rJOn91vKOSmKzY+g2mDs
         QmBu/m/p+68wyrZ7CQz7dXOxkhXoSzLMfHNIp81H8EmXHvV/3mag+MkuK9HIt/OKULre
         Ah7STjHJDkd84cI9JsmWmzAoWjN7cnCDcZ8V5yYCRzSvuB/VPorDsYeYLEajHPx+6hUh
         b3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WOYoahjhHXn+RVIX8Ab6RDdxRoB2w0EEEvrDiqBU5Q=;
        b=RjUXc/movEn3QP9ilny/0ZVRZPhkV+FdLPp8hOdD9+E1KRXITu3mtk0ZTOf9M9SKlR
         ySThSls3Zbe9OrQTSxQOnFPZz9RFVEAI8pCO2UX2MGzVW2fjB0JVBT83/FmFzNzz0cMz
         3nQxuB74K6KB46PYXASdy5ylHDtGvlq8ZF8nMlKGUAAqRfxspa7HAWdwsbtdoFpvmEbk
         3StzEv6FN3pQB2MbP52AXFgcm6YEFRft3qjq2UBovEZXeGJHzkJLagD1hZisdvSnSXRF
         JSwu9y/TYOIuIuV9zJZ0vtxMnMlHKNUEZxF4PaqsyRlax6zr1ri057e26EqtPQ38alQs
         8wkA==
X-Gm-Message-State: AOAM532l27raNGxFxD+iOIsPIgi3nAPX0fVvGRfVa/FvT5SmAdVwvzxa
        bvwss1Z/s026Ypw6R75KM7dbwq65CrkgGZhL6H/seDvsrC0=
X-Google-Smtp-Source: ABdhPJyJO3c39P3P4oQRgm9IM/erLLB5M4I7xSDd4JoLEKZAB9fElOlXiNe2BFZ1i2K1r/tMuCKMybCzeStm60/l1yA=
X-Received: by 2002:a25:e80f:: with SMTP id k15mr1027365ybd.432.1624472457264;
 Wed, 23 Jun 2021 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615192335.531929-1-marcel@holtmann.org> <60c90867.1c69fb81.59a37.017a@mx.google.com>
In-Reply-To: <60c90867.1c69fb81.59a37.017a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jun 2021 11:20:46 -0700
Message-ID: <CABBYNZ+51bKOx4wUfEU4YCWEe9=Ke1+qhSLQPYscHzojqbNteg@mail.gmail.com>
Subject: Re: Bluetooth: Increment management interface revision
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jun 15, 2021 at 1:10 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=500949
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.63 seconds
> GitLint                       PASS      0.13 seconds
> BuildKernel                   PASS      668.47 seconds
> TestRunner: Setup             PASS      435.30 seconds
> TestRunner: l2cap-tester      PASS      3.03 seconds
> TestRunner: bnep-tester       PASS      2.14 seconds
> TestRunner: mgmt-tester       PASS      32.75 seconds
> TestRunner: rfcomm-tester     PASS      2.37 seconds
> TestRunner: sco-tester        PASS      2.26 seconds
> TestRunner: smp-tester        PASS      2.40 seconds
> TestRunner: userchan-tester   PASS      2.07 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 0.63 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.13 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 668.47 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 435.30 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 3.03 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 2.14 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 32.75 seconds
> Run test-runner with mgmt-tester
> Total: 446, Passed: 433 (97.1%), Failed: 0, Not Run: 13
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.37 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.26 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - PASS - 2.40 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 2.07 seconds
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
