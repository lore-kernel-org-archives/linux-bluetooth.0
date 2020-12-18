Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358EC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2C323B88
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgLRVKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLRVKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 16:10:13 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D7C0617B0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 13:09:33 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 11so3220869oty.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 13:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Zfd8/djKQOwIiogxS5QeYwlY6BofM+CQ2EvXamQ/B6g=;
        b=d2Gv3BKUoIyjccjGUdelLQPVq044l9xAQI5W3xrak6esCBRKBGdVw+C3eKwz8h+X4w
         z/tpF35p7l67s0aAUPC2BD/6KSMJckdBggjMwSqoGT2TFO/2R/zbKiSw9TGTLrZ7ADUM
         cil117vr3s1Z4p/uxIGqosiX+0NtFzOUKR/bfnNIXiZucq5AyQaFkXNaMK9pwu+qNg4Z
         PUtO3EwYjlwXFZ7iS4dFrg1IPbcWECrk8y80kYPq5XBkfbdDLRxAA1j5Djh96XQSvPFy
         6g8fcm02+HVrBX8RXEKo/bMM8m/7K6Cg51XJnB64MfKEaoFKIoN3HZinoad7/7kz3a5q
         ZXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Zfd8/djKQOwIiogxS5QeYwlY6BofM+CQ2EvXamQ/B6g=;
        b=B4JpQEr2WHrV83DxRS0kPD/yrWKPMUAhW3ZkMMUTDqtvxCQOyhssaopkVqKT/Mqs19
         /DaT+0O2t5mzozdy6ybAC7G27JyoDagGOPBYe96WCXRbX24k9DzuH2EzPTdsIkDUPEUb
         kYGq8bDONXugiTZbNVs6PS/f3v4TbSz7IHCJRWPytsXbyUpeduQ8xwg85fFcdyXbmTne
         CUjE03yntVb60w+A7kgRpsdpp0Ys1zFfCbb4brTo6YN2vFGpuxExGzkRwyFJ8eXXE1as
         CtlJ+rhrRnuPEUhKunaWGdJrFfbq0s+jEyQTSHKiTzJ6d1cVkGfBfosu2JTxAtIarGGD
         W9Yw==
X-Gm-Message-State: AOAM5327WWrieXxYbxG9mCOdVlFOgtygPUFO3uVCKJwNTfdsGY2bODxc
        6RaJQHYdlyvYcenrwkn6+OU5oph+sRguBZfS7ct2wct9
X-Google-Smtp-Source: ABdhPJzS2+rMV9o9hYHnli1G/f0P/RTuuHwFA21hfjFwb/S4PErNHhgEEv7ujS1t1X2/XgnMk8uLkkfdJ4aul+xaEL4=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr4176675ota.44.1608325772477;
 Fri, 18 Dec 2020 13:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20201218001351.1442784-1-luiz.dentz@gmail.com> <5fdc03c1.1c69fb81.f9b11.0baf@mx.google.com>
In-Reply-To: <5fdc03c1.1c69fb81.f9b11.0baf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Dec 2020 13:09:21 -0800
Message-ID: <CABBYNZJhg=icC+LYv2Dzi8Dz5uBS7jVskYc30mu6zt8PaTUS7g@mail.gmail.com>
Subject: Re: [v2,1/3] btdev: Add support for multiple connections
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Dec 17, 2020 at 5:20 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=403877
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

Pushed.

-- 
Luiz Augusto von Dentz
