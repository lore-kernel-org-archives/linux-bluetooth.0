Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D9C07E95
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jul 2021 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7861CBB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jul 2021 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhGGUSM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jul 2021 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUSM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jul 2021 16:18:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1DC061574;
        Wed,  7 Jul 2021 13:15:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m15so1708321plx.7;
        Wed, 07 Jul 2021 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5bVls/bzRwx/bNfNfg5c0XL0O9QYtXihq0kYsdOhqo=;
        b=H61osoDMyySy9Yka9hgPq6vxgZgB0Jm5CDTcCisQwL3trjFhLlSYlSNNH9dbL1sEtD
         Tj82OrmpvsSPy2oyUDHRLplagDeN/k4yv/gsh2K836brbYtkAczttuI/C+d+XCmQVDq6
         h5M2g1an9Pxq83w2GcWg2YsOCZextnO9P8UHrSVyMX+0EzCQ7XMTA7UFaFKNH0Pcq2HY
         M8VRQB/SYmbRsdL5qzwUJkXPU9WDgXvBpDuAjU95FkjAyofBQhpx3i+WrZiEbmgMUCTY
         i72xlQ+KOsZiybQ62TDrgkYpc3et+6JkvA3S2vftcAoErU4cbZhSFsweJRR/o/qRoQsA
         Au2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5bVls/bzRwx/bNfNfg5c0XL0O9QYtXihq0kYsdOhqo=;
        b=beMP/jbxXoH3yZXCkpChpAxM8BaN50eS6BVuHuJnBHO1H4zE8JVYA0B3nhoI32Eo2q
         8OsjkaNdkPmz29AyTLgOWQmO1QXPF3YmlUXwsO3Q480mqqs7Zwe3FYyqn2PHiSLggmFt
         StF6LIz4D68upedUi7fkselye3S0t6Or3rhbxpXxBahUOBGTS1dfoRDWmZnnzVnH+rXy
         jf6eNZmcOzgY4KiNYD9fsfPuX+iSLGfG7BTpQI2MH9VbVdIr0KenoJJLBUHScZZFiIV7
         31GlS7AaB/1eHGFcQz1Df7wF+D5X1PjQw+E/UFzTt/d+8UGxwceZiTplryUIkVE7xgAY
         iJFw==
X-Gm-Message-State: AOAM5327oEH42egsGnTB1q9+5HvaK8ZtTopz6AfPone3qKpYNAHpKEP4
        GozsbBWUrb+iiKEl0xofba8=
X-Google-Smtp-Source: ABdhPJwjwmIbGNwxL3stnJ0DxKeCsYMp7s9ZoDHa4BTY6Bx7UEOqwLB8UmedomFBn4AbmR3/bGk71w==
X-Received: by 2002:a17:902:8302:b029:128:c73b:1695 with SMTP id bd2-20020a1709028302b0290128c73b1695mr22703404plb.47.1625688931258;
        Wed, 07 Jul 2021 13:15:31 -0700 (PDT)
Received: from lappy.local (061092194121.ctinets.com. [61.92.194.121])
        by smtp.gmail.com with ESMTPSA id q5sm58939pgt.46.2021.07.07.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:15:30 -0700 (PDT)
From:   waicool20@gmail.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Wai Paulo Valerio Wang <waicool20@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for IMC Networks Mediatek Chip
Date:   Thu,  8 Jul 2021 04:14:08 +0800
Message-Id: <20210707201409.33622-1-waicool20@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Wai Paulo Valerio Wang <waicool20@gmail.com>

This add supports for IMC Networks Wireless_Device Media Chip
which contains the MT7921 chipset.

$ lsusb

Bus 001 Device 004: ID 13d3:3563 IMC Networks Wireless_Device

$ cat /sys/kernel/debug/usb/devices

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3563 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Wai Paulo Valerio Wang <waicool20@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..edfa5a31a529 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -414,6 +414,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3563), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.32.0

