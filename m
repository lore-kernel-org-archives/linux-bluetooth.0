Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A88C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 23:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiHLXNK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbiHLXM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 19:12:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48FE2BDC
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:12:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so3107594lfl.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DHzvhezKN8V0+y/Wgj+09Rr1d1V6eE4szum5rT3KfiU=;
        b=MDgNmnD89CQTQkDMtFAXcE9Q+ZDrmH1ZM7/SdTzka0zLHCc1h+XSuCA1rbTKBBtpPe
         09cgKBENmuI8meVU19gsvKtZ68nytqvW5XBdQz75t3d3Gp/gLnnyh1gLVEtdtpQCiFUq
         oa+4tVhv7x6HNhYQMWERX568akFWfZkF9+BVr959he6H5WN1YY7gUT7MWa5ONjZ43aU4
         LntT3IeCj5kSV7S/PsQm14x4jdGkFUjl6p5ujxuYRDMf+L299jNVXgvMpisXEAn7vQZ+
         FLmoypigEQ3bYSNnKK3aIqNkX/bb9B2m00E5T5+70SdF+lFiZYHMNK2e1G4euphJ4L0L
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DHzvhezKN8V0+y/Wgj+09Rr1d1V6eE4szum5rT3KfiU=;
        b=XE53rCjqBmrT90bzD1DrZuNBuFhd1TjKBQLM+i3RrLBV4t6+Q7lac4gyac/VV+Hn2m
         rc2CS4CRBqMJadG+UkM1nogeHUnwIUTEPwZvGlbzEWMDbqsEgUVVHV9Jg97vdAhSwF2+
         YbD20g3SlZSwfDF0PsU5YZIMq8A2frY5Wg4K6j5HLY0iQ6G5sqSu8kh2OGOgfrRsR/BZ
         qhdADqDi4b5w1xqFsd+9ct2z7xW4pl3r+9zO/yMINFIbTMPJv2vOyeqJgaTnUNFL/bTU
         eFaESWgrLw4Sx2mEOSIuKmKoZvweidNdeH+g8JPAJjQlZrKaowC4c77ab5WlJijGTgIE
         /Mqg==
X-Gm-Message-State: ACgBeo1Pj2fxHPktftNRQ4VtZCKR4NjM8n01roWLeuRj8wG7lStSyrUD
        E0PH5ShwvL9XDsYOT/SXBboRHUht/BxeQROn6i8gaq4zHFw=
X-Google-Smtp-Source: AA6agR6qX4KQI84LDCEIYsdhRmdBpOAxAX0dgPZTNwVdM2teHGAkjVpWNiICzjp3rIu3o6nY3vbzLdNw8F0FFa2Zthw=
X-Received: by 2002:a05:6512:3fa8:b0:48c:ffd1:625d with SMTP id
 x40-20020a0565123fa800b0048cffd1625dmr1794551lfa.251.1660345967697; Fri, 12
 Aug 2022 16:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
In-Reply-To: <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Aug 2022 16:12:34 -0700
Message-ID: <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     palmer@rivosinc.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Palmer, Sudip,

On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285

Could you guys try with the above change, I think the culprit is
actually setting c = NULL which triggers some compiler to think it may
be passed to bacmp.

> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.34 seconds
> GitLint                       PASS      0.79 seconds
> SubjectPrefix                 PASS      0.58 seconds
> BuildKernel                   PASS      39.92 seconds
> BuildKernel32                 PASS      35.20 seconds
> Incremental Build with patchesPASS      49.68 seconds
> TestRunner: Setup             PASS      584.32 seconds
> TestRunner: l2cap-tester      PASS      19.76 seconds
> TestRunner: bnep-tester       PASS      7.80 seconds
> TestRunner: mgmt-tester       PASS      118.02 seconds
> TestRunner: rfcomm-tester     PASS      11.69 seconds
> TestRunner: sco-tester        PASS      11.30 seconds
> TestRunner: smp-tester        PASS      11.48 seconds
> TestRunner: userchan-tester   PASS      8.07 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth



--
Luiz Augusto von Dentz
