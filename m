Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25DCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95F660F46
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 18:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhHKSVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhHKSVM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 14:21:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F47C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 11:20:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a93so6450835ybi.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWRT0vYS1yUrtl9+XsBHYWCj7E2m+Q9DbUKHPnMYR48=;
        b=UNK6R3Yu9jrsxaDc1oLm7gs8Sxic34oGLYgfN3E3kyFrNW3YuhePa9w0oH607BbdIG
         p27bFy4QRHCPdpNwjusgRGP2qrJ2jiBVHqBLbe6zdlIYRYvhnUW90HXvp6RB194JnY/G
         en9yToXhBeYtT+CgyAKckQSh8hpaw87aDMzJ9XAtlHr3cPunoZGRO4y1pxG8v/lP3mAB
         90TSVbcSNaMm07Rd1IMYzZkBpa/RsrjMEtwA8BuQlYCs8PxvWORyYhxabr+UfOgHstgr
         RnzjEYl6Di5Rd/73CaUmRa0iR91A32seHUfg9d7RQjIstDOw6GvwyA+MkAZdqhme6P3w
         Kuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWRT0vYS1yUrtl9+XsBHYWCj7E2m+Q9DbUKHPnMYR48=;
        b=YVViGspt3Wy00mEdRT+OWMmcokfERU+8ptcNO3hhLvRMmKOMoUqjFI4RmrmdbA6x2u
         kXzUs/OiW/RBfMpySnEzr7IL83hnjF1al1XdeWFEzn7kGxqbfpWVpRQFepv68wxNuy04
         r1EyIYnS6HDPOoUCTIOq7qXOehY6+MrUfR8T4RsKDunCtr7CnLiY3zRsbEnDkCq/I+Q4
         ATo9ap03Z7PNAWCGSi8QH+THofusBRbaemSl9AYgvX6F4aoFSziyj5BYXyYXHEHytsBR
         mVwwn5lqMqlzi1i8oql9qGrmLQFVA5dIFBxAy/l7HzK9Lrv/CahIsmk1wkTU7loLkjH1
         vpSg==
X-Gm-Message-State: AOAM532tfwqSGvDpsAg+Oj80w5eQpMJJazhDaQytqPEHrrXptr7J4iLH
        WmVN7YYck9bOrHRLlC76hjmqocsbLZwugRm4obkzJaN/
X-Google-Smtp-Source: ABdhPJxiUUSQ1pqB+btcN1lB/BjWbOSsTVYFh/FuHSd+pn/Lj7sLcKYHqO9xcxh1DWuEuPR0Nb7R4eRr77jBHW8A+bc=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr40476054ybh.222.1628706047255;
 Wed, 11 Aug 2021 11:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
 <61137d4f.1c69fb81.d26ad.c894@mx.google.com>
In-Reply-To: <61137d4f.1c69fb81.d26ad.c894@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 11 Aug 2021 11:20:36 -0700
Message-ID: <CABBYNZKwMufxMDvef_DhvD=zKS-1szhtaF6jvSHGfvTu=C7JwA@mail.gmail.com>
Subject: Re: [v3,1/3] shared/shell: fix missing stdbool in shell.h
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Aug 11, 2021 at 12:35 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=529629
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.88 seconds
> GitLint                       PASS      0.30 seconds
> Prep - Setup ELL              PASS      39.82 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.97 seconds
> Build - Make                  PASS      172.65 seconds
> Make Check                    PASS      9.56 seconds
> Make Distcheck                PASS      204.28 seconds
> Build w/ext ELL - Configure   PASS      7.09 seconds
> Build w/ext ELL - Make        PASS      163.00 seconds
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
