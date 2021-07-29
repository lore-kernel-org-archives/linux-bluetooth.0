Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C28C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7111960F00
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhG2VVb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhG2VVa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DFC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:21:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s48so12428197ybi.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zryx1k2fzQy92ggF+WJFlIrjnUjcfDHIatFx+mkIvbo=;
        b=OCYfv/0kNkMIUqnqOsE8iToBccD9nBxy+bzANN+cg4/ll5mzfmuZ9dZLOE7cMlHD6S
         ZZk7i8c2uotuuFw/VOjR4H+mvWz1UbiMCIERS4oUB/8e7godiRRwwigTV9uCtL4ZeC/f
         7/fZ1h5KAC+blJ08o9T2eW73XdKcxUnL/P/CWPVt9q+LKIQYF2C2XeDsX8SDRogooMSM
         3BBPozqS1nF1QVeWpnwOFTH4M4cY49U3LUapqPU0mzsOLTj3qlaze2cOE3VwJ7vhRol6
         Dv71rK/TgoTPJtTbFFXM/sHHq+iwW6BFLBkbdlPE00JfbJV0DzVhndK7kPTYPs00uIV6
         7cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zryx1k2fzQy92ggF+WJFlIrjnUjcfDHIatFx+mkIvbo=;
        b=GfT8ksoWNcAoTxXds5JcCribCvQKV9mOZOESgBUxe3XqnBk030Zk1RX1Usr/ZqROAU
         qabvKHlhTk+CghML4VguN8GNNAbwBll34wSlNijtHM28g0TSvO9DBrm3XFLNI+ta4ivS
         rPNoR0uiVZ5PYNBeuuu/4nqVvIa2EAkUKvmHdbDmhAEOix91fTUDkSbGkHf+3WLyJi84
         k9uo7ylshyDGmIN8eorZFZxfT0sA0DEh3tSUz4XdV+K0r2bESyvhH599sVdXjS3EhI2g
         R7rrMUIkQu2RmtJ8Ts3M25G7sHsqQQV+8JU9DlJgpkaWf36SapYbl5n4EmWpe3tNES43
         hxOg==
X-Gm-Message-State: AOAM5313HxS/Cg+IWHtNG/y2niNxYdRk8AzL2Dqi18UZ/AfPrXMFb/Vf
        AbQWzEzpBmKR/xM/6rILnstbpxrg+eb5jMOrYwU=
X-Google-Smtp-Source: ABdhPJzftwdFgNtT71Sgq947fvyUNbFc8I067gcJJ0y1PZczqZfsQM4p45o4UllJri5o3R6NyCSp1aKUXLk8HKGRz24=
X-Received: by 2002:a25:d183:: with SMTP id i125mr9972579ybg.408.1627593685585;
 Thu, 29 Jul 2021 14:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210715003521.2222-1-sonnysasaka@chromium.org>
 <60ef8eb2.1c69fb81.6fb78.9241@mx.google.com> <CAO271m=0yH_9oBMGeHSCWAQFpZPiLxx+ejCZyBpbFuKYhAky6A@mail.gmail.com>
In-Reply-To: <CAO271m=0yH_9oBMGeHSCWAQFpZPiLxx+ejCZyBpbFuKYhAky6A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Jul 2021 14:21:14 -0700
Message-ID: <CABBYNZKDsU1ZPkJs2ZAjkYunnaanVtxkcpt+Rh0djdOv_V_UEw@mail.gmail.com>
Subject: Re: [BlueZ] monitor: Print EIR of Extended Advertisement Report
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Jul 29, 2021 at 10:53 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Dear Maintainers,
>
> Friendly ping to review this simple patch. Thanks!
>
>
> On Wed, Jul 14, 2021 at 6:26 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515781
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      0.24 seconds
> > GitLint                       PASS      0.11 seconds
> > Prep - Setup ELL              PASS      39.40 seconds
> > Build - Prep                  PASS      0.09 seconds
> > Build - Configure             PASS      7.11 seconds
> > Build - Make                  PASS      170.91 seconds
> > Make Check                    PASS      8.82 seconds
> > Make Distcheck                PASS      204.00 seconds
> > Build w/ext ELL - Configure   PASS      6.98 seconds
> > Build w/ext ELL - Make        PASS      161.16 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > monitor: Print EIR of Extended Advertisement Report
> > ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
> > #9:
> > Change-Id: I4805e589837733e7ecf9d33218e4135e8f822a7c
> >
> > - total: 1 errors, 0 warnings, 7 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > "[PATCH] monitor: Print EIR of Extended Advertisement Report" has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
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

Pushed, thanks.

-- 
Luiz Augusto von Dentz
