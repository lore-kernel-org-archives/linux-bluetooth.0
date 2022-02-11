Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E12C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 09:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348646AbiBKJbW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:31:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBKJbW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 04:31:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7591092
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:31:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bx2so15478124edb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pea6y//hoL3WmcYk8YOiKItOB0SVVmGIBI5l/4F2MnI=;
        b=PC2rt90PY6pZ2mbcOkK/p4SHS9nl4SgZx6/6tjnfThzxS6wedOgdqRsBq6o0bHnimf
         Q1dOBkXTyoeai09GfKqGHCsjrEi7TTHV8k5ESOdcTT9WpXQ3bWGcyB18Xd2vsXnibuaJ
         K1/0viwQu9UCVwcdesCs3qWdCu0wJSViQ7x7hYm+AJS6e9idE2motBzMWS0h5Q4oD4JR
         9WHs3P7tNcOxmMmKCrtCAeAATxdIyBxxs0FZarEA6/YsgCFOGYTekgfpjPLMKZVtEv7C
         6e+gGPxZuw8fxTUEbJd34mi0KT7fjbaoHp6deUROG6CZTKyDhBOHJbl4VmzF9z1NiF+V
         31Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pea6y//hoL3WmcYk8YOiKItOB0SVVmGIBI5l/4F2MnI=;
        b=pj7l1To8WlrRbTG9lBRFYtg/EXayRSTiw7Qzzo+Yn6bibD/YRxKTWquSmhy075QCop
         yY5iMOx28S9aJcH6Mc6XfWcq0pp+MXRbPjaxmtOmI+bX0yt1HDKP72GGrvNXZyB6aUAN
         gr9PcXy/ei74nyRUX2BQNlFDVfyIbKkwS7u0WBlhN5vpImDi0NMtVH9w8csLegBlZWTQ
         HEClWJMIJFBxS4YDUHi8C5Ys02+D8wfexIv4auHkBRtLDip9YeBRiUhscy/kuF5hRPQf
         dxli9KxbXocvVAA30YG06gF1Jwuc9YNEcAIIx/hMX51Eokyepa17TQYn57RZWXRdou0g
         34OQ==
X-Gm-Message-State: AOAM531rT2oDgH1qZpHcZiYMJc0TcRq8eaXgQmX9dgBvTILQQqcArDif
        T7sxh75h2rqzVrVUxuBxzDdTVW7AHD4=
X-Google-Smtp-Source: ABdhPJwWhHbpaNfxvY0SMSa323EOC/7aj1wK7IvBbc/Gb5oi3OGo7c8Wp+uRl10McUuCiGfTnAARtw==
X-Received: by 2002:a05:6402:43ce:: with SMTP id p14mr930649edc.300.1644571879035;
        Fri, 11 Feb 2022 01:31:19 -0800 (PST)
Received: from localhost.localdomain ([45.142.163.102])
        by smtp.gmail.com with ESMTPSA id i1sm5535608ejv.183.2022.02.11.01.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:31:18 -0800 (PST)
From:   Piotr Dymacz <pepe2k@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: [PATCH] Bluetooth: btusb: add support for LG LGSBWAC02 (MT7663BUN)
Date:   Fri, 11 Feb 2022 10:31:03 +0100
Message-Id: <20220211093103.18124-1-pepe2k@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LG LGSBWAC02 (FCC ID: BEJLGSBWAC02) is a combo Wi-Fi/BT module which
can be found in several different LG TV models. This module is based on
already supported MediaTek MT7663U series.

Device from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=043e ProdID=310c Rev= 1.00
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
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=mt7663u
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Piotr Dymacz <pepe2k@gmail.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e03dfbd92fcc..ef5d52f0e123 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -435,6 +435,11 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Additional MediaTek MT7615E Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
+	/* Additional MediaTek MT7663 Bluetooth devices */
+	{ USB_DEVICE(0x043e, 0x310c), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+
 	/* Additional MediaTek MT7668 Bluetooth devices */
 	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
-- 
2.35.1

