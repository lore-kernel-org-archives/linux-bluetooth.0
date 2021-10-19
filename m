Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0F260F8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhJSVQw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJSVQv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 17:16:51 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80502C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 14:14:38 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id q13so2731205uaq.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NvEY+DTkzTKydKvaugK/fR+II1w9AUW17w729nuDCs=;
        b=lx6LemRzUPQ0osNEXwzPVrdff8/OuE59SW+cJuCeyCveA6J2tILec4WQ4FbQR8EwnU
         O4HBUeaWdbpm42DT0paPVAPdPwAcKxyXDRBkEtvC9y8moZpjoYTavNIAcL8d9I4NkxYk
         C/zBnM81FvPcBcK+z9u8sDSMA/kAo7+1NKCgRTFh8GWOeo9DPCnq4lReCxyddUe5HrUp
         /G94CHgCp8WwEWvt9lX8JYCZG5NAeG1vpqtBCZXDz8mDNAmI1SKwkM6+LrBZVuqj3rNs
         lWITFG4rVyq40BqRAPPbC1THW8RRG678bTuT4bWyQMT0Ba4cdQtK2XlzAZu59uzLxq5I
         O8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NvEY+DTkzTKydKvaugK/fR+II1w9AUW17w729nuDCs=;
        b=t/Ou0Y+cRKIMIXJiqbBoiocE1ZVyNoMRkWWEK1cWEth/0inptyGrXy+6EzZiBoxj0H
         0MTgli9LOVjGSgY+eJci6OO39FjHVs5v//4kK9J8843camiGSOxAUzrF63eKUxu9RjTi
         io4vU0PACzpFNDTPf1fXhQtbi78NOG4ctTQ7weDppt7J7nDCuyvVnTfTUC/bi8A5q743
         KMR6nClkF1pbnhFgQjFkVy1ZV56ElTq4ba/YvNwlQXnwqatmvCLlKL6ZrIDMkLzNc9Y/
         xHT/RB2MfLvSgf+Lj0B51dUPzCxQOfEZW7t+OtB0JQZuZVERk5d+mNNVXEjLbNT72yhk
         oCaQ==
X-Gm-Message-State: AOAM533uSMm9USYkBai+uK7oChJoGOoEdL5Wx11sVTUShbFrsUnBG2mm
        pS3eGbVJXI6rWl9hfigCqGxvo7+Y2xHzBntCHiU=
X-Google-Smtp-Source: ABdhPJzia5D0FPgpMJXJIQfU3WgS1tZDfIGhAKzC5AQAgJH6Xfnyj1ecNVYnQP7RCf6qyziYQOtwOl2slWhcpRgnp6w=
X-Received: by 2002:a67:d81a:: with SMTP id e26mr7270474vsj.23.1634678077538;
 Tue, 19 Oct 2021 14:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211013190035.1876237-1-mmandlik@google.com> <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
In-Reply-To: <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Oct 2021 14:14:26 -0700
Message-ID: <CABBYNZJEVP2Q5_Zdfkh7B2ukoUmBUd+VyLvUQsyRduh5atQZ=w@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/3] doc: Introduce the Adv Monitor Device Lost event
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Oct 13, 2021 at 12:00 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Add a new event 'Adv Monitor Device Lost' to indicate that the
> controller has stopped tracking a particular device.
>
> ---
>
> Changes in v3:
> - Discard changes to the Device Found event and notify bluetoothd only
>   when the controller stops monitoring the device via new Device Lost
>   event.
>
> Changes in v2:
> - Instead of creating a new 'Device Tracking' event, add a flag 'Device
>   Tracked' in the existing 'Device Found' event and add a new 'Device
>   Lost' event to indicate that the controller has stopped tracking that
>   device.
>
>  doc/mgmt-api.txt | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..712bb362d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
>  Device Flags command, Set Device Flags command, Device Flags Changed event,
>  Read Advertisement Monitor Features command, Add Advertisement Patterns
>  Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event and Advertisement Monitor
> +Device Lost event.
>
>
>  Example
> @@ -4910,3 +4911,26 @@ Controller Resume Event
>         Address_Type. Otherwise, Address and Address_Type will both be zero.
>
>         This event will be sent to all management sockets.
> +
> +
> +Advertisement Monitor Device Lost Event
> +=======================================
> +
> +       Event code:             0x002f
> +       Controller Index:       <controller_id>
> +       Event Parameters:       Monitor_Handle (2 Octets)
> +                               Address (6 Octets)
> +                               Address_Type (1 Octet)
> +
> +       This event indicates that the controller has stopped tracking the
> +       device that was being tracked by monitor with handle Monitor_Handle.
> +
> +       The address of the device being tracked will be shared in Address and
> +       Address_Type.
> +
> +       Possible values for the Address_Type parameter:
> +               0       BR/EDR

Can the address really be BR/EDR? I always assumed adv monitor to be
LE only, or am I mistaken?

> +               1       LE Public
> +               2       LE Random
> +
> +       This event will be sent to all management sockets.
> --
> 2.33.0.882.g93a45727a2-goog
>


-- 
Luiz Augusto von Dentz
