Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB682C11F64
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D7561C67
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhF1RiP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhF1RiO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 13:38:14 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD3EC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:35:47 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o139so11795929ybg.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=voOq+qU291P4Vxfx4iIBWti6qmTh+xPpJemjqxUPzVk=;
        b=pdumb5hcGSh0lb97Y6rC0rcPxYlZ2BIWX1VwlV9R6q0ss+1K052JsPYo8yn4Q3SoDR
         qyoNS1xkvh0fNGwnCTYHr8lGPYBv3EH3mJzs8DGcSZMqgisRGjUxjpnFYVTe39aw0fn6
         yorY0OUJE7xIuWzv6Qnuw2IoJcUTUmUoHr4JbuAP4hEA78FPflCqj3yl5F1+hIoH4LFq
         XXAnlQel5P21ag2ZSQvHb7PLRxgO89Cx8InfAvfNLFhc9ZPd/nXeqHy5F6isHEQBaQDY
         P+9dTgYEGNr1JeFPykP/PaWf0FWN5NfGQGKR9/E2F4raUJ9zJH014fVL9zrnJvRnWz16
         yB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=voOq+qU291P4Vxfx4iIBWti6qmTh+xPpJemjqxUPzVk=;
        b=Tni+HtDyy0n0MTt6EeojFlaTVAHhFH4JGRUlXCTJ6B5pNH80XE3F34qntSD76wA2Zk
         sVc9Zzk/W9agL+LFbxFNFHkYbuICUBPLFCFPR8b6Tfq/crY1V5roV+TNrhAZa3X3E0TD
         7WqS1YUb14mX7PaRZ7y13Rp9AZO80O2IZCnNNITICc+futGIivvo9ub4Ccny2dzQvBbU
         t27E324SbeI0sGzH2af5BnUeaE7xPEMmhsufCxhbGKfEnQ7f8ELn+e94RriIu8tDfC4x
         x74kdjw6wV5nEsoYF1ovw9U5gyM6H5Za3bDChxouftJLVMuOhmaBh9vqJ++nuu2h3dT8
         /MpQ==
X-Gm-Message-State: AOAM533yHux0/j8yiP4IYXvnsYkHu2ZFSzJLUVE7n9d3N8KxLa55aFbW
        VNM14pin9v5s0FgmB4Sg3dbj7rWlqqyRVEbbnhRhjfsoF/0=
X-Google-Smtp-Source: ABdhPJzwQmzWc/8OCiloJJ5rOBLcWaCwzk9TTwZcYWghgvKWKeScIAl4KqcDS+bKB3VhLgrreafAjDcwqIdH1M1uJBk=
X-Received: by 2002:a25:b741:: with SMTP id e1mr33787830ybm.347.1624901746923;
 Mon, 28 Jun 2021 10:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210624220844.3920039-1-luiz.dentz@gmail.com> <60d508e3.1c69fb81.879fc.b632@mx.google.com>
In-Reply-To: <60d508e3.1c69fb81.879fc.b632@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Jun 2021 10:35:36 -0700
Message-ID: <CABBYNZJJsz77-27fOYsDFqP4i3osrEd3MTf_yCCC8ZtDmBhWgg@mail.gmail.com>
Subject: Re: [BlueZ] adapter: Fix toggling of experimental features
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 3:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=506771
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.41 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      43.31 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      7.61 seconds
> Build - Make                  PASS      188.57 seconds
> Make Check                    PASS      8.56 seconds
> Make Distcheck                PASS      222.79 seconds
> Build w/ext ELL - Configure   PASS      7.66 seconds
> Build w/ext ELL - Make        PASS      177.18 seconds
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
