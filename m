Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9692CC07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 18:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A0F6108B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhGTR1k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhGTR0z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 13:26:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C331C061766
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 11:07:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i18so33848743yba.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcS2BEnW5N0lDEtELKWSuDiHGs/BzEBvD1gxBG3kjoY=;
        b=aDzYQMLd0KjXITQVAb8q55ZixlzT3974/plH1gWGdNBYvJ1FD3ElH6MdX2umYXAqfi
         RHYKuLmf79oeRgP7Z4oLLiKMJHlIoUMVtlt5c2Ep2YM3KHvE+ECoBwjOZZK6ZK3y4csL
         icC9aZfjirxC5z681jm0e8OTj37Oxpj9NuMy2jcB+hdS+5rUjoC1IgLhi3i6SHiSL62P
         0s+g98yVtYPHnxlYJzFzLbo+K/INOQuaTqryeRU0FbqBwiKvXctt0afUxUObBApkcWwp
         7NXtS29jDqTiKlcj+u9LeupAWcMROs0zeHPWocjr1l8JcV8RDKU0NwMXUoKCVqTyr7qN
         UOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcS2BEnW5N0lDEtELKWSuDiHGs/BzEBvD1gxBG3kjoY=;
        b=mRsFA4SVZ5EidhcQdKGaXGN0FXvg0zoXf1xnC7ArQup0n+mM/LJCnzl5YpFqNTQm7L
         0rp2xtNATkaUIWZJvOZalVrhCw2hGIHq6tQ3xJWMUJR/miUbmmxMufEpXvGxYod0SUSq
         E0AvNUnReOZLnBMZN7iIWs6nPqHqZJVOYc7FKrWpPTJK3YN1vZklvZ0QNyUJrqxByw86
         OO3GKAppWbFZZ9lbLRO+G9N4s0BVqmPYNU1kNoDgy3YRY+OONA/GWhbIbINHKSqBsuXv
         x9W2Z1SBEotL9/8kVvdKy/5eWYB4+SfAJnRYtEMoYNucj8xW4JGCyYwiPLAWuJy3N2e1
         oEWQ==
X-Gm-Message-State: AOAM531ozcuvbaF8vKXBfCXAItXn9T+i7h/cGTsMCiQAXqpknGSAOFMY
        AKW89w1qrBCZS8m2JC8La4xIswxX35GPvorKxWP9GlJP
X-Google-Smtp-Source: ABdhPJy+kNNQFd0l5RgerSfm+CGKdWsee+xuubRjj8G8+5KPoo6oPzuSOtva0Zz2ptpn4EnbRv5ze1OQz/IKGbUpgUk=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr24241574ybn.264.1626804430514;
 Tue, 20 Jul 2021 11:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
 <60f010bf.1c69fb81.6775f.4720@mx.google.com>
In-Reply-To: <60f010bf.1c69fb81.6775f.4720@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Jul 2021 11:06:59 -0700
Message-ID: <CABBYNZL+gxxHVUGK_74Gh56Z=RK68r=L2ZRF=1w2+0ROwi52dQ@mail.gmail.com>
Subject: Re: [BlueZ,v6,1/3] monitor: add new Intel extended telemetry events
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Thu, Jul 15, 2021 at 5:07 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=516039
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.31 seconds
> GitLint                       PASS      0.37 seconds
> Prep - Setup ELL              PASS      47.86 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.22 seconds
> Build - Make                  PASS      211.38 seconds
> Make Check                    PASS      9.48 seconds
> Make Distcheck                PASS      249.82 seconds
> Build w/ext ELL - Configure   PASS      8.57 seconds
> Build w/ext ELL - Make        PASS      206.23 seconds
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

Applied, thanks. Note that I did change the command name for exp-bqr
to exp-quality to make it more clear what is doing from the command
name itself.

-- 
Luiz Augusto von Dentz
