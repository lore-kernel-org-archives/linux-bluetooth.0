Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A823C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 19:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F1F61265
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347025AbhI3T7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3T7T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 15:59:19 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8179CC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 12:57:36 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 64so5102134uab.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqFYeSCJXad6aS6S39heRo7FkDv01VeVP/ND29gKDgc=;
        b=dDxNVZAVqLPNNUs35D+eAe8okbmBzHKKnoi/MeyAfd64bbc77OdaNLmUDzQmhe3ppt
         VDjkAY8n83ss8owGrAkQS32J9gVE0hJoMWIaTphyKqaej3r1NhCxqqFNUnV/nt8Rc51R
         ad73RJDSzTtz7d0E4xsU+M5obJLA6clinrUI7Z0PymPnYIez+2U+mFrF5dgDMtkWl+Xw
         H6lsckibzaSzxD7lSc6AxRmjk0WAOkglCL+D9X6djIFulgstkjZTPHPreqBWXj02ttsy
         J1jxyCnLSZrGybgqlFxhO+2JRGeMhGhZWjgpJIwTup85wfUmDuA1//6mCTuMtSyZ9xRd
         xl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqFYeSCJXad6aS6S39heRo7FkDv01VeVP/ND29gKDgc=;
        b=eYQ0JAGCfxKaEgyd7kk7LbTzc2i6W2thQ+pW/wXwgrp7XcRtJg/8VRgO4T/WJFSTkl
         zPXv26dmRZ261edbRQ10ldoV+AUMewb70NXOrG5aGqNidiff+2HVCWRWLF1somzLWPJz
         od+f1wWUmvkwW0GQz1o7vQxcPMR1O8cqB1SgjUfDJjmS/fbDWnhePPA/18zB7rE0Tq5S
         Gvp0aKfunqvAfopuxEsaDLjoYXAbq+sdAV8lsx3rBY+ebVklggOaD55GmDXUcRCELP0N
         skNu/cbSd6Z9ozYYIQ956fUbC3S8mSDVqdpLaDdpZwxVsgy0G2KUnlG+PWiwljyEEFJu
         FIGA==
X-Gm-Message-State: AOAM533QY4tc0FUWP3FprzmTywH8ogRNwOydTFlXEbmJD9qFIyESilkD
        qRslGc1qFH0zzRnL1AHNGPY67zs4DSmCCy/UpTlesU4P
X-Google-Smtp-Source: ABdhPJyvalBYJ18rv9m6O69eQPJK+QCFzJLR4G8a8hapTtKqjLEHXH30tdvbh+9e8AYkcdiOnQ8raOQZFTsMuj/85+0=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr7531328uac.72.1633031855422;
 Thu, 30 Sep 2021 12:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210929174819.66551-1-marcel@holtmann.org> <6154ace0.1c69fb81.9de0c.2c2a@mx.google.com>
In-Reply-To: <6154ace0.1c69fb81.9de0c.2c2a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Sep 2021 12:57:24 -0700
Message-ID: <CABBYNZ+yK7tcvQHXR-S1z9Hnd7PRpHMXDAxKVhyZFN0kKWtTeA@mail.gmail.com>
Subject: Re: Bluetooth: btrtl: Add support for MSFT extension to rtl8821c devices
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 29, 2021 at 11:21 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=555161
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.55 seconds
> GitLint                       PASS      0.97 seconds
> BuildKernel                   PASS      627.69 seconds
> TestRunner: Setup             PASS      460.24 seconds
> TestRunner: l2cap-tester      PASS      10.26 seconds
> TestRunner: bnep-tester       PASS      5.46 seconds
> TestRunner: mgmt-tester       FAIL      85.35 seconds
> TestRunner: rfcomm-tester     PASS      6.76 seconds
> TestRunner: sco-tester        PASS      7.07 seconds
> TestRunner: smp-tester        PASS      6.77 seconds
> TestRunner: userchan-tester   PASS      5.86 seconds
>
> Details
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 85.35 seconds
> Run test-runner with mgmt-tester
> Total: 452, Passed: 451 (99.8%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.112 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
