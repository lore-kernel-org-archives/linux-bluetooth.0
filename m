Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E98C001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjGYIrG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjGYIqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BD81BD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so4088900a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274694; x=1690879494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n89ANJrt+y+ZXNxLi1rjyRRZmPrTl/SG2kXMM0plEO4=;
        b=JwN0+H0I/yhqyelNvYLlSYZHKR67V2wpcsi6wFiHALXsL+PX40n8YhXKRrfO88y8/e
         XWClJ+Q9SSuht62I5Bvb9Kvb2eBr9xgi83zr3r4Ep+3Ox6Ab6ANTJbi1R1TnSFXafdX9
         ApvYyqBcAYXmuGglONf18bB5BLnQBOWNPRk+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274694; x=1690879494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n89ANJrt+y+ZXNxLi1rjyRRZmPrTl/SG2kXMM0plEO4=;
        b=ApKgrrCglQCLVvjK3MkAGgLFsmRalyViBJmlRj2JvzWP9gaagTF0VZeIgA9GdoVOhz
         YpGAtzKmzetqgpLxMWmW6D72uHnyihXtY7ydhAEnLIEaO0+rOZ19pFAbfPs7fqyhSJnq
         cFKSiZLeatp+L9inU+EvtuWkOsCmliLM8i72CLInaBTUdcp6akts0XzjMkCXMX29xP63
         XHzSASY7AEi/5c3VoHwCxmIWK5JOoPv9djKRBEJrh7V+an38giP62t+LGBSFD+UgtGlS
         V4xT1EIaZRF3jHdIoi7q6nrvZtKQgiKxSyyemKmpXmFsxQUAzgtafA2VYxqwq+eR6Op0
         Tp+Q==
X-Gm-Message-State: ABy/qLb8WTp3gN6Lz4CNo9QuGCWKJvN0PkfzdtfDeEF/1HmgBLgoCojn
        dZHO7ksrfFTyOoEtHRUq7wOZmlpZvM4UV73YaS0=
X-Google-Smtp-Source: APBJJlE7rC2CrTmniYxlAKQi4RNlXl1m1lqpqvyoGMaAA7h+M3p828y6qb8eLmmdIg3xXpgPP475qA==
X-Received: by 2002:a17:907:7846:b0:994:8e9:67fe with SMTP id lb6-20020a170907784600b0099408e967femr10806190ejc.35.1690274694021;
        Tue, 25 Jul 2023 01:44:54 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:53 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/8] device: Refactor device_discover_services function
Date:   Tue, 25 Jul 2023 10:44:26 +0200
Message-Id: <20230725084431.640332-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After refactoring we can reuse function once more in function
void device_bonding_complete(...)
---
 profiles/input/server.c |  2 +-
 src/adapter.c           |  2 +-
 src/device.c            | 24 +++++++-----------------
 src/device.h            |  3 ++-
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 79cf08a66..12912cae6 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -102,7 +102,7 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
 	data->psm = psm;
 
 	if (psm == L2CAP_PSM_HIDP_CTRL)
-		device_discover_services(device);
+		device_discover_services(device, BDADDR_BREDR, NULL);
 
 	device_wait_for_svc_complete(device, sixaxis_sdp_cb, data);
 }
diff --git a/src/adapter.c b/src/adapter.c
index 17f4a637d..4c3bb091d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3637,7 +3637,7 @@ static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		device_attach_att(device, io);
 	}
 
-	device_discover_services(device);
+	device_discover_services(device, data->dst_type, NULL);
 	device_wait_for_svc_complete(device, device_browse_cb, NULL);
 
 	g_io_channel_unref(io);
diff --git a/src/device.c b/src/device.c
index b43ced8b5..82740216d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2446,10 +2446,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 resolve_services:
 	DBG("Resolving services for %s", dev->path);
 
-	if (bdaddr_type == BDADDR_BREDR)
-		err = device_browse_sdp(dev, msg);
-	else
-		err = device_browse_gatt(dev, msg);
+	err = device_discover_services(dev, bdaddr_type, msg);
 	if (err < 0) {
 		return btd_error_failed(msg, bdaddr_type == BDADDR_BREDR ?
 			ERR_BREDR_CONN_SDP_SEARCH : ERR_LE_CONN_GATT_BROWSE);
@@ -5873,14 +5870,15 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	return err;
 }
 
-int device_discover_services(struct btd_device *device)
+int device_discover_services(struct btd_device *device,
+						uint8_t bdaddr_type, DBusMessage *msg)
 {
 	int err;
 
-	if (device->bredr)
-		err = device_browse_sdp(device, NULL);
+	if (bdaddr_type == BDADDR_BREDR)
+		err = device_browse_sdp(device, msg);
 	else
-		err = device_browse_gatt(device, NULL);
+		err = device_browse_gatt(device, msg);
 
 	if (err == 0 && device->discov_timer) {
 		timeout_remove(device->discov_timer);
@@ -6353,15 +6351,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		DBG("Proceeding with service discovery");
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
-		if (device->discov_timer) {
-			timeout_remove(device->discov_timer);
-			device->discov_timer = 0;
-		}
-
-		if (bdaddr_type == BDADDR_BREDR)
-			device_browse_sdp(device, bonding->msg);
-		else
-			device_browse_gatt(device, bonding->msg);
+		device_discover_services(device, bdaddr_type, bonding->msg);
 
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
diff --git a/src/device.h b/src/device.h
index 3252e14ef..0393478df 100644
--- a/src/device.h
+++ b/src/device.h
@@ -176,7 +176,8 @@ bool device_remove_svc_complete_callback(struct btd_device *dev,
 struct btd_service *btd_device_get_service(struct btd_device *dev,
 						const char *remote_uuid);
 
-int device_discover_services(struct btd_device *device);
+int device_discover_services(struct btd_device *device,
+						uint8_t bdaddr_type, DBusMessage *msg);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
 uint32_t btd_device_get_current_flags(struct btd_device *dev);
-- 
2.34.1

