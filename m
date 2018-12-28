Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92627C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D2A21872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeL1WHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:07:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:19949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeL1WHy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968683"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:52 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 02/26] mesh: Utilities for DBus support
Date:   Fri, 28 Dec 2018 14:07:21 -0800
Message-Id: <20181228220745.25147-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

These files implement the BlueZ mesh DBus API as described
in doc/mesh-api.txt
---
 mesh/dbus.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/dbus.h |  33 +++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 mesh/dbus.c
 create mode 100644 mesh/dbus.h

diff --git a/mesh/dbus.c b/mesh/dbus.c
new file mode 100644
index 000000000..3b2e2aa81
--- /dev/null
+++ b/mesh/dbus.c
@@ -0,0 +1,151 @@
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
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <time.h>
+#include <ell/ell.h>
+#include <json-c/json.h>
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
+static struct l_dbus *dbus;
+
+struct error_entry {
+	const char *dbus_err;
+	const char *default_desc;
+};
+
+/*
+ * Important: The entries in this table follow the order of
+ * enumerated values in mesh_error (file error.h)
+ */
+static struct error_entry const error_table[] =
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
index 000000000..879649452
--- /dev/null
+++ b/mesh/dbus.h
@@ -0,0 +1,33 @@
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
+ */
+
+#define BLUEZ_MESH_PATH "/org/bluez/mesh"
+#define BLUEZ_MESH_SERVICE "org.bluez.mesh"
+
+bool dbus_init(struct l_dbus *dbus);
+struct l_dbus *dbus_get_bus(void);
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

