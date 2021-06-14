Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D397FC48BE6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63FF61378
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhFNVIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhFNVIb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 17:08:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB90C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 14:06:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m9so17410914ybo.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+ID0gP6OXkAGJcF6YAUU4jMoR/QqhUGqZRiYF/8AgI=;
        b=gLB3lx75coqLgL3LMihmSEpKxoNuI1yloG1Q4wx51zqBkaR8DXq5qIplwVtqgAPD84
         u0RUjtXWULpj5vX6sUhBGHc4bhD18eooQ5Jl/b3Hw+UjdYCeatPRUVfl2hB7dWKC/ENG
         DkxWXmzlRbGxc9QXEYbN1qAh3ri0YDyZwWSInaIlWbHioAkuGyFK9sg7prSX0U0lKogm
         zJuNGeMbLLNTdB8l7rQAn82cU16jXLaa95x1PlPmnfjPvspobA0t76mo09MxCQH7XHQi
         jZAjEtY3resn/fCzWiFvP2/MJeCSQx96oiAUAkkG0tXj1RFJZ8KrmNXEGeOXSr5y8TG2
         eMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+ID0gP6OXkAGJcF6YAUU4jMoR/QqhUGqZRiYF/8AgI=;
        b=elGAm6tM6/pLBnEQl76r9RzLG0a1KUNlJwiCgh0lfxM5OCDRy8ANiQ/KiDBOt65qCM
         yJcGXg/gtcea8B4x30xTI7cMlr/0tN4pIIaHRNNJzw6ptrGuoGUA5nueyB804Qf6uHF6
         Meg4nW3Lg++Tg9t97t9DVDOqjLsF2PwCy1SWF31qNjRSk0lDhKhTUFVU2om+ZhJQ47yL
         rvBuCuGT5k6mYs0pXO8AcZMLok4iZq35tbTgCoenXVJ5TVggxj3kgh5nQ69iBqrvM2Hh
         1Nq8WMqLihPoMVnJDwP7s9gqvcfAkPAn0JjaVS6m11LOYf0jd7AgpwUEMTJ+N7OiaVKQ
         8kNQ==
X-Gm-Message-State: AOAM533q4tQ2lSOSa4WKFsnTqLSRrZgMpN29ajlpgfr1L2CUMavjq4BS
        cA/RcrvDpgFD7kebzIIiU7MsDo/cg8rPvz5BTCFUlJoJYZI=
X-Google-Smtp-Source: ABdhPJz0MxuJ7Ot1KmOO2u7W960JILKp3nTmhtWIMLP9w4oWqlar6b3vqJV7YdHNojyejWvwGGHXyQL/DzlmmQUJX8o=
X-Received: by 2002:a25:6612:: with SMTP id a18mr28089660ybc.347.1623704787140;
 Mon, 14 Jun 2021 14:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210613103918.5814-1-surban@surban.net> <60c5e63d.1c69fb81.aee49.d4a8@mx.google.com>
In-Reply-To: <60c5e63d.1c69fb81.aee49.d4a8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Jun 2021 14:06:16 -0700
Message-ID: <CABBYNZ+TuSNrj9-7e-cvcNwNj+eONDD5sjsS9THyhaZqDNnFsw@mail.gmail.com>
Subject: Re: [BlueZ] gatt-server: Flush notify multiple buffer when full and
 fix overflow
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sebastian Urban <surban@surban.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sebastian,

On Sun, Jun 13, 2021 at 4:06 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=499527
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.64 seconds
> GitLint                       PASS      0.15 seconds
> Prep - Setup ELL              PASS      51.54 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      9.04 seconds
> Build - Make                  PASS      228.99 seconds
> Make Check                    PASS      9.32 seconds
> Make Distcheck                PASS      267.21 seconds
> Build w/ext ELL - Configure   PASS      9.24 seconds
> Build w/ext ELL - Make        PASS      213.85 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
