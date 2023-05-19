Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE7C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 20:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjESUv6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 16:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjESUv5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 16:51:57 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA31A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 13:51:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19a427d7b57so859593fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684529515; x=1687121515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D8cH7RV4i12cfczW90i15LC3ONTq7m9ORFosf4L4hkE=;
        b=bHlV3TOhFlJio4glWpo3mv3igVb+1FH/53LzSPefpxQo/yP/wz5oEkwpkMimhihTOi
         +CttdRERMglhQ9dKHFahaTd2EqyLVNdrXynWebk/4MfrSF+c11Pj9HTSVDZH7qO07kTa
         cX9rWIXnddp4uYr5BYEmdFjRiqpRVWLk+A26S5GZokCzPZ7TikNwuOWZlK4ZivDAIlwU
         svJIi5wwxvgEOsVYmll4WdlgsqBPegdjsk9uMu6LOZ5SFkfNGLuRhqvl4ixTZt/tGprG
         wgdLSj1JZRAi/MME4RmLvqDblmzFZH7jGbkJbmjxQku3stqQ98tsuaX230fcim1RnUJu
         4rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529515; x=1687121515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8cH7RV4i12cfczW90i15LC3ONTq7m9ORFosf4L4hkE=;
        b=Xo5x+dxiW1noew1gEjr2t7dP5/HKscA3rZDCr/K2z7nLXciCiN4iEI+2HRbgALTdu8
         SvnqLSi+00mWJg4ciUxGrIbLs+IyZei2S9w+2D9ZbJEiPwYJK89ZfOSb1vjt4KqZKU4B
         o3A5ADO5WJxHmzwpGNMx/berVrViKvJ7FVq5R0YQ31zXeej/bmsQc4jjUBenERtIEyK1
         cwtItlnx3INbZShFbSjzOpgcm2UYrqrN2l0DwSEcdV8a3KK3CaVrwwiLxPLqqHB8kggE
         Hwpz5dfj5NU+C1VijUyyqwMjXMIeWu0wnPbl7N6sOGiqsAKNc3dEMKDmswhYRWh9oher
         6HGA==
X-Gm-Message-State: AC+VfDwu4v3tOnJEAs8FqyaQKbZ6Godgz7z+P8vpour9vNB1vAdv52Qi
        2aQgb3DPKOLNE1G/Q5Jhuoc=
X-Google-Smtp-Source: ACHHUZ6Au0/IiWZ7tVExpBTxJ4mU7p1bK0P2jNCsZRxgkvvTPobJDSluC/oFt75a9wH42wY6ZW6Sjg==
X-Received: by 2002:a05:6870:b301:b0:196:4a0b:73a6 with SMTP id a1-20020a056870b30100b001964a0b73a6mr1701406oao.26.1684529515615;
        Fri, 19 May 2023 13:51:55 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q7-20020a056870028700b0019a291d1672sm2364093oaf.26.2023.05.19.13.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:51:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH V2] Bluetooth: Add device 0bda:b85e to device tables
Date:   Fri, 19 May 2023 15:51:51 -0500
Message-Id: <20230519205151.9659-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This device is part of a Realtek RTW8851BE chip.

The portion of /sys/kernel/debug/usb/devices for this device is
as follows:

T:  Bus=03 Lev=01 Prnt=01 Port=12 Cnt=03 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b85e Rev= 0.00
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
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Cc: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
V2 - Capitalize Bluetooth in subject
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..5ae52d14b56c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -537,6 +537,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8851BE Bluetooth device */
+	{ USB_DEVICE(0x0bda, 0xb85e), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.40.1

