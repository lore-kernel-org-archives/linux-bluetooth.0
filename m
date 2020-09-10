Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95244C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6C2075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXiTUIaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgIJEgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIJEgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:36:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA6C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:36:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g29so3582161pgl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLi61UtegLxZoRPn4T9W5e3L/HqdjAdjheNWCNy6w+M=;
        b=gXiTUIaNvECszPA0axiTD/Ygvahp9PvRXjW6IzWyozubqI72bwXJa3r8+40Hi4lZU2
         OR9PXo/SWrt83UyMAANKCN/KTq/e0ARItO1nOFskJbuHM8EGhHivoRQKxQR0c709QW73
         cIz6Uj4LYvS5T/9+bentuw7SKVo2318TyY4GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLi61UtegLxZoRPn4T9W5e3L/HqdjAdjheNWCNy6w+M=;
        b=CafiI0ZcglnMhjFA+Lxru69Z+yKpAuiNr9lV/Zu6gRhqdgXvT1T4RpvkWOl9+YuieR
         LoJ248p/z6nsi/9YWRhCBfyHbbvuxBipJMVz3f4x1QycrtjqvqGS3Suw4kXUAwZLGuZa
         rEC+ObGKfgChhpIsiqIOYza4xfPv5Uz7RemFfy5cmDGUeK87e8V53lYFdk97kglX+3QC
         d03m8YTLdNTbJ+UeJSuwpIrqgqCHhIcJ2GaH8vhZCyBFTuXnthaeT+2+Tw/ayMzI7JhE
         cD5xRgt6wSJJG2RU9VxHtuEVTiTeB9UKcaJ/ddkkxm4Lp+RCaRy3UD6AIlhNPumkWeAf
         EKhw==
X-Gm-Message-State: AOAM533cMs1RyR4cMR1vCVbDurcRfb3HNXW2elHWNTawC7Ly8vdfGmMR
        BW0LrM/ygawdKfyJhRqzmyRDBHj1lkrlfw==
X-Google-Smtp-Source: ABdhPJwHFrvxsHABu6Z3KByav3ToikQr89a3seZRE8YHFDSaxPPMh+WPVvJxkKhkYZF7VYtoey4TEw==
X-Received: by 2002:a62:e40a:0:b029:138:8fd6:7fd5 with SMTP id r10-20020a62e40a0000b02901388fd67fd5mr3754452pfh.1.1599712605364;
        Wed, 09 Sep 2020 21:36:45 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y4sm4149820pfq.215.2020.09.09.21.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:36:44 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 2/7] PRE-UPSTREAM: adv_monitor: Implement Get functions of Adv monitor manager properties
Date:   Wed,  9 Sep 2020 21:35:34 -0700
Message-Id: <20200909213423.BlueZ.v2.2.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the Get functions of SupportedMonitorTypes and
SupportedFeatures.

The following test was performed.
- Issue dbus-send to read SupportedMonitorTypes and SupportedFeatures.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 128 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 8e7dad8dd..54e67bf2c 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -28,6 +28,9 @@
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
 #include "adapter.h"
 #include "dbus-common.h"
 #include "log.h"
