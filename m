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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE34C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8488161406
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDWO05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWO04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 10:26:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 07:26:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1342945wmi.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt5RIqRGGJrwy6PdF0DLOD9IeNtwiPFQ2QHql0XiKZo=;
        b=myYf3tO9vH0cTJKeGvSfRVXBjDkrRsj8gTCOdfKiBita+YBJEJZ6OgPCoNE71NHp/7
         YSgcHdO4kIVpuIvKRhUMCAaGGlMHgNaQ43x7MfM7DWmHxxtE3VJvkT6cuWLWidMnrPs5
         mWhCP9YuAQPDGVKCYMPmmRhneW0TtEtlNfEVyOrCI4pUNAMUeyqROtR2hsC8lJKyeLk1
         wLFag7RpVj5TwOq8gUItydrLPNrABgr8r7+rqW4PG9G15Mkw/Gx0RnviPGZog2h9IM5C
         +Co5mEu0iPL+bLyFnCHjoq8a49QYu8lAgefM2pW/KraA7SHZJTtkWTf1dV+WuaRbiqJ7
         e4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt5RIqRGGJrwy6PdF0DLOD9IeNtwiPFQ2QHql0XiKZo=;
        b=kZOorYJteiSzyOHbplyCWi8vD7JWaiQeEr8X1oi/wftCuZ54hLIWHI8YI9mzuvRmk+
         nEuZFxgVmXzZo5eGFar+YEsoTddYf8CrVvDy0cu78wbteY2118N87hwJdNAifuRJ0Tg0
         O6YTJ9yDfuyT+RTkbqUlwvbTkHyMAmcOSK6E6Wr57niH4qETCDItGSq6LcpeUVziJd2Q
         IXriEkh8jxFqbQgXfCpLO1Qx2yPB+lRKH6XXoYK486sGw8G4a2d3R5BqxWsbvEHss7ME
         qvUcGwdZD/z1jfAUKpHpH3nqcoessHd8Ip4W0Q9hVz/2TK/lhOwMbCyAnNdeuEeuB7+y
         qebw==
X-Gm-Message-State: AOAM530uKszhDVf4bTFd2GaPOx6pbBEEXrmzYSHt7T+h2ujLSTM2se+4
        E6dWqVXRFu+znhgY3Ra2oHFviJ7ARMsgIw==
X-Google-Smtp-Source: ABdhPJyzmP3SK0HBWPqHGQyM/q0+PmdHes6o1EUwmnsN2GKT0XBxdcxBvN7ZiMe//KyfHesyiJnVag==
X-Received: by 2002:a05:600c:35d1:: with SMTP id r17mr4550935wmq.71.1619187976284;
        Fri, 23 Apr 2021 07:26:16 -0700 (PDT)
Received: from localhost.localdomain (84.red-88-11-91.dynamicip.rima-tde.net. [88.11.91.84])
        by smtp.googlemail.com with ESMTPSA id 18sm11060825wmo.47.2021.04.23.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:26:15 -0700 (PDT)
From:   Ian Mackinnon <imackinnon@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ian Mackinnon <imackinnon@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Load Broadcom firmware for Dell Bluetooth device 413c:8197.
Date:   Fri, 23 Apr 2021 16:26:09 +0200
Message-Id: <20210423142609.36712-1-imackinnon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove the btusb_table entry for 413c:8197 so the device is handled
by the later Dell vendor entry, which specifies patchram loading.

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev= 1.12
S:  Manufacturer=Dell Computer Corp
S:  Product=DW380 Bluetooth Module
S:  SerialNumber=74E54354F609
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Ian Mackinnon <imackinnon@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cbfbd948f6..2d24231f898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -119,9 +119,6 @@ static const struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
-	/* Broadcom BCM20702A0 */
-	{ USB_DEVICE(0x413c, 0x8197) },
-
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
-- 
2.25.1

