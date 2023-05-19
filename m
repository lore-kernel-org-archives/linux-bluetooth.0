Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4758DC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 19:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjESTXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESTXL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 15:23:11 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598BFD
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 12:23:10 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-54fa79be6e8so1032595eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684524189; x=1687116189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Ell+29LBWX2aVH86LCG3O28bJtA8IE4UKtQGbzZaM=;
        b=qXQPChPQMKsdsvjV8CiGKREIwBy4HBJVboGiueMgjhP9ieVLStGmICbDiarj8Wsv7d
         arKEN8YFG24VM63ys/cwobCps35nkkKLIEqh3kwc0Xme5pxrfAICHmFxgRcT4jiWhxH4
         u+PRVfLJXnv7EUENbBSpSjQtH0IMGU7AmmPSBhtnSQ0oJGRE3Lj795P1TpOaQWJw6qNS
         oKs23aauPeINgApF595BwLvOxVZGgpbB1qDJcsSHU3yJXywEnlnaCfvYo2P1PQm9AwH2
         u2TTdjLKQMEyyD7jDlzn98SEl3VxYJu/qGi+q63KClLmEzm95cJyUDwuJKOM3mmUuwgh
         Rzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684524189; x=1687116189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Ell+29LBWX2aVH86LCG3O28bJtA8IE4UKtQGbzZaM=;
        b=LXt/FIpv4I8ZhI0cH+xrAkLIZ7IGPGZeQIH6xr+CQ80W7i++gVqN6Leko1a9TYp+jR
         CwQQcROVganv+GhBXYG+/BU/Br09Gjur0DaNcmwbRiVTgUxpOyOnt0TNxApfEGXHtIJ6
         8CPWdszsZ/pqjF0icc9IACx5e2xNfWI8M+02rAzBgo83HrDs1KIT9usX7FIkazyyhlLj
         PJWstMbhPv46hL1AvvClNziqmjTY/wpkcRqFVXp0rNTkfDo1oLgJU7fuHletDYE3LAWi
         GPza6fbJ9Z/yVkyePWlvNlbdEAi9Mbv+v/fp7f3I6qcrYzDB8JSYxfyWAc3CmXUjCRx9
         jTQA==
X-Gm-Message-State: AC+VfDw1eTuCbkuW0zisuK6yw1+ju74qQTzKHRbznA1q28N7fGTNCRd1
        03AuiOEPmyVK5JQfDYZ9RgXgwo2qWLU=
X-Google-Smtp-Source: ACHHUZ7JQ2uvJFhOlSQnM/H1xS2zsoXI5cfCi9WPYHgGF3sZCF8+h9QLOh4a0c+u//dReIV4CMeBwg==
X-Received: by 2002:a4a:91d8:0:b0:54f:6137:994e with SMTP id e24-20020a4a91d8000000b0054f6137994emr1010366ooh.1.1684524189093;
        Fri, 19 May 2023 12:23:09 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id e14-20020a4a550e000000b0054fe8b73314sm27166oob.22.2023.05.19.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:23:08 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] bluetooth: Add device 0bda:b85e to device tables
Date:   Fri, 19 May 2023 14:22:56 -0500
Message-Id: <20230519192256.1334-1-Larry.Finger@lwfinger.net>
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

