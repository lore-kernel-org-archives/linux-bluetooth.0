Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DCDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 22:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbiBJWzz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:55:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbiBJWzy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 17:55:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D791E55B0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:55:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a39so12095065pfx.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wu6J3CUz+yK8eT0oBk/3837IZPQ0PXsIDjvqTM+eBY=;
        b=dpouK2sO88U07lEbLCgQaMrrdZFdaLcsqCLCQol+S4iSa01sHkGEUbK4TFQX8+hdr/
         jMwgdcNxF5nFNm11dghPzLQ0qeXb36nQ5nZHoGOXKy6ak46J2XPm69NxWGddCQIOlT8+
         VucfMcnsHAWvXqOLQ68lRUgkHI6fF1EWK7NxhCQslh5lX0j5KTxfl2cMRdT2gq9sR5oj
         0+x2/76rvT8sXuq0lFwpMaDvK/cHccp7AQxWmzNDuGHFUDVmTDsq+ncn6SzNKzG6pv4g
         QAmtCpLoLnP9Ho7gO5d4OwkVuIIfIUDsYX7St1TXloUxQMG0bUo3v9/rVlMxgImQr1xM
         H+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wu6J3CUz+yK8eT0oBk/3837IZPQ0PXsIDjvqTM+eBY=;
        b=1od3/5S1E8UYaPHnTbHKe7Bsep5W4X/qFJ/qPMxmekydwE8t68u17BuiFSbXL3n4r9
         ioyAkEoRvy7znjoEwn94FwzRE/FRYf2srx0kqLz6+eJ1/8qdKNvyIO7h8GgkXjfu4HLT
         nYP/M2RDDmnLh3k4yylzBP7D0ZLTmcXqCntLjN2tx/GrFmqiqn7Bpr3yOBxBi0uuoIQ/
         Yj5L7oY41b6TmtIlAcGXrMaPhwjHMCN/cSxxkqGPioPPCUcre15IaEbOvrgLhb2xmULA
         BzEPvr47aW9t4zUUPyXu7gcRZlEKJran5x49dZAJsSWfnzkhHh13XpQl95vzqRFaZ87U
         NWMA==
X-Gm-Message-State: AOAM5315ZUzjevqL2eCiWQNlbdMwhn3enql0FFt1N0md06ovazFPfviy
        alZQXU+CKWixom3YBx2zXFxJ/W1uoxRTTA==
X-Google-Smtp-Source: ABdhPJx1ga1YbMZeNUK6NuGzSf74sMLr6cXwqmf5yE/yl6wYjpCKMOTZ47YcXGJMqTjVE2ucCBRznw==
X-Received: by 2002:a05:6a00:10c1:: with SMTP id d1mr9814598pfu.79.1644533754099;
        Thu, 10 Feb 2022 14:55:54 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g12sm23421869pfm.119.2022.02.10.14.55.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:55:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] device: Fix crash when removing device
Date:   Thu, 10 Feb 2022 14:55:52 -0800
Message-Id: <20220210225552.573320-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calling btd_adapter_remove_device from device_remove_connection can
cause a crash, so instead of removing it immediatelly this set a the
temporary timeout to 0.

Fixes: https://github.com/bluez/bluez/issues/290
---
v2: Fix compilation

 src/device.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6d29eb896..81b8ebd1e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3200,6 +3200,28 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 								"Connected");
 }
 
+static bool device_disappeared(gpointer user_data)
+{
+	struct btd_device *dev = user_data;
+
+	dev->temporary_timer = 0;
+
+	btd_adapter_remove_device(dev->adapter, dev);
+
+	return FALSE;
+}
+
+static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
+{
+	clear_temporary_timer(dev);
+
+	if (!timeout)
+		return;
+
+	dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
+								dev, NULL);
+}
+
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
@@ -3285,7 +3307,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Connected");
 
 	if (remove_device)
-		btd_adapter_remove_device(device->adapter, device);
+		set_temporary_timer(device, 0);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -4590,28 +4612,6 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	store_device_info(device);
 }
 
-static bool device_disappeared(gpointer user_data)
-{
-	struct btd_device *dev = user_data;
-
-	dev->temporary_timer = 0;
-
-	btd_adapter_remove_device(dev->adapter, dev);
-
-	return FALSE;
-}
-
-static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
-{
-	clear_temporary_timer(dev);
-
-	if (!timeout)
-		return;
-
-	dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
-								dev, NULL);
-}
-
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (bdaddr_type == BDADDR_BREDR)
-- 
2.34.1

