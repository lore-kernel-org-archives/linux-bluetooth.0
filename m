Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B5C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492AE613C8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhGNSlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbhGNSlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 14:41:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B8C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:38:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r135so4852470ybc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mqZT++4h4YXmujfXWzxiJiByOu566xXJ1TmyCmhr9Uw=;
        b=hyMpddnyS/OKByUROb2d+tfVJL86GtnBS6X6hjDGBpo690ME20FUoazbAgbiDy/odm
         GJno7ZsBOFp7EKKPmiSS7jj4oD5eiW0p3gxTI1ZIH46nRGp6zWDB2n3nLorGmL8vFZrI
         o3q4TdNJeiCmPqW0tPYNxSJq6TK/hUwLs4mlsu/QTxd5rgb/r2XeIGdEhsdeW/DA8PuI
         V8MTtd+3rozgdx8cAf75TQN7HyjAdY9xzycmLcjMZzUUSbittlxI64MfxrZmdU0W7fZ2
         +8dsKgjm2RX78NhFvHkHmeacCsb1o9cs6xQxLVdkHRm5CsKEcunMMmo9EwXAeVB2ArE2
         54zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mqZT++4h4YXmujfXWzxiJiByOu566xXJ1TmyCmhr9Uw=;
        b=ZKafsYGkggslEQiX6y9z7stEhGwMd43H99RVOYUg0si0u6r0vqKDakTRtPJ3f7pcai
         2M22oaybIecfaaNHJ0xKjUXO+Sjyq0zrBILK6zedfxN5matLBIyKB8hM81Y35II05w+x
         FdX47un7WckA4f8gQsDPmqSxvc7nBP4rVYsWY64Hb8DnFE1uiMJLDFr3aWew2cAVtaY8
         E7E1q7qEBAf0u5bulrrrD4xLn+R0NYeOuudgr2N8A3snDwc7g9/zM7bll0fwztzmyUkU
         lULaAuEjhQBM3sxkvZeMGqoRooYf31qpUDmCmi2a0t50Zo8mflSL7wSJxSOSheU707b1
         wkkw==
X-Gm-Message-State: AOAM530yUlaH0iTsPpEc+uXWeKVLvVP4gLIukK7sr+LYNEeVKa/PDUq9
        G8q/dExAMjS5c7qgNBEN0Etu18+BQEGf81KUf3LI0UE/WXY=
X-Google-Smtp-Source: ABdhPJwdcFGZrf0dnLCVCDyc7Vi/FTpZUx9nI94EGh/3W62yPo+qVuwQFqua407qZexwxgoUVXT/QY2Uq+vgBkaeisY=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr15848825ybu.282.1626287889382;
 Wed, 14 Jul 2021 11:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210714002224.2632842-1-luiz.dentz@gmail.com> <60ee3bd7.1c69fb81.73f05.1fd1@mx.google.com>
In-Reply-To: <60ee3bd7.1c69fb81.73f05.1fd1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jul 2021 11:37:58 -0700
Message-ID: <CABBYNZ+Ky8vG3yNp0R-6WM_v+ThW=A9QCwDG0Gv9AqBoeu4O7g@mail.gmail.com>
Subject: Re: [v2] btdev: Add proper checks for own_addr_type for extended advertising
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jul 13, 2021 at 6:20 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515075
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.28 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      39.84 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.93 seconds
> Build - Make                  PASS      171.76 seconds
> Make Check                    PASS      8.57 seconds
> Make Distcheck                PASS      203.18 seconds
> Build w/ext ELL - Configure   PASS      6.96 seconds
> Build w/ext ELL - Make        PASS      161.92 seconds
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
