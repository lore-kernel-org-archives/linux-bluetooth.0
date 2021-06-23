Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF65C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A546128D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWWF2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 18:05:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603DC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:03:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j184so9238722qkd.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkEerW1BrooF0ozmfUmE6nBmw6mt2MKXbXtu35AzLCU=;
        b=Ff3ks82J6Mj/jzr+WrPTVB5Jl3bmwIG2O9thrRjtPpE+54x+rTCiMqXDvOGpaqohna
         WhgPbJnzR1E4hE4hV15n/5lb9JeLdujVsQrb1nV14UaSh1y+Lr2VyZwXS+461GEUAMqN
         Nvajt5qK46JqJ8wykMJ1X3BZgUmXwM6mJhb+52FRp101LB+5dEpTlgi3l2lWQtIbewtx
         5dzJ82BQY1K9oCWGBueqlF0lAqNl4OiAdTfHMzI5Rkd/Q/i8JFOTOebyjhoyMqB8kXFI
         FfWEpYqb93lH4ItEi2zlgh/wkH4QRVNHeSkWfu6cCdTsGShqJFYgSUxMXGHCLBTHRZPX
         Mazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkEerW1BrooF0ozmfUmE6nBmw6mt2MKXbXtu35AzLCU=;
        b=fvFeePewBWokOFiUmowmJkRwMJ1bDP2YPETlVS6ycBZp0zRdn5KVp7RDAsQcUkhjzJ
         tztcVEpfXDQSNCjoHLRJB29jTAA/Mi6vryKG6/KjP0e+/sR48ZFclZ838T6NiLN11zn7
         r01neJhQ5o3KAtf/LumFsTCUy3h8EAhaNo228XoHgtwLQHwL7PcGFSyl/zADH6hknveq
         0vdR94xrOtPwkcjbIsEcMWedGngPICcWVCpUhl2j5A4ZByb+W+3K0lsdHdVA6DBr6HlE
         VLdK7hWFlRs9jU+e5c2BiPYhH52pAop4Si/SKPnozGUwk9vZ/1H3hu7xZv15zZQdQ+Fo
         BlAQ==
X-Gm-Message-State: AOAM532dJ+CJI804bg4+CbfFhgTfiMf5aHLm6Nitq+j/xA9EUxpUQm/L
        QpkHDQT4VfiprUlba7TfeC00ftKmY1puc8KtjgXgL4isZeg=
X-Google-Smtp-Source: ABdhPJyMO4EJd0cAfYktfhvt4heeGEyC0OMY+4Bjjkl/Z7unXOUDiyVeDUvxPTpIoBPpqfmYTqFG2rZeJ8wj+j6mq58=
X-Received: by 2002:a25:be02:: with SMTP id h2mr346048ybk.91.1624485788629;
 Wed, 23 Jun 2021 15:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210623044944.602205-1-hj.tedd.an@gmail.com> <60d2c131.1c69fb81.7b32d.c122@mx.google.com>
In-Reply-To: <60d2c131.1c69fb81.7b32d.c122@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jun 2021 15:02:57 -0700
Message-ID: <CABBYNZ+fYptEVjx6fvLgF+tVccaU=XM60paunOpK_eL3Hw0u6w@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/5] tools/mgmt-tester: Enable High-Speed(HS) test cases
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jun 22, 2021 at 10:07 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=505495
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.53 seconds
> GitLint                       PASS      0.56 seconds
> Prep - Setup ELL              PASS      40.42 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.04 seconds
> Build - Make                  PASS      174.30 seconds
> Make Check                    PASS      8.99 seconds
> Make Distcheck                PASS      205.52 seconds
> Build w/ext ELL - Configure   PASS      7.06 seconds
> Build w/ext ELL - Make        PASS      164.15 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
