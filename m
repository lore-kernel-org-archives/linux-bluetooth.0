Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E234C63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 05:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7522203
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 05:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgLCFLG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgLCFLG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 00:11:06 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43593C061A4E
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 21:10:20 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w3so19378otp.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcBV9XY2loSPRpvSU7xlrBc3sdNsf4sNSTlGBrnsgnM=;
        b=cXpxheYb7+k/zpBbYa1YvTmi08xOQ0rq6TId9dF7EBZokpvu/gThzhMifOyHspS8oA
         Lvnr2Vle+OjzLwUhpzL9EMXv0YIaxeqHy6ioGpkDzv6qTjNf7c/vKPUFbp8gyyC2ow6t
         RbRxB35s1rgfJHIlDgl7MidQd3BwP+uU+/rhm1ClRYYdCNunDUHwEuezBhXJF4pHrcZF
         fzO4nube/KwfdQpJNAObqwntPHjRR51V0v2cd+ywZ63f8F8qfibBq6em2PA6oJouLCfR
         F7fBR89PSpSXP7QPaO4vOJ48MuKxVxjlA2lgOCjA6xmhAtc8wAmNKMiGsvGxHq0a/RCz
         8GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcBV9XY2loSPRpvSU7xlrBc3sdNsf4sNSTlGBrnsgnM=;
        b=NTxfF4Lebq8i9jybAQHAl8IDkbqiAzz488HUNGrC0NQ9So8UvLB2VY+fHJT9mDumIA
         xAh1RvNSuNB+0/0Af8ByCLoiss4mwYN1a3dk30JkyYa00e6pY8MfdyT7mRE5ggDKWm1j
         sKnzj4SBmf0IEAw3dnbCx4rnVqSsiuVPnmVAclu5IMaiSvRfaaJ0b5gLkj/q0NAYksDK
         Kqm0zyjC6M5+xBL59Qi2OE1+44f2EnSRy5L7W332hrB+AuIpwK8fzINbYTbRaftoJWGj
         Ntk3zDLn5Uun4+8lLw2MiWnXurwJFme5cIFI5hXTQUWC6G1h8iJWGnKXXHoSLaDD2z4H
         ykMQ==
X-Gm-Message-State: AOAM530GJJKyj5Lo5nHhNUpAKgbca7CVLRSd3CY6oAybjhk2oEnL6P89
        HOOllsGmFKwjrhcKjNgc9tJ/s/ygQLAboVFVs7hUXPQD
X-Google-Smtp-Source: ABdhPJyly3VWMi1hVC5n977uu1a258P0IswhMeUm94af9GK9T+DiZrX3r27eVD3XeCMWvjcs80FDZNxQJ5EQXwIKiNY=
X-Received: by 2002:a9d:4b81:: with SMTP id k1mr976590otf.371.1606972218742;
 Wed, 02 Dec 2020 21:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
 <5fc86b9d.1c69fb81.42315.027c@mx.google.com>
In-Reply-To: <5fc86b9d.1c69fb81.42315.027c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Dec 2020 21:10:07 -0800
Message-ID: <CABBYNZLBp6fDcJcD3HC7fgkX47oyBHBemVANDurh1A0S0bAB6A@mail.gmail.com>
Subject: Re: [bluez,v2,1/2] adv_monitor: Register client app with app-root-path
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Dec 2, 2020 at 8:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395121
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
