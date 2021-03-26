Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC1FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316161937
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 21:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZVIO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZVHr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 17:07:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D0C0613AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 14:07:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6483171otk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jh30oCpVnpC9xZSpROUQ7qerVNKJWD+xXzSmw5jzjdQ=;
        b=Mh5chwydGaz5tU0ANZ7XYA1QhuWtL9g0LRGLml1y6agalC2wwMoqkwYlbIxbOqc9PN
         M3RwSuoyPtanrGHW6BTBPWLxkhKM/L71+gCOvCfoOjGmtOp1aIm3KpWYM9S7+YD+6BWL
         Jretwc/LhXZj+kHduGz2oSaXVyPFW6al2BbMJwivgJAe7DSuBAQTFunbwq1qsPF4l9uR
         0JvNdCgQxzd8spFS7N+VomiiRxPFpfRpVHH6TmDp4DssO9YnDuDudxWYeGTLYtjFm4ef
         Z+W2SGIlPViS7/QE2Z1XyPuZTtay6oPusaRcFxIjL9TqX7R4JzyLAeTRqngiZheeGc0K
         /vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh30oCpVnpC9xZSpROUQ7qerVNKJWD+xXzSmw5jzjdQ=;
        b=dahZTYshcdxiV6lCJiht3FDv3OdBOL9OtmtIBkmh1dtmUi9RIWvrZyUygBaWaNcuhX
         ZOVUXht03coQ9eshcEDL6iF7PaI5XjMYFN/FpYeDyzkZwNgOPna4qT9iv23NSe5e46L8
         IlmearGsBODLv2KtYvEDeaU6ATFh49GiOVo1D91oIoOGvOV2PUNTrSSUfg0PdEGaSpbP
         bTLhrWSPnMzUCNss3507zwAHaNBxV47w+v+TQSbomPYFx5NKYXYaTRL4e9X++iiL+TZy
         fqKLuM6rmmvGc4rcVi7FFTMio1vTQiuoOXd1o81PGW7DsnbPJgR8KkrP4MgoQV+EhSyC
         yzcA==
X-Gm-Message-State: AOAM532paFQXiZgmAgb3Sjnv+aUI2m9rSAbNP2SXv9/unFEN39TgKoKx
        IXjLDiXETYDLFnZZB7JFIdAIQQpmr+TEDbnPJcQlfGG4dK4=
X-Google-Smtp-Source: ABdhPJwYp7lGwWSmBpA96Fq4ntYm54svL50g70+mS74RYbIhQFTgwM4fKy+9gBPBwPfL2LN8VhP6Gtz50AwszS/tsnc=
X-Received: by 2002:a9d:21a5:: with SMTP id s34mr13598259otb.240.1616792865397;
 Fri, 26 Mar 2021 14:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210324141059.88009-1-marcel@holtmann.org> <605b591b.1c69fb81.142f5.add7@mx.google.com>
In-Reply-To: <605b591b.1c69fb81.142f5.add7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Mar 2021 14:07:34 -0700
Message-ID: <CABBYNZLuvfDQ69MQ4PW+AVF0oNBgnuLF2ftJK1OkCMFfOQZBAQ@mail.gmail.com>
Subject: Re: [v2,1/5] Bluetooth: Add missing entries for PHY configuration commands
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 24, 2021 at 8:24 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=454671
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
>
> ##############################
> Test: CheckGitLint - PASS
>
>
> ##############################
> Test: CheckBuildK - PASS
>
>
> ##############################
> Test: CheckTestRunner: Setup - PASS
>
>
> ##############################
> Test: CheckTestRunner: l2cap-tester - PASS
> Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
>
> ##############################
> Test: CheckTestRunner: bnep-tester - PASS
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: mgmt-tester - PASS
> Total: 416, Passed: 402 (96.6%), Failed: 0, Not Run: 14
>
> ##############################
> Test: CheckTestRunner: rfcomm-tester - PASS
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: sco-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: smp-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: userchan-tester - PASS
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
