Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CBC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFB56023B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhDUACk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhDUACg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Apr 2021 20:02:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C0C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 17:02:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c195so45099392ybf.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gqf2zkYhhm5xSgQZDj101wspWtOWddsUNQ9A0uJy5w=;
        b=TGODgiIWQlVLWjyrlBpE+MPCTTEuNtLA1xlFVMYikL3UBO0xwiX7cDfj6FPRVZFOo2
         18ZNItvCr5OQXGv6rB6NHszbuyjq4kO3i2J10KGUcSI8Ixtu4y6VRIe9YGAMaaEIViCX
         KozX3iwu18Aj8QYjwMttSLr/7obZW+azsLOLT2yIQDI0lN9h0WusRs8Y4r6ok0FLOs+r
         pYXAaUmvpu7Lgw9/NaxEvVvrfbx696nvWTBx86IGRx7cfrNwEeZY6EY5yhv2kuLJuGCH
         a4dqD5deGm+ZdSM96wtiazeHceHtpuctmcfNkMUnGlcyuAZK9K2NTiW+5bv/3tNOI1fn
         cEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gqf2zkYhhm5xSgQZDj101wspWtOWddsUNQ9A0uJy5w=;
        b=DGUVrygPr8fa/lN3qd6u9TCN30QmZbvjX0hdzMZ20JKSZ5EN9betFcZvYIpM5UYoMj
         PMrF/HbFylv5PfoWSb10RimJQwJR94pZ+Bmi5m7YIpv7uyHvAT7bOi68GGJhGVQwuWp3
         NegU8KYGzgF0R6hUrEE0P3/QhcQV2b74/MDknMk0/tD71OtKvfG5gPX6fDGA6zmKag5P
         yQKCq2FwYRKHdfXZGunrmVhyor3oqDexL2EYcW31OT6X/f6oWCBeCkgULj+OZzTVpRJG
         e/BQKoU6BxclqqrTcIZuVBWsI+MN0kPpACphabJww3YSHf88x90wvPLv7FOZQuxh/vBy
         xTBw==
X-Gm-Message-State: AOAM533Cr8BPyx/Ud2+QZzs0GWl3QPcX3FZhIigLZVY4ejyh6wNT1owb
        peww3ERPJ8AXBbDvOQ6M4yZnfLoAzsDegn5bBwi8wotuEJ4=
X-Google-Smtp-Source: ABdhPJweQZJYs9BuVxUdRujDISrnzItxKbm9fsOnX9hRhqMATwkYUCnL/iXJvV2zFDSLkioAn7rzN8EW5x3BIcd3bV8=
X-Received: by 2002:a25:e74a:: with SMTP id e71mr29954210ybh.408.1618963323960;
 Tue, 20 Apr 2021 17:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419163518.BlueZ.v1.1.Id327043128b54d359c7ad4bf44ec21179c7d3213@changeid>
 <607e1a5c.1c69fb81.2a37f.8f69@mx.google.com>
In-Reply-To: <607e1a5c.1c69fb81.2a37f.8f69@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Apr 2021 17:01:53 -0700
Message-ID: <CABBYNZ+e6Bf_KQYENS9x7RpteHneuMvn1GO7Oc+R_v5eweKMuw@mail.gmail.com>
Subject: Re: [BlueZ,v1] device: Reply to connect request if SDP search failed
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, Apr 19, 2021 at 5:04 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=469903
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.32 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      44.34 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.74 seconds
> Build - Make                  PASS      184.91 seconds
> Make Check                    PASS      8.96 seconds
> Make Dist                     PASS      11.44 seconds
> Make Dist - Configure         PASS      4.77 seconds
> Make Dist - Make              PASS      76.05 seconds
> Build w/ext ELL - Configure   PASS      7.68 seconds
> Build w/ext ELL - Make        PASS      176.90 seconds
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
