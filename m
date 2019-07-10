Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F5C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0D720838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGJXId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:08:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:52368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJXId (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 19:08:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="186250431"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 16:08:32 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ 7/8] mesh: Implement DBus Provisioning methods
Date:   Wed, 10 Jul 2019 16:07:56 -0700
Message-Id: <20190710230757.8425-8-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190710230757.8425-1-brian.gix@intel.com>
References: <20190710230757.8425-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the Interface and Methods for:
UnprovisionedScan()
UnprovisionedScanCancel()
AddNode()
---
 mesh/manager.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 296 insertions(+), 8 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index ca3562512..2947f4a24 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -28,19 +28,202 @@
 #include "mesh/dbus.h"
 #include "mesh/error.h"
 #include "mesh/mesh.h"
+#include "mesh/mesh-io.h"
 #include "mesh/node.h"
+#include "mesh/net.h"
 #include "mesh/keyring.h"
+#include "mesh/agent.h"
+#include "mesh/provision.h"
 #include "mesh/manager.h"
 
+struct add_data{
+	struct l_dbus_message *msg;
+	struct mesh_agent *agent;
+	struct mesh_node *node;
+	uint32_t disc_watch;
+	uint16_t primary;
+	uint16_t net_idx;
+	uint8_t num_ele;
+	uint8_t uuid[16];
+};
+
+static int8_t scan_rssi;
+static uint8_t scan_uuid[16];
+static struct mesh_node *scan_node;
+static struct l_timeout *scan_timeout;
+static struct add_data *add_pending;
+
+static void scan_cancel(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_io *io;
+	struct mesh_net *net;
+
+	l_debug("scan_cancel");
+
+	if (scan_timeout)
+		l_timeout_remove(scan_timeout);
+
+	net = node_get_net(node);
+	io = mesh_net_get_io(net);
+	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_PROV_BEACON);
+	scan_node = NULL;
+	scan_timeout = NULL;
+}
+
+static void free_pending_add_call()
+{
+	if (!add_pending)
+		return;
+
+	if (add_pending->disc_watch)
+		l_dbus_remove_watch(dbus_get_bus(),
+						add_pending->disc_watch);
+
+	mesh_agent_remove(add_pending->agent);
+
+	l_free(add_pending);
+	add_pending = NULL;
+}
+
+static void prov_disc_cb(struct l_dbus *bus, void *user_data)
+{
+	if (!add_pending)
+		return;
+
+	initiator_cancel(add_pending);
+	add_pending->disc_watch = 0;
+
+	free_pending_add_call();
+}
+
+static void send_add_failed(const char *owner, const char *path,
+							uint8_t status)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message_builder *builder;
+	struct l_dbus_message *msg;
+
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_PROVISIONER_INTERFACE,
+						"AddNodeFailed");
+
+	builder = l_dbus_message_builder_new(msg);
+	dbus_append_byte_array(builder, add_pending->uuid, 16);
+	l_dbus_message_builder_append_basic(builder, 's',
+						mesh_prov_status_str(status));
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+	l_dbus_send(dbus, msg);
+
+	free_pending_add_call();
+}
+
+static bool add_cmplt(void *user_data, uint8_t status,
+					struct mesh_prov_node_info *info)
+{
+	struct add_data *pending = user_data;
+	struct mesh_node *node = pending->node;
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message_builder *builder;
+	struct l_dbus_message *msg;
+	bool result;
+
+	if (pending != add_pending)
+		return false;
+
+	if (status != PROV_ERR_SUCCESS) {
+		send_add_failed(node_get_owner(node), node_get_app_path(node),
+									status);
+		return false;
+	}
+
+	result = keyring_put_remote_dev_key(add_pending->node, info->unicast,
+						info->cnt, info->device_key);
+
+	if (!result) {
+		send_add_failed(node_get_owner(node), node_get_app_path(node),
+						PROV_ERR_CANT_ASSIGN_ADDR);
+		return false;
+	}
+
+	msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
+						node_get_app_path(node),
+						MESH_PROVISIONER_INTERFACE,
+						"AddNodeComplete");
+
+	builder = l_dbus_message_builder_new(msg);
+	dbus_append_byte_array(builder, add_pending->uuid, 16);
+	l_dbus_message_builder_append_basic(builder, 'q', &info->unicast);
+	l_dbus_message_builder_append_basic(builder, 'y', &info->cnt);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus, msg);
+
+	free_pending_add_call();
+
+	return true;
+}
+
+static void mgr_prov_data (struct l_dbus_message *reply, void *user_data)
+{
+	struct add_data *pending = user_data;
+	uint16_t net_idx;
+	uint16_t primary;
+
+	if (pending != add_pending)
+		return;
+
+	if (l_dbus_message_is_error(reply))
+		return;
+
+	if (!l_dbus_message_get_arguments(reply, "qq", &net_idx, &primary))
+		return;
+
+	add_pending->primary = primary;
+	add_pending->net_idx = net_idx;
+	initiator_prov_data(net_idx, primary, add_pending);
+}
+
+static bool add_data_get(void *user_data, uint8_t num_ele)
+{
+	struct add_data *pending = user_data;
+	struct l_dbus_message *msg;
+	struct l_dbus *dbus;
+	const char *app_path;
+	const char *sender;
+
+	if (pending != add_pending)
+		return false;
+
+	dbus = dbus_get_bus();
+	app_path = node_get_app_path(add_pending->node);
+	sender = node_get_owner(add_pending->node);
+
+	msg = l_dbus_message_new_method_call(dbus, sender, app_path,
+						MESH_PROVISIONER_INTERFACE,
+						"RequestProvData");
+
+	l_dbus_message_set_arguments(msg, "y", num_ele);
+	l_dbus_send_with_reply(dbus, msg, mgr_prov_data, add_pending, NULL);
+
+	add_pending->num_ele = num_ele;
+
+	return true;
+}
+
 static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
 	struct l_dbus_message_iter iter_uuid;
