Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE7C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60B261353
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbhERVnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352530AbhERVnU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 17:43:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0496C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 14:42:01 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so9948913oth.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ofNPcuNc/vCIfvf2rMR2k87aqC5AsBN3DBAxyFJs5bs=;
        b=glujEUxdAGJdAAFCb8YzxChdowvEOG9AJ17F6oiiVz3j8puZN/JucVgEFE3tC7MWJq
         wyr9SNm+QvB+Z41HNdF+8ERpH5Rc9hsT2pg9Fz5m+bX9lSkep71Up1lrJxsGxaD6Upjt
         w/HxXSV47FNCP2Oz3K/0PeV0hTc+kN0JxosaqiebC1reZX6/oLI3dWtbhZ624QUsyaQT
         mcfJ0ddJrNRgYLSBREymfTsciNDTyTWVvLC9CYFQQoWjQsV4my4Phbu6/HgUb23k/Bs4
         9+DEb9CBe871nLJDNTS2g4i5JsAOTNo/Cg6hUklky+VKCC3ylAcDqTWV2j+/D6QOQTgw
         Q/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ofNPcuNc/vCIfvf2rMR2k87aqC5AsBN3DBAxyFJs5bs=;
        b=eilQl8GsgzGE1iZ/Wxft0u3HyUcHn/jzvEew/ZpMa+QQLDlM53PEVVDnu08d07MM7h
         h+72p37Au8Y42y0R//N90vp6d+mYP9mdMnAKo3L8RvejCyO1995mYGHq914Y9WFSMnyo
         LSQEoQ1UjXLMXJvDuTDIsAjMpGf85g70SY3Pmg6grJ9gJl8mPF+bn2UtcY3HkroGHotG
         0ijxtqnyBD+qqZy0ja4XlEV50GGMDuI28C5pZg7xEDAMmvHPUdPNT5FBhFy+rbvIv4u9
         GMzxNakwhpCnaQhgjvyiK4hYHxiwQZfGSQfYJBFW7lswdt12sspuAX5xtzZ6oohnX1ys
         qOOg==
X-Gm-Message-State: AOAM5302/VyMgPrPVIY0/lCY8tKjsEpjFgFfk6BO64KxdZpH6QHzAY+z
        T/BIaBqArbwPdtqzKSQvGJtrfasQ2Pzxuo+kaykl4V7Uzp1JQUez
X-Google-Smtp-Source: ABdhPJyeuM2K8Y1t/hg/BsRYSMKHeG5xQiXRiRtsGx2mTpJb6CdDDlBfk5ZGcFlTrAkMZRkKgMYhvSIgk5SzQ91ecww=
X-Received: by 2002:a9d:7d8d:: with SMTP id j13mr5966391otn.208.1621374120895;
 Tue, 18 May 2021 14:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210518185938.322908-1-dlenski@gmail.com> <60a41617.1c69fb81.892b5.9705@mx.google.com>
In-Reply-To: <60a41617.1c69fb81.892b5.9705@mx.google.com>
From:   Daniel Lenski <dlenski@gmail.com>
Date:   Tue, 18 May 2021 14:41:24 -0700
Message-ID: <CAOw_LSHKPDfRo98zLe9Luc2cY1htLyfuGGF0XE6BYsvKtBPxNA@mail.gmail.com>
Subject: Re: Bluetooth: Add a new QCA_ROME device (0cf3:e500)
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,
I'm somewhat confused about why CheckPatch is failing to approve this
patch. It says that a commit referenced in the commit message does not
exist:

On Tue, May 18, 2021 at 12:31 PM <bluez.test.bot@gmail.com> wrote:
> Test: CheckPatch - FAIL - 0.84 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: Add a new QCA_ROME device (0cf3:e500)
> WARNING: Unknown commit id '0a03f98b98c2', maybe rebased or not pulled?
> #9:
> commit 0a03f98b98c2 ("Bluetooth: Add a new 04ca:3015 QCA_ROME device").

However, this commit *does* exist, and it is =E2=80=94 as far as I can tell=
 =E2=80=94
the *only* commit which exists with this text in its title.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=
=3D0a03f98b98c201191e3ba15a0e33f46d8660e1fd
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?qt=3D=
grep&q=3DAdd+a+new+04ca%3A3015+QCA_ROME+device

Any suggestions about how to resolve this?

-Dan Lenski
