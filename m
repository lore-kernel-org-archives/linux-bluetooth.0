Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E285C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGZVuq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGZVup (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:50:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F5FA
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:50:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso465205e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690408242; x=1691013042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XepCVdB4VuWL1UnNi7OmY5Bp52yMiE/fDsqtr58lWzk=;
        b=dACAkXcBxF1t3k+1+YrXfQaAWq+J6FnuHePYgBdhFWshdEdYC6S+zorb0J92S8FCBu
         u1Uhjuo+oFQvs/chatWD+4hSGmbPTn6B/dYM/jspmhjP2vjAsRuaUqNrwJsdHgdP0sRS
         b1jMmdmO0HuaSwF15cRmeP4lFrVdpznh9nCFJ6KNGJCM6ZIwfGdUbLvOcbt2vrIUVAfv
         Yg6yo+qGq1Ib8UdTNq730gsPVYYn7QPqheEBveMq/493w87IvfhdHaxLnNy/hLnL2Glw
         aR48+2nv44AynY6UQ3rtUtQtY5o7aGAobBlxhvLc1KDT41Cf4Y2VFP8E6Xp1J67/nZ5g
         NGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408242; x=1691013042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XepCVdB4VuWL1UnNi7OmY5Bp52yMiE/fDsqtr58lWzk=;
        b=SWd77VKHQ2RZV9SNpgOXnLhwkRJozzFPA/DDDsX36j9Z/u24F8eDUkX0vzG54nXNzY
         HLfSnX4X5k/tOOMkA/ONDobQUUrmeiddnCugMxPVC3G3ser67hWqBuvFUbu9GX4v3UvD
         ZUquW8zhZQ6I8KNe8RTDoHsJdi3AWp80hTud7KdQcuLhA6kIu9gBPMUUxjkvX24iFYWK
         1gkX/FzihWeETDg5WdkLTRnUpR8LQDIQxAX/mvBaRAAnmV5x2rYHHfGmAhNnSHmY1K7r
         IvdT6ImNMNbtUkapeqiM2TWjTRUvbFc/b2i6oi0kiXDZxvazM7QZApnECvM/YQ/5RqRA
         eR1Q==
X-Gm-Message-State: ABy/qLZPIlEXjWtjt9NFJtPS8RqC3EdtIVxGXCallbJuv+yPJOcCgQIn
        JwXNtIvpwCtpr2+ZGTSMzPpm6vG28q7rp1HI
X-Google-Smtp-Source: APBJJlGkqrYGZ8JmJzhx0vDrH8ulAf/8//HHZusWN3ETxnfrB8Ckpd2B88YA6BmvI3tkGFqvxB/pUg==
X-Received: by 2002:a05:6512:3caa:b0:4f8:7734:8dd2 with SMTP id h42-20020a0565123caa00b004f877348dd2mr282943lfv.53.1690408241730;
        Wed, 26 Jul 2023 14:50:41 -0700 (PDT)
Received: from foka.. (109-252-121-22.nat.spd-mgts.ru. [109.252.121.22])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512024e00b004fb757bd429sm4462lfo.96.2023.07.26.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:50:41 -0700 (PDT)
From:   Pavel Asyutchenko <svenpavel@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Support one more MediaTek 7922 VID/PID
Date:   Thu, 27 Jul 2023 00:50:40 +0300
Message-Id: <20230726215040.17827-1-svenpavel@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This one is used in Asus ROG Strix G17 2023 (G713PV).

Information from /sys/kernel/debug/usb/devices:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0f6 Rev= 1.00
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

Signed-off-by: Pavel Asyutchenko <svenpavel@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 764d176e973..fae138fd711 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f6), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.39.2

