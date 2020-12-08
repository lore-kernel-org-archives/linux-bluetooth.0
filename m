Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E70C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E7723AA9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgLHKr1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLHKr1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 05:47:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A6C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 02:46:43 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o24so18562837ljj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Zp5FHH0IFwKzP2QOuNN5XOCjtnIIzwwM07ruJZHKzE=;
        b=D0hbyE43YYgmF5NJ9q29OdN81XM39faUnFzsHvg3tfAUkLaGJGGzFHZyEXnChR6htY
         F74y1mZ62KmtUDFExWbq8DkZsIwPnSrtDqEovGSgY1BMzt1IrFHYmefaYrIMSPftAoJO
         shMzpKwBHgzCMlzJkUah8DI4lXjL6OJyXmv0cZ4GxRB4OewgN1c4WWWquhJwKzrPFmSN
         H3EDVqtAd1R/wgBfNJ+Fh3bmUZuKEApZNgiQ6A6kdUTErBZmV2Gm7a9LzEhHAjZEOwuz
         pDRNtNamtWX69KdaxjrDxLUXlrPefLcFeapUMk0xAxep+42p9vYAafrzk95lAXiSmyFV
         t9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Zp5FHH0IFwKzP2QOuNN5XOCjtnIIzwwM07ruJZHKzE=;
        b=DdKL/Duw0OExk+iYEaHltHh1ApM5zxMVirYdfY8chlcLG5cAHVDykRUFECcnJkkt8b
         xadIFAo1QbKYNGVIdsk3E/kbKeSiR6ugT02sWqqWJfvkO9uaZSfRi5Ap37/32D8iJWvf
         k+aeC0k8NQYAWTEWYgcXCAlcL+k+wnGIyBiyLuhkMcRQ9VqDF8JIHihn4tVOZvik2S7x
         t8GZfI1Hiwhfvwm9pTL2PT81U9Ur1J8433kRghaIv7G0R+KLrNFIf/p36PwfwhZcmYU0
         3jb8fGWfozxTYJayEdv7sK0f5YYqo1MMbmL+MHk/3wYzLuR2Su7fU+ieSb5lUBdL24SR
         WBHQ==
X-Gm-Message-State: AOAM530yOagj6HAfzh2Oaa8HcJVWdxWe7iWptu3Z0zqF5iJXK+6VVXiZ
        UolmAgbUYDsdrN9RuX66C8YGFDOWD13cFWZ8JgRfTvfkhz+RSg==
X-Google-Smtp-Source: ABdhPJwTDl5QYvGVXlO4cN6xxlsa5hcHd5VBwHb9xEnvxu2egdT1clA4NCI7hiiTlIFsI5rWwP7nCgGaRHD3C++6DXA=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr173579ljj.77.1607424400711;
 Tue, 08 Dec 2020 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
 <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
 <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com> <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
In-Reply-To: <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
From:   Lionel Jeanson <lionel.jeanson@gmail.com>
Date:   Tue, 8 Dec 2020 11:46:29 +0100
Message-ID: <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com>
Subject: Re: sixaxis patch proposal
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Cleaned known devices.
Restart bluetooth service.
d=C3=A9c. 08 11:36:11      Plugged sixaxis on USB, new device, pair, yes.
Checked that it is working.
 d=C3=A9c. 08 11:36:47     Plugged back sixaxis on USB while on, all went f=
ine.
Unplugged.
Turned six axis off (long press on PS button).
d=C3=A9c. 08 11:37:03      Plugged back in USB -> Authorize service etc...,
in bluetoothctl, didn't answer, request canceled     <--- this
shouldn't happen
Unplugged.
d=C3=A9c. 08 11:39:39      Tried to connect using BT, won't connect
(normal, it's nor paired anymore)


d=C3=A9c. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: compatible device
connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0005/h=
idraw/hidraw0)
d=C3=A9c. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: setting up new de=
vice
d=C3=A9c. 08 11:36:14 lionelux bluetoothd[8616]: Set device flags return
status: Unknown Command
d=C3=A9c. 08 11:36:47 lionelux bluetoothd[8616]: sixaxis: compatible device
connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0008/h=
idraw/hidraw4)
d=C3=A9c. 08 11:37:03 lionelux bluetoothd[8616]: sixaxis: compatible device
connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0009/h=
idraw/hidraw0)
d=C3=A9c. 08 11:37:03 lionelux bluetoothd[8616]: sixaxis: setting up new de=
vice
d=C3=A9c. 08 11:39:39 lionelux bluetoothd[8616]:
profiles/input/server.c:connect_event_cb() Refusing input device
connect: No such file or directory (2)
d=C3=A9c. 08 11:39:39 lionelux bluetoothd[8616]:
profiles/input/server.c:confirm_event_cb() Refusing connection from
44:D8:32:7E:6B:6A: unknown device




Le mar. 8 d=C3=A9c. 2020 =C3=A0 10:53, Bastien Nocera <hadess@hadess.net> a=
 =C3=A9crit :
>
> On Tue, 2020-12-08 at 10:45 +0100, Lionel Jeanson wrote:
> > Hi;
> >
> > yes, I've seen your commit, and actually I don't get it, since it was
> > integrated, and bluez updated, sixaxis pads are not working as well
> > as
> > they used to, I need to repair the device again and again.
> >
> > I tried to do it with the pairing agent using bluetoothctl but
> > couldn't get it to work as expected, any hint? I can't find anything
> > on google or anywhere else.
>
> 1. Start bluetoothctl
> 2. Plug in the device
> 3. Answer yes when bluetoothctl asks to pair
>
> The same should work using GNOME's Bluetooth Settings.
>
> If it doesn't work, send the bluetoothd logs when reproducing the
> problem.
>
