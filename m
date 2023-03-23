Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D5CC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 00:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCWAwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCWAwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 20:52:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B22366C
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:18 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so11378237otj.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679532738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4s7O2psfaoTqClXZN2llqI098Vp1Cd0S3s/1TmJkhE=;
        b=fmIbk1Q/05sdqDyXObLYpPng+pUPe4uWg+DZcRoj7qBtRTOW3kyO6VsiqKtdq+iqfp
         gyIKxKCDK7ZCsffanaHhQyrHPaxretcCsByFV9wcfoiXlZzzPctVMAInLvNjLPVLkuYq
         a/8k9Q9MkA7llSZa9SacV2RVGsR+jSRCUW3qgqXKHgJJfNYDFSsFCVjdJOEOEJe6olLq
         UdjyrK4d3WJS5Zy121XS651Ff+aK3K7t+gyZEkQqKwnK4K7sYjj5mwKzE/cqbJkWo00Q
         YFhfwBs09BRSal5xdbI5UHyuvP+n1s5Ocud6wpVjPeFkGlG2hnCipTGn9h0XEvnbdL+b
         q76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4s7O2psfaoTqClXZN2llqI098Vp1Cd0S3s/1TmJkhE=;
        b=PIHZEsTdhiNIqQcKz/IVwHI1tCJUgdq/qFgG0zmjJHg9IchW5teiMI/WJFFpd+MBOv
         IIveMBWTyeihqt5DDVnUUBR/YvEqHicHzXwu4OcmdB6K3dsm7v/hNNjzriWs8oR4rmLE
         gIlt5k0GEo59obvjTl0sXF3be8+No8DN1rtE9/ztWn0eG0MAOLR9KkgnL7yto/5HkEWv
         56G3HpyvDvvyNhd0AFv/mCAtHHYIL19/iXflw3KIb7HPlEK6SxziUesMoUM/BE3iKc8j
         JGIK4Q7a2v0IXaUJ/e4ZeWIxlQ4T0goHiZ4PWzlT7opE5IHJYOyo6OeBOEr7mKakFcXl
         cX2Q==
X-Gm-Message-State: AO0yUKUM9dJ1AI5GrTLsZi6feSN//I5ULi5T0dLn4sZjq8gjUW+Pcrn+
        pQxIFeHKJz5gD1T+t3P+JA1qA8qM7+E=
X-Google-Smtp-Source: AK7set+GMCQ6Biv8pAWWvYT2u1+8Cqn+8wv7z50xnsgRZ0IGWNVBvLEOhblZlIlczxIcOPsLuaSvDg==
X-Received: by 2002:a05:6830:478e:b0:699:2dfb:e70d with SMTP id df14-20020a056830478e00b006992dfbe70dmr2104655otb.6.1679532738118;
        Wed, 22 Mar 2023 17:52:18 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n7-20020a9d7407000000b0069b193c5d7esm6922702otk.38.2023.03.22.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:52:17 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] bluetooth: Add device 13d3:3571 to device tables
Date:   Wed, 22 Mar 2023 19:52:03 -0500
Message-Id: <20230323005203.19749-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
References: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This device is part of a Realtek RTW8852BE chip. The device table is as follows:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3571 Rev= 0.00
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
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 964aa5577c79..39ea0e007038 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -542,6 +542,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
-- 
2.40.0

