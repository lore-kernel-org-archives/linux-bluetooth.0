Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9080C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8149061438
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhEMVLa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEMVL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 17:11:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9380EC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:10:19 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e190so36334439ybb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbJwb0cnUzDItfh0BjgkvPf6KtSW+K4NgHkS3/LLitw=;
        b=QOEWx/lVFOnPYb2pUXnKMfOo+Q43YJ6n9riTMGTCgZvAlPL7vxrUeUmzn37SP1cC/Y
         YN/h32pEt0EZ7kTuvNw1KT1kaMGDqm19mCwekf4uBIL2uTLoYGoXifrj8+RiDxYfJaiS
         NKKAw3N7ja8TXzh34+Eg/kav1SmB1UKRo8wAPGlkbVJACyeAwiE4GNwqxLGYp4DJwzpN
         8lN0I2PSjMpQbs7hb3TAUNlU1JUQWr08uMAqDBO+cTUVQc9HNUnK9VmBRQRcfBTb2/1T
         ctkRZsX6R3w5Qa0yZou7e9U0JkUgwjsY96LPfq0JJMUcRxyBeZSmpqiePd77RJmm5fWv
         777A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbJwb0cnUzDItfh0BjgkvPf6KtSW+K4NgHkS3/LLitw=;
        b=IZ7+lnJ3g+Vn5ALp87xpk39TMJFP29APlGw/kzDqIgO+1wea6eUpGZFX4hwiYH8UKp
         8aAGx2zZsmHmQ0aexa2xEMvr8vNYEqhGv3uwkuMveS1677n+zMmt27X94ZYgnfHERg+D
         UJZpJSSUDNXmAclCsrHDZHoYv6MPpq78ko5udV2LknGfPsow39lE/cvMEi9hw5ePny2m
         wp6WxLSKlRzpyqfLFGXA25YFIctvh6bUQM7XZeD+eK2vXYhy6u4cZgqqOSOtEEDm6u63
         UnGqtfspNA32EUJZerkIT9bMo/GNrMD98lSDAzEQbZ1BJNgxPgR4A/5/FJlB6v3h101a
         ETQw==
X-Gm-Message-State: AOAM532n7I9IqDqGzuVBaaycTN2EmVXnq1smjLEoe3VW0sq365yDXtjq
        hVFgcirproqyAZSDLg6fJdlnUAFPxbgdrAdXT61KDNRF
X-Google-Smtp-Source: ABdhPJwgjFMyn7vhAb8SL1EEHuzEkP+YSEmwxUBWQcbYBLpk/gsGBYpkbd7iFvzU/Vc94EsWsD65/ubgONA24BO152s=
X-Received: by 2002:a5b:286:: with SMTP id x6mr61320982ybl.347.1620940218624;
 Thu, 13 May 2021 14:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210513003909.104379-1-inga.stotland@intel.com> <609c8431.1c69fb81.86c2a.adfc@mx.google.com>
In-Reply-To: <609c8431.1c69fb81.86c2a.adfc@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 14:10:07 -0700
Message-ID: <CABBYNZL_9vSd_zgROn75hReVU529F4yS5wFiCfNxR838CHZ61g@mail.gmail.com>
Subject: Re: [BlueZ] shared/shell: Print help info for individual commands
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Wed, May 12, 2021 at 6:45 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=481581
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.53 seconds
> GitLint                       PASS      0.14 seconds
> Prep - Setup ELL              PASS      40.14 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.03 seconds
> Build - Make                  PASS      167.38 seconds
> Make Check                    PASS      8.21 seconds
> Make Distcheck                PASS      190.10 seconds
> Build w/ext ELL - Configure   PASS      6.57 seconds
> Build w/ext ELL - Make        PASS      148.17 seconds
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
