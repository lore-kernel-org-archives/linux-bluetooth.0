Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EE8C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DFB613DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhEVAbm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 20:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhEVAbm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 20:31:42 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B3C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:30:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w1so18474780ybt.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLAQmsYSLNXnyfXcgqek46lqBP6h4n2+wBBCIoMvdmQ=;
        b=aBNz7h+O75/36aMVH+8D6cN4NYdH+gdT1rHr/Fuu1HPRwNS0/LRHfNymtD0co7vg9w
         Txl4uJeSvxAKqv9cFug3bZnjqIZubDHMSDGPq45Dg833ScEcdTXH0SZvrMRi/lOPapSX
         LDQLz1upY8XFVzYRxq11JRTxIrtQRYza02fnaZXwBkzwI6P6inTCH3pzT35zx9KS+2eM
         0PWo1UCpCfk+IANr/HgPTapyESKpP8Pc0Hc1sxnMkbVHxLw2AxppLjs1CSO7m6/8QPF1
         Skl4JMTRi7fZMmy30TWJEadjJ2tgfZ4m0pBWaQpqYVTXp03cq6gp939cVp0yu/c2+iQf
         uWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLAQmsYSLNXnyfXcgqek46lqBP6h4n2+wBBCIoMvdmQ=;
        b=FIn2dEd565LTxt4T7zSHFDhX/FAUj7Uai+gbs4/+xqU0GDOCnQjlUg+PLZwKCIebmp
         CIvlj8NzGnnpEkr41NFzNiE55ZnkDyjjxq9PtBLzucnUk06JFhHra34hikSWkF4JeSnq
         WU7iVSCGRi2DuSrF467ni8/IDsKdtvFUUTqLUcyOTrIdLt1EL0Oefi+3iV5rfoxojZu8
         fk8rnr0Hfd3uoRva1zJjpnqelHC7ScelGTfbAe/PjUR90NhlCoonqzYL63wGF8ZqXrqp
         PszWb0gAQUr+6VuzYsoBYx3J8PHFAYRl3FvtyHJgpcL3+EsMW9XT36nKIgzzqD0sOG/r
         fnnA==
X-Gm-Message-State: AOAM532OmrYe/a8eC2ILR/xFF9N9ASfSQa1rLdftACFhh8Ya2vf8VgE2
        zlryl2DkjEgzs0LD0K3I6Z6NTNmTGquFV8Y4e4s=
X-Google-Smtp-Source: ABdhPJwJJw2CrSLf7dK9/WYH4ZG4rR6INLFZNvXscj9ftHJ8/VlqLnmbNYqoUZnLnBXARaqMqQ5BWVukIWyBbSkvnLA=
X-Received: by 2002:a25:69c7:: with SMTP id e190mr19160122ybc.91.1621643416929;
 Fri, 21 May 2021 17:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210511152320.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
 <609a3528.1c69fb81.be1d6.e4de@mx.google.com> <CAPHZWUf-yoBWGRtqHwL7sShgVpJT3UjRFT=sWK=g7TYnp6XuVA@mail.gmail.com>
In-Reply-To: <CAPHZWUf-yoBWGRtqHwL7sShgVpJT3UjRFT=sWK=g7TYnp6XuVA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 May 2021 17:30:05 -0700
Message-ID: <CABBYNZLi15o6R8aM=cE+-zsuxrLmZEpX736ELv=4k104rWXBOg@mail.gmail.com>
Subject: Re: [Bluez,v1] core: Add RSSI sampling period in system parameter
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yun-hao,

On Wed, May 19, 2021 at 11:48 PM Yun-hao Chung <howardchung@google.com> wrote:
>
> Hi Linux-Bluez,
> Gentle ping
>
> On Tue, May 11, 2021 at 3:41 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480039

Looks like pw no longer has this set, can you please resend it.

> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      0.64 seconds
> > GitLint                       PASS      0.14 seconds
> > Prep - Setup ELL              PASS      48.69 seconds
> > Build - Prep                  PASS      0.13 seconds
> > Build - Configure             PASS      8.38 seconds
> > Build - Make                  PASS      210.10 seconds
> > Make Check                    PASS      8.80 seconds
> > Make Dist                     PASS      12.42 seconds
> > Make Dist - Configure         PASS      5.25 seconds
> > Make Dist - Make              PASS      84.75 seconds
> > Build w/ext ELL - Configure   PASS      8.56 seconds
> > Build w/ext ELL - Make        PASS      198.40 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > core: Add RSSI sampling period in system parameter
> > WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> > #74: FILE: src/main.c:148:
> > +static const char *advmon_options[] = {
> >
> > - total: 0 errors, 1 warnings, 93 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > "[PATCH] core: Add RSSI sampling period in system parameter" has style problems, please review.
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
> > Test: Make Dist - PASS
> > Desc: Run 'make dist' and build the distribution tarball
> >
> > ##############################
> > Test: Make Dist - Configure - PASS
> > Desc: Configure the source from distribution tarball
> >
> > ##############################
> > Test: Make Dist - Make - PASS
> > Desc: Build the source from distribution tarball
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



-- 
Luiz Augusto von Dentz
