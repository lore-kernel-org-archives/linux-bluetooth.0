Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE3C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 17:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCWRqP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCWRqO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 13:46:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C751B314
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id o26-20020a4ad49a000000b0053964a84b0fso3037185oos.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679593573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnVs0bUyHdJw5GiB3k4rH9kucFfjDgVuJrEBJkVCxlc=;
        b=bd8BHJa2BkatdW2eo7FJDsxKta0KnqQNG4Qi4SHjSO6d8Ek4W30tOYPh/scbRcRMtB
         tkxbCFj7s3Psvj4aXmiSTZVvkhztR+1/Wr0dPHabKPqosCuo1CsjxFPKPANVDib9R9sE
         h/luyVsLZTHnoCqRycIz5yEskA7YDooHsU5ZxU4WAVnmefgQJ0I7j88Q1Jj0GeW0ZJRe
         nItC/+xLv91eaH4T4qHxaEasCHDynTgLChsWNfwtL+DnVIIu6NFjkMgFnlv8eNk0AAZS
         X7J47u/6gIQIXlc76nQHAF3h7WcP4+QG6uQS8bzRcL5gck1H9FF2kFqyWAhQd9/vCqFs
         Gu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnVs0bUyHdJw5GiB3k4rH9kucFfjDgVuJrEBJkVCxlc=;
        b=AXtur9UdASJb1jCw9vH0MHenZHFxdDBAXQlOQdmQnv9XnDgh0jB8RvHyJz2BmgYybi
         ADe2qZU2ADJST5mUH+Ia6QPQSpJ8dVcxY/TsXDRQj0h28ATckmX/8QdkZDLf5yqTCuOU
         dEzdUIjdJwL1yPb+C5S/0pgVpGNLU4pixr0I3KTccnxUrKJeXGg+WhGufkXvcIS7v8/Y
         1VsvcQGe9dB7Kj2ZJa1VK+vTBiVPd2h1xAgYTgxFz2+yURhiS5rSCWqZcnOZWJWLVoEr
         mwWcBuysru09CD8uOQ77jfr4lgnSBzKr3NM78n+6aIKnkE6N0dpP3WXATseiwn3xKGd4
         9XKA==
X-Gm-Message-State: AO0yUKU8+CTa0Zjy3M+lWtGjTR0lQTN4TmeMb7OGxDDlbZpPGztKD5xJ
        2rU1LF/VOPqLPnz4xLkYSFU=
X-Google-Smtp-Source: AK7set/4ZuiJR5zd1nmYYOPJkITVk+DVsC3P5gCBHoqS99mAwM2VT5zfXM/HrnmdwPiC/4UP2ePANA==
X-Received: by 2002:a4a:ddd7:0:b0:53b:9c25:b136 with SMTP id i23-20020a4addd7000000b0053b9c25b136mr1312686oov.4.1679593572783;
        Thu, 23 Mar 2023 10:46:12 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id i7-20020a4a8d87000000b0052a77e38722sm7520924ook.26.2023.03.23.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:46:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/2] Bluetooth: Add device 0bda:887b to device tables
Date:   Thu, 23 Mar 2023 12:45:46 -0500
Message-Id: <20230323174604.30088-1-Larry.Finger@lwfinger.net>
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
V2 - changes "bluetooth" to "Bluetooth" in the subject
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

