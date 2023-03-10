Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B75C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCJAEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCJAEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:04:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FACE1924
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:03:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so3555950pja.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 16:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678406637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPIwv8Fsq1h1kbvlQ3Jn5Lj0Drodu9t1SN+ihF7Hbc4=;
        b=gzHpAMPF2rQPiyJj7wam+DW8I9KTtpOdVWZDTa5c9OALqjgr3F5DKw6Ug6hY5fcvcE
         Lf06LlX9x9/qKIetWfHZYGz0W31kn5Dp5X1TDEIHk8S4TYjslCgJV1+xJNtNgo8rS38d
         DqSk7i/h3bWegTD+eeEi/P+9hXUN2sPRDZ3vaERpQm3JbIH+iiy8+ihMm/nFlEJRJEX0
         +YaYIFWpH5eOxvAKl8W1q9rzOkwWCjnLqr+JQjf9YJw0tle3RFXHpTReV/gucjWYKqae
         TjAKs5NPOrFYdXZepsM2/Y/ycHpd3AjzVMRHE7GsMysFbxUrEslGEIXKXcnHFiWKSor+
         yCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPIwv8Fsq1h1kbvlQ3Jn5Lj0Drodu9t1SN+ihF7Hbc4=;
        b=5Efd/ut/d8Wygw7twaXK+dSFZI5JGhPyUiN0FHwQyt+Lg5ZqgdNK5hcx/HvB4QbRHD
         iOfzLww6tfQF7rWsJKY3+gm7tnSIAyzVm3ggbYF65U+2rHpk/rMpCiB2+OqJx/LaHbT0
         cDDQx+l+mc+h3X6jfiMjd+cAybYt0xMdKo7u5bY/6G+EJpFI6jcVL/Xbez9Vv0yrz6h3
         n24VYTCBueAfS6/PzCGE70GpL8uMRC/BRTKP3i/Sqn0eXkAE2K18KRvR4LX5HX31EEML
         aFUJ0HzCh3YSQ7HTR1a1XaOFHBJykjONlmCziRQO36yrzHqSNRV++IA3dc+dbtCGyr/W
         IbJQ==
X-Gm-Message-State: AO0yUKXRtcjVk3sNWIBvvNu06951yLU0WHYkSyOHHY++/fAE8T+wGCZ0
        xJJu/Qwbzpvg3HZNAh4m0d3ltsxuLW8=
X-Google-Smtp-Source: AK7set9eENpYZ6IaqgIbMcIzC+GK0XVgcwQcjw7GujYyjy5sqfXRKlxEEx+mqDUUqVXh/QzgKi/3uw==
X-Received: by 2002:a05:6a20:4415:b0:c7:40a1:ac1b with SMTP id ce21-20020a056a20441500b000c740a1ac1bmr27879170pzb.50.1678406637538;
        Thu, 09 Mar 2023 16:03:57 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b00593e4e6516csm137845pfe.124.2023.03.09.16.03.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:03:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Use DEFER_SETUP for EATT channels
Date:   Thu,  9 Mar 2023 16:03:54 -0800
Message-Id: <20230310000354.3404030-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310000354.3404030-1-luiz.dentz@gmail.com>
References: <20230310000354.3404030-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of DEFER_SETUP mechanism to do the following checks
before accepting the connection:

 - Checks a valid device object exits
 - Checks if initiator/central as if the peripheral start connecting it
   may cause collisions.
 - Checks if the limit of allowed connections has been reached.
---
 src/device.c        |  6 ++--
 src/device.h        |  1 +
 src/gatt-database.c | 88 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/src/device.c b/src/device.c
index 652c03606b9e..77b38e97a7ea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -310,7 +310,7 @@ static struct bearer_state *get_state(struct btd_device *dev,
 		return &dev->le_state;
 }
 
-static bool get_initiator(struct btd_device *dev)
+bool btd_device_is_initiator(struct btd_device *dev)
 {
 	if (dev->le_state.connected)
 		return dev->le_state.initiator;
@@ -3964,7 +3964,7 @@ done:
 	}
 
 	/* Notify driver about the new connection */
-	service_accept(service, get_initiator(device));
+	service_accept(service, btd_device_is_initiator(device));
 }
 
 static void device_add_gatt_services(struct btd_device *device)
