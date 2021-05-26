Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0850EC47088
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 21:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AD661378
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 21:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhEZVhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhEZVhR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 17:37:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E8C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 14:35:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r8so4115061ybb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iE0nYOvLWAhA3Zu11AaU5AlqueR0HwNNvroOxFsHr0=;
        b=Lu/AeonYnmW8ikk6Sg7EffFBtb3clgv3SMdmy3Lhlg3/pO4yzqjST7zI4DszYS3shu
         FYith/LtqTZs+EY8SAWcOkghb08HZPM9Bhy+FgdAUMThItT2ewAGvH5yhhQ2wP3rc2VH
         ks5uLt8+OVe0JYyi78Mfph5X1k54rJijyo83SxqX41x4WC2UPZthdh7Tp8tA8UZ5irBe
         pe3Lc+nxvl5vhYsaNtWFCbmOq/Ryo6nHnuL1xrrK36MirUYP1ydx2hXuy0RFBNJQMx6Y
         MlpzMOsN76/rN/dWGLkvWBbXAaeaIBaYsdk6vu4EcKdNhWbN34kTMZjkwrkXy10icfrf
         7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iE0nYOvLWAhA3Zu11AaU5AlqueR0HwNNvroOxFsHr0=;
        b=GQ7xc8USWdfjmKD48gq/UlLu7Xcubm4zsyiumoJot5jT7gou0XWKAEFC4/6X+Z8SnV
         RNDktT4rub47iVXg6bHm7KtvUfZdBX4yqfEE18EnWc/8S1Ay7oAgyFgvjGUHN9+x2O/v
         BwIooOLORpjPljKtrDXdDj0jGZrzOQvWpffXDAT1u5l/nfuikX3rtlmIJOLre6JhNdWQ
         OHp84o4lPTxVsxqRaFQVNuLEGHyPke3A8rvkfkSd8YPS+eB7GxwW2UJM8NMQcRUuBlZH
         ca9STGDM58qSDEVF7qcghz99ta2nZhRI5sx/M+28IoYF9TVu4Wn3H8GwpauIG6tVnvHY
         /Qew==
X-Gm-Message-State: AOAM530HzNg41GHpiWsAjDNEDiNnJ21oufIYuF/YNQuTUEDM3x035JC5
        8XUnSrkrVwDTzybHBwBwry0UV0qbt8FZYK5F9raW0Kdi
X-Google-Smtp-Source: ABdhPJyMm4QA70uD5+CehXcewB/iYZ++ViB/O4kmtoNYb8m7xTqxftJG+VJJMuwzENVg8H0HToVmbbzk1ug9UHU/7j4=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr110399ybn.440.1622064944269;
 Wed, 26 May 2021 14:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210526051310.423630-1-hj.tedd.an@gmail.com> <60ade054.1c69fb81.4789d.704b@mx.google.com>
In-Reply-To: <60ade054.1c69fb81.4789d.704b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 May 2021 14:35:33 -0700
Message-ID: <CABBYNZJYJDcZ6pYtmqH5y0HtFFtMy2LbSCUSNS9srp3EuNqXmg@mail.gmail.com>
Subject: Re: [V2,1/4] tools/btmgmt: Add device flags commands
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, May 26, 2021 at 12:54 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=488567
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.38 seconds
> GitLint                       PASS      0.46 seconds
> Prep - Setup ELL              PASS      45.66 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.83 seconds
> Build - Make                  PASS      190.51 seconds
> Make Check                    PASS      9.47 seconds
> Make Distcheck                PASS      225.24 seconds
> Build w/ext ELL - Configure   PASS      7.66 seconds
> Build w/ext ELL - Make        PASS      177.05 seconds
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
