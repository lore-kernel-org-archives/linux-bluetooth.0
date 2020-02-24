Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A42C35671
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 14:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A79E2082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 14:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVjkmxJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXOIC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:08:02 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34774 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBXOIC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 09:08:02 -0500
Received: by mail-lj1-f181.google.com with SMTP id x7so10261558ljc.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFVuRbR2J8J9/Br+w8LWg9n+kSiiX+9WFafsMfA7LLc=;
        b=JVjkmxJr41C773eKbe/n1WI5gfBLcAHcL9XvBotFf7mp1vKpM9X3zLT3R43IGi2x4w
         S3IJmcabhHaLXDnLxyqMWUl1SEYbEl4KGdvYhAdlsYnsCnqTIvBKm9JUV4fOx9vZtUDu
         KBLGrDfI0+Egnl3ZuoQJYaN9Exh38UxtErArVdtvygtJd/avq6uZ3sTv99ouNg2TAJ2l
         vHqHurOWZec5FwS5PMIW2tc7j9dVEN7Jz8k52HoMtxXBB9G88jkmv8e9CuXtDNvTxWTI
         CMKVtVDIoW9BGR2oeZcuuVasZxdfPK5vlUeG56VxMEHJY742q92PbUyVUxTonx5PI4HZ
         OZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFVuRbR2J8J9/Br+w8LWg9n+kSiiX+9WFafsMfA7LLc=;
        b=Syr39/FnFCFnZkc0zSKgr8vzMca485etKhQf49TEnsSTaV+6BiXmxPwc7sPo8diHEU
         mDtZ4eh+qF3fYx4GwHnxU0r3MAPxu64b16uMjCqQIeEMf/TqWGJ9+EHdEZpVwmhEIyM1
         qf6oxv0CP18L/N4h3QK/zzW7D5ShNGPKLI4jWJZY0b23pah4fieHlRKm9X5rxDJL0xhl
         Wa3us9q7uGZ/j2z/3L/iXRKlc9zHlgkbnUjPFQuyZp8opXarOQKKUL9HEzY0HskwMGdF
         EeUPRNsa111LsQG+y6s9LynDzfxfBpH8IaxRKWWmt08WTC9nm9/Ia+Pzx/za+ZHmnxvm
         iPcQ==
X-Gm-Message-State: APjAAAUpUbbxF9lZHdm03xo/IUg84n9X5sqgXhLbnOAC19iYDKDsryl1
        bqOmD1jRVyFUeO4Wc+xWZznCHpGd0ka3sEadp7cTIElMewg=
X-Google-Smtp-Source: APXvYqwlncHpmwe0/tBuEnzAcR77ujVVj+Dxy0IFzfriRE3gOhaykUGCDdrvkjjSCfHVoaVQIgVQkYO2awGii0gkf2A=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr29868982ljd.63.1582553280123;
 Mon, 24 Feb 2020 06:08:00 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
In-Reply-To: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 24 Feb 2020 14:07:48 +0000
Message-ID: <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com>
Subject: Re: Bluez blotoothctl scan vs hcitool scan
To:     chris baker <chrisbkr2020@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
>

> So my question is, is there a way to get those missing advertisements
> through the dbus api, possibly some additional setting somewhere?

Duplicates are disabled by default with the DBus API. This can be
controlled with the DuplicateData setting:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107

Regards,
Barry
