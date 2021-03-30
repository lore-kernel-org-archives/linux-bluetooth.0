Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBBF6198A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhC3TZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhC3TZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 15:25:23 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2618C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:25:22 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so4021931oof.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbND7jIB85sASvklQLnHVYj/BeMPkvTMaN1QB9dJrFU=;
        b=Q+WctM4f/Fbbq9PwBqBuxHifEmB1MPwAoIbetUTf1MQD0T1+EPuPJJ0aPcpepIb2Zd
         Emp+Tef5qbjc+JQ5h/wh+dLnJKsBvQc6BN2eygBfAX+VnMr9bQsXIs2fDYhtE+G7oVqM
         eritpaU5xM0gNNALkl3C9bdm1fgB1+XTTWcwKVH3kO1Ohbf9YT31Oy35uUOqvlSVihDm
         5Z4g9mTYXLgiUXZoA14mNw6mtBKW9G6NF5orbJPB2rtbX7eiBtpxS+fL/mkFe6wuSAdh
         J25jIUafeP8h2sBvRS+x7WdWGXIntlGYaZTY16arQngJflS899ygixoXzWEWo43jFYCF
         bjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbND7jIB85sASvklQLnHVYj/BeMPkvTMaN1QB9dJrFU=;
        b=rwHZcvcxRImWt+6DVq6g1J9LSu1K/3fJb0r/4R+fcP5z6cdz10V0HloAiicqD3Exv4
         1gHHoWAIiIlmT2VyPk8YbBsqTOgIwcveemCOOWPZhG6/w4ARA9O7/BQG5Ih3QxwPnZOU
         19GaXgskr0GG75DJvSI6VuXx5aMl0HIFfh1XwE8aPXQ0BI1nooxng4WTfUUpSppsR2Lh
         uLzWmQCXonZUP3FMCT7laishLrvm2Hs4OCYK5TxU2slCdJTMmgCnW/UqFxR9Kv2Wade3
         7zxsJw+b6AlXwVTMLxEzJPTO8ZUEOpiqWpgxT/I1YJEa6aft9zq5JC301H4428l6a1VT
         eE1w==
X-Gm-Message-State: AOAM531yTPoEGajTwVrVzta6Gmm5M1ICINhPW0PjS2jVHPNTvinR10c1
        eb2FyjKo0Y8lJ9hrEFtREHukG5WT/hWj4C4Yofk3GUzbCeg=
X-Google-Smtp-Source: ABdhPJwn4AhTwswCuJROPdAL9gOqlBdLpGf63IMCsSryiKrj7ue/pKIBsPP4QjQtM/VgNdPD6bZPq8t+pyeeHBRr6AA=
X-Received: by 2002:a4a:55cc:: with SMTP id e195mr5892465oob.24.1617132321810;
 Tue, 30 Mar 2021 12:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210330121204.Bluez.v6.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
 <6062ad73.1c69fb81.63adf.df98@mx.google.com>
In-Reply-To: <6062ad73.1c69fb81.63adf.df98@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Mar 2021 12:25:10 -0700
Message-ID: <CABBYNZJxOub=iS-ihSC456zXgBDnKYhNqZxmchaoctutrfi8ow@mail.gmail.com>
Subject: Re: [Bluez,v6,1/2] adv_monitor: split rssi_parameters into its own struct
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Mar 29, 2021 at 9:50 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=457783
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
> Test: CheckBuild: Setup ELL - PASS
>
> ##############################
> Test: CheckBuild: Setup - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
> ##############################
> Test: CheckBuild w/external ell - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
