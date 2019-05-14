Return-Path: <SRS0=jb0q=TO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741CFC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB0020645
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfENWyL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 May 2019 18:54:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:22776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWyL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 May 2019 18:54:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:54:11 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.252.138.236])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2019 15:54:11 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Add skeleton for org.bluez.mesh.Management1 interface
Date:   Tue, 14 May 2019 15:54:07 -0700
Message-Id: <20190514225407.29594-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514225407.29594-1-inga.stotland@intel.com>
References: <20190514225407.29594-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds bare-bones imlementation of methods on org.bluez.mesh.Management1
interface.
---
 Makefile.mesh  |   1 +
 mesh/dbus.c    |  12 ++-
 mesh/error.h   |   1 +
 mesh/manager.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/manager.h |  20 ++++
 mesh/mesh.h    |   1 +
 6 files changed, 297 insertions(+), 4 deletions(-)
 create mode 100644 mesh/manager.c
 create mode 100644 mesh/manager.h

diff --git a/Makefile.mesh b/Makefile.mesh
index bccd4d946..d494287ab 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -24,6 +24,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/dbus.h mesh/dbus.c \
 				mesh/agent.h mesh/agent.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
+				mesh/manager.h mesh/manager.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/mesh-defs.h
diff --git a/mesh/dbus.c b/mesh/dbus.c
index 3b2e2aa81..083a7f77e 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019 Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -33,10 +33,9 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
+#include "mesh/manager.h"
 #include "mesh/net.h"
-#include "mesh/storage.h"
 #include "mesh/cfgmod.h"
-#include "mesh/model.h"
 #include "mesh/mesh.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
@@ -62,7 +61,8 @@ static struct error_entry const error_table[] =
 	{ ERROR_INTERFACE ".InProgress", "Already in progress"},
 	{ ERROR_INTERFACE ".AlreadyExists", "Already exists"},
 	{ ERROR_INTERFACE ".DoesNotExist", "Does not exist"},
-	{ ERROR_INTERFACE ".Canceled", "Operation canceled"}
+	{ ERROR_INTERFACE ".Canceled", "Operation canceled"},
+	{ ERROR_INTERFACE ".NotImplemented", "Not implemented"},
 };
 
 struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
@@ -99,6 +99,10 @@ bool dbus_init(struct l_dbus *bus)
 	if (!node_dbus_init(bus))
 		return false;
 
+	/* Management interface */
+	if (!manager_dbus_init(bus))
+		return false;
+
 	dbus = bus;
 
 	return true;
diff --git a/mesh/error.h b/mesh/error.h
index a6aaa2fef..1669c070a 100644
--- a/mesh/error.h
+++ b/mesh/error.h
@@ -31,4 +31,5 @@ enum mesh_error {
 	MESH_ERROR_ALREADY_EXISTS,
 	MESH_ERROR_DOES_NOT_EXIST,
 	MESH_ERROR_CANCELED,
+	MESH_ERROR_NOT_IMPLEMENTED,
 };
diff --git a/mesh/manager.c b/mesh/manager.c
new file mode 100644
index 000000000..d990ceec2
--- /dev/null
+++ b/mesh/manager.c
@@ -0,0 +1,266 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
+#define _GNU_SOURCE
+#include <ell/ell.h>
+
+#include "mesh/dbus.h"
+#include "mesh/error.h"
+#include "mesh/mesh.h"
+#include "mesh/manager.h"
+
+static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter_uuid;
+	uint8_t *uuid;
+	uint32_t n;
+
+	l_debug("Add node request");
+
+	if (!l_dbus_message_get_arguments(msg, "ay", &iter_uuid))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
+								|| n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device UUID");
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t primary;
+	uint8_t num_ele;
+
+	if (!l_dbus_message_get_arguments(msg, "qy", &primary, &num_ele))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t duration;
+
+	if (!l_dbus_message_get_arguments(msg, "q", &duration))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *create_subnet_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *update_subnet_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *delete_subnet_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx;
+	struct l_dbus_message_iter iter_key;
+	uint8_t *key;
+	uint32_t n;
+
+	if (!l_dbus_message_get_arguments(msg, "qay", &net_idx, &iter_key))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_key, &key, &n)
+								|| n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad network key");
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *create_appkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx, app_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *update_appkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx, app_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *delete_appkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx, app_idx;
+
+	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *import_appkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx, app_idx;
+	struct l_dbus_message_iter iter_key;
+	uint8_t *key;
+	uint32_t n;
+
+	if (!l_dbus_message_get_arguments(msg, "qqay", &net_idx, &app_idx,
+								&iter_key))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_key, &key, &n)
+								|| n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad application key");
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t net_idx;
+	uint8_t phase;
+
+	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* TODO */
+	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+}
+
+static void setup_management_interface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
+								"", "uuid");
+	l_dbus_interface_method(iface, "DeleteRemodeNode", 0, delete_node_call,
+					"", "qy", "", "primary", "count");
+	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
+							"", "q", "", "seconds");
+	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
+						cancel_scan_call, "", "");
+	l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call,
+						"", "q", "", "net_index");
+	l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call,
+						"", "q", "", "net_index");
+	l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call,
+						"", "q", "", "net_index");
+	l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call,
+					"", "qay", "", "net_index", "net_key");
+	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
+					"", "qq", "", "net_index", "app_index");
+	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
+					"", "qq", "", "net_index", "app_index");
+	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
+					"", "qq", "", "net_index", "app_index");
+	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
+				"", "qqay", "", "net_index", "app_index",
+								"app_key");
+	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call,
+					"", "qy", "", "net_index", "phase");
+}
+
+bool manager_dbus_init(struct l_dbus *bus)
+{
+	if (!l_dbus_register_interface(bus, MESH_MANAGEMENT_INTERFACE,
+						setup_management_interface,
+						NULL, false)) {
+		l_info("Unable to register %s interface",
+						MESH_MANAGEMENT_INTERFACE);
+		return false;
+	}
+
+	return true;
+}
diff --git a/mesh/manager.h b/mesh/manager.h
new file mode 100644
index 000000000..f27ca4181
--- /dev/null
+++ b/mesh/manager.h
@@ -0,0 +1,20 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
+bool manager_dbus_init(struct l_dbus *dbus);
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 9b63500d1..320a108ed 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -21,6 +21,7 @@
 
 #define MESH_NETWORK_INTERFACE "org.bluez.mesh.Network1"
 #define MESH_NODE_INTERFACE "org.bluez.mesh.Node1"
+#define MESH_MANAGEMENT_INTERFACE "org.bluez.mesh.Management1"
 #define MESH_ELEMENT_INTERFACE "org.bluez.mesh.Element1"
 #define MESH_APPLICATION_INTERFACE "org.bluez.mesh.Application1"
 #define MESH_PROVISION_AGENT_INTERFACE "org.bluez.mesh.ProvisionAgent1"
-- 
2.21.0

