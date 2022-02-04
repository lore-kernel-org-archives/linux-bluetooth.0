Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4337C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiBDVOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiBDVOE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 16:14:04 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13039C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 13:14:02 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 124so21693957ybw.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HLI89Ki/2Yyhp/aVQAqgqIUGMvxWkXVvpSJVGRezcUA=;
        b=LFPKxb8SV8eyPbxDy8TF65FqqbX9vrs+APYcY4Vk6WsFOD4+a/bWlMXpkR3kCoBimp
         yF+R3gsC8JVGg17OMwheZwS4ZozjM/oZlfuuw5FvHgXMaz2YFlkVuOZZHZ3QRJpIGd28
         Nv0ILGvd4qxwP8O3jQFeBjVLYDUWNP/ElDqhnhAcjk5uR/XL/tonm2pifL9vWeSPja+o
         nQuhuPYHl5AKTrU3xYSRMmoxOztnPKDj8CtOmBC2A7orvx7BGRqGogw1UV7FYMAUmFhe
         gMJiZG3buqk8529FAiUww2D2sx39EIPoSUxN3CV1VZTrBY3JwyzkmMDSimrWc9iMUQhw
         Cdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HLI89Ki/2Yyhp/aVQAqgqIUGMvxWkXVvpSJVGRezcUA=;
        b=sC/Cl6o9nzbemiXbXkpddlRo3IpzlERTze8LE9SUO1MLN0vhGEhiUXoexMU42s1U5f
         OzSOiTI4byc5T37r0AiQ1ovWLu6k77NsdQV6o075LjraqH+s+wuRo/HBzKOv/uahBF+C
         EDex0SIQexm19lGJAHyDtoMZ/d7CHZZGF3HPEy798d8/oI/PtaG59bbwg6n89VfNl4JY
         gBXpYpohOVfD/3eZu1hj2frABbAvTVMqYh/4J/AKH4woViPA55UjbNUYOE0JgHbfzFf4
         9QBoXQF08AIQlO+dEJzKucg9g4ZZ4guruPeNx5RrW7P1+MKBdFalG7WM7b4ICktMjD1X
         O+FA==
X-Gm-Message-State: AOAM533Z1guXGWXO3LmMuos4DbexHtOWIRgDQYH7kY8K7QyO+EwMeq5p
        xXsKNFeZdAjXPAk2FraT0viKn3kqEZVVYw2l+RPSc7YtpVQ=
X-Google-Smtp-Source: ABdhPJxzSuyH5Kq0mmWNefy3gQ1z5tb1LqQydd4QPa37QHA2W7SPUeqRqD14hm8BUC7g9UPdib+BkZiU631F3OqggYs=
X-Received: by 2002:a81:450d:: with SMTP id s13mr907005ywa.358.1644009240930;
 Fri, 04 Feb 2022 13:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20220204192619.2653955-1-luiz.dentz@gmail.com> <61fd9000.1c69fb81.b27d2.a5cf@mx.google.com>
In-Reply-To: <61fd9000.1c69fb81.b27d2.a5cf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Feb 2022 13:13:49 -0800
Message-ID: <CABBYNZK=eaPEQMTmrYtWR5LMhEv1itQBNQgvvobTTeOQxgVjmA@mail.gmail.com>
Subject: Re: [v2] gdbus: Emit InterfacesAdded of parents objects first
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Feb 4, 2022 at 12:43 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611401
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.45 seconds
> GitLint                       PASS      1.02 seconds
> Prep - Setup ELL              PASS      43.52 seconds
> Build - Prep                  PASS      0.74 seconds
> Build - Configure             PASS      8.75 seconds
> Build - Make                  PASS      1440.21 seconds
> Make Check                    PASS      12.26 seconds
> Make Check w/Valgrind         PASS      451.94 seconds
> Make Distcheck                PASS      235.40 seconds
> Build w/ext ELL - Configure   PASS      8.75 seconds
> Build w/ext ELL - Make        PASS      1436.60 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
