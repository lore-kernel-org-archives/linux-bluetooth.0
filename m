Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E477EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jan 2022 20:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357822AbiALU4J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbiALU4I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 15:56:08 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8083C06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 12:56:07 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c10so9210038ybb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 12:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBIz8X2d/IaQIMY6aTV2aX9NovDlTARalKFvbKoALkQ=;
        b=pChNIINRWwqFjZPH5Gv4brz3yClrU05zm4AkdzlNwD9mvNP44zfKgt1CYcY4rwZHNI
         5PWlPf4Srp7xeSUI3GMXWqhJwUfRkFIK63u8wTF1umzDzxCBNyZJhrs4rMVLsdGYVdTg
         2B6s9dzWEuWVh5kInoTs4GbCSOkNO/VYSj+1zktPixonRbHQIU+L6yk3X6w9jjqg/UVZ
         RQPJPLC7IlXgYIhE9zdOJoZ3jDCSraHb3UUADFRzWKL1xIk9OrWiiq5xppTMXm7qaNzz
         aeRmJLEx7epKG0K+/sx1ZNA9n3Cq+yqA8lQv63hGE6qDZHmJC7n5DncHhuszCZ2JX713
         4OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBIz8X2d/IaQIMY6aTV2aX9NovDlTARalKFvbKoALkQ=;
        b=stqvvKm26eUJ54vGbC5Sh2llICGJOAZzCpOvK85GZbYnXHooEP3FCA39svAc6Gdoa1
         9zxSeP7f5K5ENPPaGdWeav6mw5XyWSMvB5gPeg+OhQQ9Vr0/MJCzNwaenCWiUqGTkH7/
         3ItAvDWi1XMJ4OK3Kn131ntt5LB8t3T17HgVMgTaOglCnanM/y8UEZB/oqD2XBQITtGC
         KLymTF7lyfAzAtKt/J89bxchbGPgz6YOsgoVwSBkvRLU/xahMiQWLHbZK6DYxeEyP9sV
         z+zaI080EaNHD7SjY5xwRn68A5yCE0p3MeOjOr2TqykkvWsjux7nmdoCM5RCVPYM3wDT
         ekgQ==
X-Gm-Message-State: AOAM533IMlwqfJudN9wjGcfigJSAAkS9sT/UPpAB7Sy5iaprk2wvUqNz
        9imR/yESbFNmsS29+Fwvb79PkJaT5ch8HDtGt+8x0AaA
X-Google-Smtp-Source: ABdhPJwzSVRnVsr+DpC435fn4tgUcQxynihaxuZ5JHaANbo7n4wZlNoTHMXOlfSLYr1kuGKoJ0403wFdTY35gHSZFx0=
X-Received: by 2002:a25:3dc2:: with SMTP id k185mr1891734yba.733.1642020966996;
 Wed, 12 Jan 2022 12:56:06 -0800 (PST)
MIME-Version: 1.0
References: <0015e594-d888-f664-56c3-f4022286c736@hartkopp.net>
In-Reply-To: <0015e594-d888-f664-56c3-f4022286c736@hartkopp.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Jan 2022 12:55:56 -0800
Message-ID: <CABBYNZLLDip=q4VGP5Mx8fNrdxd8oHfzDJY9+XYxe11nLCU+yw@mail.gmail.com>
Subject: Re: Latest Linux tree (merge window): BT mouse does not work
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Oliver,

On Wed, Jan 12, 2022 at 12:07 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi all,
>
> after upgrading from Linus' tree 5.16.0-rc7-00108-g800829388818 to the
> current merge window version 5.16.0-05432-g6f38be8f2ccd my BT mouse is
> not working anymore.
>
> I now get two new error messages:
>
>         hci0: unexpected event 0xff length: 5 > 0
>
> and
>
>         hci0: unexpected event 0xff length: 7 > 0

These are vendor events which I don't think were being handled anyway,
so it is likely something else that is preventing it to work.

> Any idea? Any new firmware required?
>
> Best regards,
> Oliver
>
> [    8.790201] Bluetooth: Core ver 2.22
> [    8.847435] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38
> 2015
> [    8.853022] Bluetooth: hci0: Device revision is 16
> [    8.853025] Bluetooth: hci0: Secure boot is enabled
> [    8.853026] Bluetooth: hci0: OTP lock is enabled
> [    8.853027] Bluetooth: hci0: API lock is enabled
> [    8.853028] Bluetooth: hci0: Debug lock is disabled
> [    8.853028] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [    8.855879] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
>
> [    9.422098] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    9.423532] Bluetooth: BNEP filters: protocol multicast
> [    9.423537] Bluetooth: BNEP socket layer initialized
> [    9.439281] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> [   10.391796] Bluetooth: hci0: Waiting for firmware download to complete
> [   10.392752] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> [   10.392789] Bluetooth: hci0: Firmware loaded in 1492456 usecs
> [   10.392985] Bluetooth: hci0: Waiting for device to boot
> [   10.404942] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
> [   10.404971] Bluetooth: hci0: Device booted in 11747 usecs
> [   10.405416] Bluetooth: hci0: Found Intel DDC parameters:
> intel/ibt-12-16.ddc
> [   10.407835] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   10.408848] Bluetooth: hci0: Firmware revision 0.1 build 50 week 12 2019
> [   10.468582] NET: Registered PF_ALG protocol family
> [   11.277319] Bluetooth: RFCOMM TTY layer initialized
> [   11.277343] Bluetooth: RFCOMM socket layer initialized
> [   11.277367] Bluetooth: RFCOMM ver 1.11

Can you attach the bluetoothd and btmon logs when you attempt to
connect the mouse, at least for the logs above it does seem the
firmware is being loaded properly.

>


-- 
Luiz Augusto von Dentz
