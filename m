Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C662C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6185261289
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEFWOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhEFWOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 18:14:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F4C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 15:13:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e190so9388221ybb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/Bhh41Ec625zyQw/v+189lnEinswBC0+peSnHmsoyc=;
        b=rBFqhG5V32jusxq7Qr5pzqeOFiBRSwfSHqcxllOvFpoiEMindwJ4GsMdeBCX0Z8ceP
         WexoDN95HRXVwUbXKLIgKIqid4axGUe9HqvtpJc7DO/Oze74/Ilso/+nFzQLy9v8YHNO
         Zz3stVOII4cTceR3jVCCZxJYZSLGsybj8OsXBgxR0HxnzJOsODQ7gR+djBFDMdcKdM31
         UBCVtppdo23bVmX47QU0jq0J8jCiPwqVcOFc1me6DXoUZQG3rmpEXhfxmtbKWH3fF2GA
         W48psMnT1IYteqjoRGkjl7OHUHcQH1Em6SCz4bgcLC5/N5kWihEOQNcs6ZF+ODAGLWbL
         L3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/Bhh41Ec625zyQw/v+189lnEinswBC0+peSnHmsoyc=;
        b=rWb7iDVSOtVbx8AVofem4I4OGGjMssZr4hLk89PWAD7chZXgORiVQFCzGXMsXwqhd4
         +faxyELWRVVjGE0q+DKYp9Sm4TaechkdqYAZt/wrfCnwBYTfJm/xCvgpLL5Xm8HuW6fA
         5K2jHm9JVpe8npENAJ8jOmK+xuAKmWmEsDXLVrTIgQbQdvtKttchSO4SfBm32vREoKfV
         kF8TV5W4mudeIWm6kqC1GiRUIIbU3431n2JqBUxyrm/+p6FWd4Eg5+CfmeEaUG47JMvW
         46eZPqBhzwV0DtFnrvxhBgcPfdihpaGmx/uWHzZHp4QVfsUyBt28mki8KL5TyavAFAj5
         UFwg==
X-Gm-Message-State: AOAM5308qkob/bSr/dDntBrn4C8WChPWnyS31XkxNec5D5IN3/mVMODi
        rJMOgL1MxHwa90PHsB2//XdVgjmseXYICzM6tNv9Q4Gp
X-Google-Smtp-Source: ABdhPJzBOyCRuxKeLPLS6Q7h4DXg0Jrg1DR1wME1+hBw2ljACo09V8iiHlkkSr2zV4AzvVXUIBsIrbtRhLwLLf1icOw=
X-Received: by 2002:a25:d1c4:: with SMTP id i187mr9559777ybg.408.1620339205098;
 Thu, 06 May 2021 15:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210505184405.1077111-1-hj.tedd.an@gmail.com> <6092ee0e.1c69fb81.f2cae.13a2@mx.google.com>
In-Reply-To: <6092ee0e.1c69fb81.f2cae.13a2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 6 May 2021 15:13:14 -0700
Message-ID: <CABBYNZL+Bbj4CXEWYCbdBpepRKKk8UorNKPC6gkfN0HhP7RmQQ@mail.gmail.com>
Subject: Re: [BlueZ,1/2] gitignore: Add generated files to the ignore list
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, May 5, 2021 at 12:14 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477477
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.77 seconds
> GitLint                       PASS      0.27 seconds
> Prep - Setup ELL              PASS      52.92 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      9.25 seconds
> Build - Make                  PASS      231.00 seconds
> Make Check                    PASS      9.59 seconds
> Make Dist                     PASS      13.58 seconds
> Make Dist - Configure         PASS      5.69 seconds
> Make Dist - Make              PASS      92.58 seconds
> Build w/ext ELL - Configure   PASS      9.32 seconds
> Build w/ext ELL - Make        PASS      217.51 seconds
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

Applied, thanks.
