Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1214EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A9E610CB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhEQVzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhEQVzX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 17:55:23 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE825C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:54:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q144so10614790ybq.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZmTCG2Euvc7SZOHL9en2ZQ5MfivLRgomHGlK1F8nwnI=;
        b=CrFjPGOVy2q2ds99aPQyeAFNeuO92et8NsOhqHdi/iPdFxPc6TeT6ocSiMZuaeQpru
         AUM6kd/IwR5Z6rBghOdrsnkuHF9k/P1UiQa49sn1pIR51DEy177ASKU3QZNqpJOetM5E
         lTYB4eVL7JTc2i8qoWKjIC0HpX7p90P4VyIWycw7SjCSUmBdcw4aMDQpshRNpACVb76u
         NIjlm9JqzhOaeRgz9oH6xewm3T3a+psaheKwYlJuCIxd2uFhoyri6ua5hpvEfNJm64Pq
         w/ItoBbrYbHwbWlml1uY+3Pjs8RUBOwgAA6OblU6ZZ41HX41baWXcZ79fcXIdX+Rx2ti
         0EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZmTCG2Euvc7SZOHL9en2ZQ5MfivLRgomHGlK1F8nwnI=;
        b=NgURhoY3kTAruRsn0kQNsJBReJbWmV5XE9liMsTT/hf/wKCVvtSCuC5TDdL6lwpehh
         wUK0nL+bb7KaqMZFYbI2i9M4eaX5rs4VeDiKesf5jtb8jN2CqoM7lJqqZv9BDHuIowD9
         d+Hf3NEGhurr16DkJq2EDy/8vj4+hHKnyNrkpYKgt2C6VCupFtY3yeuHuh+TDWmql4iL
         VccmNfif7KiyLDlTvB6fn9PW+0X7nKQXm0cXmYv73vr2dPO3Tt6OhsT8Na6Nzmc8kuw0
         8q/Kn3lYuf5kyqiAr/O0cxjO6NEkU0vUI4/FRQyT/JsDwJQE0g/DG5UtLGe+DjmhPe+t
         WzXw==
X-Gm-Message-State: AOAM532nCj/aBnxFIrrVE+nFOCx1FShqNsir0MIxP7iSXWjwvPwThNaP
        YbV/rtQ/Oavwye0b58LCIxSwX7d+55hqSn/jsy27MI0j
X-Google-Smtp-Source: ABdhPJyGp4seSOLy3GQe6T1/XMO3g9y5UjPtJsR+f0ZhUig+gNZwuV+2DaoNvv0CnirWrl0eKB8M2FGiVHIPCaIqC4A=
X-Received: by 2002:a25:ac94:: with SMTP id x20mr2707834ybi.432.1621288445906;
 Mon, 17 May 2021 14:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210514235854.143010-1-luiz.dentz@gmail.com> <609f2690.1c69fb81.a9bb9.7a94@mx.google.com>
In-Reply-To: <609f2690.1c69fb81.a9bb9.7a94@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 May 2021 14:53:55 -0700
Message-ID: <CABBYNZJ90Bhs98rsK8VPcqct0SgJOXYyuJUBnNEDeNmopq2ehA@mail.gmail.com>
Subject: Re: [BlueZ] client: Fix advertise broadcast
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, May 14, 2021 at 6:40 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=482855
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.69 seconds
> GitLint                       PASS      0.18 seconds
> Prep - Setup ELL              PASS      49.72 seconds
> Build - Prep                  PASS      0.12 seconds
> Build - Configure             PASS      8.58 seconds
> Build - Make                  PASS      210.40 seconds
> Make Check                    PASS      9.74 seconds
> Make Distcheck                PASS      246.39 seconds
> Build w/ext ELL - Configure   PASS      8.87 seconds
> Build w/ext ELL - Make        PASS      201.20 seconds
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

Pushed.

-- 
Luiz Augusto von Dentz
