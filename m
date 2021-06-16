Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74593C48BE6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4452E613DE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhFPWqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 18:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhFPWqa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 18:46:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2DDC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 15:44:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c14so5346921ybk.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcVwyLkw4muB8wQ5ROSioMj9KA3yLc7IV41gxbC+r8Y=;
        b=LreOJ+3SI128KAmqIycR9CIusioY8V2foOTILhsv+Yb3M6/4JuAiWzc6KoHJcHMnh8
         +twuqlSzo9yvl78abI0GBRxkw1901MeLSvUbNu8CMgbNeDeLNRtBBjFl+7UEUXxnRfFe
         FsrNEDMOTfkpILr9cVKSW7A2au9U8Enj5r+m6QBltUtjx+sG7GJGRZ2UV880ge3ns95B
         1i2FR1xf9JbxUQI14/qyFIU9WX/wexb2bYs12sO0dthst/XKgBF8kkujs48hW+o213ZN
         3L6+9Gqk3SIiiDTvaZojJ0twcH7ILj1Dp7aNToMfxBH5xwShLKPGfG3Hvxf5qL+xcKID
         NKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcVwyLkw4muB8wQ5ROSioMj9KA3yLc7IV41gxbC+r8Y=;
        b=G3FUypSVNZaDAZZhjC0FjsiflQeH3U64kDTxpi2Umfncwpge1vX5Wn/33Lq/3vOkBa
         V2Kw9jK3h6oF/rSErcVigpH5y4IcOMCdC9+8SSSCnz7KrcDEk1xTak7NUNglT3o1U5Pl
         jdNhf//1HjXK4sOka9K+meXR9DJeUqik3iqcIK5W3Dftc/ZXqOW5UDymTUy8pvQUQ68h
         +v9xQqa/9xA5ozoanGc+xVXECIg7kCYEz16izzFBnubwpmbYX9vnXQIIlQNUMRztNLda
         a/y5E3jyn7HyVaC1se7wB3o69Q7uZAgRo1MDdIO1laxW1LromSRNxlno8T7zqjwN1aLo
         bBBg==
X-Gm-Message-State: AOAM532QcKw/n9LhaSS8EJq6WdD3td7jCnl7ncaSI1vFnUGWzbObl3O0
        F7qFu4GuThO9jDFUzYncWGMecyVZdKFfh1tmdp3FyUxgqcY=
X-Google-Smtp-Source: ABdhPJxtjyqhewqGZLK4R4hhF7olBO3bY+lX+S7KfVRrxthhYeQy6CnLgib4XD0u/LFvSvCq+91USCzqhoMmhtgewAY=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr2086312ybt.408.1623883460031;
 Wed, 16 Jun 2021 15:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210616124229.1059905-1-alainm@chromium.org> <60ca00cc.1c69fb81.e64fd.6a86@mx.google.com>
In-Reply-To: <60ca00cc.1c69fb81.e64fd.6a86@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Jun 2021 15:44:09 -0700
Message-ID: <CABBYNZ+Qhs4aMzr48LJndDCdqDUp36K_jQJuucqTMQU9442UEQ@mail.gmail.com>
Subject: Re: [Bluez,v2] monitor: Adding missing device found flag in the parser
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Wed, Jun 16, 2021 at 12:53 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=501559
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.70 seconds
> GitLint                       PASS      0.09 seconds
> Prep - Setup ELL              PASS      38.67 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      6.50 seconds
> Build - Make                  PASS      161.00 seconds
> Make Check                    PASS      8.75 seconds
> Make Distcheck                PASS      189.81 seconds
> Build w/ext ELL - Configure   PASS      6.51 seconds
> Build w/ext ELL - Make        PASS      150.88 seconds
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
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
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
