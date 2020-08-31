Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9AC433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D250420678
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBZJjiyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHaRhU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaRhU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 13:37:20 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499BC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:37:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 37so4350856oto.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTKDttS2RbtsxmH+4uHL9y8lptlzr1gB9Bq1UlGjY/w=;
        b=rBZJjiyM+AR3+FHH34Rktu+zmv/bWAKFBJ7lej0+kq83mDo+IERrKjxhDkLeuWrR1d
         jJ2VekXmdYd7RE6Lrycx4CE+cZHjcFrYjeikyp1bmtCW4HCicU3cMLf2gTW3BRQUSVfJ
         EmqRZ1jmPA6tmBHfcPI3Y9nwdzsW4ZxDd4Piav14wJXXgF+iuwNJic2iaho0BDW3oJUd
         FnR1RSwHGH8LmQ3GgDr+eWsIpiMeDV7WCUJ6DUvVLscvS03R+b1UMvlm8v0jIgT0ywZt
         wVkLJju8h/qHHm5nVPOcv3F+5gonzn94J3tjavZEV8y1Ko5MNDmShHMH8vDEo/VRYI91
         SnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTKDttS2RbtsxmH+4uHL9y8lptlzr1gB9Bq1UlGjY/w=;
        b=byFDqEjq2VEqvobBkpuF7/pEaDWVPcQEd/DzJJIASssn4+zhAZcPwtbNJcQ8Oellli
         b5B0K4ClkPvj8Q3ed4TKHsWdL0+1605OVcffpb2Bs4A8wERJs/zjLJQPe4N82mgL3Y0T
         Vji+HDffhvg/mjDjIKx/7yVgufnY04M17MZuFl1rngK6zNbQbr2wLFvW1vFZG/c86yMo
         6Mwh88CYjC+w6MfaOXzGzMfMV6vyZ0QJE2Pw4si+7NzYRo/GP+Q3MT/Nz1ADr50Jvvvx
         01l4JQz8aV6AhxiiHFR4VcnuRpPurgPfhzJ1Oy7sn5DuFhz9cSPNeqipFRfMAsyRIj/o
         leIg==
X-Gm-Message-State: AOAM531UHVq7aTgOHEGLYNuNnri5+6Tj3ocCCs9gjIHM2GF5gDIIxc9i
        oKXWj7KimcLmzilGMXGfClSxsjbdGdwE6rxSHEY=
X-Google-Smtp-Source: ABdhPJzbidhOFjgqFEEbjcCQISFMJC1RVUni524gfIhWxK9EadA4ZR+F8LAlgumfssVXb+SUHuf7riGkyYBlBeC0P7s=
X-Received: by 2002:a9d:429:: with SMTP id 38mr1551355otc.88.1598895439389;
 Mon, 31 Aug 2020 10:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200830071108.19777-1-31baz66@gmail.com> <20200830071108.19777-2-31baz66@gmail.com>
In-Reply-To: <20200830071108.19777-2-31baz66@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 10:37:09 -0700
Message-ID: <CABBYNZK9aB4B092T7EeFoziczf_ffKt3eUcAwSDEknkBhqHTHQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Fix typo in bluetoothctl
To:     Barry Byford <31baz66@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

On Sun, Aug 30, 2020 at 12:17 AM Barry Byford <31baz66@gmail.com> wrote:
>
> ---
>  client/advertising.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index 94eb616b2..1aa28e749 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -185,7 +185,7 @@ static void print_ad(void)
>                                         bt_appear_to_str(ad.local_appearance),
>                                         ad.local_appearance);
>         else
> -               bt_shell_printf("Apperance: %s\n",
> +               bt_shell_printf("Appearance: %s\n",
>                                         ad.appearance ? "on" : "off");
>
>         bt_shell_printf("Discoverable: %s\n", ad.discoverable ? "on": "off");
> @@ -886,7 +886,7 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
>                                         bt_appear_to_str(ad.local_appearance),
>                                         ad.local_appearance);
>                 else
> -                       bt_shell_printf("Apperance: %s\n",
> +                       bt_shell_printf("Appearance: %s\n",
>                                         ad.appearance ? "on" : "off");
>
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
