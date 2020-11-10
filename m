Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F959C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 03:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB62F206E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 03:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="uzlKBZZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKJDkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 22:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKJDkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 22:40:18 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6051C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 19:40:18 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e7so10125417pfn.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 19:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZg9Y/b3yLTMT/aoFQhRo6VJELwibnkY7U6+AfYs+D0=;
        b=uzlKBZZS+2ZLBkhtde+QLTwV8poiX5Ivoa3LzYkAvyBUPah1RQyn10WZt0La5VhFUl
         hJL/SbkiE48Ptmc0lUzxSLbLY5or2VlO4agA1sAEOhdNGKxszGjpJCrGqpyMxjGtMxLi
         9q1NResKVVfgNn9n4vP0ycBl24WCF1nAwib5l3ZEzkDvlBlW7pF3Kbn3y5WjuGcKN9sU
         8uUFSz5B1hNCH75t9Nal+2CG6WWTZaKOJUIkqm7upH2e/5FMQhzHlCVOXLzsrZVjqMXQ
         EM7/emZB+22b3lmvZbl5rqgis30jnkDylXFOJXs2GQODbii1r9ePeI9o4C8WXAFIkvAN
         2q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZg9Y/b3yLTMT/aoFQhRo6VJELwibnkY7U6+AfYs+D0=;
        b=S3BdbzXL/Kuh9vrkkyj2xL7eeG4Z2sj3kfct2t0OFaBQx4y8r8wX4fhWmgSQbcURWv
         y9tT9uuMbYdohu1mNmots7So8Vj9UomVsAFi8tnzmeAGvkcd+q0wcGRAkct1X7Q+0hpi
         JFJUlJYs7JxNVXkfj0nCn1PK2Jr+Ie+j4nhuiO5YDZXmjE8B7ff6fOrLiQ1RXpoZ7v0M
         5zUjF95pbfzMd1WK3cd5b44hB1ZBg3tNX1Z0xvnaqVIM7lZlocYzvXNzRRsWUbVJtwoN
         KmJoNwmNxEXZKnRBmUbvFFXNr64LSkGOOsTuXypP3uZnhG7j7lBHK6X1ilVOL9KtD6Rf
         ubog==
X-Gm-Message-State: AOAM531N17LriI/1k9c16j2mZDE/SXEYdtI3v7ZGOLd7oLFiBEHZxSN5
        7ewhrbhqSzQwqhbKj8sqlgahCw==
X-Google-Smtp-Source: ABdhPJygg5NHHvYiNeD4GNk/5sj99DVzMvWAO0/MkZsPPi09Y5RxXZm5psKY/q3ChyWCKQwSLS8u1g==
X-Received: by 2002:a17:90a:6309:: with SMTP id e9mr2565126pjj.115.1604979618222;
        Mon, 09 Nov 2020 19:40:18 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id z3sm11333165pgl.73.2020.11.09.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 19:40:17 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     johan.hedberg@gmail.com, marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2] Bluetooth: btusb: Add support for 13d3:3560 MediaTek MT7615E device
Date:   Tue, 10 Nov 2020 11:40:10 +0800
Message-Id: <20201110034010.11088-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ASUS X532EQ laptop contains AzureWave AW-CB434NF WiFi/BT combo
module with an associated MT7615E BT chip using a USB ID of 13d3:3560.

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

v2:
  - Add comment for the MT7615E BT device.

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5af2e3f30a5e..7e05be1a7bff 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -368,6 +368,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK },
 
+	/* Additional MediaTek MT7615E Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
+
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
-- 
2.20.1

