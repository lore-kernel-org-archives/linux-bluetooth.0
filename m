Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC899C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 00:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E0120809
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 00:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I91O3tFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbgLAA3W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389143AbgLAA3V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 19:29:21 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A360CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 16:28:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id j15so16317007oih.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=txE4zsZz8X9Gq0uKnzL+dlJLWWyOSvdEYooJqq6jxrs=;
        b=I91O3tFdit/IW0aNPDgtm4JC0VoZFx/ogK5f/r29yC/wax22OC+c8C/l6exLuCCxTE
         /GZPeLIhmoe+s19ZfOzg6oj30ow4o55f+yTT8taivOQYuMc24kD8lbY2zGD1g/qufroI
         oXpvXxd8hwIwMdI3T+Mi4qX8fh8RadIqMZdn7OtQ+vEAxUYJxVWLHsFDbuuFz6WLv1QJ
         HVyEOveKHwrwqGFOyJh8Bd5xC777QyELnAE+zOuHu/2g7z5ryzM7tTFCMfiBF19d5cCN
         m1fn3QZ/mpVe9xWuw93fsI+4DICBF0R0SLwGhffuTh5Q5LM8QTJfZn5TbCBkvmzoxMco
         VsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=txE4zsZz8X9Gq0uKnzL+dlJLWWyOSvdEYooJqq6jxrs=;
        b=cLNlQoqXz8VfhW3jaH+gHxeJIUku2Z1n3E9+muutKReFe048j6GGVnZZP36xk3Aic/
         zQ0SUkj5ueQyr5Vt4h644K5c8d/3wUr4vEDoKZwMh43Re5hV1vpfgVW1KSpi0c1ffYVF
         4pxvHUutYkpK0cebBm7sjRzpzZMhj3GOathVvxqR1dH18jUsmltxdopFlA68+3FjWmpx
         Yyv+B7LRDofDUQJbl7hCldZ0kEAXsy7RxAnj2KVeNsAWDODvA82heSfOXAHLiSfPaFYN
         9JGpKOMKwOO/hz2RJjEvQGTG/U99KeZ05uqg02WqyXUPQkhVm4NRqBoi7z6CsUVLwqVK
         l2SA==
X-Gm-Message-State: AOAM532z+wtJcpzTJZVsAorJOmOsvqMU9V8Z2BbqscqM7aiMC+qA71nG
        5LdFvvakxXYG1lGoPXTchU2HaxXXBDWQ11LerC/xOHHe
X-Google-Smtp-Source: ABdhPJw1nPDxyBIbDH662RpXfvig1/o+eMvbdq3JPL7MU5seyZlfwYcyqqSOKdzZ0JKBvkD6uSeLuDfg74fv6ZnoTDc=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr101141oig.161.1606782520922;
 Mon, 30 Nov 2020 16:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20201130191749.1663518-1-luiz.dentz@gmail.com> <5fc547d5.1c69fb81.f4cc1.87c2@mx.google.com>
In-Reply-To: <5fc547d5.1c69fb81.f4cc1.87c2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Nov 2020 16:28:30 -0800
Message-ID: <CABBYNZKFwdHrE3+W2GE9UfN26cT=DLVSnSiVrWx6vDEKwx3FLA@mail.gmail.com>
Subject: Re: [BlueZ] a2dp: Fix crash if setup is freed while reconfiguring
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Nov 30, 2020 at 11:28 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393495
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
