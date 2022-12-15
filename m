Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 20:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLOUs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLOUs2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 15:48:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDF221E10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 12:48:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m29so90892lfo.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCX6fCfFngCLI4PrK145m/3DtAZxkwlgnv7UrXpsTw4=;
        b=SRZBr4/YhvNdIGbHUqDG4Ir8euz2tqgqY0geq+FZfD5352xEpjLTIpiffYyj/fJi0n
         eExYm7Mb6/567FpfG7AksLZ5ZjO7Xsn1qeLaoEtB+88W3Bb/qLcHbXVWxILUPZ6QWoBf
         gfxbIn8ZGrf9oBbAA2MhcpAiRAK65XMzcA6A7zLWYRnsOuif1ORstGj3pGi1a8F8cQPp
         CJYCcSzwRjulCDr93O2VzvpHweTwusAEC0XIWlL4eticy+/f82XkN7XWHXbQ7JLYQSFt
         s4D0pz4bWEsLppnaVwSPrz2hvDnBwGwBaGfMljykcqo+3l6MBm9ue83xh8nHlodD/5mV
         NLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCX6fCfFngCLI4PrK145m/3DtAZxkwlgnv7UrXpsTw4=;
        b=Fl2SGVHkcrYd/b6wA/ttktHtHOYu5a1p0O00obcAWhRTcLEjJRI7Bdyd1rrBpMkElo
         aqyVBCcbmi8l+daCVwevRvFbWq+P/Ifmh/kmI00CD4PHs21UkEhV31NnIhGPsqk1nkLF
         X6PBClX9vE66RpYZjrTeF/u/LYp7F42jC7C5X1Dor5qNTBCLlJ2ug/gCs/A72I4RkgAi
         h5sClSqN8p7WE+YokQ6UXHzFd1AOCcNzY76F7NKbd/WulPzqKSi7fe3nXk1Ur9HRGtMR
         Q4Uka/W5Ilc/n2FUVwocmTY3tSa3Idcw0SKCe1PNfpT62bFbXzDoXVCbGiKd1XmBY5ip
         48vQ==
X-Gm-Message-State: ANoB5pk058QEiwlwI71XZlOOcL6JSnK282/jpPcD7pfHz2KNaoV4wEes
        H9e3zbvRuh6Un0AwHbH8k3zY92flfnzmAFEGO9QhNMs/J6w8AD0a
X-Google-Smtp-Source: AA0mqf77A4lJwYtNykCmtRa75WGPTfftPj/tCdynHKuBIQENQ4hXFBPHchKk3W6Tug0LAJ9OJ4V9TGDFt9pA/kfE+rQ=
X-Received: by 2002:a05:6512:31ca:b0:4b5:5da1:5224 with SMTP id
 j10-20020a05651231ca00b004b55da15224mr8244685lfe.106.1671137305421; Thu, 15
 Dec 2022 12:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20221215142150.240712-1-neeraj.sanjaykale@nxp.com> <639b31a8.c80a0220.85898.f5be@mx.google.com>
In-Reply-To: <639b31a8.c80a0220.85898.f5be@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Dec 2022 12:48:13 -0800
Message-ID: <CABBYNZKpJCT3VhRgc-a58utFOm7mFz6uOQayzW_+pEbfhbfGqQ@mail.gmail.com>
Subject: Re: [v5,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP
 BT chipsets
To:     linux-bluetooth@vger.kernel.org
Cc:     neeraj.sanjaykale@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neeraj,

On Thu, Dec 15, 2022 at 6:46 AM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
>
> ----- Output -----
>
> error: tools/btattach.c: does not exist in index
> error: tools/hciattach.h: does not exist in index
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

Looks like you are mixing up userspace and kernel changes in the same
set, please don't do that since they are for different trees and our
CI get confused when you do that, for the userspace please follow the
instructions below:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n98

-- 
Luiz Augusto von Dentz
