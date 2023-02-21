Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09942C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Feb 2023 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBUVXJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUVXI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 16:23:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB60B93CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 13:23:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h16so22816496edz.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzI9IaEYK3mu8UhySWHMQWy3ljfnMJk+3UzdqGyQSIY=;
        b=e/CxAAAaTxEChBjAyMnX9Ww/K2GC9NdCZRELdXIF3OhrKh/cWA8GSmCnCseyu8tUsl
         iet2W7zwo0IJ84TAE/DQvpJ41j4QIuWbRXrVK5dFuSOwd2i/S5zOpU+4S+DUzjXrgSqm
         l/C6Sxy4zElqjB6o8EqRFfBG4ZLWtN6AdvMj09JS4WpOtGsEJOn8PwO6zFXW84R8Dk0Q
         V9l1km9h7dv1KTk9xUqflzkh+ZK2yngRhQT5Eqi93otGOvBxL9dRiwrGeEFUp1puNaxj
         6WlscWp5ZVk6qSXPuCP7Juo70ZsiEahPvNyoFuj5y2dC1tF7Pfgm+B3sLwAmwp075+Ya
         KVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzI9IaEYK3mu8UhySWHMQWy3ljfnMJk+3UzdqGyQSIY=;
        b=6herBmawgy6X9CrXtAA3/daQWFcKJnKxs3OtoD04qBVbNg9SW5+TRcrCr4wmSJe1bp
         xxrK64PZnAGPfEFvDtJOcr0PPLUuLD4AZ+4FQ0wG4ARrMQ+ndWhK1x4B7sgN7GIEUqGb
         fv8zEFGvj85FtLVARAEYn/u/VkBrb9xCSe5XrF5AKeJbAo2S7F1X8pvBAkoXN5c5p/r3
         Uf6LCNjDZuV3yQEmmJSOXiLkNbcNTX1Kk8VKR6/JNNAfhF5bcV83vyT2EERBVic9lSE/
         1wfXn2Ox0eW2hwYODgiroXW4bNpDnIQUq1rSHzn5LiDXjd0RzFp2UOAvqoTRMQ2PQ5JM
         g1sQ==
X-Gm-Message-State: AO0yUKWW4O6tdj//syYLdl9XoIMod8NQVlMLwIepKnAb6AKTZHkZQrVi
        C5k+wGYvxVwSZeXdHSb2JjCuZkzrg0uavLzsofhn9UEqaCQ=
X-Google-Smtp-Source: AK7set/jChbbb7ExyetMvVTw+zrpCwPdbBETvfVkcsmv/3mY4H9U1TznBsduSX9W8CHoS6SdB7H2tx6GYxCMDgMVtHU=
X-Received: by 2002:a17:906:5a42:b0:8b1:7ac6:318a with SMTP id
 my2-20020a1709065a4200b008b17ac6318amr7874154ejc.4.1677014584871; Tue, 21 Feb
 2023 13:23:04 -0800 (PST)
MIME-Version: 1.0
References: <3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com>
In-Reply-To: <3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Feb 2023 22:22:53 +0100
Message-ID: <CAFBinCBWyiObgbyuT2Xc=FnoTTTUBu3sePpybdrocVZr7SVDWw@mail.gmail.com>
Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Hilda Wu <hildawu@realtek.com>, Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Vyacheslav <adeep@lexina.in>, Max Chou <max.chou@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

+ Max Chou as the author of commit 848fc6164158 ("Bluetooth: hci_h5:
btrtl: Add support for RTL8822C")

On Tue, Feb 21, 2023 at 8:13 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
[...]
> I can also use the oldest upstream firmware with the Armbian config:
>
> [    7.315358] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
> [    7.318754] Bluetooth: hci0: RTL: rom_version status=0 version=3
> [    7.318772] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
> [    7.319680] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
> [    7.341340] Bluetooth: hci0: RTL: cfg_sz 73, total sz 30817
> [    7.612533] Bluetooth: hci0: RTL: fw version 0x05990d54
>
> The config file Armbian are using [0] is sourced from an Amlogic (Android) BSP
> repo shared to manufacturer Jethome (Vyacheslav on CC). There is no obvious
> version info. There are newer (more recently committed) config files available
> in updates to the Amlogic repo (alongside older 0599_0D54 firmware) and all work
> with any upstream firmware file.
I did compare the two config files and they differ in certain areas.
- upstream config: 1500000 baud, flow control is disabled
- Armbian config: 2000000 baud, flow control is enabled

Seeing that the Armbian config works with a higher baud rate my guess
is that there's some issue with flow control instead.

For those who are interested, here's the raw data provided by the
rtlfw tool from [0].
Armbian (= working) config:
Signature: 0x8723ab55
Data len:  67
len=16  offset=000c,{ 02 50 00 00 50 c5 ea 19 e1 1b fd af 5f 01 a4 0b
},UART_CONFIG
len=2   offset=01be,{ 1a 19 }
len=1   offset=01bb,{ 3d }
len=4   offset=01c0,{ 10 00 60 01 }
len=11  offset=1000,{ 00 ff 04 5d 00 03 00 ff ff ff ff }
len=11  offset=1040,{ 28 08 30 30 00 ff ff ff ff ff ff }
len=1   offset=01c4,{ 02 }

upstream (= non-working) config:
Signature: 0x8723ab55
Data len:  27
len=16  offset=000c,{ 02 80 92 04 50 c5 ea 19 e1 1b fd af 5b 01 a4 0b
},UART_CONFIG
len=1   offset=007a,{ 37 }
len=1   offset=00d9,{ 0f }

The baud rate is encoded in the first four bytes and can be decoded
with the help of btrtl_convert_baudrate() from Linux'
drivers/bluetooth/btrtl.c
Flow control is encoded as BIT(2) in data[12].

I am hoping that Hilda and/or Max can provide some ideas on how to
solve this issue.


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/rtlfw.c?id=5d347b54714e0f2d750253be09b68b0c3119dd0a
