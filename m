Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F61C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 06:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbiAYG6h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 01:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S249548AbiAYEKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 23:10:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72521C061769
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 18:40:02 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c10so57535015ybb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 18:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgFUPQ/8Layg0C/RxzILgA0Et58EfmsefukPB/DNHHw=;
        b=LcvfH4kFqsfVDF3EOXpQy6sngQvMURHZ70JmHQEUIqn5XdtrGfvx/2lb93WDsP0o91
         TspaAFilXKSw8ggl9PGu4EosvT4M4AMnwngjYkuIzp1LpEkDLui3Tfxow9K+5vbU1gnT
         ou6+qYSlHOMzaxsFzTfBetSSKmQ+ovb7yScMcxQvMHHuehtlEfYXmYvItYVqL+yDshp2
         Gn1dJThjIp8bEDO73xI3/thyHN4tjb0S5Y2Ii6sPtZ/cJRboqZcy9+3NOWFNeGeGjcIb
         Etb6s8SGd7OCsmvNtxx7wmVXArZKwYJ9oqpj2iKMXvJ/Ghnh23XNoXpR47aXmB9NK1Ef
         AhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgFUPQ/8Layg0C/RxzILgA0Et58EfmsefukPB/DNHHw=;
        b=dqI1ovHFKOuFONnJTjxuxWy9MSCIJXOK0AuFj4vWJkgWt2Cqw5ZfAvHht/7npNtTrR
         W8kUOlL9ZCar0Y44hjqo7v1GKsQvVAHRDOWw6wf9RyX8GnsTtM9Q6T8YKmFyX3+08FUo
         q08xPlYlPZjTbVBny+dMgEkNzLX/46an9VahCr/e+dl7HpryczdyTl+87ywetfQonSnf
         dv4YmAAAOvSfxSYO/oWVbbQtxWzL0mZc6tLJc4uBbSEyzrx4AihP6uvVQRbm2GnKTT8h
         dD6ka8vVYCMjh2/jcWI/WAEISuBGQNvB1zN7oqJ8AybblvIoKQMQ8sWf7t+aZh03Boaq
         xX1Q==
X-Gm-Message-State: AOAM530CccsSzpdwqx7/XAuzajX/YmciEvqLkDSLnMIHCstxX6bJdBre
        xb2PbRa1+iuctNDgxZ+wM7QxwYKDCa4JqNknXAKLXWkWNfE=
X-Google-Smtp-Source: ABdhPJwCuRVhZ9NWSAwe+HBzU/iStpaEv7toucrflOOg8aYB1IfDjzhBZWvRuSa6cBZxFlRmt3bENOhnM4zcyGCiw5I=
X-Received: by 2002:a25:bd8d:: with SMTP id f13mr27217442ybh.573.1643078400531;
 Mon, 24 Jan 2022 18:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20220123140624.30005-1-soenke.huster@eknoes.de> <61ed6bfc.1c69fb81.81a86.35c1@mx.google.com>
In-Reply-To: <61ed6bfc.1c69fb81.81a86.35c1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jan 2022 18:39:35 -0800
Message-ID: <CABBYNZKKpEhE9rEB85sZOAZjgkdiWNbggMAfd2e55tARjFhefw@mail.gmail.com>
Subject: Re: [RFC,v2] Bluetooth: hci_event: Ignore multiple conn complete events
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonke,

On Mon, Jan 24, 2022 at 1:13 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607576
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.90 seconds
> GitLint                       FAIL      0.97 seconds
> SubjectPrefix                 PASS      0.85 seconds
> BuildKernel                   PASS      30.23 seconds
> BuildKernel32                 PASS      27.08 seconds
> Incremental Build with patchesPASS      36.92 seconds
> TestRunner: Setup             PASS      479.12 seconds
> TestRunner: l2cap-tester      PASS      13.54 seconds
> TestRunner: bnep-tester       PASS      6.05 seconds
> TestRunner: mgmt-tester       PASS      104.38 seconds
> TestRunner: rfcomm-tester     PASS      7.51 seconds
> TestRunner: sco-tester        PASS      7.71 seconds
> TestRunner: smp-tester        PASS      7.54 seconds
> TestRunner: userchan-tester   PASS      6.37 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL - 0.97 seconds
> Run gitlint with rule in .gitlint
> [RFC,v2] Bluetooth: hci_event: Ignore multiple conn complete events
> 16: B2 Line has trailing whitespace: "v2: "
>
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
