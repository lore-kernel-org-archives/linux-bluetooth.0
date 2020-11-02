Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD3C388F2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED2E22272
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="rTYOIXoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgKBINN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIME (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 03:12:04 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AECC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 00:12:04 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t14so10138911pgg.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2lbRxRCm6YJ/XgJATRJyEyLX4vRUjWqIBI7bdt9ix0=;
        b=rTYOIXoaERUMqqFWrKz5r963tOK5UvxmwILHg/dNBgIyFKveGTlbRc0W1MgBlZcvtH
         xS9BXyhubL7euN/5c5vZt8N8Rx0hDfpaR/bCaCM8U2BI6f5ylc7QWpsYeacF4CEkHV3r
         gH9Yuf1GSBDKSjaVJGjkUR4ojpI2GvlpGStZwpr3FsA+U5wm9Wj3KkdSP2fuNiXvG3mj
         AkGqzhbpeU08Ix6nU+8Lzs2QhDUMttrQ946on4pzF4gyqHmAYNggwEbmVkDC2LDzULke
         GzP+ooh50vwcK+2Lezl5a7CeZRCdlxlmhI2oT/qvz3cO5nL0Txj2/XnBWR5hnYzJuyJX
         HWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2lbRxRCm6YJ/XgJATRJyEyLX4vRUjWqIBI7bdt9ix0=;
        b=XfgbrOjEoaxBIJMkph54Q3Dj2OB4QaVI6uB4p82qtXpGYfyQpb1HZTsjw0Z5FU2O8h
         +R1EgZfjRs+0IDa+/lErZsevTs0vSTuKQz/WS+0ibzztxNE4ZfmUb3sQkwzbbFssF0Aq
         xyM33wR9buKyhe/6JbbeJiUAU/2FygNVP5PAukIjZLhbB1CQ2JpPy1lFT2lgAYZz62Ur
         o718WUYcZohNV9333hdXHUkHsyZyS544uJE3QA3qhqbm75LC/73lUc8I9wR/iq4mEvee
         2/TTv02byut3EGSFMluWfxsMGKta+aafzeWE8Lu+TrBkSbHLkV6owlkdMF7cPx3Q8a9I
         kLVg==
X-Gm-Message-State: AOAM5300RdlR0R8RQw04/Dm6xN5BDl8c3YaYDI5CvzyaauW9c5EQqGYi
        x5IBjhxz+LhQP7AqpiyfejIEMA==
X-Google-Smtp-Source: ABdhPJzhWRwM9T+K7YXOdYW/f/MLs7UkfWf9rR7zJarQUKacM61QVlTaewhaM0+Q2A5PdiGqQnNf2Q==
X-Received: by 2002:aa7:931a:0:b029:164:115:33ca with SMTP id 26-20020aa7931a0000b0290164011533camr21021035pfj.62.1604304724131;
        Mon, 02 Nov 2020 00:12:04 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id a18sm13885502pfg.54.2020.11.02.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:12:03 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] Bluetooth: btusb: Add support for 13d3:3560 MediaTek MT7615E device
Date:   Mon,  2 Nov 2020 16:11:57 +0800
Message-Id: <20201102081157.25012-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ASUS X532EQ laptop contains AzureWave AW-CB434NF module with an
associated MT7615E BT chip using a USB ID of 13d3:3560.

T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3560 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5af2e3f30a5e..a0bfd41fdfee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -367,6 +367,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK },
+	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.20.1

