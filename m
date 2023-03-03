Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A4C678D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCB17 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCCB14 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6666173B
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so1129601plw.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkQOloDQBql5f4S+4NOFgI3qikHTXcOuf3pdWCcDAMs=;
        b=M8T9trxhTnPdv/bOlbjwk6ILZU4UKHl9V+LIwGzaIhN7/yWbeY8gVvtmRKeMD3HLp8
         cwIdNst/OipW6P9xlSv9sYkFJO9TOdUc2VQ/+HwKBdzus2u4NejDlD+bA2UQjKVDiK8q
         IJgWxMAVfeQmkRKLchZMS/SeBRc6mr/RnAlVJhuoffRk009gxwbi28j97HJA45rpNc5h
         7HQ7fTySYB16z+hnA2Z7CRt8Y4qq1f60BD4mTWYYRaDC0LONHWFTZFA7j831fbs+uHrP
         htN1mLqRv/eDOvpVKLVjpR3IkJg3f99QHeoWYilQj8r9ygU1TKWWB0/2f2G2JeeLI7t6
         6S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkQOloDQBql5f4S+4NOFgI3qikHTXcOuf3pdWCcDAMs=;
        b=VQezkQkMnIJk+O+zTqeLSUafJVupRZPIP4+Ma+L4O+AZT1ndm1FoG3WORKEOhMGqWU
         0kkyZQ75o+bOvwM90LXrmmZ3uLLweELH74aNGWc2WSKV6pR5jAwDO9NCCqMKFeacb8C+
         26t6xmbmpUDZoF/1DX/8vloG8gMuZqzAVyud9o/RPIw6Lv3N604kURhpSwSueU4VR17a
         C8xQV5z+hqbcy+4taixA1foVYeHaJTqdhq42KTF2qzj7kIp9pwhbda3zhnEySFFa2ZdV
         r5So7oIt7Um+l4dQwIHe3ZCcLfQR2YF92YA8jxeHsvmCLaHFf+GJLO/cIix+3CXK5bHQ
         oj7A==
X-Gm-Message-State: AO0yUKWm+RnbSopxlVqzKNr4RrpFchZRl3xMD8Ti5IWZNyTSonwbvZDW
        pJZ+2/rtNJ9leBE+liTjGq8t3T+wWaU=
X-Google-Smtp-Source: AK7set/KTDsteXrdWjIxGIGUwuWX78pz1+EwH0VWWAyrvelhr5OEH5YWQMbVS0NegHcxoG59H8ah9A==
X-Received: by 2002:a17:902:ec8e:b0:19c:bcae:b45a with SMTP id x14-20020a170902ec8e00b0019cbcaeb45amr274083plg.65.1677806871859;
        Thu, 02 Mar 2023 17:27:51 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 8/9] profiles: Add initial code for csip plugin
Date:   Thu,  2 Mar 2023 17:27:41 -0800
Message-Id: <20230303012742.1386291-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

This adds initial code for csip plugin which handles Coordinated
set identification Profile and Coordinated Set Identification
Service.
---
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 profiles/audio/csip.c | 363 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 profiles/audio/csip.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 20cac384ef44..0f119e8714b7 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -131,3 +131,8 @@ if VCP
 builtin_modules += vcp
 builtin_sources += profiles/audio/vcp.c
 endif
+
+if CSIP
+builtin_modules += csip
+builtin_sources += profiles/audio/csip.c
+endif
diff --git a/configure.ac b/configure.ac
index 515cdf1461eb..6f890110f554 100644
--- a/configure.ac
+++ b/configure.ac
@@ -207,6 +207,10 @@ AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
 		[disable VCP profile]), [enable_vcp=${enableval}])
 AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
 
+AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
+		[disable CSIP profile]), [enable_csip=${enableval}])
+AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
new file mode 100644
index 000000000000..c273c02b8e76
--- /dev/null
+++ b/profiles/audio/csip.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (C) 2022 Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/csip.h"
+
+#include "btio/btio.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+#include "src/btd.h"
+
+#define CSIS_UUID_STR "00001846-0000-1000-8000-00805f9b34fb"
+
+struct csip_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_csip *csip;
+	unsigned int ready_id;
+};
+
+static struct queue *sessions;
+
+static void csip_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static struct csip_data *csip_data_new(struct btd_device *device)
+{
+	struct csip_data *data;
+
+	data = new0(struct csip_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static bool csip_ltk_read(struct bt_csip *csip, uint8_t k[16], void *user_data)
+{
+	/* TODO: Retrieve LTK using device object */
+	return false;
+}
+
+static void csip_data_add(struct csip_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_csip_set_debug(data->csip, csip_debug, NULL, NULL);
+
+	bt_csip_set_sirk(data->csip, btd_opts.csis.encrypt, btd_opts.csis.sirk,
+				btd_opts.csis.size, btd_opts.csis.rank,
+				csip_ltk_read, data);
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, data);
+
+	if (data->service)
+		btd_service_set_user_data(data->service, data);
+}
+
+static int csip_disconnect(struct btd_service *service)
+{
+	struct csip_data *data = btd_service_get_user_data(service);
+
+	bt_csip_detach(data->csip);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct csip_data *vdata = data;
+	const struct bt_csip *csip = match_data;
+
+	return vdata->csip == csip;
+}
+
+static void csip_data_free(struct csip_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_csip_set_user_data(data->csip, NULL);
+	}
+
+	bt_csip_ready_unregister(data->csip, data->ready_id);
+	bt_csip_unref(data->csip);
+	free(data);
+}
+
+static void csip_data_remove(struct csip_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	csip_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void csip_detached(struct bt_csip *csip, void *user_data)
+{
+	struct csip_data *data;
+
+	DBG("%p", csip);
+
+	data = queue_find(sessions, match_data, csip);
+	if (!data) {
+		error("Unable to find csip session");
+		return;
+	}
+
+	/* If there is a service it means there is CSIS thus we can keep
+	 * instance allocated.
+	 */
+	if (data->service)
+		return;
+
+	csip_data_remove(data);
+}
+
+static void csip_attached(struct bt_csip *csip, void *user_data)
+{
+	struct csip_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", csip);
+
+	data = queue_find(sessions, match_data, csip);
+	if (data)
+		return;
+
+	att = bt_csip_get_att(csip);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return;
+	}
+
+	data = csip_data_new(device);
+	data->csip = csip;
+
+	csip_data_add(data);
+
+}
+
+static int csip_server_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("CSIP path %s", adapter_get_path(adapter));
+
+	bt_csip_add_db(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void csip_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("CSIP remove Adapter");
+}
+
+static int csip_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct csip_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("CSIP service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_csip_attach(data->csip, client)) {
+		error("CSIP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static void csip_ready(struct bt_csip *csip, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct btd_device *device = btd_service_get_device(service);
+	uint8_t type, size, rank;
+	uint8_t k[16];
+
+	DBG("csip %p", csip);
+
+	if (!bt_csip_get_sirk(csip, &type, k, &size, &rank)) {
+		error("Unable to read SIRK");
+		return;
+	}
+
+	btd_device_add_set(device, type == BT_CSIP_SIRK_ENCRYPT ? true : false,
+								k, size, rank);
+}
+
+static int csip_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct csip_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = csip_data_new(device);
+	data->service = service;
+
+	data->csip = bt_csip_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->csip) {
+		error("Unable to create CSIP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	csip_data_add(data);
+
+	data->ready_id = bt_csip_ready_register(data->csip, csip_ready, service,
+								NULL);
+
+	bt_csip_set_user_data(data->csip, service);
+
+	return 0;
+}
+
+static void csip_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct csip_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("CSIP service not handled by profile");
+		return;
+	}
+
+	csip_data_remove(data);
+}
+
+static struct btd_profile csip_profile = {
+	.name		= "csip",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= CSIS_UUID_STR,
+
+	.device_probe	= csip_probe,
+	.device_remove	= csip_remove,
+
+	.accept		= csip_accept,
+	.disconnect	= csip_disconnect,
+
+	.adapter_probe	= csip_server_probe,
+	.adapter_remove	= csip_server_remove,
+};
+
+static unsigned int csip_id;
+
+static int csip_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&csip_profile);
+	csip_id = bt_csip_register(csip_attached, csip_detached, NULL);
+
+	return 0;
+}
+
+static void csip_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&csip_profile);
+		bt_csip_unregister(csip_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(csip, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						csip_init, csip_exit)
-- 
2.39.2

