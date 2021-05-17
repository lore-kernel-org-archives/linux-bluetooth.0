Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7CEC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5548610CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbhEQVzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbhEQVzm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 17:55:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC36C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:54:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v188so10579694ybe.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5tOayXsPOnAy2538g4JJNCylLQnUbeWzP5hHilrcJFE=;
        b=vbOEL6CHpDteg52mGQhr/9OThYyjpcFFJuYjJJLOLJlTdDAnRTRQZOoBAoFm36e5/9
         /MjZlK4yp9SI5cJCk2RFKLQ4cPAfw++4lMY3NGeXDNbOOGlosbVslJnShj3Xcl7DdXgp
         nQVQkJRKLqsRT0kNhJL3pbRozdyWJJ3di54ZWWDTLrRpas2vVacuQ092sSnzSzRDXY5R
         PBqUe8ALLr85IHUVbgl+V1WJ3t9kS4rR/+DsaJyYqjtixK+ZozXhUQkZz1A//JIAgWtH
         MEWVQ8jPTB9mk3doqV5F9xJEGLgOig+S+EhQQ4ksYyLSgbbKYhBeUgPUy+YLFK4O2yu4
         BtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5tOayXsPOnAy2538g4JJNCylLQnUbeWzP5hHilrcJFE=;
        b=SZ3LiAmCV4OJ/ZHtSJgOplxCiGYr4M+Kj7qpRyYR6lAJtB5NrKrJE5MShAHur4I/Cv
         b46tXqs2tWWaaaSiOLYyXubJQa3hgWQugkfMqqFXFdSAjGfNkYsGgi32qTpbU1fauQv1
         wJFPmthcJGConiIcH3S4H4paILVDGD2Xj1fBMaUSRVfd0+aEx2AD6DyGBVsciR+MPZt5
         DgMXHHwG4BfZ9JNjKNHoRt5asvH5GdRPZTVwXNlRFJ7c6b8s4gZ5uzuXDgXMiihVv2Fu
         H5Hz6f4bb7YsUCsPLuVx1vSkQxlXFPIJm8ivsxxXs3hJEatyvHGL/sNSxW5jHPAwZp4O
         R0bQ==
X-Gm-Message-State: AOAM5333UER7/hzAXhXwuMS7mKu8YqiYHynRdclreZ8NY++Qcwklp6QJ
        /X3SBTkE2MwojL3Z0NriB0cLRzpVVr8PsPwxJxSTDt/X
X-Google-Smtp-Source: ABdhPJx/V5CxC9UWXCSjQORLI3tNg8jolZo5w2f9pD4LGrhak83hfPNr3b+P0nKJeuJKPg8/KsIZz3sTsY79kfsfPeM=
X-Received: by 2002:a5b:286:: with SMTP id x6mr2904930ybl.347.1621288464980;
 Mon, 17 May 2021 14:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210514211304.17237-1-luiz.dentz@gmail.com> <609eeec7.1c69fb81.51f46.4576@mx.google.com>
In-Reply-To: <609eeec7.1c69fb81.51f46.4576@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 May 2021 14:54:14 -0700
Message-ID: <CABBYNZJYDXLy++KyAoWMO+ZvUP0S3Nz9EUx9CMbUmo9=R8pG3w@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: Add option to enable experimental features
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, May 14, 2021 at 2:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=482739
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.93 seconds
> GitLint                       PASS      0.15 seconds
> Prep - Setup ELL              PASS      47.82 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      8.16 seconds
> Build - Make                  PASS      209.60 seconds
> Make Check                    PASS      9.27 seconds
> Make Distcheck                PASS      242.89 seconds
> Build w/ext ELL - Configure   PASS      8.18 seconds
> Build w/ext ELL - Make        PASS      196.61 seconds
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
