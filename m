Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D02C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Jan 2022 06:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiAPGH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jan 2022 01:07:56 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51757 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231607AbiAPGH4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jan 2022 01:07:56 -0500
Received: from [192.168.0.4] (ip5f5aeaa0.dynamic.kabel-deutschland.de [95.90.234.160])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7ABD361EA1BE4;
        Sun, 16 Jan 2022 07:07:54 +0100 (CET)
Message-ID: <d2b50954-5303-a547-3be8-35e6c3208a1d@molgen.mpg.de>
Date:   Sun, 16 Jan 2022 07:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] bluetooth: Add support for EP-B3536 USB Bluetooth adapter
Content-Language: en-US
To:     Jack Murray <kernel@c0rporation.com>
References: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Jack,


Am 15.01.22 um 22:30 schrieb Jack Murray:
> From: Jack Murray <kernel@c0rporation.com>
> 
> This patch adds support for the EP-B3536 USB bluetooth 5.1 adapter based

Who manufactures that device? Is it Teledyne? 0x2550 is 9552 (decimal), 
and according to [1] that is Teledyne. Maybe, add that to the commit 
message.

> on the 8761B chipset. The existing driver and firmware work fine for this
> device from what I can tell, so this patch just adds the vendor/product IDs
> for it to the supported device list.
> 
> Signed-off-by: Jack Murray <kernel@c0rporation.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60d2fce59a71..207c8289c5c2 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -436,6 +436,8 @@ static const struct usb_device_id blacklist_table[] = {
>          /* Additional Realtek 8761BU Bluetooth devices */
>          { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
> BTUSB_WIDEBAND_SPEECH },
> +       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
> + BTUSB_WIDEBAND_SPEECH }, >
>          /* Additional Realtek 8821AE Bluetooth devices */
>          { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },


Kind regards,

Paul


[1]: https://www.usb.org/sites/default/files/vendor_ids082119_0.pdf
