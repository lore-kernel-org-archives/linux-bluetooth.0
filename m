Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29516C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B6F61356
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhFNVIT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhFNVIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 17:08:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4939C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 14:06:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p184so17355405yba.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koYoDzALdRKLAWcK0+d3Qogr0vsnXmsAHiZPqxAL3+U=;
        b=N3YaAb3lFsr0lAwEVvjpq5J7lAd7BGdjCzOhnjOO9S6BCNfvylrGpPi5kngbKYE/x5
         GZGu+C/sBWBJ3sQVMhDQQHIoYZNia06cV6/MmLV1Agz1z1T7mopgYe0rB5VfnEF15Wb8
         q8AxR8v/m8yrUKXJ3dmVTRh32WkMN0TF8VxSYUwkda5JpGk4eBbCrW1puxW7qmWkYx34
         7YsEXro6/o5JNHPsrezKDdvxOLWngivxvR1p4yLegE01A1Xa0Yop7+9/7/muMNaFbc8R
         NZROJa/IytXJyeNxdaN5dZGj56vLJDIaTsptXuceLlk9gm7Elo4HEggXFiKs+UvFsmVG
         sfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koYoDzALdRKLAWcK0+d3Qogr0vsnXmsAHiZPqxAL3+U=;
        b=PbAOZJGEQj9Z9QdzvlvsRELsKHNUBLlyC2fwoPGh79Eqnrtud1gYANuTaBzjl1uL54
         l4IkYWjlJNHdpPQTBBWNh7LRC562zKOoczX5clyFxFvKs4OnedAdm4At9LE5r1NhVsF5
         I3nvNsQdgfQBDVtxbrotH3D3Ln8bcVYwcHMBGrlj5hrLC5vMkZhvfqU1Qf8ICAVILCpS
         oCWN6dLZWABt8udXNu7Bds3QdVeYxoezTF5cVgUmG/X9Z6oH7mtCxaZGiqTsGSjF4mHV
         BGxkq79dmYv+lOnbPMuTBhiCZIVeMgrsNWVkJmsVAwDYnUNucfX6VY+N1yVep31yMuoo
         terQ==
X-Gm-Message-State: AOAM530yZi/VRXKhCdpFNyRSj7a7lw3XI899dhMBK6N/QppSUpCmKk4Y
        bCcvmYoIhoWY/q6Y9V7AwuAwOGCb83fQM16cdNp+Lmq1GjA=
X-Google-Smtp-Source: ABdhPJwQuCE9LOG//nvMXYKRTyE4HXW4Gj0rSV4f7cBlbtyB3tApODUEMvigpCnrt5pA7tfSvfE/ZPLJyImSVktxFJk=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr26580125ybn.440.1623704759715;
 Mon, 14 Jun 2021 14:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210612095601.7654-1-surban@surban.net> <60c48fcb.1c69fb81.54cad.fb66@mx.google.com>
In-Reply-To: <60c48fcb.1c69fb81.54cad.fb66@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Jun 2021 14:05:48 -0700
Message-ID: <CABBYNZKhNVJUCEcoEQ6fuwXv93xTSY3G1jzA6gB74GDkqPnP6g@mail.gmail.com>
Subject: Re: [BlueZ] gatt-database: No multiple calls to AcquireWrite
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sebastian Urban <surban@surban.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sebastian,

On Sat, Jun 12, 2021 at 3:45 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=499305
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.38 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      47.67 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.35 seconds
> Build - Make                  PASS      219.52 seconds
> Make Check                    PASS      9.72 seconds
> Make Distcheck                PASS      256.97 seconds
> Build w/ext ELL - Configure   PASS      8.54 seconds
> Build w/ext ELL - Make        PASS      203.08 seconds
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