@@ -3984,7 +3984,7 @@ static void device_add_gatt_services(struct btd_device *device)
 static void device_accept_gatt_profiles(struct btd_device *device)
 {
 	GSList *l;
-	bool initiator = get_initiator(device);
+	bool initiator = btd_device_is_initiator(device);
 
 	DBG("initiator %s", initiator ? "true" : "false");
 
diff --git a/src/device.h b/src/device.h
index 96347ff229cc..3252e14eff84 100644
--- a/src/device.h
+++ b/src/device.h
@@ -67,6 +67,7 @@ GSList *btd_device_get_primaries(struct btd_device *device);
 struct gatt_db *btd_device_get_gatt_db(struct btd_device *device);
 struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
 struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device);
+bool btd_device_is_initiator(struct btd_device *device);
 void *btd_device_get_attrib(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 3b53bf2a3c84..01dd84e8e3f7 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -632,7 +632,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	struct btd_device *device;
 	uint8_t dst_type;
 	bdaddr_t src, dst;
-	uint16_t cid;
 
 	if (gerr) {
 		error("%s", gerr->message);
@@ -642,7 +641,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
 						BT_IO_OPT_DEST_BDADDR, &dst,
 						BT_IO_OPT_DEST_TYPE, &dst_type,
-						BT_IO_OPT_CID, &cid,
 						BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -657,21 +655,9 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!adapter)
 		return;
 
-	/* Check cid before attempting to create device, if the device is using
-	 * an RPA it could be that the MGMT event has not been processed yet
-	 * which would lead to create a second copy of the same device using its
-	 * identity address.
-	 */
-	if (cid == BT_ATT_CID)
-		device = btd_adapter_get_device(adapter, &dst, dst_type);
-	else
-		device = btd_adapter_find_device(adapter, &dst, dst_type);
-
-	if (!device) {
-		error("Unable to find device, dropping connection attempt");
-		g_io_channel_shutdown(io, FALSE, NULL);
+	device = btd_adapter_get_device(adapter, &dst, dst_type);
+	if (!device)
 		return;
-	}
 
 	device_attach_att(device, io);
 }
@@ -3802,6 +3788,70 @@ static uint8_t server_authorize(struct bt_att *att, uint8_t opcode,
 	return BT_ATT_ERROR_DB_OUT_OF_SYNC;
 }
 
+static void eatt_confirm_cb(GIOChannel *io, gpointer data)
+{
+	char address[18];
+	uint8_t dst_type;
+	bdaddr_t src, dst;
+	GError *gerr = NULL;
+	struct btd_device *device;
+	struct bt_gatt_server *server;
+	struct bt_att *att;
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dst,
+				BT_IO_OPT_DEST_TYPE, &dst_type,
+				BT_IO_OPT_DEST, address,
+				BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+
+	DBG("New incoming EATT connection");
+
+	/* Confirm the device exists before accepting the connection, if the
+	 * device is using an RPA it could be that the MGMT event has not been
+	 * processed yet which would lead to create a second copy of the same
+	 * device using its identity address.
+	 */
+	device = btd_adapter_find_device(adapter_find(&src), &dst, dst_type);
+	if (!device) {
+		error("Unable to find device: %s", address);
+		goto drop;
+	}
+
+	/* Only allow EATT connection from central */
+	if (btd_device_is_initiator(device)) {
+		warn("EATT connection from peripheral may cause collisions");
+		goto drop;
+	}
+
+	server = btd_device_get_gatt_server(device);
+	if (!server) {
+		error("Unable to resolve bt_server");
+		goto drop;
+	}
+
+	att = bt_gatt_server_get_att(server);
+	if (bt_att_get_channels(att) == btd_opts.gatt_channels) {
+		DBG("EATT channel limit reached");
+		goto drop;
+	}
+
+	if (!bt_io_accept(io, connect_cb, NULL, NULL, &gerr)) {
+		error("bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
 struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 {
 	struct btd_gatt_database *database;
@@ -3838,14 +3888,14 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	if (btd_opts.gatt_channels == 1)
 		goto bredr;
 
-	/* EATT socket */
-	database->eatt_io = bt_io_listen(connect_cb, NULL, NULL, NULL,
+	/* EATT socket, encryption is required */
+	database->eatt_io = bt_io_listen(NULL, eatt_confirm_cb, NULL, NULL,
 					&gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_SOURCE_TYPE,
 					btd_adapter_get_address_type(adapter),
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
 	if (!database->eatt_io) {
-- 
2.39.2

