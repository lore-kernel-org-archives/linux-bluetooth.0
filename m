Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ADC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 23:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC3564E2E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 23:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhBUXr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Feb 2021 18:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhBUXry (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Feb 2021 18:47:54 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC2C061786
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 15:47:13 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q186so12240073oig.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGP3r2f4zPW3GtaZ9hFWR2PWzu1ogKxejTXf/7WVcyQ=;
        b=ZQEG8oOwrz+IyPbefiACvnZy26YQL1b5cqZlYXRcHzZPJ6E8w/YIpMxKQPbcoa/8Ej
         2pqOXAKLBNZmABIHqPrUwmlenNEXSG2ahuN7Mm6i62Z+NiF+qE34kLvIuqKhdxysm4Bc
         SquhzH1VGE2a89p1wYVmubReWVL+urGMMvfP9vGsvire08NNNiJc9YKU3E/MxE07IYt9
         koXJc5e0qUTY++ME/6ziaa7J/QZZ0o3tTI0AkuGbuNiPoxoi35ReNQNhIkgePcTJTPYF
         Qd77xSo0BaTeMb/PLUXVhjhJCV0UIXJhovLwfhJjkIX6FnSANqSfzlm3V/vOoHdUdgm8
         i78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGP3r2f4zPW3GtaZ9hFWR2PWzu1ogKxejTXf/7WVcyQ=;
        b=rYQskXKTud7QNdqBgZ8MkhkFeZaKznPFBjQPZBdO0UJgPp9TwFcpy3jvUIOOeqp4CP
         usQ8hGRR6OeJEyzT1W7Yg7WzTYN58Zcn/0Sm0/lulzp8Z4rGW0cgUB2m175IKsvHYkoU
         w/xRPeD/qWi4XSwvvF7W+Vb62Q/qntf1YefvGLnUnnWG5hYQ5KHhDgHe9Zrka/0YkKxE
         +zkArCnbfurCG8e53pZl+L7dpNKp37ZpOx63d8YFFVyQZmsZhfacJGpZkKuV4kOVFXsz
         cFWB8yPXMMFdNnnfFsBLL3pNhsc1JVlIAeGvSgUZEtO3/w88LvipNpj+m0dW2EF7+LcD
         zA3w==
X-Gm-Message-State: AOAM5334uGLmSLEnKIytz0z2zs8OLBkb+gigL6L5oZMKOGszryxuY0Z5
        EZn8x+JsVpi/EJMe0ECRF6b8vj8b5MQ3jL9/E84=
X-Google-Smtp-Source: ABdhPJx1/1gYyHxsaLrV3Yz0aFIlDnAo8fZFEvP4t6Jbwcv6hdUTj/hQRONLMHf3VTZ+Jl2rN23d7qrmUdFx3EYx+3E=
X-Received: by 2002:aca:c109:: with SMTP id r9mr13817576oif.64.1613951233228;
 Sun, 21 Feb 2021 15:47:13 -0800 (PST)
MIME-Version: 1.0
References: <CAP_L5iP4vuasHk6qF4KYrPUwE33n3NVzwA28E559bykM9+GnOw@mail.gmail.com>
In-Reply-To: <CAP_L5iP4vuasHk6qF4KYrPUwE33n3NVzwA28E559bykM9+GnOw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 21 Feb 2021 15:47:02 -0800
Message-ID: <CABBYNZ+qMec0KbGx4Gfjb5yygXYzxz5WESReo3FS3_WNuqw1UA@mail.gmail.com>
Subject: Re: How to receive notifications after calling StartNotify
To:     Mihai Emilian <be.mihai22@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mihai,

On Sun, Feb 21, 2021 at 9:13 AM Mihai Emilian <be.mihai22@gmail.com> wrote:
>
> Dear linux-bluetooth community,
>
> I am writing a bluetooth client in C which receives notifications from
> a bluetooth device (server). I am able to call StartNotify() from the
> bluez api and the Notifying property changes to true. However, I am
> not sure how I should listen for the notifications, or where.
>
> There are several questions:
> a) How do I provide a callback function to this?
> b) async or sync method call? Does it matter?
> c) Do I need the main loop to do this and why?

You will need to subscribe for signals, e.g. using g_signal_connect:

https://www.freedesktop.org/software/gstreamer-sdk/data/docs/latest/gio/GDBusProxy.html

Signals are async so typically that would be handled by a mainloop.

> Here's my source code https://pastebin.com/KEGTatsL
>
> Is there an example? I tried looking at the different files such as
> client in bluez kernel source and gatttool source, but I couldn't
> figure this out.
>
> Many thanks,
> Regards,
> Mihai



-- 
Luiz Augusto von Dentz
