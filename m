Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37979C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7196113A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhJDWuB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDWuB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 18:50:01 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9EC061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 15:48:11 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 188so21627582vsv.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvxCRJ3W65P7QqyG0dGWqzex/Oyw+5PGS6wynx4t+vI=;
        b=Vm+uukhJI++Xq0v9Z0HCGT45wA/YAiNJcOP+dnKB5f6JYe+7WkkdNE0zRUICGVSwSx
         9TF2QplzRl/MrhWcbJvCZo9EwAsmS9U/9ln9Be/VAvwcj6Fs3z9B9V5Xxxp6UOS7Pf3y
         5ly3cvK7QtYPppSnK5+ZROMU7UJ5/gK5Wsu4hgKy6O+O5aRShaZ2R/vSLs9Dg+0iOgBG
         7BFnXeXoVuYgH0ODsbZfkQ3Sy5HjXaRE2MWl2kEsgtDm3lHNQ0iUMgE7QTlp6sMwKZOw
         KuKUp8y9f+CkK/ISUlU1Nazh3fQEJhLiJkAEb5lEgZavcoG6U7HOVXPX4kc1G/p/VKBu
         vKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvxCRJ3W65P7QqyG0dGWqzex/Oyw+5PGS6wynx4t+vI=;
        b=IxyNP64e27by3Rs3rVSddjmZmTdv7jysJcL2X/toXnJyNhC3j8mopNkQNuu8Zv7n7s
         SJuOp2Ij1f8vQdm31QNmp/o747qZazedkJ4eDrIOwiN9jgCa3G1hSYRJhfAmqpSfHZEE
         K5WI+d21NHdk3+d54jJL26R/O3X5jzvQSmlxs3Rj3bPLdm/3p0Ovasr5e+rKr3OafSPd
         ZsGQDGU+gdiJwby4/kUBTGlDita9mD0K+eBiSc9J3qMfLOGtQJiux3I5NMqrcTq38El5
         xxa4/sAIT1FTAi/mGE6jaMGV/DDxAPqpRaaKrnpSNfaGVwMQD8G5ErWOoub3iIWijTty
         0EcA==
X-Gm-Message-State: AOAM531m7ju/CEMfy/uYwpxGL07tGdEQyhgmVSi2gTy90wAaLVyfqaTs
        UWRpAe4GImqcboLlgePCoBvtXAraQlydP6JwceQ=
X-Google-Smtp-Source: ABdhPJzNERw6rJ7OhE2rOuB0RiBqjpxHpgtSxlCIsMXnAr1BxocB9QaM6NwTQDHpk1dlJL19eyiW6LcD/OMWBbuk19k=
X-Received: by 2002:a05:6102:21d0:: with SMTP id r16mr16211859vsg.39.1633387690878;
 Mon, 04 Oct 2021 15:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210930223726.2886139-1-mcchou@chromium.org>
In-Reply-To: <20210930223726.2886139-1-mcchou@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 15:48:00 -0700
Message-ID: <CABBYNZL2cX9Rx25DqFd3ggmRM8ZQXF2nPK5dUSWNB5c1qmjN9Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v7 0/4] Detailed error string
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Sep 30, 2021 at 3:46 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Chromium OS has been working closely with Linux Bluetooth community to
> improve BlueZ stack, and there are increasing needs from applications
> building their features around Bluetooth. One of the major feedback
> from these application is the lack of the detailed failure reasons as
> return for D-Bus method call, and these failure reasons can be used in
> metrics, optimizing retry mechanism, hinting the reproduce scenario to
> improve BlueZ stack. The current org.bluez.Error.* are serving the
> generic errors well. However,g given org.bluez.Error.* errors are used
> across different interface context which does not serve the detailed
> failure reasons well. (See https://github.com/bluez/bluez/issues/131)
>
> Changes in v7:
> - Fix nits
>
> Changes in v6:
> - Rephrase error string
>
> Changes in v5:
> - Replace error code with error string
>
> Changes in v4:
> - Address make errors.
>
> Changes in v3:
> - Correct error-codes.txt.
>
> Changes in v2:
> - Add documentation for error codes
>
> Miao-chen Chou (4):
>   Add errors.txt to describe errors of D-Bus method returns
>   BR/EDR and LE connection failure reasons
>   Include detailed error string in Connect() return
>   Print error code for connect methods
>
>  client/main.c  |   3 +-
>  doc/errors.txt | 233 +++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.c   |  46 ++++++----
>  src/error.c    | 100 +++++++++++++++++++++
>  src/error.h    |  57 ++++++++++++
>  5 files changed, 422 insertions(+), 17 deletions(-)
>  create mode 100644 doc/errors.txt
>
> --
> 2.33.0.800.g4c38ced690-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
