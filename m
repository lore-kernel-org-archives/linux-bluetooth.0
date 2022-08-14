Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C9C25B06
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Aug 2022 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiHNSHZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHNSHY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 14:07:24 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B524090
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 11:07:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c185so6618586oia.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=qiZD45dO09l9E/wesyVV3y65HvfbJYG2SGqiTHybHuU=;
        b=p9mrBZUp7EXQWsIE4WCFx+qmIefm97KdpWSHt0u4Q0DxLlJwdmkIGyaId8eb9I2/i6
         yDdji+cXOVwy3I0hg+e/xyfjpjWXrR7LiFtaWP6hZSZ5C9KFm3AcX5tJ5jqy+KnffG+J
         mPZpvYpP3POZlU7DovpoyGk2+T/wsjFR4M0OOB7KdfMnPdoco98v7EHVuEQz9C9woJ4+
         Y6OlNAeCO/36uJci88bzloodFpR4K+WtYau6sP0zDngffLZ2Mb/gcMtUjt/vbDX5VbCj
         eI+vkWZpmV3WpwWEPtL9rCPAa39qsGYMXPDoIaFKzSoICJXq4rA/JmpMMjWdovj9WLyB
         5EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=qiZD45dO09l9E/wesyVV3y65HvfbJYG2SGqiTHybHuU=;
        b=qE20qsGVmrSe8uSF6lkonzznGaXvlAGWEniLfnew9oBkjaeWKRjGl+HQDrV9wZov9o
         T0bD7PpNstV2xHpexsA/ZaTJoQg+pv4m17CXdYjs2JJUO7ilAUNBo8TSvWOG5CP6IFYr
         4QhP9FVD66qiUZ+9WsDatl9wyQcGcaV1y3BpQNo7A8XxrUwauWhosBXQ9sdaEMbuYux/
         DNkxPenuLATOgqEt2N1PyzqNP+R3LDeq7uagHT23z1fj1xU66ftaVTkp2FRaTKuqTTkA
         LYRLYOo+CZ9nZhcMC6iaAccruXIJzGCgyWRQo+uWSAvToCBHDUDTyrtIevA9chmgitBK
         //CQ==
X-Gm-Message-State: ACgBeo3dcC04tbzgpBbhoDq0m+7rwmpieq0bFtpUdfm4U+Gli/iQiiGP
        iI0t9cy+2yJI1kZowFebAvY=
X-Google-Smtp-Source: AA6agR4y4Ll9beZsHp1zno8sxM/UAedRruVzjOyPg60CL1mVe0pghmK541fbyFnj9stM1tJ41mmD6w==
X-Received: by 2002:a05:6808:138e:b0:343:1207:b07f with SMTP id c14-20020a056808138e00b003431207b07fmr8800575oiw.267.1660500442582;
        Sun, 14 Aug 2022 11:07:22 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o9-20020acaf009000000b00342a198e240sm1433561oih.22.2022.08.14.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:07:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables
Date:   Sun, 14 Aug 2022 13:07:13 -0500
Message-Id: <20220814180713.27069-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
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
index e25fcd49db70..02378be3287d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -427,6 +427,12 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
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
2.36.1

