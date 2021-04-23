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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7944A61152
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 15:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhDWPSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhDWPSK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 11:18:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20051C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 08:17:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e7so39786128wrs.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt5RIqRGGJrwy6PdF0DLOD9IeNtwiPFQ2QHql0XiKZo=;
        b=WWLD+0WV7aarDUyyRg+YpNBksOUxyeyjNkX8JZZRANKWpQq5VXVKyVnHF7BPXgdTDF
         NnblrvRyvZwiq8jj3YxGrfp/imJgYkAzkxA/fwUDuPFx3eNKuOJDsPU9xNvBqA6Fuktq
         FBAIqKcF8xnIU3eJxkuhlxeWW6OCJkRoMYdTg4taIijlnhiOUDD3dUn4phV9tMDdToLI
         o3A6zut3ceG1G4rXGnmlS7DJEGwA5ffOe28kGeRQmld0oeXYbPhXsI87hG9qZLxJgi38
         x2wn+vr75+kfEB9Ruxj8eM7YhIORVCxtK1UUH9fsKest7ga1cW482XRPE6gPQTbf8d2f
         +pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt5RIqRGGJrwy6PdF0DLOD9IeNtwiPFQ2QHql0XiKZo=;
        b=QCS41qX06qgUZqQzKZ4TQbuUT3fNF21RGeZGmWORGczxbo1Yu75l4X+bX1bGJ8v1tL
         IAbxT7uEIgg/msQCZwM4isp1olbihA0Zbe7jzJiE72rLXOhL7NVn5aY23gF93oCwkQU2
         yUDtQBE6p8EX2aaVXBoE4KOVNfp+vHnQeeQ+sVNCPq03GQSbbbFGeH/AS2VnFV6wvCGy
         WhcHvsZVhf379IDH2v31+gu5vLSdxZuGRW4k57Mv+zOPvQYLkoiBWOc4luxFuXKfRFCA
         bnlynce0p1A352hBTKLb9Q4b2ksRx1Q1o8kajzOe24/eMVuuB/+K9+aoVIsMlNBYmEDh
         hJLQ==
X-Gm-Message-State: AOAM530UA2HGC7kLNdB0LhlOHrUoxMzhJntdsvCkwCt0fKaNQr2eccW1
        MaCik4XzubZ+paeQSbTpL7EPIsQbf8CaOg==
X-Google-Smtp-Source: ABdhPJyvRf34v7LNhJLKJ6uzzckWLS6JCYQ2x4FK/m4fVvATdcy/Vr8x8UiEtO26ygKIEIeJ/TpP5g==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr5396496wrv.181.1619191052884;
        Fri, 23 Apr 2021 08:17:32 -0700 (PDT)
Received: from localhost.localdomain (84.red-88-11-91.dynamicip.rima-tde.net. [88.11.91.84])
        by smtp.googlemail.com with ESMTPSA id f6sm9074545wrt.19.2021.04.23.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:17:32 -0700 (PDT)
From:   Ian Mackinnon <imackinnon@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ian Mackinnon <imackinnon@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Load Broadcom firmware for Dell device 413c:8197
Date:   Fri, 23 Apr 2021 17:17:16 +0200
Message-Id: <20210423151716.39598-1-imackinnon@gmail.com>
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

