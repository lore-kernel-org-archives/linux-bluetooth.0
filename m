Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA41C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB52611BD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhESSDa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhESSD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:03:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B049C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:02:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id l7so19239249ybf.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vd2yyo1kda9E6yf2YrE0WbVify9sVC6LuWxaJCZ8gF0=;
        b=uUVzNiIhWb61FK/RyMuRWthuvgHvOSwzDoTY0hW3Rf0oPmmubFSPlsZZC6unG+yUA1
         Tnqu2/zyVSjVBMGHqF6KHbTP5wCY/1YYhkkBgikDAa68Yc6fqsX1WbK4FRxXPKgBys6i
         4ht2FYI6ib7vRelSOEZP2KCu6y8mIVfgVMzS8KvaSAOuaP+lyyXB0jIIlH5ZIE2vJyEa
         Zac6+13aaOHs/uGi2ePj0SkkavsrufXrk6TA2H541qKrGbtBlv0IDUQ13sGwNgBzyIfi
         MOtlj266bEbBpS2rTSCRC7K1mvko+O7QA27Gr6XetshzG7DmIyozfk0CD5bwmUSbYZ/i
         MeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vd2yyo1kda9E6yf2YrE0WbVify9sVC6LuWxaJCZ8gF0=;
        b=BsPmGZ7vzyoIIIoA/koQBtrpeKlvEPuGW3QGo2ltDX3CxJwXniI94o/fdagls3hZdX
         f9G8mCVS1R+HC55WT14UGntr4MdJ30mp5J7PhuPW8Oj6wQkYQHJ08nE/5YaASZ+nNFQH
         CVBJ+zp7vZ7AOzpkydvVmPLVhS6lUNVQHp+LpU3jkwE7hr5Vmbj/zlf8UqK4KjY/k8R/
         mpTQXkgdpehKW2PnlnsAbuCa0N5oIk00GAvg4cjAXIpTshz6Ha88UY/LiKVnF6hmMBuL
         Czd2RPT1S1W++jGpJHy8nUnKW+Q65CxXehdNTOJoriVuJjmTxP7n5GUg9oc+QCSr1zGu
         APWA==
X-Gm-Message-State: AOAM531dEjSbguHoxyvBA6n8Hza6SO+xol5OWt4Cr4fIZoP6YH8Fx9Yo
        //RADa16pJ5Wp01VNiBhPUww+CXp6eQYvgdMIAxqRmPC
X-Google-Smtp-Source: ABdhPJxZkswUPZAXAKNydbc8NiI9Cue0V1BKkmORUsqW03bzll1nXvbmYGQueDv8JRp/1yTXV5fo3CxAsA3FZGllgFg=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr1115853ybn.440.1621447325505;
 Wed, 19 May 2021 11:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210518183937.786605-1-luiz.dentz@gmail.com> <60a40fb8.1c69fb81.62a81.a826@mx.google.com>
In-Reply-To: <60a40fb8.1c69fb81.62a81.a826@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 11:01:54 -0700
Message-ID: <CABBYNZLtrMfoTA-bqcSwGE0C_094eSn7O5KVYG+rbs6ibP4QQQ@mail.gmail.com>
Subject: Re: [BlueZ,1/3] shared/util: Add bt_uuid128_to_str
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 12:04 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484525
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.16 seconds
> GitLint                       PASS      0.40 seconds
> Prep - Setup ELL              PASS      51.17 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      9.04 seconds
> Build - Make                  PASS      217.20 seconds
> Make Check                    PASS      9.63 seconds
> Make Distcheck                PASS      256.57 seconds
> Build w/ext ELL - Configure   PASS      9.17 seconds
> Build w/ext ELL - Make        PASS      204.36 seconds
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
