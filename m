Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC998C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806F5613F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEAAnT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 20:43:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4CC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:42:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r8so183167ybb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvhQwkfcES6MT5+76N3iKnf5Ql/p6ew7TqaYS/pFq78=;
        b=EFHW/Ty89VhDu7p+iot2IcOar4fqKsm/xkxmRpfDUb+WeLRnxtSrFL6halsDE/qINX
         8UkHsok1cw89XmdLevZ4XTLg/PttEYzYy+vewfGsZh5+4mxOe4ytQGJ02B4yW6f2HIBF
         Zx2toBt5jXxjg9Ar04e1O+nHHD3UmK6vIpC9pWlkMO3wafcg4xQov7UBt0QaEu32TjV5
         nCAVdN2hXuBx8HIcdbuvVSMW5s0gvx5l/lfDE1X4dobR1B5Bjw5IGKNsWpnAcLtz8zxu
         yWKNwP4bHWU3LYfzwfQ8fAAFFyGRsdgQOO2YorISEI98y3wDiE3iaH7shfEyJGnfqaTZ
         Zlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvhQwkfcES6MT5+76N3iKnf5Ql/p6ew7TqaYS/pFq78=;
        b=Znd11OVNG13H1p10i36daAXnCWqWvIyZs0WGxXVCdOnosNBjemeKA/1ESszsJDPKX4
         VOVRlF2PI2k40sZMF+j8t4cMjLEO6fCkD/WMpJ5bx1DorJZ+FtUiKcgnI4N00CJ9bvVo
         AvAQL+v3v1uhD8XXS7yiTgyokKniRDggV/hIib2+4ONjCd8mO81dCgKoAaGxpI6ASisu
         WIcSU/ITnkdNN2AdQaV4zm67EUlCYTP6NusXFA3HTPkP5lvN509AXvi8KUGR5otUWRQt
         yDCepCMPtg5xaXseqam1kUHlaeSqn71RvNJEWeCwKJV9CfTE+7Xpp6sPY9ecP3bEvff6
         wKXQ==
X-Gm-Message-State: AOAM530faez/rKZCfyXXZ8hshL6+YudF+b9tYy4CYdWmlSP7UFD1AW3h
        pPYbX7qhBFSM8V7+akkvaOXUR6yeS7xZ/3SQ5UXNsuJlDw8=
X-Google-Smtp-Source: ABdhPJwBI73kJInLhKCyJ2dCvx4j2+edGhAHeaxloW/aL2bzhh+wsjbWZTdthPtMsfiDyGwpuDpw0Ww0Jc28gh52l9w=
X-Received: by 2002:a25:380b:: with SMTP id f11mr8800580yba.222.1619829749176;
 Fri, 30 Apr 2021 17:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210428225650.372450-1-hj.tedd.an@gmail.com> <6089f2ea.1c69fb81.44687.a8d3@mx.google.com>
In-Reply-To: <6089f2ea.1c69fb81.44687.a8d3@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Apr 2021 17:42:18 -0700
Message-ID: <CABBYNZ+GYngx-s-2XikYqO6dcTxONJ7nJMmuA5omDNbCadxYJA@mail.gmail.com>
Subject: Re: [BlueZ] Build: Add missing ELL headers and sources
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Apr 28, 2021 at 4:44 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=474765
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.31 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      48.10 seconds
> Build - Prep                  PASS      0.13 seconds
> Build - Configure             PASS      8.39 seconds
> Build - Make                  PASS      207.27 seconds
> Make Check                    PASS      13.27 seconds
> Make Dist                     PASS      12.03 seconds
> Make Dist - Configure         PASS      5.18 seconds
> Make Dist - Make              PASS      84.09 seconds
> Build w/ext ELL - Configure   PASS      8.44 seconds
> Build w/ext ELL - Make        PASS      194.55 seconds
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

-- 
Luiz Augusto von Dentz
