Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031056124C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhDLR1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbhDLR1l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 13:27:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F9C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 10:27:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l131so9140006oih.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sGRN+np/fG6wnuPcLXNnb6SBlAnLW+G2WxZsSeE8g4=;
        b=IAu4lEPHBkUIW9y9IeYCiroNYyWAEglulUEQIQf7f6xJgXopQxLekKddeO2JiBF27a
         NYY4hLFlzPf/G62nZZ8lLSTIuL+lPLRTSauk43rCPdTOcn5Ic7FoLVLdjTTWw4xwlfxi
         BYMuUV/6WUcT/BMtRriZ3mKPDlUPD8LUyTN7gZo/Z1l7Ylqr5ZYcUekudg4nP4c42Pi+
         r4WVr/dO4pM9O/Vgtk/SiKq6OHrMrX5LFGw6IAH+1UAbXy+Lxw8IAMz7g0mY16jULDTd
         3KKPBnMmfFMly4PKsVulpVkfjHKS7RhcJiuiVgRWWr6eZ/nbRANH2d2ZPE81Cl9gzgTr
         nReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sGRN+np/fG6wnuPcLXNnb6SBlAnLW+G2WxZsSeE8g4=;
        b=ReWedLd0g4X8359VN43VIBT5cSA+s1qLwu9JMQitADBGRR8UIpYhB0uoKK2RLlCF8G
         cW2/Kfkekfa43g5lRGofDwoKQGkx92aavgvWOx+1qmOLo2XFfl1gPwVD3BV/ax8ARc0K
         WPQau+34itGeIROb2xTlYQ6AMdM8jj3D2PbNkISHnawRdkxe5Z8Yx9BNtecxPS99CXXI
         FV8rfXck3m7YkLR9Jk/+QXqON73dSHCgI08ChRwihI+9l51E72rTcOdsFn+o+6iwupl8
         N1giPk4fgERR2v4l9unmK5uVpAISxG91/NrZHYiUjOCrbVGBvoL6pXqCY09KEC+w/6Kv
         NrcQ==
X-Gm-Message-State: AOAM530r0IWTapCiQAjmTXYV1glokqHibM5Ua+/J4Jw15sWHVc2bN0hY
        6BKYTVuMU/Zs+VSjVxbtlsHRujmTfVHRIYtsziHidsY+7MY=
X-Google-Smtp-Source: ABdhPJys4obVArcNDb1Z1zaQBfgl1v3AZjc8DHBgfSLJnGN07dTrD2rq3bBS2CBV44J2n06Zd3+KFRt7KjtwpsGONZk=
X-Received: by 2002:a05:6808:1313:: with SMTP id y19mr151180oiv.161.1618248440804;
 Mon, 12 Apr 2021 10:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210410064605.287884-1-hj.tedd.an@gmail.com> <60714f22.1c69fb81.34b5a.77af@mx.google.com>
In-Reply-To: <60714f22.1c69fb81.34b5a.77af@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Apr 2021 10:27:10 -0700
Message-ID: <CABBYNZLJD+j0UbBTMCY+Hxv+VKHa3ZeML2hNh=eiQo0eSRnU1Q@mail.gmail.com>
Subject: Re: [BlueZ,1/2] tools/mgmt-tester: Add callback routine for
 validating the parameter
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Sat, Apr 10, 2021 at 12:11 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=464847
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.54 seconds
> GitLint                       PASS      0.23 seconds
> Prep - Setup ELL              PASS      48.52 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.49 seconds
> Build - Make                  PASS      204.22 seconds
> Make Check                    PASS      9.82 seconds
> Make Dist                     PASS      13.24 seconds
> Make Dist - Configure         PASS      5.31 seconds
> Make Dist - Make              PASS      85.07 seconds
> Build w/ext ELL - Configure   PASS      8.76 seconds
> Build w/ext ELL - Make        PASS      197.17 seconds
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
