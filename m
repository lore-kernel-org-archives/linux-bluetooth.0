Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB872242A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbhAKQrk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbhAKQrj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jan 2021 11:47:39 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCFC061786
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 08:46:59 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x13so262544oto.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=n+wk5yzuU/Ar64AvaWOE5ZGO6vlaRzOvCZB1FmspQYY=;
        b=CSQcN6yx3gUSkAGUEux0sgoVL8uh0DQORImXO3PlayXXEDmTjdwfenEp58eahxnKmT
         +EqofVK14G5OqZW024d00m0dshmrNxEMR4OPsPJ+HrOVvy5Gb7YnE+vlR8jmiH/ExrRg
         lcjBFKSr1Ivs1iScW8C8g9AkfuCqsOHH7fj/UVwKJqgXka2kC78xmU6XD+3okhoGJ3ZT
         V3fMxDHDCAmUyIs0VTqzXhXWH4N461x/s/GZcKPIYh7Wk6mySONxSGtG8Ue41q39qIIG
         hP5lX+GR5GVRkZntDnh9/TqPn0RJd4s8COVzRqy1af+sH3JajXEsFjviuQPDIx7nf7/c
         AD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=n+wk5yzuU/Ar64AvaWOE5ZGO6vlaRzOvCZB1FmspQYY=;
        b=Lp5XfmMjaz4vyiCocXELflNYuBz3igTSU5r/v1b5EkE6Ki8NkdPmfoHm/fLS7OiTR8
         FbAwN3wkQtJsJed8LVpwy3p/jVHZZk68nNw5KRmORhJnkw93AkeDAdQOd1rI+BQl7xnw
         78SWCO0+7ieRBrnscznHHr6ZkDmGHk7BBioAGwDokb9/i/OtLcWq7JffxLJPaP2K5/FU
         RwCPlegScQXbr89gCkM9xiGleH1LRovrjlVLzEaSmjMq2amGlmczqj9PIU3Lkp9C/qDP
         tYN3LwMYitWkFi1t4XJajC2WDMp8So9ccvvc54aRRlUtN1FNAT4Sy2OLqR+RZoirtpcb
         qKyQ==
X-Gm-Message-State: AOAM5317LxOdrXKt5reEGH829U6nBE7i/3c7j7TXnHCTIu2lEJ8msHBK
        i+fPwdvD+vjRUqFkI8WCxWIVYahrIGVhaMzeIvDdVTVM
X-Google-Smtp-Source: ABdhPJwoB8VP0MbvqS8HRajPDXdq1zcHDPx+8M78uJK72LXq64Qv1KoKFqYQF9/v/4Z2fvT//ld7zOFng2L+uEkwRgQ=
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr42532otp.240.1610383618753;
 Mon, 11 Jan 2021 08:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20210108211513.5180-1-luiz.dentz@gmail.com> <5ff8d15a.1c69fb81.d489c.a708@mx.google.com>
In-Reply-To: <5ff8d15a.1c69fb81.d489c.a708@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 11 Jan 2021 08:46:47 -0800
Message-ID: <CABBYNZ+O4PTHCoCJRDk1AO+nfeSWr3m_GW-mbHJcjOOQ13cd0A@mail.gmail.com>
Subject: Re: [BlueZ,1/4] util: Introduce util_debug_va
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 8, 2021 at 1:40 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=411499
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

Pushed.

-- 
Luiz Augusto von Dentz
