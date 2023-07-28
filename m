Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCCFC001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjG1FcA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjG1Fb6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:31:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59DF3580
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bed101b70so43951866b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522316; x=1691127116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2IxCT8vJ1aWH/MtmgyRtIThU0CLjE0BMARfQcpenh0=;
        b=u+BXY+sQfSekC8fkizp1jKP8hIFDqskvlOzziRYARxK0cphl+mzyyca8OAurwP8Gr3
         ZLE9oLHsAmHSiE696Ywqr48jTW4M58lieHbgoSxaJPm/67Tx0OgHfvubjtFZALx4nvz4
         Tn8VjwoW7J7Bw+z4r3HQdhEv50gEgMLwT2OBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522316; x=1691127116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2IxCT8vJ1aWH/MtmgyRtIThU0CLjE0BMARfQcpenh0=;
        b=HvXJaXHvtKMqGKEmz7WSovdhfI5ooLYQxEFB4FxW8GHXlro07zEUFqY9K8FBy+lt/g
         xmuFDqtryqv9zlIf4XDFW5ZFsMR2ErC+FTwQYagiAp+puDmhCU5nT7rcI+XM4VXhE6gz
         xheA1Vl3Y+qWEcrMLJKKSYxJsL2twdXYj95pH3o95oswzXZuWZx2MuaRrbmeIGoSZ3ee
         l2Y8V+JaGQdOP6WkewCjIcXc/grq81/muGlfjjzXpPLJZqPJUvaH9sjOh73v4yWhBMOe
         juUfIPhj/1Fsg36fKbGM1J0/xwgltZ+GysOOoj8dVCxI/19g5bcXEkVjo0Z+atwoVtgX
         9YUQ==
X-Gm-Message-State: ABy/qLaeZRLePyIllzAuKP5MTiuusgB75m61hz+vo0FN8kmjnVbbI4zz
        ZwtPN1w3nY1CKrxTDMCHDOi9b4E+r76emOrfQ1s=
X-Google-Smtp-Source: APBJJlHW4B6VyGe/eMZfmQuVbUbm2aFT7Nfqn0ekVOjQ8XYgvQolbAmIlhOeWkDGDFz46VnRKbVZEw==
X-Received: by 2002:a17:906:209:b0:99b:d168:41e5 with SMTP id 9-20020a170906020900b0099bd16841e5mr1285286ejd.54.1690522315893;
        Thu, 27 Jul 2023 22:31:55 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:55 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/5] device: Refactor device_discover_services function
Date:   Fri, 28 Jul 2023 07:31:49 +0200
Message-Id: <20230728053153.584222-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
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
index 2679d4302..b77d90c7b 100644
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

