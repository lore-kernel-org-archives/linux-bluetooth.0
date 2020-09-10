Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6399C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A1C20809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mNCcUETr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIJEmU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEmQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:42:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37125C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:42:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v15so3570420pgh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLi61UtegLxZoRPn4T9W5e3L/HqdjAdjheNWCNy6w+M=;
        b=mNCcUETrSu4J2M5L+AAySz4MvYfQY3feIqA4hLyjHt/wbAGoX2kVRZUnWIZbfN5HHz
         935JdnQDDEmWcS70AtOEwDqb+gZs0FJxIAd3ONu7hfkO+l9fzxKNKywh922FFsVclJHj
         h4VpUSDZqgg65RAXmljutzZpD/OJ7bMn52TJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLi61UtegLxZoRPn4T9W5e3L/HqdjAdjheNWCNy6w+M=;
        b=Q6sbdAGG45uWRqKkpoIrK5q2mElX/M4lzvNk+QgOqhGR2fiSjd+9nT4ixd9tQIkfuy
         cchVxVHkLSrXHmSCU2J1OIJHB9v9GlO84PaE75tdOPfPwRXG76VIj9L/4my0TgGg3qB3
         pgJlreiFOH5T9y5QFkkmFVJjNbBUf5++EJXrF7S9rG5MTmLXTGC1IVDcFvZEnJtAlzi2
         2jxdv1hdY2CGUdAXqYiZ7Nh1ksRlnICLG+gY35hpP+vq1BqXNmCdOMjBmauw5QuDi856
         9MbbZuJ6L+HEWXteOOqJwYz6g1biVMUNNsoho8GokR0sbHJTstGuXOGAr+p2yZ6/AmwY
         iinA==
X-Gm-Message-State: AOAM530PldC6nJTGxLVNwUrItHTFu1Vs4H6zn2L3YUVImiY51WEEsM31
        +S2jOwXIgah/DW1K8ycA6d2KW2Fu9PaV/g==
X-Google-Smtp-Source: ABdhPJxy/HuhFeimU+UuLjQ03fU2cdPjG6RTwnDDlWyrsaWZ5LGfbCUYy3nXsczIxHMLzizes3jAUA==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr3708258pfk.32.1599712935382;
        Wed, 09 Sep 2020 21:42:15 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k4sm644888pjl.10.2020.09.09.21.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:42:14 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 2/7] adv_monitor: Implement Get functions of Adv monitor manager properties
Date:   Wed,  9 Sep 2020 21:41:26 -0700
Message-Id: <20200909214058.BlueZ.v3.2.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

