Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99809613C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 18:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEJSVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhEJSVD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 14:21:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60741C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 11:19:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e190so22886720ybb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+54EMqPI1BVI38XAsQ5k/n8+3oh3R9msU5q+7SHk4RQ=;
        b=akKRBgFlfPg9Xrw8k8WIALDHi8bm0hqMWB5tgvtjoGhnTAz6ugFT5kRAL6MJ72dIim
         0at4yS+vt+OnyEakirTJmg0XxQyt3JxpmbpfdF7cyeTkdrrSJcc4EEB9j555Ybu3GycU
         /qFcthUDU2X6AquvDv1cKHKpPSgIYnAcCN0SU847lUSFx1d1K/lovnDpu/m3r3DdSehe
         /44sh//aYiUvITrinAKyPfUe2Zqqapz/v/Jy4XfDtVYDo5A80iht7SWIzwRtcC32H/Hk
         smgbq+esVJDjFtSfcxuP4cNA+vYaroIRfQA4FLSpdwNe6sl0UeYjHg9q5UasgTJ8ONz4
         /REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+54EMqPI1BVI38XAsQ5k/n8+3oh3R9msU5q+7SHk4RQ=;
        b=SNrplrOfSmnFxRhHOLusx0E0SVHlDO+JWiOn3Hf/0xztxdifQcOYt5rYw9WnSIngoa
         pkRFpW1ObA2WbWljpWLj3l3kqIHzlI/pbfIEzPhiCmLzgpxgYRLk4nIT6JZBhksCXRXk
         6QVlMN6pVaiQBEIrB414qGd8DgYV9QguXrQcVPxfWQ9C4a6+2go8hQ6xwa41NcvGTByP
         ZuVJrPwCWeMptmm1SSirxbH/ytgrreAzy0NEBVN8/5NHZoIwwADQPJP5qxknMkKAPK9E
         O0ZQi7MF9wxBuOK0zzAQGrJ9p8iafDqPds56GmfcdtA6Wt4yefrwRHh7ztOXZaH2I9Nu
         OUnA==
X-Gm-Message-State: AOAM532TF6ptiXpdF1cwLNK8yA4505O0cSZhH+AdxpXij1vXfiAQifdW
        XtoCn1Fu9yaaMAHKP9qX9ScpkGNosTQ5UIo2v/AL3eyx
X-Google-Smtp-Source: ABdhPJxp6qBg4/0AYo/cvUAIgdEeShan2LCG6Qe8khQXNjGcouPUqbmMSKMfTzja5jqkAm9NrfNphkGowH7FIegy2gY=
X-Received: by 2002:a25:ac94:: with SMTP id x20mr34808218ybi.432.1620670796380;
 Mon, 10 May 2021 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210507005630.1231205-1-hj.tedd.an@gmail.com> <6094983f.1c69fb81.c435d.7385@mx.google.com>
In-Reply-To: <6094983f.1c69fb81.c435d.7385@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 May 2021 11:19:45 -0700
Message-ID: <CABBYNZK=shxTPFDT_ozxBTiXcK0jLdcUfL41tFHgw8K=QnFe=A@mail.gmail.com>
Subject: Re: [BlueZ] monitor: Remove Pygments dependency from manpage
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, May 6, 2021 at 7:06 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=478179
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.90 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      47.68 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.37 seconds
> Build - Make                  PASS      203.26 seconds
> Make Check                    PASS      9.58 seconds
> Make Dist                     PASS      12.87 seconds
> Make Dist - Configure         PASS      5.15 seconds
> Make Dist - Make              PASS      81.78 seconds
> Build w/ext ELL - Configure   PASS      8.41 seconds
> Build w/ext ELL - Make        PASS      190.81 seconds
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
