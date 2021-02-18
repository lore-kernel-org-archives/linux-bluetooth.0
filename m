Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F7DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 20:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAE64E28
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBRUJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhBRUHp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 15:07:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D5C06178C
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 12:07:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k22so7937016ljg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 12:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4pMAphLL4BvCx/DtACIjY4FZ7sTSw8xprugvLYR/Dc=;
        b=uxmsrwBwd3C9O84IJJ0DwQZPURriFQPlbqKRs3MAGjV28VdLQ/64UUhFNyfZGgBbxB
         UanwESU5nvJQMh+7StCF/X9rgGapFP2zgUrFewgIbkBdyOx6GbOYKWgFFUH3knefPzDK
         FyYE6V9pzsiIvMGDQapJLUQX4Hiz03egQKbSswayGzzsjQYThzpRMIlaWacFjxhJfib8
         TsP6QUoQkVojuzIAGQwf3WAi8rX0eymzXkL7dqPNrwB1s0wF2eOnyleWHw22lrcax0xu
         jXNl4aDrOVMKt8xh2v5922is2jmMUqHM/RMc98ccjlzJKlQOF2100ByjNi7T/Qnl7gya
         Yymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4pMAphLL4BvCx/DtACIjY4FZ7sTSw8xprugvLYR/Dc=;
        b=Y4TJRKudHkcFNX7o1jIpJ2pQLUzM00kFwKc2XJKFftb3m2TtzqnCTPxYq9it3HCMWh
         b5eut3k3H8S2z+hbaJVdyb6nMnnel0I52vb5pWObwETZv1BsV9+C5fU99pwV62+1efkB
         b5L3AhQdaaNzIZdN3du5Nh3mvf+1Lf/+yIUvDpqk+WxXQrz6fiw/TA11Qu2Hs+hxzhGS
         PPPTlVlUZ1e+kAd99/MPHi9MjbBUaMToPusNRM53FSRfPd8OLQEqNxBfn6eSeaxNCgnk
         lz0ZhpZf4mttlRuf77NWmtuJ4AxIPCqd3nuiWev4ll8WZms/CpGasrDZCWAsu3qGrLCJ
         5Shg==
X-Gm-Message-State: AOAM5338J4dmaUkILLzyl/td7+mP2ZD/CBFyVh6RcQOeWxnYSbw6tdVl
        nAZg8C0kbSqqdbrH1LKLm2V6w8c46yAT/LjHTxNJIz1HXSg=
X-Google-Smtp-Source: ABdhPJxKFqq9Z1XQtkjICcjzUV68o1KCgaVs3JOvIYpc3hRdyjizOdK/Q2wkf9oZsqez+C3aq1bW6Dp1Wzk/eOpQp7o=
X-Received: by 2002:a19:f241:: with SMTP id d1mr3206625lfk.490.1613678822856;
 Thu, 18 Feb 2021 12:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20210217142511.3221605-1-alainm@chromium.org> <602d321b.1c69fb81.3fe48.4e13@mx.google.com>
In-Reply-To: <602d321b.1c69fb81.3fe48.4e13@mx.google.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 18 Feb 2021 15:06:45 -0500
Message-ID: <CALWDO_XuBfnvY4jSbCFVmec63S3-V_iW3nG+TkcDKtU-t=h5rA@mail.gmail.com>
Subject: Re: [v1] Bluetooth: Tolerate valid pre 4.2 conn params
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Marcel for viz


On Wed, Feb 17, 2021 at 10:11 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434523
>
> ---Test result---
>
> ##############################
>     Test: CheckPatch - PASS
>
>
>     ##############################
>     Test: CheckGitLint - PASS
>
>
>     ##############################
>     Test: CheckBuildK - PASS
>
>
>     ##############################
>     Test: CheckTestRunner: Setup - PASS
>
>
>     ##############################
>     Test: CheckTestRunner: l2cap-tester - PASS
>     Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
>
>     ##############################
>     Test: CheckTestRunner: bnep-tester - PASS
>     Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
>     ##############################
>     Test: CheckTestRunner: mgmt-tester - PASS
>     Total: 416, Passed: 402 (96.6%), Failed: 0, Not Run: 14
>
>     ##############################
>     Test: CheckTestRunner: rfcomm-tester - PASS
>     Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
>     ##############################
>     Test: CheckTestRunner: sco-tester - PASS
>     Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
>     ##############################
>     Test: CheckTestRunner: smp-tester - PASS
>     Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
>     ##############################
>     Test: CheckTestRunner: userchan-tester - PASS
>     Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth
>
