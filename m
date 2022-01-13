Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298ADC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 21:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiAMVgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiAMVgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 16:36:42 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09923C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:36:42 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so18790855ybd.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VF1ascbHX2Fcm1QlKiVnVNZkUS91O1w4hwkr2xdRbY=;
        b=D6kdKgwhUmnoA0Bk3L+oFLvmGb2/ur0EVUNUY3qb/TPMQQku9FHsU7//Cfkf83BGSD
         hS/raoNMLmUxMSPDtYEzejILfo/U6m60GM9cVOgDCDuicTssBc256d9+MyewXYZIlkUJ
         Epbn0TdNklfqdyHHcVPs5pDNgg6R4Ye0PRZwXV0fizbbvvuduS8fIaXJK5bPyLnHS0gm
         AObdJIfUwfcxIIfLV3Rje10AHJILEpHA9FZyH38QB0tyc/1XGpvmzWs97I7QpANlqP1B
         t8fbExVfK7JPTb1yMf10Sdg0CLVs6UWx6ZK8AVflXr6FmoLUWes+mB3Uid7GGu93cMkl
         f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VF1ascbHX2Fcm1QlKiVnVNZkUS91O1w4hwkr2xdRbY=;
        b=oifjwomlws5DhD1CFK+4txUouFqWiUZFoJazj+zF3zZ323eOFPEF21YhLjg7WIbqbL
         zTxU7knS2GR3i5PBYL8260Khja3lmzdhi4Xm0r6Y0cFo9BCHvM7Ye0PI/zZpFQMG2EsU
         v/HiKFO1cMEsNETZhZIipuLmCY53IezRhvXu+s8F3s+x5NHIwjSEthU51h3nLnGPwC9y
         sWCxEpAt0+IfEKJN37pYYnzryIAEUFksVhl4ZX/NbeDfKEuOV5paHzafnbqRsiQoHwyl
         jPpIVsapTRagV3PKPJnUOvbq1SwcHDyUmc71g0xSg2JV+vldspEFoNzgD872tUp9O92E
         G0Rw==
X-Gm-Message-State: AOAM5337d3Nz/RNDe3nE9MqwllkZIwMBLIC2PRADPV4rfjoDT7jOTcMe
        K2ECRD2PT68uxTkjzLbvF5rno8cYhv+VMQPZ+v9O92lC
X-Google-Smtp-Source: ABdhPJxO5K5b2S1va/CxH4wvNG6bPUZVEoQt3ttE9ngC9ZVKzU1uhO+BVDcsxTsi7zshpjY9vz0QNUwVA/o/kOLVuXc=
X-Received: by 2002:a25:b683:: with SMTP id s3mr8266143ybj.293.1642109801006;
 Thu, 13 Jan 2022 13:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20220113154626.Bluez.v2.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
 <61dff149.1c69fb81.415f4.8d3e@mx.google.com>
In-Reply-To: <61dff149.1c69fb81.415f4.8d3e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Jan 2022 13:36:30 -0800
Message-ID: <CABBYNZJFsOG5+Gbyt_DN2r9O29Aq90sEZu5cBbomMjEF715GJA@mail.gmail.com>
Subject: Re: [Bluez,v2] device: Fix device can't be scanned for 5 mins after reboot
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, Jan 13, 2022 at 6:50 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605104
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.44 seconds
> GitLint                       PASS      0.97 seconds
> Prep - Setup ELL              PASS      42.40 seconds
> Build - Prep                  PASS      0.70 seconds
> Build - Configure             PASS      8.52 seconds
> Build - Make                  PASS      1403.75 seconds
> Make Check                    PASS      12.08 seconds
> Make Check w/Valgrind         PASS      437.97 seconds
> Make Distcheck                PASS      232.37 seconds
> Build w/ext ELL - Configure   PASS      8.66 seconds
> Build w/ext ELL - Make        PASS      1365.55 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
