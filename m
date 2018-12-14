Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F534C43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917922080F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbeLNWsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:48:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:9378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbeLNWsN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 17:48:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 14:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="100809940"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2018 14:48:12 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ 03/30] mesh: Utilities for DBus support
Date:   Fri, 14 Dec 2018 14:47:26 -0800
Message-Id: <20181214224753.2892-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181214224753.2892-1-brian.gix@intel.com>
References: <20181214224753.2892-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/dbus.c | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/dbus.h |  40 ++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 mesh/dbus.c
 create mode 100644 mesh/dbus.h

diff --git a/mesh/dbus.c b/mesh/dbus.c
new file mode 100644
index 000000000..a8b398f9e
--- /dev/null
+++ b/mesh/dbus.c
@@ -0,0 +1,181 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <time.h>
+#include <ell/ell.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "src/shared/mgmt.h"
+
+#include "mesh/mesh-defs.h"
+#include "mesh/mesh-io.h"
+#include "mesh/node.h"
+#include "mesh/net.h"
+#include "mesh/storage.h"
+#include "mesh/cfgmod.h"
+#include "mesh/model.h"
+#include "mesh/mesh.h"
+#include "mesh/error.h"
+#include "mesh/dbus.h"
+
+struct l_dbus *dbus;
+
+struct error_entry {
+	const char *dbus_err;
+	const char *default_desc;
+};
+
+/*
+ * Important: The entries in this table are ordered to enum
+ * values in mesh_error_t (error.h)
+ */
+static struct error_entry error_table[] =
+{
+	{ NULL, NULL },
+	{ ERROR_INTERFACE ".Failed", "Operation failed" },
+	{ ERROR_INTERFACE ".NotAuthorized", "Permission denied"},
+	{ ERROR_INTERFACE ".NotFound", "Object not found"},
+	{ ERROR_INTERFACE ".InvalidArgs", "Invalid arguments"},
+	{ ERROR_INTERFACE ".InProgress", "Already in progress"},
+	{ ERROR_INTERFACE ".AlreadyExists", "Already exists"},
+	{ ERROR_INTERFACE ".DoesNotExist", "Does not exist"},
+	{ ERROR_INTERFACE ".Canceled", "Operation canceled"}
+};
+
+struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
+							const char *description)
+{
+	int array_len = L_ARRAY_SIZE(error_table);
+
+	/* Default to ".Failed" */
+	if (!err || err >= array_len)
+		err = MESH_ERROR_FAILED;
+
+	if (description)
+		return l_dbus_message_new_error(msg,
+				error_table[err].dbus_err,
+				"%s", description);
+	else
+		return l_dbus_message_new_error(msg,
+				error_table[err].dbus_err,
+				"%s", error_table[err].default_desc);
+}
+
+struct l_dbus *dbus_get_bus(void)
+{
+	return dbus;
+}
+
+uint32_t dbus_get_byte_array(struct l_dbus_message_iter *array, uint8_t *buf,
+							uint32_t max_len)
+{
+	uint32_t i;
+
+	for (i = 0; i < max_len; i++) {
+		if (!l_dbus_message_iter_next_entry(array, buf + i))
+			break;
+	}
+
+	return i;
+}
+
+uint32_t dbus_disconnect_watch_add(struct l_dbus *dbus, const char *name,
+					l_dbus_watch_func_t callback,
+					void *user_data)
+{
+	return l_dbus_add_signal_watch(dbus, "org.freedesktop.DBus",
+				"/org/freedesktop/DBus",
+				L_DBUS_INTERFACE_DBUS, "NameOwnerChanged",
+				L_DBUS_MATCH_ARGUMENT(0), name,
+				L_DBUS_MATCH_NONE,
+				callback, user_data);
+}
+
+bool dbus_disconnect_watch_remove(struct l_dbus *dbus, uint32_t id)
+{
+	return l_dbus_remove_signal_watch(dbus, id);
+}
+
+bool dbus_init(struct l_dbus *bus)
+{
+	/* Network interface */
+	if (!mesh_dbus_init(bus))
+		return false;
+
+	/* Node interface */
+	if (!node_dbus_init(bus))
+		return false;
+
+	dbus = bus;
+
+	return true;
+}
+
+bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
+							const char *match)
+{
+	const char *interface;
+	struct l_dbus_message_iter properties;
+
+	while (l_dbus_message_iter_next_entry(interfaces, &interface,
+								&properties)) {
+		if (!strcmp(match, interface))
+			return true;
+	}
+
+	return false;
+}
+
+bool dbus_append_byte_array(struct l_dbus_message_builder *builder,
+						const uint8_t *data, int len)
+{
+	int i;
+
+	if (!l_dbus_message_builder_enter_array(builder, "y"))
+		return false;
+
+	for (i = 0; i < len; i++)
+		if (!l_dbus_message_builder_append_basic(builder, 'y',
+				data + i))
+			return false;
+
+	if (!l_dbus_message_builder_leave_array(builder))
+		return false;
+
+	return true;
+}
+
+void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
+					const char *key, const char *signature,
+					const void *data)
+{
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, signature);
+	l_dbus_message_builder_append_basic(builder, signature[0], data);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
diff --git a/mesh/dbus.h b/mesh/dbus.h
new file mode 100644
index 000000000..90cbe9e5c
--- /dev/null
+++ b/mesh/dbus.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *
+ */
+
+#define BLUEZ_MESH_PATH "/org/bluez/mesh"
+#define BLUEZ_MESH_SERVICE "org.bluez.mesh"
+
+bool dbus_init(struct l_dbus *dbus);
+struct l_dbus *dbus_get_bus(void);
+uint32_t dbus_disconnect_watch_add(struct l_dbus *dbus, const char *name,
+					l_dbus_watch_func_t callback,
+					void *user_data);
+bool dbus_disconnect_watch_remove(struct l_dbus *dbus, uint32_t id);
+uint32_t dbus_get_byte_array(struct l_dbus_message_iter *array, uint8_t *buf,
+							uint32_t max_len);
+bool dbus_append_byte_array(struct l_dbus_message_builder *builder,
+						const uint8_t *data, int len);
+void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
+					const char *key, const char *signature,
+					const void *data);
+bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
+							const char *match);
+struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
+						const char *description);
-- 
2.14.5

