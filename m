Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685AC23406
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbhAGRn1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jan 2021 12:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbhAGRn1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jan 2021 12:43:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0078C0612F8
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jan 2021 09:42:46 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x13so7028871oto.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jan 2021 09:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEZd5dVKMuOEgynxj24kMrRUH9BgOiaCTqlLJ03FvXk=;
        b=V2bnsGEr8fFHYtZ1RQihttCkhZzOWe9CTDnO7z5lsC8wOBNgR0pMHnTjVp7WDdJzgB
         guMixm7sFFOBcM9zVfjgh8/vvQo/D36NFIqkvQhm/Y3A8N4F2lkoD10LkzTAQAjTG7iy
         x99a4ZWdCEvLtYGg4bl6geZMrSDxfRRJrlqYkQWdhrdb8pdMT/3pVXM/nZ5qDE/zSXkk
         Sgcon1HHnTxbn8MOHX776EOYJGcTVK/sNMh8A3GQ6+o+hHvibYQJJeM+r53yEPMcqeXo
         WHqIXvK6/V3jHcBqZGL+lbUS3dbXo1ufPYSE9E7IgfiuS/NDslwcT+nkmjWjRgfjSwUX
         QeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEZd5dVKMuOEgynxj24kMrRUH9BgOiaCTqlLJ03FvXk=;
        b=POPfC2DyQWdoT0ZY3KWzIwfw3p1XAH+/6Z5cOKb3p6dpywoFbL4JN8XijCWAFXDL6L
         38EdAXawDwCy8M2aBIYDd9PYT8n+oHyBR6otw0Dokrmgf9hv8eMvBOBeKmzhpNBf5yfb
         wtGcIYvvCfQIvrvKvd7h8DK9ZR8wB75aJBodt1L9gNeKmpI1XbKEVgSgyU7DETNZOG+6
         FnsvmGDSY0q2loyPhc30aUjNEQ0YEaRfvAVDkm6nCYptc8l4ob+Bs76hJ++8/xdJ05Gy
         KA2zrnG5lQ84yiaXJUMftbaCVvdRBSXZymG1/lrAUIstBabyOZUbqmReQq9pWA/fRkjh
         uONA==
X-Gm-Message-State: AOAM531C0uBICwefZztDJXt/6iCCLNIg/up0un2VM398oR2F5qDPs/1I
        LMCb4MiJOIR+mSnqDGpn4l9ulE+AiAADdCACzP8=
X-Google-Smtp-Source: ABdhPJyTnl0Y14f/qHt+RcGi3jnH3AFpSRU7xiQCGYc3rvgYlVReTGa1oPaLf3t8YsJP56Eu/9hn/ZhKB+xWolL3KY0=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr7558359otq.240.1610041366298;
 Thu, 07 Jan 2021 09:42:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMDdHNdD+7dh8VTmzRd0kNY4cFtXXQK4j=9c4FQ0-6Yg5TLj_g@mail.gmail.com>
In-Reply-To: <CAMDdHNdD+7dh8VTmzRd0kNY4cFtXXQK4j=9c4FQ0-6Yg5TLj_g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Jan 2021 09:42:35 -0800
Message-ID: <CABBYNZJxDmcr5gF0px9z1G2TTdBXgbp1P6WiczK5SRfcELGcVQ@mail.gmail.com>
Subject: Re: Notification data limited to 20 bytes with L2CAP sockets even if
 MTU is larger
To:     Thibaud Roussillat <thibaud.roussillat@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thibaud,

On Thu, Jan 7, 2021 at 4:12 AM Thibaud Roussillat
<thibaud.roussillat@gmail.com> wrote:
>
> Hi,
>
> I'm new to Bluez. I tried some librairies but without succes.
>
> I try to use bluez librairies to test binary transfer over BLE
> (peripheral role played by an NRF52832, service Nordic UART). I also
> tried some other librairies but without finding the good one so I came
> to bluez.
>
> To achieve my test, I modified btgatt-client.c to have the following behaviour :
> * Connect to a device
> * Send an hexadecimal code (0x00) on the TX characteristic (RX for the
> NRF) to start transfer
> * Received data through notification
> * If received data begin with 0x01, write 0x01 to the TX
> * If received data begin with 0x02, do nothing (stop transfer)
>
> Even if MTU is more than 23 bytes, receveid data are troncated.
>
> I tried to do the same thing using bluetoothctl who works with DBus
> and the all data are received.
>
> I played with gdb to identified the problem and this is the backtrace
> display by bt:
>
> #0  notify_cb (user_data=0x67558, length=20, value=0x67c5b "\001",
> value_handle=15) at tools/btgatt-diego.c:1106
> #1  notify_cb (value_handle=<optimized out>, value=0x67c5b "\001",
> length=<optimized out>, user_data=0x67558) at
> tools/btgatt-diego.c:1081
> #2  0x0001ed50 in queue_foreach (queue=0x678f0, function=0x16bfc
> <notify_handler>, user_data=user_data@entry=0xbefff190) at
> src/shared/queue.c:206
> #3  0x00019934 in notify_cb (chan=0x67570, chan@entry=0x67628,
> opcode=opcode@entry=27 '\033', pdu=0x67c5b, pdu@entry=0x67c59,
> length=20, length@entry=22, user_data=0x677e0)
>     at src/shared/gatt-client.c:2191
> #4  0x00016244 in handle_notify (pdu_len=23, pdu=<optimized out>,
> chan=0x67628) at src/shared/att.c:959
> #5  can_read_data (io=<optimized out>, user_data=0x67628) at
> src/shared/att.c:1050
> #6  0x0001dc8c in io_callback (fd=<optimized out>, events=<optimized
> out>, user_data=0x675a0) at src/shared/io-mainloop.c:110
> #7  0x0001e308 in mainloop_run () at src/shared/mainloop.c:106
> #8  0x0001ea5c in mainloop_run_with_signal (func=func@entry=0x11ed0
> <signal_cb>, user_data=user_data@entry=0x0) at
> src/shared/mainloop-notify.c:188
> #9  0x0001184c in main (argc=<optimized out>, argv=<optimized out>) at
> tools/btgatt-diego.c:1746
>
>
> In can_read_data function, bytes_read = read(chan->fd, chan->buf,
> chan->mtu); return a value of 20 even if chan->mtu is larger.

Have you completed an exchange MTU procedure?

> I tried to reconfigure the socket as found on some thread by doing this :
>
>         struct l2cap_options opts;
>         int optlen = sizeof(opts), err;
>         err = getsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, &optlen );
>         if( ! err ) {
>                 opts.omtu = opts.imtu = 40;
>                 err = setsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS,
> &opts, optlen );
>         }
>         else {
>                 printf("=============> Unable to set socket opt");
>         }
>
> This hasn't effect on transfer.
>
> I don't known if I don't understand something or if there is a bug...
>
> Help is welcome.
>
> (last chance is to communicate via DBus but not a lot of time to do this now)

Actually D-Bus is the only officially supported/qualifiable solution
by BlueZ, Im not sure why you came to the conclusion you can just use
a library and not use the daemon.

-- 
Luiz Augusto von Dentz
