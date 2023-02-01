Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24DC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBAXrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBAXrc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 18:47:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC18646BE
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 15:47:31 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h24so488656lfv.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZUs1G4FAg0RWENOa/pDHVkRsTa0SGLirWvO+RGeE8=;
        b=fNrP0EaGh0Vtak4lVk0x9+94741YAHA69lAiVQmlL4187JMsGtYJqVkK7zlkJ4x5AI
         k7CgHjMidXYQJKnw2y7dcCGN9Yjj4uj4nbvCehmbIlV7ZSQUJUIfuLxTbpB9d/8VOMpq
         gHh3dtJjd0miCOIgUJkD/wKIoY4J/9TZCljStQAUO2LirzmNdUKy1PdDrJvxY6AWNjZm
         vQV4KSTEbivDQqx1rO4t9nMiaB7MoAMACIHjAHlb5nSWbdBHElNm5+8M4Rg0YES+swAA
         3uPODjdidXKCnuCwTEQ4qq/mqIWG2TNWRErD2SqK3LguP4yWg1OCFvKnzo6Whwt69IdS
         0+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiZUs1G4FAg0RWENOa/pDHVkRsTa0SGLirWvO+RGeE8=;
        b=T7j42TZd0pM+3GoOO4XG7jyqT1AQGTE0hFWgbb/PS5DVn4FYeGahycZd8j3gFShaLm
         6AXqBsGQlvxtdsqn2CiJzustvwZz+DxPLHYCC+8jv4/SCL5cNXFh5bq0GxdtvBgHb+og
         cpGVbsje3Hl8PVn2F+mb0hqoQT1h8MbQCX6SpxmWTZTXJqrWefMhU+XgNpRbZfBDH5NW
         lEajwA4C73mWpbhHxJVLykBMS8riU1Knql0EIRx41wbFVLSkAQ6LViPb/SKByGyqOAb3
         NAFPsUE3Z80sIGpD35fwIaVWBUNir9zaifAxwaaRl+jpomaee4OC1dAHU4nmNkCUkiTs
         Onxg==
X-Gm-Message-State: AO0yUKXQauZvxv1N2amTD4naT8kFV8jQXiB7+ZhEyF4Q+wfzxcT6DFz/
        cG4xJ2cPbAPalYyiAva4VndegsZD2w/5wJZhPF1hI0Lx
X-Google-Smtp-Source: AK7set/+Y5NVrIA9KT/GpZmzA32hnIAQ3N2vuN4dkyvImA2ow1Y0C/W5kw7nup+gtGXEQkUtNzy5lDCjq7xENmCv1Bw=
X-Received: by 2002:a05:6512:3e1d:b0:4b5:2958:bd06 with SMTP id
 i29-20020a0565123e1d00b004b52958bd06mr860745lfv.26.1675295248725; Wed, 01 Feb
 2023 15:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20230201220704.1543663-1-luiz.dentz@gmail.com> <63dae95a.370a0220.25d9.c141@mx.google.com>
In-Reply-To: <63dae95a.370a0220.25d9.c141@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Feb 2023 15:47:14 -0800
Message-ID: <CABBYNZKHRbx-uCBQs1kRnbjLETLZ3+_if_68UBq9VzMfHxBbww@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix potential user-after-free
To:     linux-bluetooth@vger.kernel.org
Cc:     Alexander Coffin <alex.coffin@matician.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

On Wed, Feb 1, 2023 at 2:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717902
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.17 seconds
> GitLint                       PASS      0.36 seconds
> SubjectPrefix                 PASS      0.13 seconds
> BuildKernel                   PASS      37.93 seconds
> CheckAllWarning               PASS      41.71 seconds
> CheckSparse                   PASS      46.75 seconds
> CheckSmatch                   PASS      126.54 seconds
> BuildKernel32                 PASS      36.61 seconds
> TestRunnerSetup               PASS      525.34 seconds
> TestRunner_l2cap-tester       PASS      18.69 seconds
> TestRunner_iso-tester         PASS      20.41 seconds
> TestRunner_bnep-tester        PASS      6.76 seconds
> TestRunner_mgmt-tester        PASS      129.22 seconds
> TestRunner_rfcomm-tester      PASS      10.65 seconds
> TestRunner_sco-tester         PASS      9.84 seconds
> TestRunner_ioctl-tester       PASS      11.64 seconds
> TestRunner_mesh-tester        PASS      8.60 seconds
> TestRunner_smp-tester         PASS      9.80 seconds
> TestRunner_userchan-tester    PASS      7.09 seconds
> IncrementalBuild              PASS      34.40 seconds

Looks like it is good with our tests in CI, that said I do wonder if
you guys could enable it to run tests that may trigger these problems,
since they normally are not found by normal tests.

>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
