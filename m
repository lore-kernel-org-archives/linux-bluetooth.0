Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50999C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDCC610CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbhERR1W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351108AbhERR1W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 13:27:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245ACC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 10:26:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v13so5476891ple.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e4o4lEPMWrXe8mP8JVjlTIaYpq8ZazkvErRgclKN0s8=;
        b=cYsMIvANsOEZTRh9a75ENLkF89i5uU7+zhhNNJ9+PMjurICkXpCoy5RfYLSmlCuYA7
         s2/QgNN1hQKdN+BRGKvLr6e93OUP6csID5z6vJuJwmw2rJ5+SVPP7fCWQd8bhQdcDt3m
         XvsNQTXEFc8UL7eXCGnRwALlrm2u9Z6UO74KAbiarnNOls9Jj6IPTFT4QEeeq2ZpDucY
         gOVYNfLyTRzX3GKhIrccB+tsbe5+NM/2DfiiJNFjnmHie//bFyVa7K7GGXiv20RqRujw
         QN2fdjtAOGt0YfKFIyj6lcMsXkmCdtkwMXlOv+7BJfoiuaD0QGHL32lNgr5kd4KuRkDM
         tTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e4o4lEPMWrXe8mP8JVjlTIaYpq8ZazkvErRgclKN0s8=;
        b=UPqpeNWGG5CIx+qz3jQoIo6w0TL4ND4W+WSwqfMXUR4aji/qsH1qUppSpMgVmt9sw3
         ZHK/ibu78Og+Qf9a7q88vIVMr7lHngz1AQtO2JDoBrwL7O4CRTYUyIWkOXmTPZHlQNWY
         ViM9Lh+M9GOydr5Bu/EDllX7HVHsQw3AUQ/rcMokdGcUWRRyl3H9pk7lPEu2MVctwKaL
         ywnqRlf0kuZGJ3bH0kGF1QcT5QkHf+h0KF36fKUKxxAwVQv8BkQeiNL4ltqpGQ00z4yC
         sHFxhJ5CE+Z99IBeTK6jqZi5Rd9Tvh070ySlPPZ0+J7/zGRsYJdqnkBJESYw7Y0BUMEo
         iRZw==
X-Gm-Message-State: AOAM531Vg4ivsMm7zmfZ740q4Q/mXfc0QR+QRlCDBi/W4+zv0hOLT8mp
        Pj2KzuWOlqTp45o3dF8hpTxunfBvBwfYSZZa
X-Google-Smtp-Source: ABdhPJxoWbqrOyS12tFexQmYxBiRa/CVCDseU55hclEQSyryki5ddcqETLmdpvZ7t7lbiKNEu/w2cg==
X-Received: by 2002:a17:902:c789:b029:f4:33e3:dad9 with SMTP id w9-20020a170902c789b02900f433e3dad9mr39320pla.84.1621358762179;
        Tue, 18 May 2021 10:26:02 -0700 (PDT)
Received: from u0b6eedb2c9435b.ant.amazon.com ([73.96.106.178])
        by smtp.gmail.com with ESMTPSA id s12sm2413747pji.5.2021.05.18.10.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:26:01 -0700 (PDT)
From:   Daniel Lenski <dlenski@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniel Lenski <dlenski@gmail.com>
Subject: [PATCH] Bluetooth: Add a new QCA_ROME device (0cf3:e500)
Date:   Tue, 18 May 2021 10:25:46 -0700
Message-Id: <20210518172546.304882-1-dlenski@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the 0cf3:e500 Bluetooth device (from a QCA9377 board) as a
QCA_ROME device.  It appears to be functionally identical to another device
ID, also from a QCA9377 board, which was previously marked as QCA_ROME in
0a03f98b98c201191e3ba15a0e33f46d8660e1fd
("Bluetooth: Add a new 04ca:3015 QCA_ROME device").

Without this patch, the WiFi side of the QCA9377 board is slow or unusable
when the Bluetooth side is in use.

See https://askubuntu.com/a/1137852 for another report of QCA_ROME fixing
this issue for this device ID.

/sys/kernel/debug/usb/devices:

T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e500 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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

Signed-off-by: Daniel Lenski <dlenski@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d603ef39..ba339e074 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -270,6 +270,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe500), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME |
-- 
2.17.1

