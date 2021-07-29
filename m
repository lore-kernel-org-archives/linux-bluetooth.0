Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116ECC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E8360ED4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhG2VVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhG2VVD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:03 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157BC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:20:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q15so12464263ybu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lpm9z2VuC7XCxu6fyUFGyVjJV5feunrV1kR6XZzEULk=;
        b=REaIw2hBrXj8DHzuUfjhwlOue+A2gZFJRbTVp0YfgnRwWhsswSYnNu5hFcFDrgaSN3
         IXsaZ7KNQpxiSFC5YTdfa3ov7BOZCl/hUgkTA2HRHa5zNUlbraPInmpVZSjASrcoCTbp
         UvBEUh3q4343q8RaZaqV1kP0h2UdUHOeDvz02s3oym3ZEs7np4OmOaDs2zeu83vg1Qvc
         GSDKYvJCYsgBi8CkGU24lj1Luo6vNhOFezZbc0UC1LgLXPbBcA8dtirNb6A7Njrxv1E7
         3S33EXbpv61ky2tm+FIwEFpRjLv5CoEKB37854kw6oiZeavUMVa7/WiB0xyvlx7sAHhr
         9FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lpm9z2VuC7XCxu6fyUFGyVjJV5feunrV1kR6XZzEULk=;
        b=JaIEaQVEunCyDH6ba3/TBDNri5z3cmq17SVeMhnpr7ZW+twGo5XwxR8lL57oiPSieh
         p3o5+f8H86OonSshczpiqvNi4MT/+tmCIxFyRzBxYff7RqpvVejIyn5PVUGxR5b7zvvl
         02uFclhfzbF5PltIX/ZoDl6ZVtUgI0xgkiTlXGMxZunT4QE6SX1TlWFj1S0gFIjRjiBC
         R2PnmrvGB3TlZJGwylbkuSGiaqI/DXRsFe4JNIJG8BCi/TS3u/rnW9lh4JT9YlprQlnf
         Kv2x92QxcdZmz/W34qg1mzDa10pWN9RzyywsAbGW9N6cnNirzeMAMAh6JYVqWvk9/fMV
         yjPQ==
X-Gm-Message-State: AOAM533+HzQs+pmLZrb078mIQLizi6/wUtslxerQSHsebfNUol9HetCK
        CjztgXkIvg51yIMtvuVe7aupNT1/4aH3Bodz0BttyVNa
X-Google-Smtp-Source: ABdhPJxJoTdjYPMxhpjFAJkwFaCg5dWD6oQaSRchOnlHE83o08W0AjXGKNd6s4QYbDEJSfhYEjrlb8bKDHRlooJ2dE0=
X-Received: by 2002:a25:7e86:: with SMTP id z128mr9226342ybc.222.1627593657335;
 Thu, 29 Jul 2021 14:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210728204800.2205665-1-luiz.dentz@gmail.com> <6101cdb2.1c69fb81.9e653.5a33@mx.google.com>
In-Reply-To: <6101cdb2.1c69fb81.9e653.5a33@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Jul 2021 14:20:46 -0700
Message-ID: <CABBYNZJy=dPbLycjKyT0XvUJJyKcaCPte9suehjfXS-oi_St+w@mail.gmail.com>
Subject: Re: [v2] gatt: Add support for Central Address Resolution characteristic
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 28, 2021 at 2:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=522925
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.30 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      39.70 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.96 seconds
> Build - Make                  PASS      172.16 seconds
> Make Check                    PASS      9.09 seconds
> Make Distcheck                PASS      201.97 seconds
> Build w/ext ELL - Configure   PASS      6.97 seconds
> Build w/ext ELL - Make        PASS      161.60 seconds
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
