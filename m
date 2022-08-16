Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3BC2BB41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiHPVfc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiHPVfa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 17:35:30 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403758B996
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:29 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso2009146ooa.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=0iUjTpHZhf5wriiAcqQNIgI532H+rjITIuetchmVkTg=;
        b=a15Y2lZGynsgZpOuhqKEHf8ytcP+EoAPbPZo6QszxmPgEpJkOJv4WvLhQUbkCpTt6x
         d1fHQDRH3Hy1vvP6TBRflLVWd0UwUEGfEHKg2TFIEt7tSOh5PETaMu42Y90foUUpcG3E
         +F3A2571Mrj0b2Yg8b06KfC//8YYUZ56utdI5lppNI57uVrRHQQ6gkcmr0Xb3dz4H9O7
         CF3KKxAvRzwmMPJdv9F5R07nGcoSZ3Ek9pI4Sk9BnimeUY+Jl9gKuiw4UWhSKwP4v1WA
         qleQiRT0iHV7sODLVvBXW0XWyHECiypKM0piYvM/zDPXL7Lgwgz1AQiBOwWBYIfSbhh0
         aMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=0iUjTpHZhf5wriiAcqQNIgI532H+rjITIuetchmVkTg=;
        b=QaAgBG3VGwh/SeZC3Bu9bGVLjxSHMMCNnraUCErfLYEIJNCm8aFHoJEN05qGiMOgTR
         nhsgjafP4dISeioUHfORLjUzMwFNoUgSF7agrRTfCDAHoWeWhg5623DJOYDhNyKdT/5P
         2ciUIK37vFZh33Z3p3a1OnmjvvENQuoK6Sc8+KIZmUalCt0T1JoyNRaPQkiYQLREMvc/
         /MV2jyLVNEnYLA/xR757xBXOFqfuUy+yRLpyUUzavHZHoHAAs9RIxpR1GUa44nK56sgl
         jIfJlxSPo7kKpVHosLvoXqyu6KaQIsDvg9OieGHGxUmX/KNtftNBTgr3ofwyUnXkS6r1
         37/g==
X-Gm-Message-State: ACgBeo2qysTKm+GSJ0DeMi3Op070EjFfJdfKR7o4nW1dPTSpT1QnO4Ps
        qDbF6SkyUC9fM57ZkkqDpMY=
X-Google-Smtp-Source: AA6agR5jx7nctuzE2QDIUq/KDwzbky+wFpE7D0Fi6ibggcAMwilRTPDv87MTZYvXL+r8+kSWIaqrQg==
X-Received: by 2002:a4a:b445:0:b0:44a:c71e:9921 with SMTP id h5-20020a4ab445000000b0044ac71e9921mr1579582ooo.49.1660685728594;
        Tue, 16 Aug 2022 14:35:28 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870f14600b0010c5005d427sm2325240oac.33.2022.08.16.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:35:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables
Date:   Tue, 16 Aug 2022 16:35:23 -0500
Message-Id: <20220816213523.5207-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
References: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A new Realtek device, the RTW8852BE, includes a BT part, which is not
currently contained in the tables in btusb. File btrtl already contains
some information for these devices. Thus far, two such devices are known.

These two known devices have the following lsusb outputs:

Bus 003 Device 004: ID 0bda:4853 Realtek Semiconductor Corp. Bluetooth Radio
Bus 002 Device 003: ID 0bda:887b Realtek Semiconductor Corp. Bluetooth Radio

The pertinent contents of /sys/kernel/debug/usb/devices for the second is
as follows:

T:  Bus=02 Lev=01 Prnt=01 Port=12 Cnt=03 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=887b Rev= 0.00
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

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 33e8ff6e0d13..e3776dbbaf18 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -441,6 +441,12 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3586), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8852BE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.37.1

