Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E17C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jan 2022 22:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiAJWkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiAJWkm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 17:40:42 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4AAC06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 14:40:42 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id u23so4665097qku.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 14:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RwRh5W5dW6MkDob6kxWPOFBQqoxpUddxe8xdACp1a/E=;
        b=nRelA5qeq1RwnllciD2voD8aSNnv8+2yJpfdlLeorjyodi4oslZ3Ae8pXSQ1T3Hb7L
         97OQ74dytAuYPSvPRV2ynCmT9zfHfff8/tc2woTMZFFtZa+QWphRH+YJsNpwTbxBqIlX
         LL/0EIlyGaQz2ZDeWWDL4YKtxZ7E4f8p3pkEkppWAItwg/aO5rx3RUsTBYqc7thNU2Z4
         ts310Z2r3wY9Adb+JPRFZiFlsU8yrIkgkUbS3jmZYnc/qSGDKq1JwJF/gMl9e9jG1Emx
         QgBw8/4ZSpuDD41550/lgCl9Ai2kGk6wssoObPJlRbZIN3/wk9SzV7STIMsZiqvlIN3n
         S1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RwRh5W5dW6MkDob6kxWPOFBQqoxpUddxe8xdACp1a/E=;
        b=qtWwDqVUPPhgl5PSJKdNXyh3LXiefB6CLFnJU+rzohHLEHFrQdLjbgu3WRyzVsXCtp
         UcqcTFnMQ0wseRNKGIHi4/RK+ATJCChQjqPvdkQvWIF9Axakk7CaWqOdPIszTW5awy+E
         E/vQgL6tnpPo15L+5UryLQDEibnzRdtIVHCq6qsxfPeteqzuKUEx/q8RfqVAPGqBkAtf
         WqNSGnXHR3WsA1JrhEXsokdbVmHK4vhg2hl1bofFA9sglQGffkdC5lAfTtzZH78ajLUm
         4+p3lH5jODUX653WAa6QqfLuTGwaxs8RXHkzlET/b6QPtvjMeFFX4TcEtyJlzWDrNVDK
         9GOg==
X-Gm-Message-State: AOAM531wtXCBiwE5eCMrhYb5bEhNLyHJtaF6kf1zyFYd62KW5KRHeBHT
        caJxxrOE/xbsAs/Mp+R89IhWWrLkWUj/OVRkVer3e2Z07qE=
X-Google-Smtp-Source: ABdhPJzycyWbbXT8Va1f6C8xydMYxTF8LJSZMAHqwaiqiDFW6Kv5RObNLbY82mvz9Dd1dw0ZztKtaCsUg22HLVuciuI=
X-Received: by 2002:a05:620a:1129:: with SMTP id p9mr1387840qkk.405.1641854441672;
 Mon, 10 Jan 2022 14:40:41 -0800 (PST)
MIME-Version: 1.0
References: <CAGjK+HS2o8P4wPb869vaJoP6Fm-EMHmguhVKEyBX=nGoBchDKw@mail.gmail.com>
 <CABBYNZLdam79JAKNC-VN6joZZUvwhTceOpe7b9zS1zbGJeHJ_w@mail.gmail.com>
In-Reply-To: <CABBYNZLdam79JAKNC-VN6joZZUvwhTceOpe7b9zS1zbGJeHJ_w@mail.gmail.com>
From:   =?UTF-8?Q?Sergio_Conde_G=C3=B3mez?= <skgsergio@gmail.com>
Date:   Mon, 10 Jan 2022 23:40:30 +0100
Message-ID: <CAGjK+HRywY_AWfByuhvPuHW5QTKcjnqtYSMrRNviMEOPRruRig@mail.gmail.com>
Subject: Re: Unable to connect to Bluetooth LE devices with long advertising times
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

El lun, 10 ene 2022 a las 23:07, Luiz Augusto von Dentz
(<luiz.dentz@gmail.com>) escribi=C3=B3:
>
> Hi Sergio,
>
> On Mon, Jan 10, 2022 at 10:31 AM Sergio Conde G=C3=B3mez <skgsergio@gmail=
.com> wrote:
> >
> > Hello,
> >
> > I'm on kernel version 5.15.13 (shipped by Arch Linux) with bluez 5.63
> > and I'm unable to connect to Bluetooth LE devices with 5s, 7,5s, 10s
> > advertising times. As for hardware, I have a PCIe card with an Intel
> > AC9260 (WiFi + BT combo)[1].
> >
> > I've been doing some research together with an open-source firmware
> > developer and some other users for one of the devices, and we found
> > references of Linux's HCI_LE_AUTOCONN_TIMEOUT
> > (include/net/bluetooth/hci.h) being too low[2].
>
> This used to be even shorted (2s) and has been bumped to 4s, so I do
> wonder if we need to allow the full range, that said userspace can set
> its own timeout nowadays:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n19=
9

Completely missed it, thanks! What I've discovered after sending my
mail is that I could change it using btmgmt (btmgmt set-sysconfig -v
001b:2:e02e), but having this in the config file is far more
convenient as it persists.

> > Apparently, the Bluetooth Core Specification allows the advertising to
> > be from 20ms to 10,485s in multiples of 0.625ms (Vol. 6, Part B,
> > 4.4.2.2.1, page 2749 of the Core Specification 5.3), and Linux's
> > HCI_LE_AUTOCONN_TIMEOUT is set to 4s.
> >
> > I've recompiled the kernel package on my machine raising it to 20s (no
> > scientific reason for this number other than being
> > HCI_LE_CONN_TIMEOUT) and I could connect to them (with the device with
> > 10s advertising time was not successful every time but at least I
> > could connect). I retested changing the value again to 12s (to cover
> > the 10,485s, plus some extra with no scientific reasons) and I got
> > more or less the same results as with the 20s (but was quick testing
> > this morning, not as in deep as with the 20s).
> >
> > The connection procedure was just running "bluetoothctl", "scan on",
> > and when the device is first seen then "connect DEVICE_MAC".
>
> Have you tried doing a #scan off before #connect <bdaddr>? I wonder if
> the device is busy discovering, that said bumping to the maximum
> window as default sounds like a good idea. @Marcel Holtmann any
> thoughts?

Yes, but even stopping the scan without the timeout increased I can't
connect to devices with advertisement intervals of 7,5s or 10s.

What I'm not sure about is if when I had transient issues connecting
to the 10s device with the timeout increased I was stopping the scan
or not, I guess I can test now easily.

> > Now, I'm no expert in Bluetooth, BLE, or Linux Kernel, so I might be
> > doing it wrong or misunderstanding something, but changing the value
> > made it work. If this timeout is what is making us unable to connect
> > to these devices, what's the reason for this low timeout outside the
> > spec? Would be possible to fix it by not changing the devices to a
> > shorter advertisement time (which impacts battery life)?
> >
> > Regards,
> > Sergio Conde.
> >
> > [1]: https://www.intel.com/content/www/us/en/products/sku/99445/intel-w=
irelessac-9260/specifications.html
> > [2]: Full discussion https://github.com/pvvx/ATC_MiThermometer/issues/1=
72
>
>
>
> --
> Luiz Augusto von Dentz

--=20
Sergio Conde
