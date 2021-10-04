Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC6BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582EA6136F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhJDX27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 19:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhJDX26 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 19:28:58 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67BC061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 16:27:07 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v4so6957065vsg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bbHz+Bd0EjRMCZvBQZfZnGimWs8szfPu9RvK6dNHM0=;
        b=UaCCvWbyHAWQnaJXp205czCaw/QiC4hfiMIg/cPYupOcSVy8iWgFkRDDY72cEAyc6G
         XbHYMbVtAfCDbjrnOAqmiyCHqjr68/E4SObwQtCtLga0Nuise1bDBFxfdaeYIT94cY2M
         NFuwL784BYAib88w+uATZAG8uFzXocJbS+M5ev4Tb5v3YCQ11GZ9YXc04kzy+dizBC/t
         jRfy1YsXFf00jEincsfifHzxu0nVTCo1AFk+kEVBegPgGbFyOz5WsQlWJ4okfXYNziQQ
         1vpuTMbAOBPIrwY1NpexXqN96BGkoalP63paRAsdqnGqA6alD9fxA5muARaLtGpGNypI
         iZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bbHz+Bd0EjRMCZvBQZfZnGimWs8szfPu9RvK6dNHM0=;
        b=IwP4uMoIeL0jIeA+lfN0zWB4qOxYAJgnaWL4tk9SXkg9HLsInikMi7GotywFz6gBbC
         VT4BoA9NWw8bTkDY+xdB/LOi+6KJ3mhhJnRPqDFVV+VeWuP+U+/GylLPF71MAnXQXRAZ
         iL9OCBom+2uzbR7/Yu9xpE/LoPku8Ca7aaU3wtmKrlyPGuJqwNLtXOGKmx6OWlmp+ZPd
         kOj+SL23iJjNptESDJeDT44bKYSPnEHtE+Vn3bB2ptUGlgdkNEU2V0RJuQ+HS+nYeB9t
         wNx9bhlrDcHQz4x6r45oxOpASsUkz0wJ/oyMvgnjDxtwflI8CaKzU5zFK5MPBFSOeQ5n
         QO2Q==
X-Gm-Message-State: AOAM5327lSAZqgTUQiFANorN+atntM9oBmag14x9vBc5IvZFwiezF6oa
        9jj/lzOAdq2IR2sMf93YdnWFf0g4lfQz8BvJYeK4YYC1
X-Google-Smtp-Source: ABdhPJzfmQ9xg0XsROanw751W2vEyjIxe9fy2QCFNYYQm8W8zyebsRtKuhpGRJOpE9cDd6u6/y8FVDX29VmdCJc1L1A=
X-Received: by 2002:a05:6102:21d0:: with SMTP id r16mr16341063vsg.39.1633390026015;
 Mon, 04 Oct 2021 16:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210909230923.165649-1-hj.tedd.an@gmail.com> <613a9a4e.1c69fb81.a6be7.e83b@mx.google.com>
In-Reply-To: <613a9a4e.1c69fb81.a6be7.e83b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 16:26:55 -0700
Message-ID: <CABBYNZL0TnwUFS1EM55ZSAwL5FPbxV5X5XZpPPC_1fWOmcpNjA@mail.gmail.com>
Subject: Re: [BlueZ,V2] tools/mgmt-tester: Add test cases for
 load_long_term_keys command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Sep 9, 2021 at 4:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544673
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.60 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      44.50 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.75 seconds
> Build - Make                  PASS      194.30 seconds
> Make Check                    PASS      9.25 seconds
> Make Distcheck                PASS      229.46 seconds
> Build w/ext ELL - Configure   PASS      7.76 seconds
> Build w/ext ELL - Make        PASS      178.84 seconds
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
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
