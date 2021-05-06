Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D1AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C1A61157
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 20:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEFUBf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhEFUBf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 16:01:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF0C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 13:00:35 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e190so8946632ybb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEHkGQ8ANsbVT44hbB5WFpARfqPYa7wb0E9ewMGCrlg=;
        b=dSuL0zJ99JMcD313+ibJzJyIfn7k1nikCq1nIPJHR7b6qsbY/qEGEN68zT1Xs3t6O8
         inr9tmOCU8qqyMsTdtBCq6bq1iyf+hNBl7O+ZkC48F7AMF7+XMu3Zkw+89W1N4DJHFwK
         ikjU1TI11aj1jTmArkdAWKoayNLFfngf7w9GwEFueU1uJQLtohN6BLfvoRhrqya4jFPc
         AYZIF9Mx5A0IXu13NQW66/G6a1p2seYV7uLQkvB3y8FmpKPUa5kcQuR3K6zOokXEekrr
         +AWSZyKQJG+KdpMhnbpFerlYQzwXaYkrOPPfQjExQzz2BOdGXlVzoe4iM9Oy5pUoElc3
         I36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEHkGQ8ANsbVT44hbB5WFpARfqPYa7wb0E9ewMGCrlg=;
        b=Z3eC7wCfk+8DPQWNSYtyoEQqS+T+mPQEOrBX6f/NBA1DpM8anp2vydCdFFMvxEGv3K
         p5OV1fc5mKuKO796NPRWRdn0zx1fwcXk+PZ7dNPMGqaycKK/ZOrzbHdZQE9hw3HfOpsl
         P0h7gm7w+3tEkiEIedSRF3G2fjQqKlySsvI32hVMXYrzGrcF/85RweTzQed7QfRqWiHP
         lPbTYObd+NTUuU1GoL3vzKAEx5C4TfMIikYbK2FMtMKqSyK/B12NOaj1l3+PKZANMfNl
         8tNo8kkjARxDYUde6CgP+645xMoXEIVcZIrjDYObcHHvQcqf6CcLzE+Oj5Yyh/6xfjXU
         wpjg==
X-Gm-Message-State: AOAM530BzZxSWqZKaS7TnVKUejkeyk0kyN9A29CrvONKWGdoBu+/r/Jg
        MVCH5nAquNRwP9v0SJRJwTg8ChpMyII4YhCFDwAaQHOq
X-Google-Smtp-Source: ABdhPJyPDx0DiJAS+XxmwwnGzABHxxYDLsFpWk2PR6mo3kgrtG91tXaNk1Ti3m0LcfoSRsuwtJggTph8+ULCHUdVhiA=
X-Received: by 2002:a25:dfc3:: with SMTP id w186mr8117595ybg.440.1620331234518;
 Thu, 06 May 2021 13:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210506114234.Bluez.v3.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
 <60936aae.1c69fb81.e4bce.68c2@mx.google.com>
In-Reply-To: <60936aae.1c69fb81.e4bce.68c2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 6 May 2021 13:00:23 -0700
Message-ID: <CABBYNZLJz72FtfU3+ruC=VGajb2c8f9RcoOmOtuKmik4_1cdfg@mail.gmail.com>
Subject: Re: [Bluez,v3,1/2] PRE-UPSTREAM: unit/gobex: remove timer only when
 it's not removed yet
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, May 5, 2021 at 9:05 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477667
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.33 seconds
> GitLint                       PASS      0.24 seconds
> Prep - Setup ELL              PASS      40.93 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.15 seconds
> Build - Make                  PASS      174.64 seconds
> Make Check                    PASS      8.56 seconds
> Make Dist                     PASS      11.62 seconds
> Make Dist - Configure         PASS      4.47 seconds
> Make Dist - Make              PASS      70.64 seconds
> Build w/ext ELL - Configure   PASS      7.16 seconds
> Build w/ext ELL - Make        PASS      164.49 seconds
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
