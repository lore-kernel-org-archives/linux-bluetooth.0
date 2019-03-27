Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E42C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48512206BA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U87KTfVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfC0SzZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:55:25 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:36869 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389461AbfC0SzY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 14:55:24 -0400
Received: by mail-it1-f177.google.com with SMTP id u65so1934254itc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2019 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RYrqb0Nr9kAEajZOIxTOm9bBUxa1WzK5vewMHDHvxOo=;
        b=U87KTfVPOGZR0eVmGgBRYu35bxAXmDfs8V2GcQ1SoZGsIcWhosCwiOP7SisCHE0Ow3
         7s+wrfTlFjBYQLZcP0Sbwm9VA6Yn0zdpLBsGnLyqeCoBRs8cd2GiWF0Vac6Fqbc4ISCb
         7Skqa/XTGVSUQgtf87pLAROS4tk9zqrSnUQJsA2uN7r44HYf2TxGxzn53fw7TrEf2duD
         0zLzOZ1KSvoh9sxzHqo+Vv6Xg0zIEiRRzF46RL06o8JjftueImv7z3yuoP6WyzO6xPbw
         aDC5Aq5xZOaQ4YuuhYd1SzzROayXgbUGq0Ag1D5a1MlaLDtRBR0r63EpC6rU8W815YRE
         BtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RYrqb0Nr9kAEajZOIxTOm9bBUxa1WzK5vewMHDHvxOo=;
        b=WVV7JDdKMCZodd73Y30uW54DxAF3/UomJy9h7jPFon7s3W9g0N7MMXTOydlfs0BgxO
         DrCcseM671Xz8J8NMDzISUDRhDvOPtocJDJrLQ0IM1u5Xg67SqErGPBuk84fCgZ5wOWm
         q8fbDut2PM+xwZQVf3XMMFxcYegdxF/MFYhTJNnR92G0jJBUPOX817U+CLYkZcplTklG
         b6dR2teNGrLofbU2GpHMXuq4rRgDbG7oAeN5ecwG/eFTrcJu/bsctOTsy0ZAvEZja3oc
         BmTAxvXh9h3yrZouLGOheodZFv3T2gh/LB4Wc0+0jrNwyti0sUNiWkrCwDjVa70lkRQo
         OXeg==
X-Gm-Message-State: APjAAAUNREaiYdQeaV/z2yiqd94T6zYbqtr7oerPyQgiWqK38YXx9Qmq
        Qj4GemTNEIgaAvrRN6uqNcqdDiKyERo9DOCdgrkc9EVHCwo=
X-Google-Smtp-Source: APXvYqzu/trDdCGViin+h1dv/DG65ghyRzIkjAaYp1smFTdZHf14jJtIaI33pjgBg3+uJmXZoCa3/JG4giUsvkDT9QA=
X-Received: by 2002:a05:660c:750:: with SMTP id a16mr4847358itl.170.1553712922538;
 Wed, 27 Mar 2019 11:55:22 -0700 (PDT)
MIME-Version: 1.0
From:   "sayandasgupta12@gmail.com" <sayandasgupta12@gmail.com>
Date:   Thu, 28 Mar 2019 00:25:08 +0530
Message-ID: <CAF6QkFJ60hg3qCwEaak9Kyg42qVXBxMietqzAaqAwpHLV9iuSw@mail.gmail.com>
Subject: BT slave and BLE peripheral simultaneous discovery issue
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am currently using blueZ5.43 on my device.
My device is currently running on linux-3.10 kernel.
We are currently using Both BT classic and ble.
We are presenlty using SPP profile by running the rfcomm utilty.
We are playing the slave role in SPP and listening to any SPP incoming
connection.
Similarly we have written some custom GATT service, which we added to
the list of core gatt_services which are registered when the
bluetoothd comes up.
For other devices to connect to our SPP slave we are doing "hciconfig
hci0 piscan".
Also for other devices to connect to our GATT service we are doing BLE
advertising.
In the advertising data we are setting the "Complete Local Name" as
"XXXXXXXXX_XXXXXX"(just putting wild characters instead of actual name
we used in our case).
We set the device name as "XXXXXXXXX_XXXXXX_BT" in
/etc/bluetooth/bluetooth.conf and the bluetoothd sets the device name
the same when it comes up.

We are running the bluetoothd with --compat option so that the sdptool
adds the SPP profile.

With this setup when we are discovering the device from any other
device (Like windows 10 machine or from Android device).

We are seeing sometimes the device shows up with "XXXXXXXXX_XXXXXX_BT"
and sometimes the device shows up with "XXXXXXXXX_XXXXXX" and this
continues to happen with only one visible at a time.

if we try to connect and pair with "XXXXXXXXX_XXXXXX" it sends a GATT
Connect request and subsequently pairs and does GATT discovery but
doesn't discover SPP.

if we try to connect and pair with "XXXXXXXXX_XXXXXX_BT" it sends a
accept connection request, and subsequenlty pairs and does SDP
discovery and the SPP shows up on a particular BT serial port

Based on the above points following are my question:

1)Why scanning of the device is showing separate entries for BLE and BT classic.
2)Is there a way to make our device visible to outside world, where it
will only appear once in the scanned list of the other devices and
discover both GATT as well as SPP profile?

Any suggestions would be helpful.

Thanks.
