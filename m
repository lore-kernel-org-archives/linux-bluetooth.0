Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577EC388F2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 03:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B433822249
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 03:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meQLDY/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411531AbgJUDFk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Oct 2020 23:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411526AbgJUDFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Oct 2020 23:05:40 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5415C0613CE;
        Tue, 20 Oct 2020 20:05:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n15so572159otl.8;
        Tue, 20 Oct 2020 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHj8eRnSLlSUCkdk/FFaXiuFyAYJ62QdpiU4SN27KUw=;
        b=meQLDY/aG1DCYy2fnDr+zizkV9BWcN02DfbymEnIKLpLS1ZYTQxB5WlOuuJMOIaL59
         j/Yk107UccuEqAyLMsr8wAMgKoL189nH5/5LBbnx1KfVAuj9ZcfohJPCijUYtqKSoFyS
         cZY4GKjJFaABLs27/poKamsyu9/WToZTvAN7BR7cZ2QwsQP2t/Xi/XHqukIUVceXV3jG
         Q+4M5dTl7wZYi7PK9HGQvCehkmw5qojK8HdrU/IXZvFtkBXB7SAhXWPAPTPOYn49QdlY
         XGvLCSxxzrk2/TbbUcubBcYugYZXdeAJN75XbKPdnw/QZw9UJm1EEGsi7qCBNUA+mfTt
         mutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHj8eRnSLlSUCkdk/FFaXiuFyAYJ62QdpiU4SN27KUw=;
        b=k4RUO039LTYfsTU6XAjIg14aKRxbmlYlR3hVXlGveM3Sc765nMwedVFUyBjl+265+2
         VQ8v2FrqAXndMpEf4eDuggfh9OZ/wneX0V9SNoXivYpzKFKmV4JCmFnILVJvY/ITNHW8
         hrwKnuWbBUCDkJvocUrwGl97ZEI8kBrjG/W5bh/8UHBlLcu0Aj9MTGcyzBaGHgO/iDee
         pKbkMlnK2qB5CMECVWotEaSQHL8OJdbMrJdCQVQ6/JbekWlVM9xYxqQ3zS+PUKUG0txA
         TIA56gkE6RSEbiD253U+voXxGIlNdAKRHHDxcYezFbliXYSoJzLx5Anq7zO7o1UppBSy
         qwwQ==
X-Gm-Message-State: AOAM533/4yVZEFHccqQDq9m57N4xKBWtpDuuNLoGjBT1dRe7ByH/kDJs
        H20wClogwOfri6gcR3UNofQ=
X-Google-Smtp-Source: ABdhPJzm2N0mVnthdkuasZyt3yLkW1m3qrIxBc8nXo5aUeJGFy/4Z7P/xMxa8+D9kx/wrLE1WHvB7Q==
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr1031154otk.156.1603249538105;
        Tue, 20 Oct 2020 20:05:38 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id j7sm304100oie.44.2020.10.20.20.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 20:05:37 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     Forest Crossman <cyrozap@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add support for LG LGSBWAC92/TWCM-K505D
Date:   Tue, 20 Oct 2020 22:05:21 -0500
Message-Id: <20201021030521.1121268-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016030238.1033559-1-cyrozap@gmail.com>
References: <20201016030238.1033559-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LG LGSBWAC92/TWCM-K505D/EAT64454801/EAT64454802 (it goes by many
names) is a combo WiFi/Bluetooth module that's used in several models of
LG TVs. It uses the MediaTek MT7668AUN, which is already supported in
btusb, but this device has a non-MediaTek USB VID so to get it to work
we just need to add it to the list of devices to probe.

Device from /sys/kernel/debug/usb/devices:

T:  Bus=09 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=043e ProdID=3109 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
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
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---

Changes from v1:
 - Added /sys/kernel/debug/usb/devices info.
 - Specify device with USB_DEVICE_AND_INTERFACE_INFO instead of just
   USB_DEVICE.

---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf667..fbc7b87f0190 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -366,6 +366,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x043e, 0x3109, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_MEDIATEK },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.20.1