+	struct l_dbus_message *reply;
 	uint8_t *uuid;
 	uint32_t n;
 
-	l_debug("Add node request");
+	l_debug("AddNode request");
 
 	if (!l_dbus_message_get_arguments(msg, "ay", &iter_uuid))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -50,8 +233,47 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	/* Allow AddNode to cancel Scanning if from the same node */
+	if (scan_node) {
+		if (scan_node != node)
+			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+		scan_cancel(NULL, node);
+	}
+
+	/* Invoke Prov Initiator */
+
+	add_pending = l_new(struct add_data, 1);
+	memcpy(add_pending->uuid, uuid, 16);
+	add_pending->node = node;
+	add_pending->agent = node_get_agent(node);;
+
+	if (!node_is_provisioner(node) || (add_pending->agent == NULL)) {
+		l_info("Provisioner: %d", node_is_provisioner(node));
+		l_info("Agent: %p", add_pending->agent);
+		reply = dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+							"Missing Interfaces");
+		goto fail;
+	}
+
+
+	if (!initiator_start(PB_ADV, uuid, 99, 0, 60, add_pending->agent,
+				add_data_get, add_cmplt, node, add_pending)) {
+		reply = dbus_error(msg, MESH_ERROR_FAILED,
+				"Failed to start provisioning initiator");
+		goto fail;
+	}
+
+	add_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
+						node_get_owner(node),
+						prov_disc_cb, NULL, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+
+fail:
+	l_free(add_pending);
+	add_pending = NULL;
+	return reply;
 }
 
 
@@ -97,25 +319,91 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static void prov_beacon_recv(void *user_data, struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct mesh_node *node = user_data;
+	struct l_dbus_message_builder *builder;
+	struct l_dbus_message *msg;
+	struct l_dbus *dbus;
+	int16_t rssi;
+
+	if (scan_node != node || len < sizeof(scan_uuid) + 2 || data[1] != 0x00)
+		return;
+
+	if (!memcmp(data + 2, scan_uuid, sizeof(scan_uuid))) {
+		if (info->rssi <= scan_rssi)
+			return;
+	}
+
+	memcpy(scan_uuid, data + 2, sizeof(scan_uuid));
+	scan_rssi = info->rssi;
+	rssi = info->rssi;
+
+	dbus = dbus_get_bus();
+	msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
+						node_get_app_path(node),
+						MESH_PROVISIONER_INTERFACE,
+						"ScanResult");
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 'n', &rssi);
+	dbus_append_byte_array(builder, data + 2, len -2);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus, msg);
+}
+
 static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
 	uint16_t duration;
+	struct mesh_io *io;
+	struct mesh_net *net;
 
 	if (!l_dbus_message_get_arguments(msg, "q", &duration))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	if (scan_node && scan_node != node)
+		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+	if (!node_is_provisioner(node))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	if (scan_timeout)
+		l_timeout_remove(scan_timeout);
+
+	memset(scan_uuid, 0, sizeof(scan_uuid));
+	scan_rssi = -128;
+	scan_timeout = NULL;
+	net = node_get_net(node);
+	io = mesh_net_get_io(net);
+	scan_node = node;
+	mesh_io_register_recv_cb(io, MESH_IO_FILTER_PROV_BEACON,
+						prov_beacon_recv, node);
+
+	if (duration)
+		scan_timeout = l_timeout_create(duration, scan_cancel,
+								node, NULL);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	struct mesh_node *node = user_data;
+
+	if (scan_node != node)
+		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+	scan_cancel(NULL, node);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *store_new_subnet(struct mesh_node *node,
@@ -416,7 +704,7 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
-								"", "uuid");
+								"uuid");
 	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
 						"", "qyay", "", "primary",
 						"count", "dev_key");
-- 
2.14.5

