Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F3FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4C46109F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhERUU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhERUU3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 16:20:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCAC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 13:19:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e190so14979258ybb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PHokCErmdxjzYLW7hry8a6GNwHDC9g3Pi3bBed5xcb8=;
        b=lchV9p4ZEuK5DBRT68soKpB/iMgwX+BrDorHvZHX18ocXmC1rsyabPncu1GfFY597H
         hg2pzXWzCqHII5+BToQ+6Y8i5zv6ENym1ElsdGAgXtshw0yjXJ6Y4SxOVmE0b6K1LUQN
         Ta8wobxlLSd+JJCcgl/8s2pQ77mCS7gyXUXlc3PSM/ieiBjfP0RyY7Nzh+uJSt4CpSgt
         0TL4DKGVINNS2UaiRgWzFtNmE+qDoFqQjEnc3dyzgJ2ojKHMg8bYM7ccqKmx5Kp35Tds
         mMvo0CFhaFSl6xEZROQjBM06JXlt/6MZm3wRD34xeBmtUoKhbgLupgmpSZESdXsn24yA
         DEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PHokCErmdxjzYLW7hry8a6GNwHDC9g3Pi3bBed5xcb8=;
        b=grvGqDvtKz5EDDPo3iYKZFyMpLiXQ1OH4FY0Akz2Yq6P5dqpcheQDSc1X/9hSUPUMr
         Q0MZ4853mo5djeJl33OJqyfF5koiXQghkGZVmgLjvyaJrmF0SZ6Z2ncs9W+d+SkW4wj1
         pH0p2afmho/c6BxW5/RnOlEYvh95I6qy2KE6wxtp4bdBcE2bFd0AvQ5EmcHz4RF3zH/7
         r97kjuDHAx2ngreTdZzowNGKdrlsa4qYGSh77YmoCF0i8PkUjf2fH2glvY+gvuLoWhq0
         b5hVvZkfSFOVNmxfDE59f1SR8tplNaROXD8YJEI9YJexH7NdbHekqn/kevnp18yKn+2f
         VWOg==
X-Gm-Message-State: AOAM533yKitltLmquGafBrLy3xULu7kTE/aWVd5oV7OyEh+TmuHrmmc4
        fFUssSuCpEZ03Wkugj2ILpJ6AHZb+KVpFcHBF+RWTYCT
X-Google-Smtp-Source: ABdhPJw5Pr79N1MCIdd4kL8W0uIG9JqQwNciW1hpKCqriNnF47p0nSAV7gYrGoxuOiFQwZeFwb53cxCyVc/etkIxkfU=
X-Received: by 2002:a25:380b:: with SMTP id f11mr9868836yba.222.1621369149787;
 Tue, 18 May 2021 13:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210517173906.575688-1-luiz.dentz@gmail.com> <60a2b11f.1c69fb81.417b9.3edb@mx.google.com>
In-Reply-To: <60a2b11f.1c69fb81.417b9.3edb@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 May 2021 13:18:59 -0700
Message-ID: <CABBYNZ+MCLj8y21dX1H5xXQ2v__sAPOx1gJJD8hz5CZDfNYnaA@mail.gmail.com>
Subject: Re: [BlueZ] btdev: Add support for Add/Remove White List
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, May 17, 2021 at 11:08 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=483813
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.92 seconds
> GitLint                       PASS      0.15 seconds
> Prep - Setup ELL              PASS      52.50 seconds
> Build - Prep                  PASS      0.13 seconds
> Build - Configure             PASS      9.32 seconds
> Build - Make                  PASS      222.28 seconds
> Make Check                    PASS      9.22 seconds
> Make Distcheck                PASS      262.69 seconds
> Build w/ext ELL - Configure   PASS      9.43 seconds
> Build w/ext ELL - Make        PASS      209.08 seconds
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

Pushed.

-- 
Luiz Augusto von Dentz
