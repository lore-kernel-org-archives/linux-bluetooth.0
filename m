Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB4C43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B26E21734
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQEJlcx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgILGwW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgILGwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:52:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC8C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk9so2732963pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIsvcCCe4eEzn40v5J1tH5z/WLp46x3UEfdIUBIffwU=;
        b=iQEJlcx0UPQ/rre2YHa6Cz+hUs97ueji945vqIfBLQXxlJmWR+ugRTQKaccbjUfTrC
         xU0n50oI6wBCldbIm7dvvK/7TM1OfMxc7jfwuMxYmC0qmlI7J/z4/TPAnuaw0W0L+wcN
         m4D4lYGXNU60LM+neAKxHsewJsnwQx0Opsbgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIsvcCCe4eEzn40v5J1tH5z/WLp46x3UEfdIUBIffwU=;
        b=bjjdLMyO03B05C5Pf/O9DVrv9/0+oP+ArSJ/bO5XmbHFyPn8mw1E7sZR6JlHS8Fevr
         0Wbv/mgAWf/SzqkNuZF+czbA+9tvT7689DXpk3/c6Zk3Vp/1m/R0i5oWEnImLx8WBexK
         HCpR0G0oQiuCOWGtvhmnuSGYkbj5kZrDew4rdj+6ffESXVPvBQHKEKtTGpQ+VGH6JXoD
         zOPqP/CDfJcEhpeCmMqGPhnJZsx8z2pzueDgsvuNVKoxAqQYuaNm4gDCnJi5I6TtGe3q
         K4FIlOtHa26744N9wAv9QRH1AL1TD6yasAL0EHJ3POlTWlkiignFezF3G8ZTBTJyQOhj
         gDEw==
X-Gm-Message-State: AOAM533nB6lLxH/Jl/Yxo4OW5hqtV4LtW4d/5qecSnBY3ffTNXLX1KgE
        qgBLFAwTWUZKjXZ9cqWmJPpPBZEEng+n2g==
X-Google-Smtp-Source: ABdhPJz8AyHkDMKYKwekYXelrG3s6YYBVlc1p5JstlHjY3sMpgAfT/TSWT8/ZxPS0Yqes97xIYhy1Q==
X-Received: by 2002:a17:90b:1918:: with SMTP id mp24mr5246474pjb.110.1599893538347;
        Fri, 11 Sep 2020 23:52:18 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id hg16sm3440913pjb.37.2020.09.11.23.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:52:17 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 3/8] adv_monitor: Implement Get functions of Adv monitor manager properties
Date:   Fri, 11 Sep 2020 23:51:23 -0700
Message-Id: <20200911235104.BlueZ.v5.3.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
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

Changes in v5:
- Remove unused variable.

 src/adv_monitor.c | 126 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index ad3f64cbe..48aa6838d 100644
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
@@ -42,6 +45,11 @@ struct btd_adv_monitor_manager {
 	struct btd_adapter *adapter;
 	struct mgmt *mgmt;
 	uint16_t adapter_id;
+
+	uint32_t supported_features;	/* MGMT_ADV_MONITOR_FEATURE_MASK_* */
+	uint32_t enabled_features;	/* MGMT_ADV_MONITOR_FEATURE_MASK_* */
+	uint16_t max_num_monitors;
+	uint8_t max_num_patterns;
 };
 
 static const GDBusMethodTable adv_monitor_methods[] = {
@@ -54,10 +62,77 @@ static const GDBusMethodTable adv_monitor_methods[] = {
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
-	{"SupportedFeatures", "as", NULL, NULL, NULL,
+	{"SupportedFeatures", "as", get_supported_features, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ }
 };
@@ -104,6 +179,42 @@ static void manager_destroy(struct btd_adv_monitor_manager *manager)
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
@@ -128,9 +239,14 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
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

