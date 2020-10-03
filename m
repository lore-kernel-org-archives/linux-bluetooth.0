Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132CC4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A94A206C1
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 18:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="Tr+qQAQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgJCSLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgJCSLb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 14:11:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D5C0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2020 11:11:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i3so2872889pjz.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2020 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xlorcE0ClSa2d4NdZFeRct7GeqVa2LgYNdP1feTP2sY=;
        b=Tr+qQAQ9gYuOZP5x2w5vjYPbLF4ZaG9OZabgyvLXzt9PvJxtIu6Ym5BMxnbTGSQQ4C
         2hSnGdYS6MAoefboKlbawC6wrAsLoeXRsSs//x2rFkkjDWdV2e7xpq8omtgSGCe0yD14
         yegnhJyAxpbyvWZHPAD9eUW1LrxK64pfrLYCPL7qM1JfbOCq4yFHA39akM/2IMCW89Hr
         TmTtFVmOJdTMoFGfu/Qnwrrn7BdjkunuYtmJPRk02Utb/XGcNaSt4VmicxTcJK0muaNQ
         3j/EKWxuQS0j49mSiYqFXRgAvhDd9dJ4wi/QsVh0zpBKkfwYXAkUPQv9Ao100UUmdB5D
         8rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xlorcE0ClSa2d4NdZFeRct7GeqVa2LgYNdP1feTP2sY=;
        b=AGUeHD02GQye5HKYdBVmbeBUIUffVOoZd63jvloaOdKIkUTk+xF5g3NtHLNnOQNir7
         6tNQcTXLPsc0Y0Od6VbvUxvaWYgEusIxqvBDywrM9qUFHv6rQaqAElclGpz0GdueNLhj
         x/9LzPsCiydPb3n9EtYDQg8USu7+UNLq+UwtrxU2Xpq2qMSK1w8ud/EyxgvaJmOOhmrt
         6cHxNY0BJHk3oto//sQxEjl59oQRRWpZIML2fGTN7a6JClyUPlLo8O9aSnEvLbVz0Tk4
         BUaJCM92wfZFRzActqJMymd3xOtiGT/cMFd13o15gn3l8C9NR8FIZi2r6/zgrbsddiNx
         D1cA==
X-Gm-Message-State: AOAM530mPP74qXgYAB8iQnPCB8nVu++P15d7dk9BU5u7r3K8jUCnTjPr
        aOvhgfCpk3wETVHW5s7W4e8n+Ipbnuj6dZyABS/X3rfXUSk=
X-Google-Smtp-Source: ABdhPJxbFZMgsu4Cxg1Q+CAkyW/31yvNfEf6B5zlTrsmkSg/1MqBdL337THLFBEn47+7Dcw+qhu/pBQ5qNr8ANWcG/w=
X-Received: by 2002:a17:90a:4545:: with SMTP id r5mr8243922pjm.55.1601748688900;
 Sat, 03 Oct 2020 11:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200928064446.17803-1-machiry@cs.ucsb.edu> <5f719177.1c69fb81.4e1d.07c5@mx.google.com>
In-Reply-To: <5f719177.1c69fb81.4e1d.07c5@mx.google.com>
From:   Aravind Machiry <machiry@cs.ucsb.edu>
Date:   Sat, 3 Oct 2020 11:11:17 -0700
Message-ID: <CANozA0imy3i=ohQLLAA0ou32qBAEfAk0QGrXzMWBTqueO-8wfg@mail.gmail.com>
Subject: Re: [BlueZ] lib/sdp.c: Validate attribute search return value
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Gentle reminder!

On Mon, Sep 28, 2020 at 12:32 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356319
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
>
