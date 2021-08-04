Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE16C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E0961073
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhHDWDp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhHDWDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 18:03:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA1C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 15:02:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j77so5986818ybj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Uk44ztAe48lqNdLBDktAqfGNRmjNHGTeQX0gFybUgTQ=;
        b=deMIzFe7Hg3pavQlvPLPUn/0RDMVBFSWpN4VKEyqxaKQ+UfYAm0TjAVhqWJDfQuTSf
         o3pv5j0tppw3fiAoMSqmCA9I0X5uScIZ82uIfo9QMpZGuSn/hvMnJlWZKcgziNExg7GF
         AIaO4YfioDkfHW5Vb8Te8X+yz1xsqM7J1Frc26Q1VwDBhQHIGV9TRmZ4e7tXXQGHeWGi
         ILagp4Qmo9gXhwpbogOaUhu5tE6X6fAZ4lskkaniiKfr1ffFR+UXSLSb+QeALzXtgld0
         BKu/cYoviZnw4Lxo1S2NZf0iP2szfqsbzhO/M4TecclD/Dw36jOQtArWU5tVtgh2cCH0
         U4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Uk44ztAe48lqNdLBDktAqfGNRmjNHGTeQX0gFybUgTQ=;
        b=fr5CtgMM/99cJJRUqQtWC77Hy74DifyOSGUmgd08dRm8eAjrUXI1rcLYSMgqwJ6XVw
         67mgcR9JzPyDlykW1EGz3PjolnxZUgGAIJz4YwZx88BduqDejJwjNTkz4am4u8Ek7vO8
         6AgqQIYRl2a9MJlVb7VDEKPHSqSrQ1ndJtwccj4mqNd7+ej6k09NA5N6pYPfzenCvT4a
         gNbZ/lCDl4iW8nEE2rzG12Er8m2jenJ/FXhC9bxvW+5KmUR1Jb52fTL4UaORJ6ORb+ft
         zv0Xnd/pPbksCkfhTidm/kdpm2G1QgPdVgBn/BH1GVkh29QzbYBwTysVpwL3TPGgaRRj
         35JA==
X-Gm-Message-State: AOAM530KkmUQGevdZjQZFzIE52N8SxqJ/MYsKperoihjCNrjRBbgmcYh
        3ZF4zJLww6/Q3xjlZC6fp1GZUy/Eg6xcpw05tWWHhQAE
X-Google-Smtp-Source: ABdhPJx1oVV5cxDdo/hatKQI586ybaSJkjo4/0W67hCSD+vg2fvEAcF0fP2HnOlNE64WKT5yKY7LtD/zz3tAVamJKyw=
X-Received: by 2002:a25:d183:: with SMTP id i125mr2139469ybg.408.1628114562242;
 Wed, 04 Aug 2021 15:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210803225050.95417-1-luiz.dentz@gmail.com> <6109d34e.1c69fb81.ac27d.18ec@mx.google.com>
In-Reply-To: <6109d34e.1c69fb81.ac27d.18ec@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Aug 2021 15:02:31 -0700
Message-ID: <CABBYNZKEYsu8hNwNtT7gG7Uar92kU2oBwjKags8-0VpfVXyYZg@mail.gmail.com>
Subject: Re: [v2] a2dp: Invalidate cache if SetConfiguration fails
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Aug 3, 2021 at 4:37 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525931
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.52 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      51.39 seconds
> Build - Prep                  PASS      0.13 seconds
> Build - Configure             PASS      9.25 seconds
> Build - Make                  PASS      220.91 seconds
> Make Check                    PASS      9.38 seconds
> Make Distcheck                PASS      261.96 seconds
> Build w/ext ELL - Configure   PASS      9.37 seconds
> Build w/ext ELL - Make        PASS      207.52 seconds
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

Pushed.

-- 
Luiz Augusto von Dentz
