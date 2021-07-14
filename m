Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E8BC07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD58361260
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhGNSoX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhGNSoW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 14:44:22 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F909C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:41:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y38so4836846ybi.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RScPTB3t1rBaNBbMVAausEGjhdfoFJpiuhtymXSPgbM=;
        b=pR2ZNGLUw8WpjP7KzRgc2l1c2j6cP2UnPGO2bDWmyvV1VuO9DoehkO3j/+fYB61Qnf
         uaLaaI7ZLM7nAlTg6EvSudjUFtmDvaxO94pXBDqekTmh8n6KHAvwO8tF1yI0/RlNVa6s
         Zlublt3Ba7VqmkaRgcaV85k+ntmYghzdtkCzNFYf+/u/gRofnbBTfQVJqdV2pNyeFiwQ
         jc8dIFPtXKCmLpr2i8xCywldyVa5JG50l47Vijd8+6xAwT5f4o2GM2fC8h1W3FR3mrmt
         2HbSoB7ymEzFVkETHPTa4+5KDVbCdROMI8ZAEB4LIulTrtPUVeB2y1qf86BV4YN2azM1
         BOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RScPTB3t1rBaNBbMVAausEGjhdfoFJpiuhtymXSPgbM=;
        b=OdZ80bQxispT2fb+OVlmkDoo84DRmHEnt98M/l4F+SF7J6AMfudxZTAt9/2NE2rtOm
         ZYMd/BmcrLEU8Jt1u78Cotdal1h7GMnsMxn7mOqXSo5aCk3mu3XFg7PnzsWLIPbccqM8
         WLlerHFLikdeQaRxU8dF7AcEDpnen9rlNmcESdzIwwcJx0CARpOuU1Bb0809DEV4vQp+
         RhiaBX8+LIgV/wC7UrDrMabKCLYobOVbiiOZ+mNm+uFMRz/N4fUHOGJSxyNDRwsuIhP7
         ryqsvXBK8NnlI8UiYdVHOsslCWYsBbJe449MpO8kVOUYPqXgzMSDu+YheZjeVYgNQwsG
         G7Ig==
X-Gm-Message-State: AOAM5308QMm4A3UzwQk/aU59WVPPrkxnc9/hFbtCTJmkiHfa9yRpNw9W
        UHVFzCuVI1nESoF5FFIirHAsx51A8KGMoM6DCkHFhDGEEGc=
X-Google-Smtp-Source: ABdhPJz6Y7DCbT9TsKpdI6LgIqoDO7HAQ3mY5vdmWGoE8Xr2r7BrsJuwfTJz/3qatqFiP4m7HwWQz7fxJLh/xLnt/Qg=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr15866939ybu.282.1626288089456;
 Wed, 14 Jul 2021 11:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210714170153.Bluez.v4.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
 <60eeb030.1c69fb81.805d9.5088@mx.google.com>
In-Reply-To: <60eeb030.1c69fb81.805d9.5088@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jul 2021 11:41:18 -0700
Message-ID: <CABBYNZJ=oT9BdoyWDdiFwFj1FCaNruEnTi1u-E-U=9CM7DdYZw@mail.gmail.com>
Subject: Re: [Bluez,v4] a2dp: Fix crash in channel_free while waiting cmd resp
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 14, 2021 at 2:38 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515283
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.34 seconds
> GitLint                       FAIL      0.09 seconds
> Prep - Setup ELL              PASS      37.99 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.53 seconds
> Build - Make                  PASS      165.22 seconds
> Make Check                    PASS      9.22 seconds
> Make Distcheck                PASS      193.33 seconds
> Build w/ext ELL - Configure   PASS      6.37 seconds
> Build w/ext ELL - Make        PASS      153.23 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> a2dp: Fix crash in channel_free while waiting cmd resp
> 14: B3 Line contains hard tab characters (\t): "0x000059f01943e688      (bluetoothd -avdtp.c:3690)"
> 16: B3 Line contains hard tab characters (\t): "0x000059f01943928a      (bluetoothd -a2dp.c:3069)"
> 18: B3 Line contains hard tab characters (\t): "0x000059f0194377fa      (bluetoothd -sink.c:324)"
> 20: B3 Line contains hard tab characters (\t): "0x000059f01948715a      (bluetoothd -service.c:177)"
> 22: B3 Line contains hard tab characters (\t): "0x000059f01948d77c      (bluetoothd -device.c:5346)"
> 24: B3 Line contains hard tab characters (\t): "0x000059f019476d14      (bluetoothd -adapter.c:7202)"
> 26: B3 Line contains hard tab characters (\t): "0x000059f019476c3e      (bluetoothd -adapter.c:10827)"
> 28: B3 Line contains hard tab characters (\t): "0x000059f01949d8d7      (bluetoothd -main.c:1114)               main"
> 29: B3 Line contains hard tab characters (\t): "0x0000787b36185d74      (libc.so.6 -libc-start.c:308)"
> 31: B3 Line contains hard tab characters (\t): "0x000059f019433e39      (bluetoothd + 0x00026e39)               _start"
>
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
