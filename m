Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC36BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585272225B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAa8J8JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKQUeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQUeL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 15:34:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEDC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 12:34:11 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l206so2968801oif.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GzLOnqwxNiD0Y5FcpUInpBF1YBqk7SKyWOHX/PSTFuA=;
        b=TAa8J8JP1L7S2vUN+h30JXbhXeWrXuGj1uSZH5ehZBSiAoNROJ0C5o8kSScc1xg9XG
         0rjuzQsENbq6/CGsTo3qJM3+2Dd2shtOKgegPOh63QCgYr7DBWemZAA2ebO80kvWkP0n
         k5L3/2I2tTzS2I0fTAETyqCgmtPjNbX8HlYjBCqXnwIH/qs2QjC6tuBFFCdk8OVhh58Y
         4oLtOAhIvqui9/gDMnvQCmWW01s2vX4T5va9fmBbTOAYW+IP08bBuLgdg0EzPrYp+UpD
         n7J28cZjgRRC6Vu3CkoFDx8B5CoevXINDLWwQ16bAOVrP7sV38LTgqdh5LCBBPsNAJtS
         l6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GzLOnqwxNiD0Y5FcpUInpBF1YBqk7SKyWOHX/PSTFuA=;
        b=P2t8SkDSU4dcphx4SM+lNvh8F2573JR+eZog/o+qpAF2OAzJOL2R/Sg83AKwpUX499
         vf0Rx88cavCcw2Ny4AfOSRKECEjgTWW93MFcgVajgXeWPAFpSLYbC3A6IhU8dR/8FxKN
         6ON+vHeZiVhkw1lFA7eFUERx7oH3Ca1LPGfdpf19YLX53oaFKklQvhvTPoSVNAn5oayA
         2NufrcN63gjYmjWSd8MhRAmTNTj+7Iuj5SS8TsdT6+GI92KtIgNdHcKhuiwwt4aOi0CP
         sVwEu5KiVnbSMWJudQuYvSj6RlkbUGfBjUx01peZyG+zcmbW6/zJcTnzW/pd+WOPf8xf
         ddBA==
X-Gm-Message-State: AOAM5338ik2vjUQSHo8fBEaCcqfQ4g4yYGucMwvGF8k83FA6naWO48DM
        Yr7dYZT9ZvHy0cOAfXHe64LjvEzCg8LuOPkkDN+Leb0x
X-Google-Smtp-Source: ABdhPJwtkbgJU48Rh9+rfOYMPW10zA4eQsxbTL+mrZ9Zgm5AvkAP06yYXva8OHJiem29oYRVLAYAz+sl35ku/S4VWr8=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr648766oif.58.1605645250205;
 Tue, 17 Nov 2020 12:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20201117190607.50483-1-luiz.dentz@gmail.com> <5fb4239f.1c69fb81.cdc9d.38fa@mx.google.com>
In-Reply-To: <5fb4239f.1c69fb81.cdc9d.38fa@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Nov 2020 12:33:59 -0800
Message-ID: <CABBYNZJQzzcGBGkr1qcoUkBEzv-ge+2-TsizeXPkKWwn0yqEtA@mail.gmail.com>
Subject: Re: [BlueZ,1/2] test-runner: Change qemu output
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Nov 17, 2020 at 11:25 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386271
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

Pushed.

-- 
Luiz Augusto von Dentz
