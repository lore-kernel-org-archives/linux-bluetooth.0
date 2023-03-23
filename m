Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B2C76196
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWRqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCWRqR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 13:46:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F4715174
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b19so3853024oib.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679593575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2EF4HwABBeb6MM+8fRr/P5gWymTAjBVdOKy+eyVmFw=;
        b=R3xWEM88J91PsmyFuqg+erfnG9TJYyGHaz8tZtyWMoksuWrewb9iEm1zFeydWPw2Dk
         63ORLip3G+4XhuZVCDdoYVel9FEW2Mz1UtB1nbMJgzGNUbVW43kyHYL03pi/B24ZMyA+
         PIOwqadJGE1rUK6vogW/CWgAFmARjwTlTl6vAJbQMpyBXcZFsyswBgig3DeIbeha6YYF
         4mP4VLaAjXhKahr91uVs9J7NO4hTbR6jKiUE8qQu5PK41X6donKZGW/yQiL80wzac9no
         n5+9YZszrmZk3Bz6E7YFte/s4p9FdzFy9e/DDTMzJYtFlCOxg8jRJCR40vktOgJ/6SeF
         1F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2EF4HwABBeb6MM+8fRr/P5gWymTAjBVdOKy+eyVmFw=;
        b=R9+AZmHjdZWKrYlQvvHZmXgCLZqV2Sq1jRj3SVeOAhBBcZR+CfTbaGPyx8sF7FVjJr
         9C0iAnSYK9wsOeVJRwLnVzxhHCdMsrJVkWI5PeonvSlJBEuS9rufRMtt4WUww2/JAKCD
         KAibzv9ADaDsUcy5B02MBNdnFG1Phcqjd419jvi8+Vn6Qc0PqC7dNgbyq7lmnunWqK8x
         SDB7tfDeuZdN5AzI6GUU9H1pBsAcaY9jMJO4FLXIHgDzGTWZSiQAG24SjIkrvPDEwh6n
         Rf7MuGlw7ZFjunUt6FM/TYLaIkZ+sLP7vsSOtD/aT2uMk5Rc1Yn+TcHUMaVgyEF0qIF7
         CqYw==
X-Gm-Message-State: AO0yUKXBvnFrrHEzlJVJ/8lpy1c/qRIMKemStuAhBaMrTQ9pP+5U67Zy
        JUyWeBNKjpthkkyMzpRhNnQ=
X-Google-Smtp-Source: AK7set9J0JnhJL8Y9zNHVP8P3NF119U16JGFoCUSyYRqsQzTSK+D2SF6vJfTjPldOiFLJfbI7DghDA==
X-Received: by 2002:a05:6808:10c:b0:386:97a0:5662 with SMTP id b12-20020a056808010c00b0038697a05662mr3059720oie.19.1679593574980;
        Thu, 23 Mar 2023 10:46:14 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id i7-20020a4a8d87000000b0052a77e38722sm7520924ook.26.2023.03.23.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:46:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] Bluetooth: Add device 13d3:3571 to device tables
Date:   Thu, 23 Mar 2023 12:45:47 -0500
Message-Id: <20230323174604.30088-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
References: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This device is part of a Realtek RTW8852BE chip. The device table is as
follows:

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
V2 - changed "bluetooth" to "Bluetooth" in the subject
     Fixed the long line in the description
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

