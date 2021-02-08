Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB21C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00CB64E9A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBHWOd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhBHWOb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 17:14:31 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69BC061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 14:13:51 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id m7so17291502oiw.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtBNNC+mHWLPqon+2os7p/gSQH9H51aBzaYKCv0aWvc=;
        b=OpyxTH/hpLN9qXoW7I0GE20RU75Zg612eS00GJhH8m89BA+7qqIaXzwh+s28am751v
         7dnELakFuc1zqMu5pxY3S9/tL4X73RMy1fbG+JQy72YvXC/6/4U9lWUMaCeHBB4JrSmh
         qup2mR3qD15+yE8R8MOcnJfZ+MyZZ2NeM+3iCcKql97/5ZrxDNPET1OHaWQz6TV+iWkF
         WMFnbLz24Pkcy9Q9coRH7iUIyTOnncWVLb2K9QGdf5olWIGb7tWaWSrjXjpxpvTqEFTi
         qJEkYnhgiFV5OnhdGPWwWpOpduXHr4hDZ/kIrAUhPebXClXTVaTsg7knpXuOK+W7reu/
         Jw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtBNNC+mHWLPqon+2os7p/gSQH9H51aBzaYKCv0aWvc=;
        b=uIl8SHuEPX708o1Zxk/+6nRUz9UKVQASYaEKjUjNW3mMzz/K0rtrhCUyXB9JaSHMM2
         rVPGLVilvQGrBxpkaQu38D6+0vBp8Io+SGmzOTk/8DchQ57GBGTRh5xTC7Ej8d2UXg+3
         ESeTHlxTASbToGCeyMtOdpFvveOGyhKdK5V6QmSvjHSeBVDczLzUboAbZtIGjnExXRTF
         KIS3NtAyi6KLjirjbjWRGfQe9JIK776HFHGjsLFRSXll8AK49IIfm+zBIN2RAMTe258i
         ol9Q+kQ7aE9gOvMd6W+eaC5EAniTxziTvOdkyLJKL+ZX1u5wtrprI7pSadHZGffnfru/
         AIQA==
X-Gm-Message-State: AOAM530mMEngkNZJPrK1xOMKy0XHk1CcLEcLMKC94EiDltVnYTG4QVy8
        czRov1o3XYG9jecBShl1nMomxsYKAYbCDIq+tf/hXUiAJzg=
X-Google-Smtp-Source: ABdhPJwgmeZgLHLIBf1Is/CNFr1aeoUgeaqpHfiTjtyhGE+YM6MfMdbmoOFjjoZkxU6Kqww6CuJ+B5zvwKiFXvlbvcY=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr565722oiw.161.1612822430508;
 Mon, 08 Feb 2021 14:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20210205114735.Bluez.v1.1.I68cf9b7c0c0c3c0e069011976e3008ff11374a28@changeid>
 <601ccc1f.1c69fb81.4084.e3cb@mx.google.com>
In-Reply-To: <601ccc1f.1c69fb81.4084.e3cb@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Feb 2021 14:13:39 -0800
Message-ID: <CABBYNZJJY+GgGzQHj_xTMUr_8ui7FVyGfU=9JmJB+L05bPToVA@mail.gmail.com>
Subject: Re: [Bluez,v1] a2dp: set session to NULL when freeing channel
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, Feb 4, 2021 at 8:44 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=428439
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
