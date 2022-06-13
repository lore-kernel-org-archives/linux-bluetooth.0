Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A5FC43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiFMXel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiFMXeg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 19:34:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579E7326FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:34:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d13so6344385plh.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/msugjDXCR2JcbdU30lPMalv5JtW0EsxUeVgX8tsjEE=;
        b=pT1LIiGQe257sR3V/TXrU6VNPvDFyNL+nl8rEu2M19dY3NRNSLeqr2oOqoKzNU8QRD
         xMKttV7y9+5qUgjINY288rJxF7fyeyOF4LKkrL6OwC16buwmeBmjqApgFPPt64nz84ZH
         iqzKniDRTcL4KNzOqqcDxdSTiHfAcvKA2oufZDBeRK//KuKqUvYEh4Wc4FUVDEXhEhpm
         Z8wdMr7dpRaZ8BcsCNUknuYonOItPQexqKRh2gYHOVuU2m6HOH1W0UHIB8ZCSLOpCCgY
         1YalUgI8HpiOoTEeQwaDILmWnqRU0sYgxfJSdx9xKEAQ3bCf4MWGp1sKxc3LNrVQHkvI
         ZHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/msugjDXCR2JcbdU30lPMalv5JtW0EsxUeVgX8tsjEE=;
        b=wgV5aQ+0Zx3Bj17rC+lxafyHrSLCKFPlIYG5gAZyA9bUTfML107vu+dCgqo76yOLVR
         Fteh0UVPDkD0UayfuLN55mgHIj6dFsshFJy3Ugt0B6JRrOANjIjvToUsG41T9E/ik5J7
         2tDqm2Z49WXnxtFArW9NGyM1z+wHXxExTlmztdmL8voytlYs+yKshFPQds6z3ccBAwlr
         oyYQr0VUusW6mMEvgYUISC5bihIX2syVganrMFdXvfhtbib/03ETn01ClAR5LYIsjr+o
         viOcFbYqw3jiFqtBMPCmck9hOJ5JIW05/31BaQj7ApMRRWjLi/znlU7MekOTThIrRPXA
         YP+g==
X-Gm-Message-State: AJIora9giHcJGdXYdiMUyehmcd+ovu/INRc2bcCclEAL2jmOR5z+DzEe
        lFKCW8yLF7R01dvnYI1301YQwGA3zfM=
X-Google-Smtp-Source: AGRyM1u4dHxFcwqOEnreyY418zkQiPRvdUfX6YonxvrsYtnyRg5iMLU9ImJH7MTddqwSKWqdbLPHOg==
X-Received: by 2002:a17:902:eb85:b0:168:b028:573b with SMTP id q5-20020a170902eb8500b00168b028573bmr1680935plg.158.1655163262875;
        Mon, 13 Jun 2022 16:34:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b00163ffe73300sm5691017plj.137.2022.06.13.16.34.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:34:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Add connectable flag to bearer state
Date:   Mon, 13 Jun 2022 16:34:18 -0700
Message-Id: <20220613233419.177421-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds connectable flag to state so it can be used to detect which is
the last seen connectable bearer.
---
 src/adapter.c |  6 +++---
 src/device.c  | 41 +++++++++++++++++++++++------------------
 src/device.h  |  3 ++-
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a75dd61bf..aeef6b7a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3484,7 +3484,7 @@ static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	/* continue with service discovery and connection */
 	btd_device_set_temporary(device, false);
-	device_update_last_seen(device, data->dst_type);
+	device_update_last_seen(device, data->dst_type, true);
 
 	if (data->dst_type != BDADDR_BREDR){
 		g_io_channel_set_close_on_unref(io, FALSE);
@@ -6994,7 +6994,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_update_last_seen(dev, bdaddr_type);
+	device_update_last_seen(dev, bdaddr_type, !not_connectable);
 
 	/*
 	 * FIXME: We need to check for non-zero flags first because
@@ -7006,7 +7006,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 					!(eir_data.flags & EIR_BREDR_UNSUP)) {
 		device_set_bredr_support(dev);
 		/* Update last seen for BR/EDR in case its flag is set */
-		device_update_last_seen(dev, BDADDR_BREDR);
+		device_update_last_seen(dev, BDADDR_BREDR, !not_connectable);
 	}
 
 	if (eir_data.name != NULL && eir_data.name_complete)
