Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8659EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBA060F4B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhIAA6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhIAA6o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:58:44 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128CFC061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:57:48 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id l21so434878vkd.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfxIJAs5YRRykvu/ctB2dU74CoPMNMVdgLu5Tkj/3iA=;
        b=kpEBJv76BNVTAoqG7V0AfyNzO+Rsi2pf6fNRCLCVf37QWl3iqHUDEOQtk1JTABXtZt
         M72SeQtrJ6I9hYGLQL+77GqQMNV1BE9zwVhJs9/g7FQ/m5vdirTHL/cVTAu0qvA3sMng
         uCGvPakHGSADE0FhG5s9n2V8u6JJtlvlT1MqqWPm1EnfKyRJkGJYpvuR8URpw55enIhs
         yfYFFs+ndIXd14KIN/Nfn5/g8vxwXMZ3Twe3dVOgPRBUC0i3n3VaSUXrAvoncV4pWCmt
         4099EOH8tAIo3UqTcV3Mw0PJ0P5opWQAfaAEBUP53Xxf7uAgT8+dq7SukDPW2hTossvU
         IXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfxIJAs5YRRykvu/ctB2dU74CoPMNMVdgLu5Tkj/3iA=;
        b=oYZSiYbwdUO0xJa/3B8H5KT2A4UyXJchMl9jFU4aLCeV2EQWRumThUrShYjtxY6nNw
         CzVUHQWfbyWeQEMbYdW/oNxnWx51BzlQa3fJi7h4C29T3BV+n3IOmtBw4XuVqrgi/Fw5
         tjpN9pL5KYC2gwOicFf+RWoo7MMnn+cm4yILKxWXCPZy3f0EG98g5l/ENam1rMZvPZqU
         b4mXBSeMNT55Crh/+rBmcCV2BGvRlnh2QSRWF6RaeUM87/V7um0nupG/8JzgHMrKQJmV
         bJkPd1s5NyIhw3Fseno4jgxdlZ1U2my4LytndHXzyOLYybyB4jj/bNBgmiUkdwqOGYHv
         Fqmg==
X-Gm-Message-State: AOAM532KKRiyr5xD852G0JOUOw07txhpk2zQeR8h5+jF7l8iwUkxZGzz
        30GjvKA8yNSxgIMaATbifttPHU+++yXvkQ7BLVlSpeyl
X-Google-Smtp-Source: ABdhPJw7obZyjmziekkYWLU3YfgJdh2id2vTfdNCA8c2KRCR1byr4TDkEpGsJlC3CNhjczidUwuNJjYYFVOQlMpeCJE=
X-Received: by 2002:a1f:6244:: with SMTP id w65mr20186254vkb.1.1630457867009;
 Tue, 31 Aug 2021 17:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210831133844.Bluez.v1.1.Ia40feb9cf37fd87db5b5b4910c08882c9cf21688@changeid>
 <612dcee3.1c69fb81.a8dde.8568@mx.google.com>
In-Reply-To: <612dcee3.1c69fb81.a8dde.8568@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Aug 2021 17:57:36 -0700
Message-ID: <CABBYNZL3vGMv4WvMogC+RQEJZdMxsOfQsNGg+x4JvqsWgRUE-g@mail.gmail.com>
Subject: Re: [Bluez,v1] plugin/admin: fix set empty allowlist no persistence issue
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
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539553
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.28 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      44.12 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.31 seconds
> Build - Make                  PASS      180.67 seconds
> Make Check                    PASS      8.61 seconds
> Make Distcheck                PASS      214.06 seconds
> Build w/ext ELL - Configure   PASS      7.34 seconds
> Build w/ext ELL - Make        PASS      167.81 seconds
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
