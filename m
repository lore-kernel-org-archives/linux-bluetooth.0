Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2584C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGUSUr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGUSUq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 14:20:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3B018E0A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 11:20:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u13so4095038lfn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQk6x6BgTRGeuaeYI4xS5sh5HscwRl74pRGyiIhNUiI=;
        b=DBwMO1V7b3QYH+kvZXHLMpwc6rYYcNUcF3YzMBSe1oQEV1UH+yY52zqqr3mKwAzjZJ
         IR/3XcGTOf++FhOpX3EPvaCGGGL7rOQ9oFfS7iACO3VY/VqYq9Xl0IhD1J0uYypcNqWD
         gpXAqKlNJ3M/GPJOiDRd+bWxkq76bRFCXWYD8TNJKfjbqH1jxfnHXjLdp6eXqOCY26/C
         tA28NL2gwugY2bZAMypq8KnXICg4CIdL8015OQuydqXRW8gsLXPFFz1jxXr5S1TNjuww
         vcRtZeZnYYTmL+iKvL18U9LRLq1Jf3/R5qeUfqXKJ39gnain6Qpp05frRtJZyTPMK48f
         bb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQk6x6BgTRGeuaeYI4xS5sh5HscwRl74pRGyiIhNUiI=;
        b=Au66c+SECYWI4VcNSPuWSKrctKPWq8WhWMQy2uSdnmpgYnicaiHmBIqzFG/GYCectW
         9DV+RCkeXd355EBn94a5aRsypeXZ6568wyH8drMNtOBuROiqUtxG6/L6deAv/H/0/Prt
         pbWpgSfmK91zfQ4h1FMaY9b+LsbzVSJzKVuKMx0bMftgy49bK3gNEX9Y7NBLqLK9+qt+
         HRfX3OKBvlVCIDn/Rqp2FUtiFolfbb4M7IQaxGyhGmEG5G7KRtbDSZnyfvwC/mSKW+xR
         izwmC3UV1TCW5KbVLOl9iyS1H0qSkbh/n+ePexHYu/7I8nGTEn2c4Q9OCaUeNhHrKRFN
         dmAQ==
X-Gm-Message-State: AJIora+uUxrj9Mvk3F8I4OHauktCQzgA96jGhG6pIIhJQKHhyuh70Ywk
        JUFdP7pURPuhCqJuTeCWYK1jbXSGnmxEMrQ+xjowQtLY12T67w==
X-Google-Smtp-Source: AGRyM1tHD6KyTumFqRNrqqpVsg33DB3pvEAA7atBF0sm3wkR6eYQIlL8UTl7d8gMJ7HtjFbcd5/KnfkjWx2Za2hwcRc=
X-Received: by 2002:a19:5f4d:0:b0:48a:7001:dbf8 with SMTP id
 a13-20020a195f4d000000b0048a7001dbf8mr1580192lfj.251.1658427643285; Thu, 21
 Jul 2022 11:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220720011002.5221-1-faenkhauser@gmail.com> <62d7718f.1c69fb81.55c6.7e70@mx.google.com>
In-Reply-To: <62d7718f.1c69fb81.55c6.7e70@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jul 2022 11:20:31 -0700
Message-ID: <CABBYNZLMvy0s=52ByxoW4rwaEAmKCpiKhvAXY0EZM+GGMzBRQw@mail.gmail.com>
Subject: Re: drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     faenkhauser@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 8:13 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661295
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      2.63 seconds
> GitLint                       PASS      0.83 seconds
> SubjectPrefix                 FAIL      0.63 seconds
> BuildKernel                   PASS      34.64 seconds
> BuildKernel32                 PASS      28.81 seconds
> Incremental Build with patchesPASS      40.77 seconds
> TestRunner: Setup             PASS      494.12 seconds
> TestRunner: l2cap-tester      PASS      16.89 seconds
> TestRunner: bnep-tester       PASS      5.67 seconds
> TestRunner: mgmt-tester       PASS      96.20 seconds
> TestRunner: rfcomm-tester     PASS      9.09 seconds
> TestRunner: sco-tester        PASS      8.71 seconds
> TestRunner: smp-tester        PASS      8.82 seconds
> TestRunner: userchan-tester   PASS      5.79 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 2.63 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> drivers/bluetooth: Add PID of Foxconn bluetooth Adapter\ERROR:MISSING_SIGN_OFF: Missing Signed-off-by: line(s)

You will need to config you email address and set Signed-off-by (e.g.
git commit -s), also please add the information such as:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=b4e7b216fd4c560e2c30c00b29be9909178e3dc7

> total: 1 errors, 0 warnings, 9 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12923221.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: SubjectPrefix - FAIL - 0.63 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
