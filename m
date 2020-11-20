Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FCC56201
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B7322240
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozdgPRzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKTRsp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 12:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKTRso (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 12:48:44 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E385C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 09:48:44 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id z13so2400587ooa.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORjXe7TQaDIT9ovvXXRHvcR3idcdO+mXMd/zKfSmJKE=;
        b=ozdgPRzjuF1VcwFHo+IafdgHR8xVZI3DCmm6m/VxEw4UTZVbtCtW/atM+27oKRiqwm
         lRSyrAcnkAyHyMewlf9kdva4dRNKPjXdsI4LXB3FxtSERehfW2rVQKJKOsPL88XLWLf7
         S09dy7IB8NaQziCup7Pm37aSvYsx+UXleYfhlX1Ygfv777zlBPIB3GcIjM9z7FmRyJfD
         5WaM1nz3tAxCWtkShsKmelp7Pc7TexQrlkFwPM4px85I483vtQ7o4eqOYF6gqwDCuh4J
         kz4XHV8ontT5bIQiBdV77gQJJwTYkPCo31+3nR1jDlgOriPmavU0ZZkrfcjCOGlnqMBu
         RJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORjXe7TQaDIT9ovvXXRHvcR3idcdO+mXMd/zKfSmJKE=;
        b=aA6s9bsYYVfna+oIOQsM3VoBRAm++iecPtvjbqx2pIGxBIBJF+d0CdcrHzRVIqYS2b
         4VpdjQb+qtuY/g7+bN2wrVc7+dNGe/KR+Q8iy/mzbCV44biSiWJwPjzTzqntC/TgJxfX
         F2a0BFfTATVFrnTPnc+xuj1q9d1FBoAsiEUEWYPSBgqlF3SO4jdPDDYSRg7CXkqLqtaS
         8DEWbJdnCFDoywKJ0TAP3xGVQ4NfQyeazAcfLzdiZxQNv84e4lXJlTWj7VxIJhIOYy3O
         I2ZchCkmFbd/leiiaGBWhqr1nGcKWGgwbIWxk+9jLZOPPMpTeeqi70i2UW1LCuUoeZic
         I9AQ==
X-Gm-Message-State: AOAM531LBmFd/h0g4hOxgnO5kEwyIBILZproI5KEoiZABf5YoMVrqsOv
        HE3qQt1QWp/5p/dO3VY/wR0WRdixpTG0kCX41rhMLpy7
X-Google-Smtp-Source: ABdhPJwAUgdFHbDidg+EejBFUOEhNNYL24X/LhtB/XCkppwEKfx7E3eR1Re1Z2wJGemDmk99s9FI917C1uOkiC6VVZs=
X-Received: by 2002:a4a:b148:: with SMTP id e8mr14693835ooo.65.1605894523549;
 Fri, 20 Nov 2020 09:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20201120002215.3946089-1-pavelm@google.com> <5fb71511.1c69fb81.c6c94.817c@mx.google.com>
In-Reply-To: <5fb71511.1c69fb81.c6c94.817c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Nov 2020 09:48:32 -0800
Message-ID: <CABBYNZK-6J2xf8YM-Ye49MoWier-SrhdU7m4XVkgn4j8W1oZfA@mail.gmail.com>
Subject: Re: Fix duplicate free for GATT service includes
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     pavelm@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pavel,

On Thu, Nov 19, 2020 at 5:06 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388009
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
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
