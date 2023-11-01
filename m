Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA11EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 09:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjKAJkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjKAJkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 05:40:49 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06287FD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 02:40:46 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-32d9effe314so4438742f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Nov 2023 02:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698831644; x=1699436444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/+s9KuWqMCjoc27vAVRRX2PZoWPfecNtGyIdlR56NA=;
        b=lLDQyTWx2Ymr9y8TXg+aiMTnLOAffVS7xc6dIXCnDYVwIA+HGmR7SmR7Q78yrOipE1
         lIkPA6noL0KPrAOy5A+RC13l8Na52fIBudqQgCqTn9UpuRonGao+k9ScrgnYQ4bc3JXX
         ZGvyUwJ0/Q/17MDIbppKSxyh2ltyfZ/N4NUPp6IRm81kFWOJcAXwnH90lL35t8ItthZb
         1xBJ+hA/shyYkFEEPpZ40SJtClGjWL8ElBbU9VIbH1tDbLO8zCR283ylCxXIvnQmctQ0
         0/KMU5h3zIdwhUM9qGsYrS7CxiubPAxFLW2aOoC5TMfSWc7bvL/VSs0bcVj4mjOwt6Q9
         cRSg==
X-Gm-Message-State: AOJu0Yw2nWVcesP3LSj1+xfZS8tyu/K/arhwvjPBdzMtW+PYN/dX9V7d
        QtP8x9ZbIIkvNAcRBkwdijpoCKXSJK2CAw==
X-Google-Smtp-Source: AGHT+IGx+5QYfBnITj5CylM7gcPcsMbZ4IE1zaGfG6viKWBlk/gtDoZo5vYk4YoRhXk2rjcMw+uG7g==
X-Received: by 2002:a5d:694d:0:b0:31f:f9a9:a742 with SMTP id r13-20020a5d694d000000b0031ff9a9a742mr9579098wrw.23.1698831643994;
        Wed, 01 Nov 2023 02:40:43 -0700 (PDT)
Received: from redmibookpro.tendawifi.com ([217.155.96.227])
        by smtp.googlemail.com with ESMTPSA id bn19-20020a056000061300b0032d9f32b96csm3788642wrb.62.2023.11.01.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:40:43 -0700 (PDT)
From:   Tom Waldron <tom@baremetal.dev>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     Tom Waldron <tom@baremetal.dev>
Subject: [PATCH 1/1] Bluetooth: btusb: Add a new VID/PID 35f5/7922 for MT7922
Date:   Wed,  1 Nov 2023 09:40:43 +0000
Message-ID: <20231101094043.43294-1-tom@baremetal.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add VID/PID 35f5/7922 for MediaTek MT7922 USB Bluetooth chip.
Change tested on Redmi Book Pro 15 2023 (Fedora 38).

Signed-off-by: Tom Waldron <tom@baremetal.dev>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 499f4809f..23590c931 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -644,6 +644,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.41.0

