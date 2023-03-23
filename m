Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1AC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 00:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCWAwR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCWAwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 20:52:16 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE03ABC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p20-20020a056830319400b0069f914e5c74so3098526ots.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679532735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbOCChFqSyDttqjdNnyRt4WP+ei45Hgcyz0FmScqYJQ=;
        b=Z4Fhuj522/thvBc9Qnpt9sGreJw3mkNuILASSmOb0hwIXqExqXB++aaKOfLOJe7L4h
         DIz9zI7ATzf+bPEwtan689h6mKAFzXT3VbcCcJbf1SLtS9plTHiuHoqFMB6+Asdc2B9M
         Tht2hVB5AJjK6DdnsmsZlhaZAfSIoOpoQYGKLac7a38HBDyp3HpXqsSK4A50b0P2x/Gi
         qwOqqua81dz8wUDcU6L/Xg6kU0HGSs6azf5sYvIZaqqdX9Rw7cx2jUcrnMJ4QaEH3SU2
         YaI3w0tRq6fyUXEbUC2OFC+IbIKt1AexbIDObT3k9KeeLRyAorvIcOHbcVSxDXMyN/5l
         XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbOCChFqSyDttqjdNnyRt4WP+ei45Hgcyz0FmScqYJQ=;
        b=KEgLiSe6266gVegSE/OBf+tyMSJ8EagPTTGt8OH7iPxlCRSQGHNGEa4ttchF+gieme
         M0CDxolkylaqKBiiFznp1VEWTaIVSBG87YJGUYpyj7UknNIUCvHpvMaP/slMOV7C85+S
         pd2av9EZDl3dHN/wywkSGTkklVeUiH/fJGaTOBJ+yFoDGAnwPqZuTcbaZRclEmaZwdJP
         w2NZXmkEiENGbEkyuSiyI0NWqsfrY0T3q6Z5zNP1D/NagUtV1B8Rx9R7wiSTZmNQyuns
         BP6ZPPQTIWXSwvVguiJ18nsyu9dM5wqJzxCv6GzTqnrn8NZzDWIAlUHwrdeRwXR2LkSX
         OzTA==
X-Gm-Message-State: AO0yUKWaCWJwoJLs/s3XhC/PdaUvmkhw4BoKuZ+HU6gQzmud1qUueYFh
        CQ1FBZpQeSyN4TsCCI5bRlMZy/P6EwQ=
X-Google-Smtp-Source: AK7set9El+GyBeJ6ykplNwSgW0BzTAfPtSCsbJakfsEOBButoPMK3q9hF0qTBDB+ZcXcpynVXo/Bmw==
X-Received: by 2002:a05:6830:309c:b0:693:d999:431a with SMTP id g28-20020a056830309c00b00693d999431amr2224860ots.13.1679532735492;
        Wed, 22 Mar 2023 17:52:15 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n7-20020a9d7407000000b0069b193c5d7esm6922702otk.38.2023.03.22.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:52:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/2] bluetooth: Add device 0bda:887b to device tables
Date:   Wed, 22 Mar 2023 19:52:02 -0500
Message-Id: <20230323005203.19749-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
References: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This device is part of a Realtek RTW8852BE chip.

The device table entry is as follows:

T:  Bus=03 Lev=01 Prnt=01 Port=12 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
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
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 18bc94718711..964aa5577c79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -540,6 +540,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
-- 
2.40.0

