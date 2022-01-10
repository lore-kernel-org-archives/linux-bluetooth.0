Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA05C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jan 2022 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiAJWHN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiAJWHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 17:07:11 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC8C06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 14:07:11 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id h14so24603863ybe.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zl3dIrqHxn/KP34KdBOKPDLemijspgBCkb7pSC/e+JI=;
        b=TeKeoPgqyskgRuz/oEphlICSJseOD+CIsKTwnUWHH5iDUXSOUXjtotZySUXOSn8RsX
         AnDCilCRs0vgw+fzefTOB/muhMvaurRWOX3wVF2ExhNNY0OH1qrtOpRcm+lQ3ElBbegj
         /Of1n+Jot+2GNt++0PBLce1/KKIsFr9kwv2MvKLuyilpQXyLjzSjzCynvKGD90Zr/Sir
         OddG0jr8A7dZtR2P19domptuK8QrO1oYZpsUtGMeHakBz9qVpNVL8Esd1HQ8Uwgn6WXj
         LRldpIrNcBfrKZzuAMMg9Kly9vqVvKeSnwzkF/OsUt9GpVCpYbU9SygKjNVXOwbYfGvN
         hRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zl3dIrqHxn/KP34KdBOKPDLemijspgBCkb7pSC/e+JI=;
        b=4UlSlf9d3bt+QDU1mckaj97drJZuE5lXRmHNnuSxbVQNOO7r1XnfBIWn5aUD284Wz2
         Ijg27mhSNyF6GBqPAnNEU7MH0SJuqOuP1IPHaZWKmvrvtIiw/v2OY8Kt17HYPf7Hnkio
         nvbrGCAh83nZFqf7AKFraVy17GuDCZeQMoX3NqkmeiaUG3giykek6YMxSNx11IzgzaS3
         pcvHIlJYIanTOOILa//y46hZB8qYfE9MlajRKC08DgZkmJBUQwnSUGTwUcr/28iLs4w8
         rO9DwSS82+94jSFill7bf2DanhTGCXtnRK539VIEuBoeUim8j/rDAGSMqV/OUmY2SxJm
         jLlQ==
X-Gm-Message-State: AOAM532E0yg2IaD6rhtUEMcfsu2YVeMB/kFha0OaxA0rsTzEsVr3R7gR
        B8DUH5Gg4gtRiGFvqKMaRnh++BUoKPbzH9cDVOz+Nly57fU=
X-Google-Smtp-Source: ABdhPJweZGeSEPJCAOCMUhq+msvs7jo340nU+YgVz96WjqZItfMkZTvOwEPbBVMWqYUWKizHRyKxze1LV8/7dQqbJHs=
X-Received: by 2002:a25:c41:: with SMTP id 62mr2325545ybm.284.1641852430759;
 Mon, 10 Jan 2022 14:07:10 -0800 (PST)
MIME-Version: 1.0
References: <CAGjK+HS2o8P4wPb869vaJoP6Fm-EMHmguhVKEyBX=nGoBchDKw@mail.gmail.com>
In-Reply-To: <CAGjK+HS2o8P4wPb869vaJoP6Fm-EMHmguhVKEyBX=nGoBchDKw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Jan 2022 14:07:00 -0800
Message-ID: <CABBYNZLdam79JAKNC-VN6joZZUvwhTceOpe7b9zS1zbGJeHJ_w@mail.gmail.com>
Subject: Re: Unable to connect to Bluetooth LE devices with long advertising times
To:     =?UTF-8?Q?Sergio_Conde_G=C3=B3mez?= <skgsergio@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sergio,

On Mon, Jan 10, 2022 at 10:31 AM Sergio Conde G=C3=B3mez <skgsergio@gmail.c=
om> wrote:
>
> Hello,
>
> I'm on kernel version 5.15.13 (shipped by Arch Linux) with bluez 5.63
> and I'm unable to connect to Bluetooth LE devices with 5s, 7,5s, 10s
> advertising times. As for hardware, I have a PCIe card with an Intel
> AC9260 (WiFi + BT combo)[1].
>
> I've been doing some research together with an open-source firmware
> developer and some other users for one of the devices, and we found
> references of Linux's HCI_LE_AUTOCONN_TIMEOUT
> (include/net/bluetooth/hci.h) being too low[2].

This used to be even shorted (2s) and has been bumped to 4s, so I do
wonder if we need to allow the full range, that said userspace can set
its own timeout nowadays:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n199

> Apparently, the Bluetooth Core Specification allows the advertising to
> be from 20ms to 10,485s in multiples of 0.625ms (Vol. 6, Part B,
> 4.4.2.2.1, page 2749 of the Core Specification 5.3), and Linux's
> HCI_LE_AUTOCONN_TIMEOUT is set to 4s.
>
> I've recompiled the kernel package on my machine raising it to 20s (no
> scientific reason for this number other than being
> HCI_LE_CONN_TIMEOUT) and I could connect to them (with the device with
> 10s advertising time was not successful every time but at least I
> could connect). I retested changing the value again to 12s (to cover
> the 10,485s, plus some extra with no scientific reasons) and I got
> more or less the same results as with the 20s (but was quick testing
> this morning, not as in deep as with the 20s).
>
> The connection procedure was just running "bluetoothctl", "scan on",
> and when the device is first seen then "connect DEVICE_MAC".

Have you tried doing a #scan off before #connect <bdaddr>? I wonder if
the device is busy discovering, that said bumping to the maximum
window as default sounds like a good idea. @Marcel Holtmann any
thoughts?

> Now, I'm no expert in Bluetooth, BLE, or Linux Kernel, so I might be
> doing it wrong or misunderstanding something, but changing the value
> made it work. If this timeout is what is making us unable to connect
> to these devices, what's the reason for this low timeout outside the
> spec? Would be possible to fix it by not changing the devices to a
> shorter advertisement time (which impacts battery life)?
>
> Regards,
> Sergio Conde.
>
> [1]: https://www.intel.com/content/www/us/en/products/sku/99445/intel-wir=
elessac-9260/specifications.html
> [2]: Full discussion https://github.com/pvvx/ATC_MiThermometer/issues/172



--=20
Luiz Augusto von Dentz