diff --git a/src/device.c b/src/device.c
index 3da09578f..7b451e458 100644
--- a/src/device.c
+++ b/src/device.c
@@ -155,6 +155,8 @@ struct bearer_state {
 	bool connected;
 	bool svc_resolved;
 	bool initiator;
+	bool connectable;
+	time_t last_seen;
 };
 
 struct csrk_info {
@@ -255,9 +257,6 @@ struct btd_device {
 
 	sdp_list_t	*tmp_records;
 
-	time_t		bredr_seen;
-	time_t		le_seen;
-
 	gboolean	trusted;
 	gboolean	blocked;
 	gboolean	auto_connect;
@@ -2273,14 +2272,14 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	if (dev->bdaddr_type == BDADDR_LE_RANDOM)
 		return dev->bdaddr_type;
 
-	if (dev->bredr_seen) {
-		bredr_last = current - dev->bredr_seen;
+	if (dev->bredr_state.last_seen) {
+		bredr_last = current - dev->bredr_state.last_seen;
 		if (bredr_last > SEEN_TRESHHOLD)
 			bredr_last = NVAL_TIME;
 	}
 
-	if (dev->le_seen) {
-		le_last = current - dev->le_seen;
+	if (dev->le_state.last_seen) {
+		le_last = current - dev->le_state.last_seen;
 		if (le_last > SEEN_TRESHHOLD)
 			le_last = NVAL_TIME;
 	}
@@ -3022,7 +3021,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 
-	device_update_last_seen(dev, bdaddr_type);
+	device_update_last_seen(dev, bdaddr_type, true);
 
 	if (state->connected) {
 		char addr[18];
@@ -3151,7 +3150,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
-	device_update_last_seen(device, bdaddr_type);
+	device_update_last_seen(device, bdaddr_type, true);
 
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;
@@ -4168,7 +4167,7 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 
 void device_set_bredr_support(struct btd_device *device)
 {
-	if (device->bredr)
+	if (btd_opts.mode == BT_MODE_LE || device->bredr)
 		return;
 
 	device->bredr = true;
@@ -4177,7 +4176,7 @@ void device_set_bredr_support(struct btd_device *device)
 
 void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 {
-	if (device->le)
+	if (btd_opts.mode == BT_MODE_BREDR || device->le)
 		return;
 
 	device->le = true;
@@ -4186,12 +4185,15 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	store_device_info(device);
 }
 
-void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
+void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
+							bool connectable)
 {
-	if (bdaddr_type == BDADDR_BREDR)
-		device->bredr_seen = time(NULL);
-	else
-		device->le_seen = time(NULL);
+	struct bearer_state *state;
+
+	state = get_state(device, bdaddr_type);
+
+	state->last_seen = time(NULL);
+	state->connectable = connectable;
 
 	if (!device_is_temporary(device))
 		return;
@@ -5902,14 +5904,17 @@ void device_set_flags(struct btd_device *device, uint8_t flags)
 
 bool device_is_connectable(struct btd_device *device)
 {
+	struct bearer_state *state;
+
 	if (!device)
 		return false;
 
 	if (device->bredr)
 		return true;
 
-	/* Check if either Limited or General discoverable are set */
-	return (device->ad_flags[0] & 0x03);
+	state = get_state(device, device->bdaddr_type);
+
+	return state->connectable;
 }
 
 static bool start_discovery(gpointer user_data)
diff --git a/src/device.h b/src/device.h
index 5e8d1c3e1..1bf7b3989 100644
--- a/src/device.h
+++ b/src/device.h
@@ -33,7 +33,8 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
 void device_set_bredr_support(struct btd_device *device);
 void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
-void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type);
+void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
+							bool last_seen);
 void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup);
 uint32_t btd_device_get_class(struct btd_device *device);
 uint16_t btd_device_get_vendor(struct btd_device *device);
-- 
2.35.3