@@ -43,6 +46,12 @@ struct btd_adv_monitor_manager {
 	struct mgmt *mgmt;
 	uint16_t adapter_id;
 	char *path;
+
+	uint32_t supported_features;	/* MGMT_ADV_MONITOR_FEATURE_MASK_* */
+	uint32_t enabled_features;	/* MGMT_ADV_MONITOR_FEATURE_MASK_* */
+	uint16_t max_num_monitors;
+	uint8_t max_num_patterns;
+
 };
 
 static const GDBusMethodTable adv_monitor_methods[] = {
@@ -55,10 +64,78 @@ static const GDBusMethodTable adv_monitor_methods[] = {
 	{ }
 };
 
+enum monitor_type {
+	MONITOR_TYPE_OR_PATTERNS,
+};
+
+const struct adv_monitor_type {
+	enum monitor_type type;
+	const char *name;
+} supported_types[] = {
+	{ MONITOR_TYPE_OR_PATTERNS, "or_patterns" },
+	{ },
+};
+
+/* Gets SupportedMonitorTypes property */
+static gboolean get_supported_monitor_types(const GDBusPropertyTable *property,
+						DBusMessageIter *iter,
+						void *data)
+{
+	DBusMessageIter entry;
+	const struct adv_monitor_type *t;
+	struct btd_adv_monitor_manager *manager = data;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING,
+						&entry);
+
+	for (t = supported_types; t->name; t++) {
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&t->name);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+const struct adv_monitor_feature {
+	uint32_t mask;
+	const char *name;
+} supported_features[] = {
+	{ MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS, "controller-patterns" },
+	{ }
+};
+
+/* Gets SupportedFeatures property */
+static gboolean get_supported_features(const GDBusPropertyTable *property,
+						DBusMessageIter *iter,
+						void *data)
+{
+	DBusMessageIter entry;
+	const struct adv_monitor_feature *f;
+	struct btd_adv_monitor_manager *manager = data;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING,
+						&entry);
+
+	for (f = supported_features; f->name; f++) {
+		if (manager->supported_features & f->mask) {
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&f->name);
+		}
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable adv_monitor_properties[] = {
-	{"SupportedMonitorTypes", "as", NULL, NULL, NULL,
+	{"SupportedMonitorTypes", "as", get_supported_monitor_types, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
-	{"SupportedFeatures", "as", NULL, NULL, NULL},
+	{"SupportedFeatures", "as", get_supported_features, NULL, NULL},
 	{ }
 };
 
@@ -106,6 +183,42 @@ static void manager_destroy(struct btd_adv_monitor_manager *manager)
 	manager_free(manager);
 }
 
+/* Initiates manager's members based on the return of
+ * MGMT_OP_READ_ADV_MONITOR_FEATURES
+ */
+static void read_adv_monitor_features_cb(uint8_t status, uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	const struct mgmt_rp_read_adv_monitor_features *rp = param;
+	struct btd_adv_monitor_manager *manager = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS || !param) {
+		btd_error(manager->adapter_id, "Failed to Read Adv Monitor "
+				"Features with status 0x%02x", status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(manager->adapter_id,
+				"Wrong size of Read Adv Monitor Features "
+				"response");
+		return;
+	}
+
+	manager->supported_features = le32_to_cpu(rp->supported_features);
+	manager->enabled_features = le32_to_cpu(rp->enabled_features);
+	manager->max_num_monitors = le16_to_cpu(rp->max_num_handles);
+	manager->max_num_patterns = rp->max_num_patterns;
+
+	btd_info(manager->adapter_id, "Adv Monitor Manager created with "
+			"supported features:0x%08x, enabled features:0x%08x, "
+			"max number of supported monitors:%d, "
+			"max number of supported patterns:%d",
+			manager->supported_features, manager->enabled_features,
+			manager->max_num_monitors, manager->max_num_patterns);
+}
+
 /* Creates a manager and registers its D-Bus interface */
 struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 						struct btd_adapter *adapter,
@@ -129,9 +242,14 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 		return NULL;
 	}
 
-	btd_info(manager->adapter_id,
-			"Adv Monitor Manager created for adapter %s",
-			adapter_get_path(manager->adapter));
+	if (!mgmt_send(manager->mgmt, MGMT_OP_READ_ADV_MONITOR_FEATURES,
+			manager->adapter_id, 0, NULL,
+			read_adv_monitor_features_cb, manager, NULL)) {
+		btd_error(manager->adapter_id,
+				"Failed to send Read Adv Monitor Features");
+		manager_destroy(manager);
+		return NULL;
+	}
 
 	return manager;
 }
-- 
2.26.2

