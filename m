Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400DC07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C225613AB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhGIUXC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUXC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 16:23:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE800C0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 13:20:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b13so16398517ybk.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlsJxb8gA+zlwvj6SKJ1y4wnFTg8mmYxBiX1Blbrpp0=;
        b=V7w5wQDZE1iddP1nKRPUYBgXpy+bsz1sYQ1YVG/5h+phAWzO0UcDv+3sX+AFeGC4W7
         7Z74TQuk1Q2ZtsCiaX7ga0Oc07RxnLKQOkJH5Y/E0G2IMG5H/bmeaOfsGBoANmmrSFb6
         bQiJZsAVAVVCevFqoaHL7o6qunLs6QVdyOiTBoZ+NVzy9dJQO1Vxj93c6UTTL3yxeeDl
         b9LvK+Y4YX8WsmFGiuK71ti9RqB18WfdrrvuWkRPc1oy1sxdPhdP6wnL2PUlrP/ZvYSr
         RDdHqoowJGW55JukLJNCo1DRRyUm/dR/q1u12WBj8DWb2xjBy2WO02J6kRIXwTNEJ13i
         Xt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlsJxb8gA+zlwvj6SKJ1y4wnFTg8mmYxBiX1Blbrpp0=;
        b=YMjULtGqhVrNaHE+FWUF5g2wxhUUshGmLWUpnnNLO25THlT7MlaLjTbKoqD1pUXcrR
         vPRrX8pZtAEODbK9SmM2Yx40ev6Tu/PKAQnvWqv3dAmMb5Zt6/FCrirW8/w1MSBcLfQ8
         SWnC3MzI6DH7rEInbq2qMIx+D/tzXvyew6R6vgQdqzWoagNsHap2LFjhAMiTRQaFlvxg
         mmGqcbZHWbw624eUUQymRfBrnQs95okTmBfnaUhKGWbmPqs/WIJjF1fR3Suls7uok8jU
         kMI2He2yeZOfzfl6coyWhYTT4sOmkhMFB2u5sTp5/a7f6+B0DfkDdhC65cyQQdHox6gU
         MHuA==
X-Gm-Message-State: AOAM531SvGQ4RDO4BoEDb1GrgtJANuYp6kiQkFfpEwUe7OJYvHE2YUaW
        L/x82bEbcnLEJenc4/EPXGSMQIUoolRbhbltq2s=
X-Google-Smtp-Source: ABdhPJzoP4RK9ljKr7Yy1jOWeTOtSsBjMdR+JHFd729Qv1uj43OfHnWCHq0DTU6FwnC8+4v4I2dMM+G45kdTKMBcdPI=
X-Received: by 2002:a25:b741:: with SMTP id e1mr50680911ybm.347.1625862016969;
 Fri, 09 Jul 2021 13:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210628113535.Bluez.v2.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
 <60d949b8.1c69fb81.7de68.0d09@mx.google.com> <CAPHZWUcpvuR+V43VEjVvB0qXT_eyTEdXJskPtJxBn=AbvZ+_YA@mail.gmail.com>
In-Reply-To: <CAPHZWUcpvuR+V43VEjVvB0qXT_eyTEdXJskPtJxBn=AbvZ+_YA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 9 Jul 2021 13:20:06 -0700
Message-ID: <CABBYNZ+bZS5H-RMLHb6H2HAt0Fx8bBe=av0tBTVLhN4UDFENMA@mail.gmail.com>
Subject: Re: [Bluez,v2] src/adv_monitor: Remove checking in device lost timeout
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 7, 2021 at 7:35 PM Yun-hao Chung <howardchung@google.com> wrote:
>
> Gentle ping.
>
> On Mon, Jun 28, 2021 at 12:02 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=507773
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      0.69 seconds
> > GitLint                       PASS      0.14 seconds
> > Prep - Setup ELL              PASS      47.87 seconds
> > Build - Prep                  PASS      0.11 seconds
> > Build - Configure             PASS      8.22 seconds
> > Build - Make                  PASS      204.47 seconds
> > Make Check                    PASS      9.06 seconds
> > Make Distcheck                PASS      241.25 seconds
> > Build w/ext ELL - Configure   PASS      8.28 seconds
> > Build w/ext ELL - Make        PASS      192.03 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - PASS
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> >
> > ##############################
> > Test: GitLint - PASS
> > Desc: Run gitlint with rule in .gitlint
> >
> > ##############################
> > Test: Prep - Setup ELL - PASS
> > Desc: Clone, build, and install ELL
> >
> > ##############################
> > Test: Build - Prep - PASS
> > Desc: Prepare environment for build
> >
> > ##############################
> > Test: Build - Configure - PASS
> > Desc: Configure the BlueZ source tree
> >
> > ##############################
> > Test: Build - Make - PASS
> > Desc: Build the BlueZ source tree
> >
> > ##############################
> > Test: Make Check - PASS
> > Desc: Run 'make check'
> >
> > ##############################
> > Test: Make Distcheck - PASS
> > Desc: Run distcheck to check the distribution
> >
> > ##############################
> > Test: Build w/ext ELL - Configure - PASS
> > Desc: Configure BlueZ source with '--enable-external-ell' configuration
> >
> > ##############################
> > Test: Build w/ext ELL - Make - PASS
> > Desc: Build BlueZ source with '--enable-external-ell' configuration
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
