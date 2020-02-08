Return-Path: <SRS0=/q0O=34=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B679CC35250
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Feb 2020 08:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B44221775
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Feb 2020 08:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgBHI2a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Feb 2020 03:28:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47297 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgBHI2a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Feb 2020 03:28:30 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B69F4CECEF;
        Sat,  8 Feb 2020 09:37:51 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 13d3:3548 Realtek
 8822CE device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1581112454.2855.0@prok.pw>
Date:   Sat, 8 Feb 2020 09:28:29 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <54525F5A-A461-4E40-ACD5-BF2D2755E5C0@holtmann.org>
References: <1581112454.2855.0@prok.pw>
To:     Sergey Shatunov <me@prok.pw>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sergey,

> The ASUS FX505DV laptop contains RTL8822CE device with an
> associated BT chip using a USB ID of 13d3:3548.
> This patch add fw download support for it.
> 
> T: Bus=03 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=13d3 ProdID=3548 Rev= 0.00
> S: Manufacturer=Realtek
> S: Product=Bluetooth Radio
> S: SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> 
> Signed-off-by: Sergey Shatunov <me@prok.pw>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f5924f3e8b8d..fa207b715012 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -387,6 +387,7 @@ static const struct usb_device_id blacklist_table[] = {
> 
> /* Additional Realtek 8822CE Bluetooth devices */
> { USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
> + { USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },

this patch doesn’t apply. I think your mailer mangled the whitespaces / tabs.

Regards

Marcel

