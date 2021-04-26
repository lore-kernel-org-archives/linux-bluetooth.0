Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 17:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1565760234
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhDZRCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhDZRCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Apr 2021 13:02:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C058C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 10:01:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p202so22076136ybg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JMZasM+2fE5q18WV8tga2FEm10R8FrqX1JyM1WybuCc=;
        b=QShKPDbNevInRZnWgJsActZ+hZj7i5YMp7qn/JfjqyS1ILagiw3A5vFMgUcMs4bauF
         JRn/PWRampi/8mLrsB/vaSi6hLb7gbMm2tO0XtDaJqi1uSxln39A8PhI3yyfDdrL7MVc
         lTKT5O4M5FhJAHEbNIs7rluRHOuzFEaRjrWfk972eR0kRYvTN+G7dpmATqrQyI/9FNmj
         wEhDXtiZrCK4ADr1DsDs2rPnQ5Z9iFZIgouqhlLrehWvHFdSLW4fpFc/Lt3fKgINxJuF
         TlG7VHL6sS1J99ptV7Rlrw7hevks3E1Y8or9In8uYraDDOWUG1dFHPDikNGl47sj7Wd6
         KVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMZasM+2fE5q18WV8tga2FEm10R8FrqX1JyM1WybuCc=;
        b=rlb9nsxEQ4yamD7yl6SSt5NsPHQN8xmzKF65QVa2SDIofuHNFzrVQxHEb8xFENxCC5
         1ze1w2rVq+jm3xXmvXbmlArZvVCAUhEFKCXzZJqc6QhQ6USWv4o/NdkPxZPB0PlzwI1p
         o7vJIa1jBYJVrT3+li06iHl93e2Y6UHYm2wRiz/O+XCRltQuYc9XQVo9arbe0ztTjZD2
         gR2/oCD8RUScAlZYLi3hRQS50pRtZ88FJjVabJXjOYEQ0fNMnSc8c1mJl71VEHXSasJp
         4WqHefrPJuAD3IxMYSrpOvwQmlA9hTlbjAI5uweaAfRD8cGLrPnq1aNnwYZJ3IUNCYOG
         rWlg==
X-Gm-Message-State: AOAM531eIDI7V3jtJQz4ri8FyCOVgErstPfuEzwHcPDo56vEp89wUgWD
        EddpulWg/gB7LTDsUNAjWR+bzvpIhu7jtTJYPIVL+B3hx+4=
X-Google-Smtp-Source: ABdhPJyvj1/1+fwbGvNRSIIRHCTNuYbb5Iult5pX8l6S107nKYAnm0QuCRjBKor5Tejz9Yfz9M+6m1snoZayHH1l9+I=
X-Received: by 2002:a25:e74a:: with SMTP id e71mr27965435ybh.408.1619456489644;
 Mon, 26 Apr 2021 10:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423235352.33965-1-hj.tedd.an@gmail.com> <60837551.1c69fb81.fa8bb.23d7@mx.google.com>
In-Reply-To: <60837551.1c69fb81.fa8bb.23d7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Apr 2021 10:01:18 -0700
Message-ID: <CABBYNZ+mU6vTR3O1xeDWpt-6n4o=MRfg5fa3QAEgo2LuqvLtUw@mail.gmail.com>
Subject: Re: [BlueZ,1/3] emulator/btdev: Add missing commands
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Apr 23, 2021 at 6:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=472555
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.85 seconds
> GitLint                       PASS      0.34 seconds
> Prep - Setup ELL              PASS      47.31 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.24 seconds
> Build - Make                  PASS      201.85 seconds
> Make Check                    PASS      8.79 seconds
> Make Dist                     PASS      11.57 seconds
> Make Dist - Configure         PASS      5.02 seconds
> Make Dist - Make              PASS      82.43 seconds
> Build w/ext ELL - Configure   PASS      8.09 seconds
> Build w/ext ELL - Make        PASS      188.41 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
>
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
>
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
