Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 13:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D6364E5F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 13:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBRN7Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 08:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBRLjY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 06:39:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599AC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 03:11:55 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h26so5994259lfm.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 03:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nns.ee; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7C2rq42FKfMXFKLBllYdNimfFLg/j5EKB2u9DM8VVA=;
        b=KumThAblz21RkL6AZphkFJvZObob7oS5koxTNShXzKH+bNusERJUSMCpc3LhKEIkk4
         om+Ba6VDK+V3qdPZdTq4YGBAisEEABvU/Av92imWws38+l5bjkDYr7JureGfGHy5Syr0
         ICeCpZNU1NXhXu2ItSaWeky3KrHQKN2eKlPHRQcFUf5V3cqMHA/4oNmVCT0zEzCiM2zK
         /XsU2kkLooPY0ahO/V9FMvXK3gE0T5YysoVFo8CMYJ6LMJdfz3n6gzw5eIg7jsFRdXDt
         LX8pC5JZO+JHGnmBvXZ+Q++HrJ3bNVpRT8pwDkmhT02BKNTd+5FBwJZR2aWM/jyLi6Sh
         qP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7C2rq42FKfMXFKLBllYdNimfFLg/j5EKB2u9DM8VVA=;
        b=t5kR755iVEgvlrsMnmb4YjacvzCL52eSAnUtYKZakiyaC9LSfwpArLri/Y6hXQ7pTy
         fNgdZfhVPJDbWWT5pOHxAKOAkRxoym8pR+7/t4GA1a7Hni1YUD0osnvewwu7NZaWrM9M
         3e+CGQR0atRInH4ohPEvO/0Ff4tZmu42cA0gkavNREB58NokPiSGDgve+A2h4fx8Y1HD
         fkrMhJYY2UWUsgSVFoUy7kDJ87PcajdtKIpCaTUQaHegMMyIDz2S5r+wB8HvGdDxJDkz
         AJTB7EpNcuVFx64mgxlHsYJU8oS56CkwuVrCUVkq3kK33FbR2Ogfka+tefdqLWcLtfoA
         gZ7Q==
X-Gm-Message-State: AOAM53010/ef8O68FYzTayTfLpbTsyJuM+haUxMkotK6aerNJnEeS/Yp
        FYNdKSFQxBdcSRxtd3krl+TFlQ==
X-Google-Smtp-Source: ABdhPJyvQmCQMUGBGmU7bas+z66yZJMwBXfzt9lgV/QE7fPlHkcDfK5yVqHl9ba962u6jjZ3AQmukw==
X-Received: by 2002:ac2:4d87:: with SMTP id g7mr1714012lfe.31.1613646713852;
        Thu, 18 Feb 2021 03:11:53 -0800 (PST)
Received: from book.hoh.ee (08c8-403c-451c-6712-db04-700d-07d0-2001.sta.estpak.ee. [2001:7d0:700d:db04:6712:451c:403c:8c8])
        by smtp.gmail.com with ESMTPSA id p24sm573137lfe.27.2021.02.18.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:11:53 -0800 (PST)
From:   Rasmus Moorats <xx@nns.ee>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, Rasmus Moorats <xx@nns.ee>
Subject: [PATCH] Bluetooth: btusb: support 0cb5:c547 Realtek 8822CE device
Date:   Thu, 18 Feb 2021 13:11:24 +0200
Message-Id: <20210218111124.12612-1-xx@nns.ee>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some Xiaomi RedmiBook laptop models use the 0cb5:c547 USB identifier
for their Bluetooth device, so load the appropriate firmware for
Realtek 8822CE.

-Device(0cb5:c547) from /sys/kernel/debug/usb/devices
T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cb5 ProdID=c547 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
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

Signed-off-by: Rasmus Moorats <xx@nns.ee>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa91277..89a92951180f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -453,6 +453,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xc123), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.27.0

