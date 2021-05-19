Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3330C60FEB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 03:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353090AbhESDwD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 23:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbhESDwC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 23:52:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC0C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 20:50:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id di13so13671889edb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 20:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CCsV9zbyDAqoRzIwisZAlNKiKX4wTpSGZ1VQM3XsayY=;
        b=AMP0aGlliauaDWVcWr/yp+z6hBrs8YaGq/GSFbBKNUUC+rtOU6ZYZqAsOrunKYjiLf
         0LkBnVbgBCkqxfit6aYHiYKQdA1khJA8NUbf8r4A3n2MWIECwstm+G8FeVddGfjBUwpR
         5MZag3DzbeinbaTV3ObSdfq7XUbZPHDn4eO8WOA2NOgN0FrtDvpc7xSaafXvvzXtcoNg
         B7xkUmB3v3BTDAeLdq3JQDp3XzhcqYyOLbDtqSWIHAqf7n2jek8b9UMOBP0dsiMzF2Xf
         mJLOxO7n/MyPNEqhUgvgI/NEbp1Om7SreJFnqbI+dqT37thJKU+EUUnnbi+uth6hbg8a
         kX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CCsV9zbyDAqoRzIwisZAlNKiKX4wTpSGZ1VQM3XsayY=;
        b=ItZ6f08mMoXzeB+jyyKsVs9rEY3TNMl8K6H0XobZcNfyqX53lB23OF5Pq85ma06m9X
         FYgqk6C3nXYKQU6YZ3IFTL8ymKRB46v03qLA6wCRd3cZ3RQqxDHM7Z6eBhf/zcJbc0I4
         llxbGr3Zhq2FA4g9ZVVCbZNim9G90tZP/gu2spSGt8MU2RysupCn6FzM6sQC6LXVzLTs
         K3nvB2W3wiwZsQPCLiaS7HZNJ9mzpI/GwGMwePi7e+h9zGkWdyBMQ5RpkiNYIjjyUZaj
         CgWyNpau+HSIKync33oCS8pllrtUR4X56GLuZwXX1YAHcGFvrGsCrzgl5RcTMiXfWhP2
         pGFA==
X-Gm-Message-State: AOAM531IffFurAI0/2poEPxokZOuYdAOhfS/e7ffjt5zRE3jOVXYQI0K
        h7QqaZxtoa2/UP59UJz6ENQ9pKY02H+BBOEexJVEfU2UfOWEJu4V
X-Google-Smtp-Source: ABdhPJxxTsN2gyMPFE8jjVxVTmB+UjcliHUPqgmqOtbXlBqp2B313w9QvlX50R34a7vUbmQ5CDDAiCjKW7yHKgf/jFE=
X-Received: by 2002:a05:6402:12cf:: with SMTP id k15mr10163656edx.332.1621396240289;
 Tue, 18 May 2021 20:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
 <6094c6c5.1c69fb81.14b93.8c78@mx.google.com>
In-Reply-To: <6094c6c5.1c69fb81.14b93.8c78@mx.google.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 19 May 2021 11:50:29 +0800
Message-ID: <CAPHZWUdzQ1zRq3dc0c+d-RMT22tpcXMPVeO-pUjQaOJbTrmkDA@mail.gmail.com>
Subject: Re: [Bluez,v1] core: Fix loading AVDTP options
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluez,

Gentle ping.


On Fri, May 7, 2021 at 12:49 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=478213
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.31 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      45.60 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.95 seconds
> Build - Make                  PASS      193.97 seconds
> Make Check                    PASS      9.40 seconds
> Make Dist                     PASS      12.46 seconds
> Make Dist - Configure         PASS      4.88 seconds
> Make Dist - Make              PASS      80.65 seconds
> Build w/ext ELL - Configure   PASS      8.34 seconds
> Build w/ext ELL - Make        PASS      188.95 seconds
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
>
