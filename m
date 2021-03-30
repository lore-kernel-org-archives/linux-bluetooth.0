Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159CC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F4261996
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhC3TZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhC3TZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 15:25:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F47C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:25:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso16628700oti.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVJpxIh6GrideWNuWMiCW2tren8Pwf4Yo0vIdLSuvqo=;
        b=cDn2v0O5WWioz5Q676Ad5Wooy57tVCIzRl8AvIbX2HeBAEZXXmdqKd2Zv21x85jOH5
         EaFuatlkoLyIOgX0FtBiitYeguq2He7jdniA0GcmASVWUTQnVEAue/+9ebp7v1lpuJ9x
         3cIY8EbKd2jV3nLFyPbVVBvxblm3s8Psox8uOZ2X4KzNqO7EXWBq7itjiScfh8Y5eFoN
         klv8fERjozTM2uaQvF8aCcyQqP4HhvagQIw2JUocBEVfZR/lEx/A94XNTW1gxzGNLPd3
         yG5XmG+76QU6a7sezRlphtRG0gAzHxV5cBcD1zmD3cJt31uViaqxK0i1GeAGLWxb6zU0
         3lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVJpxIh6GrideWNuWMiCW2tren8Pwf4Yo0vIdLSuvqo=;
        b=Q7m7+/jblSWg/Sq1m72r7tzrmktHnh6ZoO5UdPuP+yZk/PuEhu9xxD8jm1JrdfMmwQ
         lIl+P4jz8hIimeOy55MhCyrKUiRpRnxBOieOixNJgcBxGoxsyuatDm58FfwQMS8la3Yb
         RrdQPcL703CUx5hxDy5M7zFENM6D91y1pu0ptlnudJs09zIvtdoum/+6Y4rb9lNr8GhZ
         0PhpDnXA/4yocpK68iGDT493QlfZUPUtqLpbObc2ThJuhxWRabVWKFhofxE/UOhz6Mx6
         8mSxWutUslyRn+2z83yK7dVmtNqvz6kRQXDvevYsoHjeUjsLcN2NereJH92VzidC+dlI
         t9bw==
X-Gm-Message-State: AOAM532ZQJ1+Jy2PmM2pX85gb6NaghDj2tnyPAmPuZr8eV7l9HiCc/Bf
        AiKFH5iIXpjeMTqH5E0jO0o7fzo+NVFf6+OVbpGpyF78k4w=
X-Google-Smtp-Source: ABdhPJzXFr9RRPfIRxZSCcrPSSm3CNQsJH+fFXntb4WXooRfkTeCg4m8S7hW/z1CHx0kaXd0CV9/+T3JXoO4cLU/cbw=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr27625026otp.44.1617132345581;
 Tue, 30 Mar 2021 12:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210329231544.bluez.v1.1.I18e234e0b4d11e2ee24a699e70bde7e0a84b0be7@changeid>
 <6062c87f.1c69fb81.a55c6.d49e@mx.google.com>
In-Reply-To: <6062c87f.1c69fb81.a55c6.d49e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Mar 2021 12:25:34 -0700
Message-ID: <CABBYNZKuhAR49WLcj=j_PPF=J_aqzjwcBFTZTD0rL5hwkRiUfg@mail.gmail.com>
Subject: Re: [bluez,v1] test: Fix AdvMonitor RSSI filter properties
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Mar 29, 2021 at 11:45 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=457825
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
