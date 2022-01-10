Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jan 2022 08:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiAJIax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 03:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiAJIaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 03:30:10 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E9C061759
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 00:30:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v7so10328854qtw.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=TakGUpz2ZaNLkv/bMS4wKYI1kGiJlFwoGHaCYZJx3AQ=;
        b=Vz2jRG74UxuQGvKKzC7hSarUELs4QUctOYDeItgkx0NczDJPBbnY5qaxldhy0XfsxC
         +5VTpHn1xpD2Em4UN25P4KaRfWe+FaGw6s47pKAYs9+UgHVk/m3BRycXHf3fRWNvc39r
         ypRHBw2esZM7KFWnO7wtA89SGb8f0rhv7pGstWzNQLbQKG/VDRVV1eVWswZR1xSxtOju
         6YsNA+slQxaHBvKOqlyrfwWQaZsSQnYW9skwr//WDDT5g7TbXVYteQTy7FR2YI6vYPBN
         hdTbCVML+rGP9V4FwSD+nA1abgp+l7WjdSNoko6WyvBGdu2MOnaL2B8Q/D0tXezAzr1N
         pWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TakGUpz2ZaNLkv/bMS4wKYI1kGiJlFwoGHaCYZJx3AQ=;
        b=whZOTYAFrDFgjindeaPv02EoWiQQEVuf/SeOlYJmA7EFOE80RCHeo+G/fTX2FHGKau
         IiiQ2TTGBkLapw9jFLRIxaPWzGd/T0HxgSgi16PFv6/JXY2YM7aTvt/7zWcvDNmsmhvu
         P1lNWoprqkMNTKgea6x8Y4FJPnAIzF8XX5f3QyDQ4kTb8S3XiR8KJLKo/NqT3c4ma8Mr
         5oyaP6qHMYdUVoU3qeUQYpSAAH+6b4yE1dc/0tnDG37AYXzyo7AnKvIel1964MvF8gGV
         Y7hHiLswE5K46aJZKaGlarht0DoqMG9WEIrdee1W6DPUhm/nrnHcwrKpgs83ewhcMc5d
         BqFw==
X-Gm-Message-State: AOAM531Y40d2/U8knWwlgeshNhnsiNdmmUQZx5z50Lc72pjG6iay1lyD
        RYHAAmsawX4L1qN6O0s1LgV1p1vKPJhMAELjN1MeNr4TuAE=
X-Google-Smtp-Source: ABdhPJw2GoDDuMj5vyLMsy+1Qry7lcQTHNxvU7QbG8mt7y8jHQoSeIbWUxcyOrzsMBefzxjcgsbmsa3nOpm2bS6lEUY=
X-Received: by 2002:a05:622a:452:: with SMTP id o18mr64074843qtx.549.1641803408590;
 Mon, 10 Jan 2022 00:30:08 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Sergio_Conde_G=C3=B3mez?= <skgsergio@gmail.com>
Date:   Mon, 10 Jan 2022 09:29:59 +0100
Message-ID: <CAGjK+HS2o8P4wPb869vaJoP6Fm-EMHmguhVKEyBX=nGoBchDKw@mail.gmail.com>
Subject: Unable to connect to Bluetooth LE devices with long advertising times
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I'm on kernel version 5.15.13 (shipped by Arch Linux) with bluez 5.63
and I'm unable to connect to Bluetooth LE devices with 5s, 7,5s, 10s
advertising times. As for hardware, I have a PCIe card with an Intel
AC9260 (WiFi + BT combo)[1].

I've been doing some research together with an open-source firmware
developer and some other users for one of the devices, and we found
references of Linux's HCI_LE_AUTOCONN_TIMEOUT
(include/net/bluetooth/hci.h) being too low[2].

Apparently, the Bluetooth Core Specification allows the advertising to
be from 20ms to 10,485s in multiples of 0.625ms (Vol. 6, Part B,
4.4.2.2.1, page 2749 of the Core Specification 5.3), and Linux's
HCI_LE_AUTOCONN_TIMEOUT is set to 4s.

I've recompiled the kernel package on my machine raising it to 20s (no
scientific reason for this number other than being
HCI_LE_CONN_TIMEOUT) and I could connect to them (with the device with
10s advertising time was not successful every time but at least I
could connect). I retested changing the value again to 12s (to cover
the 10,485s, plus some extra with no scientific reasons) and I got
more or less the same results as with the 20s (but was quick testing
this morning, not as in deep as with the 20s).

The connection procedure was just running "bluetoothctl", "scan on",
and when the device is first seen then "connect DEVICE_MAC".

Now, I'm no expert in Bluetooth, BLE, or Linux Kernel, so I might be
doing it wrong or misunderstanding something, but changing the value
made it work. If this timeout is what is making us unable to connect
to these devices, what's the reason for this low timeout outside the
spec? Would be possible to fix it by not changing the devices to a
shorter advertisement time (which impacts battery life)?

Regards,
Sergio Conde.

[1]: https://www.intel.com/content/www/us/en/products/sku/99445/intel-wirelessac-9260/specifications.html
[2]: Full discussion https://github.com/pvvx/ATC_MiThermometer/issues/172
