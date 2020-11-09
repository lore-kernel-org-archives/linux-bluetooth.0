Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF5C5517A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEE820789
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 22:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+nlFiIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgKIW13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgKIW13 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 17:27:29 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA18C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 14:27:29 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q206so11991486oif.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uhuVwlDPQek0u0PuBzcR0QR/XYC/IufHuT0Zt2DE/0=;
        b=u+nlFiIznLYkJyKsMUgOo5L3ofd74nrATV+dLkm4Ukb+5qsmCNAtghPvHxJWoeBdRH
         SzC8Cm66Ci6Rc66G/GD+NA31Kwlpe3vRRjpDYV/a5wqjpZqm8C/eoA6q9NG/tr5Jzc1n
         i8FD6mWdWoQbl5x1wwAzIk9lhr2x4Ae752PXxCi72/kxMgXWDX7hwEhydPzkJxxlOI74
         jZCUcVVxUiiz2qsdumwOaxsk+SwCy52qtmjrJ33i3bVWwu2sRpzS74P7S0t4Y3+fpZiY
         q+jNV67rGyYs0UHuweaq3i7LHSfzBHzjwo2J02ef5Ub/+/Ej0Ue6yLM2evj1dP1OhNQ1
         UFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uhuVwlDPQek0u0PuBzcR0QR/XYC/IufHuT0Zt2DE/0=;
        b=bDeWOK7XgYoLVJfAboXeNZsLwtLeHtW5Rjtmw3I5Td0rZWfNh8RMq1tgYOa/WqCsfD
         kRxkF/AE+FQq0t76FMgWi5QovNxxf0/xJe44KyYr+D4dLgNqKUuvg9apzHIur9Z8V0EV
         RaWoshrUV1fXnJ1Dab/vec3KvE3baAyZ8nUwYLWvNxOvappZmO3yLHZZJKuqhRVcsITu
         ggJfQN4MYlLywbeISlZd/mGgyg2vJlDcjVpCpVj/otcvLPyvDcshAz+QH8fQCRkSPf/C
         4Nm4Nt6KcyjAQ0zw3XfllUZGfP0UpxSl1dcERiSLby+k7ZbwEM7qXE2AOjt5/1iybSjO
         fpDg==
X-Gm-Message-State: AOAM531FFp/Hkm0GlkjKoolWxdouNAE0OdmxTd9SYDWuF+ixXVZtauga
        TOeNE7hNYcumxYfIWPaDomgJ1OIccATPyrzILPEnDDeI4UQ=
X-Google-Smtp-Source: ABdhPJwVgmRlYWWmYrDgxLWsvD85cci3DCra4Lx4lqbdezBQsK9gJOSthIvy1r+HIss7Xspqf8fZ0Oazy4QicXnklqw=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr952915oif.58.1604960848587;
 Mon, 09 Nov 2020 14:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20201109192742.42207-1-inga.stotland@intel.com> <5fa99cc8.1c69fb81.73e40.7565@mx.google.com>
In-Reply-To: <5fa99cc8.1c69fb81.73e40.7565@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Nov 2020 14:27:17 -0800
Message-ID: <CABBYNZ+uL+TGSqFt7_Ph0-jycxxHA9Terjsb16PS0X2FKjCh0w@mail.gmail.com>
Subject: Re: [BlueZ] client: Remove reference to g_steal_pointer()
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Mon, Nov 9, 2020 at 11:50 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380609
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
