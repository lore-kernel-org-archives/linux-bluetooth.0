Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE2C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633FB20786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sx1sJ4D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHRW2V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRW2T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:28:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE9C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:28:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt12so185013pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKJ+f/QmyMYNU6dao3M/rrJbJatyE8JsrAuSYL+1TOQ=;
        b=Sx1sJ4D/Jj+OxwB14Esl7d7y4DFtoFs/Dqdf9infowX8dkY6nEsM+egVf5HAH2vw2v
         aV46lwbw5fJQIdF+U9g1LWjCIT9eY/m5+TjTnwXX5ZaX8EeDjGaXqXAbVrZtnx+AvmDM
         usHMbCC/r7oQX5PZiB+TkrHoL2ofLksjtw3GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKJ+f/QmyMYNU6dao3M/rrJbJatyE8JsrAuSYL+1TOQ=;
        b=DLHp0iPXgIORaEN2cH8aOGY+yxYQYEb8Ba8X9N8bSILQJ7Fd0p2/yaWQGpBMRsROet
         syY/pNrDxUsCgbg4+HRIuEL46VUWJDYBCtUXRGGVT5FzlxjOFKKPy3C6jWw0c07bCfAO
         HTAj4dMwQoufVQ2mfI+U7J2z74aP8Kdo6HpAJyd0GyCfXikdKM+F2kBJMDUpQ+rtxq4n
         3qBeh3qO0Ol7+y+O08tj10YVBmiHAVhPVdifKo7vGywrxyr8xLUzvSyrzeP/bjSoLFEZ
         jUfH5jvVjxHueKKw/5Vtge1C1Jsf3p8ppr1Csx302RmGDpKqxo6Q0bB9nARU73iFVtGT
         3QPw==
X-Gm-Message-State: AOAM531KThShjQDxW/bvWS6bWQ+lISjw8BCVjX1/hJWsmra/7NV+MBv/
        PU2Mi+lFOyuSh0YtMQkjUH7EHR4rz414mQ==
X-Google-Smtp-Source: ABdhPJzkH+85uFFfO7XW7FzfEsmR/amlr1Dbh1aDkPzdkKTJ61ghfRYbiuHqdGExKzQ+P82lxYGKsA==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr1780184pjb.64.1597789698910;
        Tue, 18 Aug 2020 15:28:18 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id mp3sm14137286pjb.0.2020.08.18.15.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:28:18 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v1 2/7] adv_monitor: Implement Get functions of ADV monitor manager properties
Date:   Tue, 18 Aug 2020 15:26:37 -0700
Message-Id: <20200818152612.BlueZ.v1.2.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

 src/adv_monitor.c | 130 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 7044d3cca..4d02237e8 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -28,10 +28,14 @@
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
 #include "adapter.h"
 #include "dbus-common.h"
 #include "log.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
 
 #include "adv_monitor.h"
 
@@ -42,6 +46,12 @@ struct btd_adv_monitor_manager {
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
@@ -54,9 +64,78 @@ static const GDBusMethodTable adv_monitor_methods[] = {
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
-	{"SupportedMonitorTypes", "as", NULL, NULL, NULL},
-	{"SupportedFeatures", "as", NULL, NULL, NULL},
+	{"SupportedMonitorTypes", "as", get_supported_monitor_types, NULL,
+									NULL},
+	{"SupportedFeatures", "as", get_supported_features, NULL, NULL},
 	{ }
 };
 
@@ -107,6 +186,42 @@ static void manager_destroy(struct btd_adv_monitor_manager *manager)
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
@@ -130,9 +245,14 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
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

