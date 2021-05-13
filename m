Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5173C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF71613F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhEMVP7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhEMVP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 17:15:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF9C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:14:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c14so4815499ybr.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLfGfgjYXC4Pb65XFIQMRq2u/ApZrHMNzLAAUqXY/78=;
        b=c4Wlg4qtJ77QhmNBsELHYeaweWNFrJAS/Npk0+3MOtE15Ex6zKb9cZSZeuTr8GRYyn
         od6pGlE0fbYnUCSPFF4qhbW3Yis9Q9A25MZoKmNz81YVWZuTYkW3UI3KLDrvccxlWBw0
         GkbIEU2aHwMpvdO6rV0B0G3rt7a46jUn645SrY2z2RjAVXmlPAYVHyEpFZ4M67ObW5gL
         v+50Otcf4LYEi/mzrRs1N5g4LDfUgLlV6XmVZZl6lSYjdGVqu81wN3yr3U+Ixs1j+2T6
         GX5GqmJjYWi+VG4MoAPt4i3a3mqzArKDTR9QzaTNlGvpQ3W4ReyXxTjxPAIi6VgtonH/
         3xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLfGfgjYXC4Pb65XFIQMRq2u/ApZrHMNzLAAUqXY/78=;
        b=D51Or8kadS5ImC0KGlwcLkopta8Hx3L8gj755zMcMqvN5Pu59/x8LYhuFMc+57ZM5/
         gMCSpcQcT5gOKMC7hXEdBLB7UG0BUueMUpWjEBpS/aSh1FYxF0C9NpX1WHDeC2AwvuG7
         gceqfUPgK1k3c/GGi7GeXVqL80PCz9O3BQELjfoVS7x+xpeOS0kUX3PuTBSsf+Ykb2Qw
         fW0YdBlGh9jTWgyR5rvI4Vbv8mnEADg6JCIUnukTAXa2Yxi2bTDh2cwFEEgv3qiYu439
         +iHExPd8FDlRK1utfQYTdz0ZJsHd86uv4SogjjT/86oYHH9t68J+1W4N7XWx9HdfQ3oQ
         rOmw==
X-Gm-Message-State: AOAM5333NnKJRDDCBZcdMiNjkjM7xmWY8bZbQEgiG7PtVNF9hBD2AjOp
        LsEyASJjCRxGYuh+Fs13xe/0YmGhEwulXmewewj6eL/z
X-Google-Smtp-Source: ABdhPJyFprWu1f1LdH8CWEiV72zeZD5qg9jqelcoWDQUlsvR+z2uONmnXduyr42s2PYDY2J0gP+/e83uOLxbkKNGkaY=
X-Received: by 2002:a25:a466:: with SMTP id f93mr59420911ybi.264.1620940487043;
 Thu, 13 May 2021 14:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210512103550.Bluez.v2.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
 <609b4968.1c69fb81.acc3d.d4b6@mx.google.com>
In-Reply-To: <609b4968.1c69fb81.acc3d.d4b6@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 14:14:36 -0700
Message-ID: <CABBYNZLa7x6orooxc1XtjYwU1RaCgAe9VJHrVm4fKUTAF=PmMg@mail.gmail.com>
Subject: Re: [Bluez,v2] monitor: Fix possible crash of rfcomm packet
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yun,

On Tue, May 11, 2021 at 8:21 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480831
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.33 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      49.08 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.39 seconds
> Build - Make                  PASS      215.02 seconds
> Make Check                    PASS      9.33 seconds
> Make Dist                     PASS      12.62 seconds
> Make Dist - Configure         PASS      5.15 seconds
> Make Dist - Make              PASS      87.51 seconds
> Build w/ext ELL - Configure   PASS      8.44 seconds
> Build w/ext ELL - Make        PASS      201.74 seconds
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
