Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EEC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9761285
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFIUXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIUXn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 16:23:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1BC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jun 2021 13:21:32 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f84so37371344ybg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rZDX+jMYeYNJrK497s7YOmEDLjX8ua4lDM4bzN97/dQ=;
        b=X4uZzBNPGs8/zftVyZMNSl5eYcGEW81S36HHbrvHgpQmwI/6cu3WPqiQVOlOzSS9Mr
         YeSfNvJ3yjkfs4VoQkicEoF2hsV3UIUpZ/lYM0BlgaEnhOk9HpSSb21Xb+oBlrg93yuP
         VBCdTRweQC8N7ZGyEaH35Gdgjxz/b+A93pvyFitaCFPNER0wkGNjgfdQMRDEQ7jJ9yxR
         PriKwdB82MlMxC+6vnW9i+8iRtZgstS5AzAWYO+GvfJ1ZuEqdHU+pAHbD2u4TDc4hRH1
         FFCc03H2+hBwJ2IjloUJv0dIjbdn3fr3Hb2Mi6Vlr+t/Ko1H9WAKqw/FXAr/NL7EsRBI
         NLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rZDX+jMYeYNJrK497s7YOmEDLjX8ua4lDM4bzN97/dQ=;
        b=KexDujrsFpXz4HUIs27VdosMqHcUaLLDRnEVQu50netsO5xuOgHTdB2R2dkrqncFZt
         pzIqn1arNvhv8jEQNcXI5HnH48QnkN9z2ImGgVfTyApKcJOwB35qmLP+kVNvn2M9/iBm
         2WzYu6TWX9v0EUNBwKaCf2fLDjY/6FWvqQGLFly5FBRXDvHieBv9yaBQyuwRnX6r6Hvk
         rmwWW4pF673cR3xSsWU7XqNbl88zci2X3KlvDfmOYO5ZIkHuXfDCDAoaZAIDH1jkKQ9j
         WqQH2EBsAslljZLpBdMB3Ixpu+s2Eg6Q3vsrI5k3S/z2xZaWg7gG3JlxHHcEk3C8V0Hl
         iXsQ==
X-Gm-Message-State: AOAM5335ydUvIx7LGOCUw4FuZKDbLbZEWBisCTIKzlYRFcZxnZIpx5SQ
        GKaD1suX1t54cjyBcZKHCBhBudidXFN2OCG8pnxcaakw
X-Google-Smtp-Source: ABdhPJyOQMCJULO3BKMx1p8YZp09x7A4HI5/wVU/ETHT8lxR9Au47LhvyWZY11OeOw3yRgYUmFIpKgEpYaYiom9x8TE=
X-Received: by 2002:a25:c60a:: with SMTP id k10mr2353360ybf.264.1623270091281;
 Wed, 09 Jun 2021 13:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210607184134.2664349-1-luiz.dentz@gmail.com> <60c03e04.1c69fb81.d6c5d.766d@mx.google.com>
In-Reply-To: <60c03e04.1c69fb81.d6c5d.766d@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Jun 2021 13:21:20 -0700
Message-ID: <CABBYNZ+FGjLJHHA2nTJjSCrP+oEzeVMa=WX+kU6M83TnzpPbkw@mail.gmail.com>
Subject: Re: [BlueZ,1/2] btdev: Check advertising/scanning states when
 changing White List
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jun 8, 2021 at 9:05 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=495601
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.53 seconds
> GitLint                       PASS      0.20 seconds
> Prep - Setup ELL              PASS      40.30 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.00 seconds
> Build - Make                  PASS      173.43 seconds
> Make Check                    PASS      8.70 seconds
> Make Distcheck                PASS      204.32 seconds
> Build w/ext ELL - Configure   PASS      7.18 seconds
> Build w/ext ELL - Make        PASS      163.31 seconds
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
