Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B62C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EF760F4B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhIAA6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhIAA6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:58:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7030C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:57:21 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id g34so429437vkd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fHmjsgPvrSgLE+WSUPhm3x3tnEKRT+I2T7OTdyvQlI=;
        b=QXs2krhE8uHasP3iMKti+omRoDF/EV8E7Z3sMjs7Iw/79MpFEqq5IeRYmj+uQ9g+va
         ep+JYvxO6RB1VJVH+PcoDpnFLnU65XoRk4U/lajIu1zBPhkHq91NhlyPcKw3OGtcHofe
         pwagxM60a8kPhgl27VGT1D3LBA3NB+cFJKfXueGDnlGCBqoqB5xQ+w0sUTRNuYf20SlZ
         Pjv+t5i7Vi/YKI+jPmcE2jRZqWkJC120ChaHwwgWqBuuaYTwl452QoCLlVwffy1ts0nl
         sitOOSFWB54kf9LXj1mgivjNeLOzrnNOdVwGum/9NNv8Wvo5wnKDRZ9GA9XFYefEvaGt
         ZBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fHmjsgPvrSgLE+WSUPhm3x3tnEKRT+I2T7OTdyvQlI=;
        b=F3DVrI5OLCK+BVKdxXpwHKjWegXdKDfbkYWvujJXx5LLw1gDQRgrmzLYyYC9NOOcCR
         NhxhgvefhdpN4Ik0gToF7yDs/QkoGIbpw8g2WKBSbokyN0w1Y1nwl71dZ8+2PeQvJwXd
         ERPpkowLTY7gktvpu/cWe6UJAoLJy/xrs5VPc6gWMp7aSLUBjgXoPvi4ITKwFBoG0gZ5
         EedILfnuwvyjOHTVRzi+EuF+u63kCwJI6TRrNGTUKaMTtpXFEeXVv+yy8gm4AF1h49pX
         Yu72KMRTWVplc49YGZCF8st1YS7ybHorOs94o8HPDew+JFpdVOLvrOCh0N9l94pR4Odk
         5F5A==
X-Gm-Message-State: AOAM530z02uOlTDVDtgM7pjiPi7VQwm7UlmPcpZWLEgtD0NozU4P8r22
        P4d+Rl0HzNluRNHtjGJntgCqODHYnxBbJRJj1J/R0xtx
X-Google-Smtp-Source: ABdhPJwFXTlCZ9FXPwGWueEhvxtxbD1X8Xo+BHkj6t6KfTnyqmlx2NHZXWpxmjdLku8gX4moQ0npVUecWHPbcYCDPcE=
X-Received: by 2002:a05:6122:1281:: with SMTP id i1mr20743760vkp.18.1630457840303;
 Tue, 31 Aug 2021 17:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210831134420.Bluez.v1.1.Iea4821c4c33d0a0f1986b97a1f6cd885427348a8@changeid>
 <612dceb9.1c69fb81.a1bb9.46e1@mx.google.com>
In-Reply-To: <612dceb9.1c69fb81.a1bb9.46e1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Aug 2021 17:57:09 -0700
Message-ID: <CABBYNZKwzXdYURteEpNmNuECaAQOgX8wFsiPB7NenaCAXTMoPA@mail.gmail.com>
Subject: Re: [Bluez,v1] btmgmt: add non-interactive quit on read-sysconfig
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Aug 30, 2021 at 11:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539559
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.30 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      37.75 seconds
> Build - Prep                  PASS      0.08 seconds
> Build - Configure             PASS      6.52 seconds
> Build - Make                  PASS      172.74 seconds
> Make Check                    PASS      8.58 seconds
> Make Distcheck                PASS      195.39 seconds
> Build w/ext ELL - Configure   PASS      6.38 seconds
> Build w/ext ELL - Make        PASS      153.97 seconds
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
