Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94650C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 17:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E3660EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhH0RIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhH0RID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 13:08:03 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224AC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 10:07:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id i23so5093314vsj.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wKxHZUVmSu5yS+nKrEj4b06VVizFdEWYOZvfslWpmA=;
        b=rYNQXfacf3wpBbS+4VtoSafhPdQhoA7aNyg+yfqsV9Yk35vFdr0+kbNYKK3Uj8BOKg
         4soD+HbIxKwY1FLelbcap3B5/WBjnDjD5gZKQZSqsZsvrOSdJGJtScgqpiZZh1RkX8Lv
         xolcMqXQebICxYq5I64aOGcfBnqJpyDGwTLvJ1sYm/nVy9Ke69oQl0hOzMgfVlHRVua1
         dvah5GlCCGIXjtgRNiRywknkRp+3QZsnv1xjQ3sA7XDGl3IFAYSvT2rXV5bq1soKjrsk
         Vpxlz0sVdw4AVIvv1mJLF40k082lV0mx5IHX6YxDWQN2Wf/cZE5rBnr82NwB+R0pKrLF
         Lpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wKxHZUVmSu5yS+nKrEj4b06VVizFdEWYOZvfslWpmA=;
        b=hrcJgzGmDbhUZBvwe4/gz+IlaI9xQxrB3w2bcnqskRoWzZOLR0fM39hn+BYNZYntkK
         73Hil5Q/DOyu8hb2elyoi+SXQmVX48RbvHd7Qm5sX2e7z0HQ9nxQrf1vZ/Vw5yl1qNan
         pFTuHW772/WFA4DJSBjTk+7iRVBrSWxoigjdxPJ3peJvdSlabkqUTQl5bYRJ0M1Jy2TB
         wrHHK3/UWSLnscKVlAyAbJMMt49+PuMPxYUqQbUCBKgKFQbEnhwyoDhBSw7Ep/OkI8Uc
         lUAro4iIvHJvRTYWKnEPUxeY3+TX18eQOKCqUtaDk0dOGdBi7cPTmGLVlW7xLj5zTk81
         /3Ew==
X-Gm-Message-State: AOAM532Sg1LD2APMeJ3UUl0mfWOBxSsV3Mr3e67kIxJBo1zQFVF2vLTq
        zY2OMgtpLnA62Iz33DcjbBhwhMBDRb7AD3Mog61aL61Z
X-Google-Smtp-Source: ABdhPJxAHE56tmp8fN+g+PJzMK5ueHRXKHRuRvAvMK51lunjFTs2Db+2tZVQuy6hawBSxGI0IjrDiLRTGEMCETWWWaw=
X-Received: by 2002:a67:ebcc:: with SMTP id y12mr2808605vso.18.1630084031586;
 Fri, 27 Aug 2021 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210820131751.BlueZ.v1.1.I165b6fc2b20d80c8d18946434005f0269d92f489@changeid>
 <611f3f4a.1c69fb81.5e87b.392f@mx.google.com>
In-Reply-To: <611f3f4a.1c69fb81.5e87b.392f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Aug 2021 10:07:00 -0700
Message-ID: <CABBYNZLY+0-hBwAXot6KFwZEcq1YviWQ+cWpPw8AgaZ7NKw=Bg@mail.gmail.com>
Subject: Re: [BlueZ,v1] tools/mgmt-tester: add a exp feature to Read Exp
 Feature - Success
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Thu, Aug 19, 2021 at 10:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=534647
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.38 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      49.11 seconds
> Build - Prep                  PASS      0.16 seconds
> Build - Configure             PASS      8.57 seconds
> Build - Make                  PASS      216.81 seconds
> Make Check                    PASS      9.11 seconds
> Make Distcheck                PASS      251.16 seconds
> Build w/ext ELL - Configure   PASS      8.44 seconds
> Build w/ext ELL - Make        PASS      201.38 seconds
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
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
