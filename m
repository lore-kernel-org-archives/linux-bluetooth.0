Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76CC3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Dec 2022 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLYTIQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 14:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYTIO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 14:08:14 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40772AE8;
        Sun, 25 Dec 2022 11:08:13 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id z23so4285349vkb.12;
        Sun, 25 Dec 2022 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQFcG7iixZxLC41DStoyJ+91Cmm5Vb3DkAn0xS90x7s=;
        b=GIoBHB/eUib2AKqETQ30GiThx10GpeL9mVR9E4FM5S1hKI9fku4WH9T09uJzcpASyo
         HHCFyUMcZZzAiDJOux5UC+QvCfNBEqpyJbJBJyUoK4sIeJ7VHu++B9xfzaS0Jl4Yg42V
         p+d6huIggIH4Iwl+B8f7/+/hFh9WtTVb/GlHuLDrQdWiF+2Q8f8G3WLDMcxgPNOlaPgO
         TJXlnHfQRGkVhULvXBceqyQMb/mmLpqvmgW0kcC4pchfVoQatMFaXmt93KhCxstOUr+R
         FVItTpvOAaEwowbSUZ+Be0nkScSUjv7gw8YdJsaqCU2J2+JpevyVcaWP4Qrls0KCdTcv
         RlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQFcG7iixZxLC41DStoyJ+91Cmm5Vb3DkAn0xS90x7s=;
        b=G6aCEQRfUu3hufecxxaUYlE7genHiElsbbXb+KY/c6qvM+neK0VgAYKv8/DD3paU4z
         fWeDJshOqVfMecF0V8ZBZuzLdVgL/O5iqxF0/SEeT/CPwgNiu7aHAxECuY8j2erSETqd
         j/wT/wSMzjnI31ka+xgOJRLMFPeSfLDf2GyCEmtoXkE+F1ylm6SRi+ZsApSWwG8XLheL
         lg8DvUm0L7QTDgmq/OEamKy3U/jlVtfrRR/5wAVD5ERMB8fy+nczN1rs4+hcWiVsthFw
         0fg2VBozg6RmWNYBBmWaD9aF/mPIw2iiQ3/FFB8Q4mV2WP0X1hwa+2EBgWoA0EeVXrjp
         TgSA==
X-Gm-Message-State: AFqh2kqaDsQRhvqlvynZ6CWuGDwr5bgaDBJJLJJoIdmr+K6kTZ8lF5Ul
        TlWxVgDOwDEBtZI2mchcVf/7XMsXw3ROAQ==
X-Google-Smtp-Source: AMrXdXtjg637YAxUjTJYfIqea7PugHxjl5W5/oJbYCTroCQguVW03yRgCTNqNbdk8o86pvEitfh2jA==
X-Received: by 2002:a1f:1dc7:0:b0:3d0:bc8f:dd8e with SMTP id d190-20020a1f1dc7000000b003d0bc8fdd8emr1287462vkd.1.1671995292595;
        Sun, 25 Dec 2022 11:08:12 -0800 (PST)
Received: from lenovo-y720.. (097-101-018-014.res.spectrum.com. [97.101.18.14])
        by smtp.gmail.com with ESMTPSA id j4-20020a1f2304000000b003d53be21b4esm958869vkj.38.2022.12.25.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 11:08:12 -0800 (PST)
From:   Moises Cardona <moisesmcardona@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     johan.hedberg@gmail.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moises Cardona <moisesmcardona@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add VID:PID 13d3:3529 for Realtek RTL8821CE
Date:   Sun, 25 Dec 2022 14:07:13 -0500
Message-Id: <20221225190713.656505-1-moisesmcardona@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Happy Holidays everyone,

This patch adds VID:PID 13d3:3529 to the btusb.c file.

This VID:PID is found in the Realtek RTL8821CE module 
(M.2 module AW-CB304NF on an ASUS E210MA laptop)

Output of /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3529 Rev= 1.10
S:  Manufacturer=Realtek 
S:  Product=Bluetooth Radio 
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms


Cheers,
Moisés

Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2ad4efdd9e40..d6b0f9952fb5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -492,6 +492,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
+	/* Realtek 8821CE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3529), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.37.2

