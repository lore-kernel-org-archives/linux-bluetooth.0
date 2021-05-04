Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AD1C43462
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4BF6121F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 23:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEDXwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhEDXwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 19:52:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E390C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 16:51:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 82so342392yby.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTsuDnQgbRiXZDtiBvqP4RzKkrin4of3HiWGpC7Zl2U=;
        b=bQm42fGgeI9ON06pBmiGzZ2XTPuMdwWMWHGOOSrZmDxYyJH05PlAUsCOkoFQiU5Qu0
         ARPQjADN8oz76r103g2H5mxPZRXCRj3Ktk1WFSGktDEZB4f6ZcCiN2u6vhOP0VQsMwpV
         6oIDago4OO/hMeK5k5+QDqLOy2C9dxQvPqXuBnu+V7wyMaaikJb2m1Fgg0ytxESxWp+9
         nRvzTovdiMCLVFNkKVhcj4cIG7wvPUB+ZCGd2MUEc+jkWnM46aolF5T+roGNoNycJjZ5
         joO+JCFmb4zG2UeU1aeMAnDTDRnAzRMN5l5EWfs31bVI0bW5RR6kBnKG0SlJahQ//D5v
         JClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTsuDnQgbRiXZDtiBvqP4RzKkrin4of3HiWGpC7Zl2U=;
        b=RDEbCk1zSGZFjHcih/yykreQmK3Qf+SFqYRRXBybA5HglYd3NOTzvwPte31sT/JCYJ
         LotMz0YmPx0Ig+f6NrFNh/K86HHuAWu7lD+6B7rsaa/kNk+RaEPdysm/cT1q0Xg0vZyp
         9Neu7tIXaxmNKLN+uNKw/2h5MNoJH61xiAcBKCDtJyXpOs3M4PArS33MxZANncpcC7vG
         UlvDZ0Swi4zFYII001jOKCHcOZwVulYcSxLth5tlBb2Hs7MT44DtE3SZqmqWYgajyTrM
         g2IjQfoVl1c9wfXQufCabgkPY5Q6+ZG6jphXIyqx+NAa9/dmHOXvK1YeBq7EbDb6+SrP
         f+Ow==
X-Gm-Message-State: AOAM530hPdPru2KEIWYtMZk2GxOUPg4WAlg/yhtpIO8DtqjLhSB1Qi6v
        nkYFQQq4cTnHtOwZTWKhvcdT2pZS0HrBWji6CqwCJUq5
X-Google-Smtp-Source: ABdhPJw8ciwc/jvbvKsC9455lwOjN1fiWOAIPNnQ+O5n2BMUaZPcTDxpV6TS6WA/rv4vRAYSsGSZaMIijOfFNXeUTzE=
X-Received: by 2002:a25:d1c4:: with SMTP id i187mr1192751ybg.408.1620172271615;
 Tue, 04 May 2021 16:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504195953.901987-1-hj.tedd.an@gmail.com> <6091b0a4.1c69fb81.7e1e8.984a@mx.google.com>
In-Reply-To: <6091b0a4.1c69fb81.7e1e8.984a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 May 2021 16:51:00 -0700
Message-ID: <CABBYNZJW+_x1V_6VtxG7yDR2PYA3JepUFwvuNqvKBd2YUztFiw@mail.gmail.com>
Subject: Re: [BlueZ] checkpatch: ignore SPDX license header check
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, May 4, 2021 at 1:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477013
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.41 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      39.89 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.00 seconds
> Build - Make                  PASS      171.28 seconds
> Make Check                    PASS      8.62 seconds
> Make Dist                     PASS      10.72 seconds
> Make Dist - Configure         PASS      4.36 seconds
> Make Dist - Make              PASS      69.25 seconds
> Build w/ext ELL - Configure   PASS      7.00 seconds
> Build w/ext ELL - Make        PASS      160.22 seconds
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
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
