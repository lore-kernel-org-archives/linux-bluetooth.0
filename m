Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA8C47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E93F613AA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFCN7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhFCN7P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 09:59:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7374C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jun 2021 06:57:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t20so4391862qtx.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jun 2021 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3zcFspg7Updo+C4gI3oi9LRNATWhtpCSYaFeeQ46Kk=;
        b=pMuFzb81JoKm5Ii/sL1zdYJTBOaQ3aveFcIcaBHY4U1lLAXKkIjPS+HPR4YLYRmn7D
         MrLh55skTXlRjl/oXDm6WofWX7VVraGrAne9aKV/K0ki5HdC9iHNI7yFh0sC3/jukI6o
         dPv/BAHhhRDQQTm08oTAIiM2JgnYmMeTRHO5kgwBYYmqEp5p8vSXAj+vif5HacEg+3qt
         A6TuzZ4w2LxUQRov2krkG8tQYbIjuHrtVsLdPzXqeOT4XNSM8uZrz2Ni71eyC1kjJ2SJ
         4iCZICXzlFCboKtL/gPtW/E9Hwrp+byVvcPfxIQTncWd838REvEzfJjMl1nUnbig7ik5
         mniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3zcFspg7Updo+C4gI3oi9LRNATWhtpCSYaFeeQ46Kk=;
        b=uj5cg0eo75bByz7CybeeqD6DAjxuVA2bR5AtAYBQ2ZUnn3YwdpDNUAk+jf6yE0Hzbx
         7qCIEbqxAZkSPe460DQ5PsyOqnzgHKDdBvbBiTHSUCnzOXykdztuYzbM1N6zG+6q4Cx6
         z818bZqK0v71D9N3rCN375jlHEMWuSat1UXGGHTazeWSAc/TrCG9F7qfC0mqfsisJFJa
         xPstOrIoTzKLC0avRRAMCv9/7JJBNj3uD4ClEekaq+r99e8uXbAC2wo7ArkXJ/6AWggy
         Bq/GNz6LA/WItLOuT4SXINiQ/eKQTbVPeSiMRgl/h6Ou0PfG6E40cQKpwME+5QexXqFy
         n9tg==
X-Gm-Message-State: AOAM5313R9eS508RBN2/ZzgveCE8zXqzDDC3ajJZnundIj6fAZ6bcSwj
        ufJC2oy4/n+4SBptmqV6bykQa/aJabUYegH+Mvw=
X-Google-Smtp-Source: ABdhPJz/g9RYpjdR4BGLBI+Lbg4EPYdsgK0KiLY1WsZoNIO8utR2T2LBGCuSpc2RLViyvh1Vh+FLuoPSLZtd5KLxrNg=
X-Received: by 2002:a05:622a:87:: with SMTP id o7mr21126qtw.137.1622728649993;
 Thu, 03 Jun 2021 06:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210422192253.553048-1-marijns95@gmail.com>
In-Reply-To: <20210422192253.553048-1-marijns95@gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Thu, 3 Jun 2021 15:57:19 +0200
Message-ID: <CANX-K3vis3qqDHwPMSH132y5ermf6Gcr2d0Yd_T4Ksd=j6dLUQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Determine Absolute Volume support from
 feature category 2
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marek Czerski <ma.czerski@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 22 Apr 2021 at 21:23, Marijn Suijten <marijns95@gmail.com> wrote:
>
> The AVRCP spec (1.6.2) does not mention anything about a version
> requirement for Absolute Volume, despite this feature only existing
> since spec version 1.4.  Android reports a version of 1.3 [1] for its
> "AVRCP remote" (CT) service and mentions in the comment above it itself
> relies on feature bits rather than the exposed version.  As it stands
> BlueZ requires at least version 1.4 making it unable to communicate
> absolute volume levels with even the most recent Android phones running
> Fluoride (have not checked the version on Gabeldorsche).
>
> The spec states that supporting SetAbsoluteVolume and
> EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> excluded otherwise.  This feature bit is set on Android and, when used
> by this patch, allows for successfully communicating volume back and
> forth despite the version theoretically being too low.
>
> [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
> ---
>
> Hi Luiz, Marek,
>
> It's been quite a while since our last mail contact.  As mentioned
> Android simply reports a too low version for its CT despite setting
> category 2 for absolute volume support.  Using this feature instead of
> the version solves being unable to synchronize volume, is that okay with
> you?
>
> - Marijn
>
>  profiles/audio/avrcp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 05dd791de..bacd1aeb4 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4136,13 +4136,16 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> +       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> +               session->supported_events |=
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +
>         if (target->version < 0x0104)
>                 return;
>
>         session->supported_events |=
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
>
>         /* Only check capabilities if controller is not supported */
>         if (session->controller == NULL)
> --
> 2.31.1
>

Hi Luiz,

Has this patch by chance not reached your inbox?  Would like to
discuss the approach and get this issue fixed.

Any suggestions on solving the test bot error?  I don't think
splitting too-long links over multiple lines is standard practice just
to appease it?

Thanks for looking into it.

- Marijn
