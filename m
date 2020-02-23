Return-Path: <SRS0=oZGl=4L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFCEC35666
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Feb 2020 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F6206E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Feb 2020 18:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBWSwO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:52:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:24069 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWSwO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Feb 2020 13:52:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 10:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,477,1574150400"; 
   d="scan'208";a="255368768"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.231.132])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2020 10:52:13 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: rework incoming advertisement filtering
Date:   Sun, 23 Feb 2020 10:52:08 -0800
Message-Id: <20200223185208.12970-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Future versions of Mesh will introduce new advertising packets, which
do not fit in the limited and rigid filtering currently used. This minor
rewrite allows registering and receiving of *any* AD types, including
the filtering on multiple octets of the incoming AD parts.
---
 mesh/manager.c         |   5 +-
 mesh/mesh-io-api.h     |  12 ++--
 mesh/mesh-io-generic.c | 139 +++++++++++++++++++++++------------------
 mesh/mesh-io.c         |  36 +++--------
 mesh/mesh-io.h         |  25 +++-----
 mesh/mesh.c            |  10 ++-
 mesh/net.c             |  13 ++--
 7 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index e4a7deaeb..0909c7e16 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -52,6 +52,7 @@ static uint8_t scan_uuid[16];
 static struct mesh_node *scan_node;
 static struct l_timeout *scan_timeout;
 static struct add_data *add_pending;
+static const uint8_t prvb[2] = {MESH_AD_TYPE_BEACON, 0x00};
 
 static void scan_cancel(struct l_timeout *timeout, void *user_data)
 {
@@ -66,7 +67,7 @@ static void scan_cancel(struct l_timeout *timeout, void *user_data)
 
 	net = node_get_net(node);
 	io = mesh_net_get_io(net);
-	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_PROV_BEACON);
+	mesh_io_deregister_recv_cb(io, prvb, sizeof(prvb));
 	scan_node = NULL;
 	scan_timeout = NULL;
 }
@@ -397,7 +398,7 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 	net = node_get_net(node);
 	io = mesh_net_get_io(net);
 	scan_node = node;
-	mesh_io_register_recv_cb(io, MESH_IO_FILTER_PROV_BEACON,
+	mesh_io_register_recv_cb(io, prvb, sizeof(prvb),
 						prov_beacon_recv, node);
 
 	if (duration)
diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 75b881800..7a5b49c60 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -26,12 +26,11 @@ typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
 					struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len);
-typedef bool (*mesh_io_register_t)(struct mesh_io *io, uint8_t filter_id,
-				mesh_io_recv_func_t cb, void *user_data);
-typedef bool (*mesh_io_deregister_t)(struct mesh_io *io, uint8_t filter_id);
-typedef bool (*mesh_io_filter_set_t)(struct mesh_io *io,
-			uint8_t filter_id, const uint8_t *data, uint8_t len,
-			mesh_io_status_func_t callback, void *user_data);
+typedef bool (*mesh_io_register_t)(struct mesh_io *io, const uint8_t *filter,
+					uint8_t len, mesh_io_recv_func_t cb,
+					void *user_data);
+typedef bool (*mesh_io_deregister_t)(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len);
 typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, const uint8_t *pattern,
 								uint8_t len);
 
@@ -42,7 +41,6 @@ struct mesh_io_api {
 	mesh_io_send_t		send;
 	mesh_io_register_t	reg;
 	mesh_io_deregister_t	dereg;
-	mesh_io_filter_set_t	set;
 	mesh_io_tx_cancel_t	cancel;
 };
 
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index b42fb4f1d..72f9d400a 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -31,6 +31,7 @@
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
+#include "mesh/mesh-defs.h"
 #include "mesh/mesh-mgmt.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
@@ -44,16 +45,17 @@ struct mesh_io_private {
 	struct l_queue *rx_regs;
 	struct l_queue *tx_pkts;
 	struct tx_pkt *tx;
-	uint8_t filters[4];
-	bool sending;
 	uint16_t index;
 	uint16_t interval;
+	bool sending;
+	bool active;
 };
 
 struct pvt_rx_reg {
-	uint8_t filter_id;
 	mesh_io_recv_func_t cb;
 	void *user_data;
+	uint8_t len;
+	uint8_t filter[0];
 };
 
 struct process_data {
@@ -97,16 +99,14 @@ static void process_rx_callbacks(void *v_rx, void *v_reg)
 {
 	struct pvt_rx_reg *rx_reg = v_rx;
 	struct process_data *rx = v_reg;
-	uint8_t ad_type;
-
-	ad_type = rx->pvt->filters[rx_reg->filter_id - 1];
+	uint8_t len = rx->len > rx_reg->len ? rx_reg->len : rx->len;
 
-	if (rx->data[0] == ad_type && rx_reg->cb)
+	if (!memcmp(rx->data, rx_reg->filter, len))
 		rx_reg->cb(rx_reg->user_data, &rx->info, rx->data, rx->len);
 }
 
 static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
-					uint32_t instant,
+					uint32_t instant, const uint8_t *addr,
 					const uint8_t *data, uint8_t len)
 {
 	struct process_data rx = {
@@ -114,6 +114,7 @@ static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
 		.data = data,
 		.len = len,
 		.info.instant = instant,
+		.info.addr = addr,
 		.info.chan = 7,
 		.info.rssi = rssi,
 	};
@@ -125,6 +126,7 @@ static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_report *evt = buf;
 	const uint8_t *adv;
+	const uint8_t *addr;
 	uint32_t instant;
 	uint8_t adv_len;
 	uint16_t len = 0;
@@ -136,6 +138,7 @@ static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
 	instant = get_instant();
 	adv = evt->data;
 	adv_len = evt->data_len;
+	addr = evt->addr;
 
 	/* rssi is just beyond last byte of data */
 	rssi = (int8_t) adv[adv_len];
@@ -154,7 +157,7 @@ static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
 			break;
 
 		/* TODO: Create an Instant to use */
-		process_rx(io->pvt, rssi, instant, adv + 1, adv[0]);
+		process_rx(io->pvt, rssi, instant, addr, adv + 1, adv[0]);
 
 		adv += field_len + 1;
 	}
@@ -371,7 +374,7 @@ static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
 	if (!pvt || !caps)
 		return false;
 
-	caps->max_num_filters = sizeof(pvt->filters);
+	caps->max_num_filters = 255;
 	caps->window_accuracy = 50;
 
 	return true;
@@ -703,12 +706,12 @@ static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 	return true;
 }
 
-static bool find_by_filter_id(const void *a, const void *b)
+static bool find_by_filter(const void *a, const void *b)
 {
 	const struct pvt_rx_reg *rx_reg = a;
-	uint8_t filter_id = L_PTR_TO_UINT(b);
+	const uint8_t *filter = b;
 
-	return rx_reg->filter_id == filter_id;
+	return !memcmp(rx_reg->filter, filter, rx_reg->len);
 }
 
 static void scan_enable_rsp(const void *buf, uint8_t size,
@@ -732,28 +735,58 @@ static void set_recv_scan_enable(const void *buf, uint8_t size,
 			&cmd, sizeof(cmd), scan_enable_rsp, pvt, NULL);
 }
 
-static bool recv_register(struct mesh_io *io, uint8_t filter_id,
-				mesh_io_recv_func_t cb, void *user_data)
+static void scan_disable_rsp(const void *buf, uint8_t size,
+							void *user_data)
 {
 	struct bt_hci_cmd_le_set_scan_parameters cmd;
+	struct mesh_io_private *pvt = user_data;
+	uint8_t status = *((uint8_t *) buf);
+
+	if (status)
+		l_error("LE Scan disable failed (0x%02x)", status);
+
+	cmd.type = pvt->active ? 0x01 : 0x00;	/* Passive/Active scanning */
+	cmd.interval = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+	cmd.window = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+	cmd.own_addr_type = 0x01;		/* ADDR_TYPE_RANDOM */
+	cmd.filter_policy = 0x00;		/* Accept all */
+
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+			&cmd, sizeof(cmd),
+			set_recv_scan_enable, pvt, NULL);
+}
+
+static bool find_active(const void *a, const void *b)
+{
+	const struct pvt_rx_reg *rx_reg = a;
+
+	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
+			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
+		return true;
+
+	return false;
+}
+
+static bool recv_register(struct mesh_io *io, const uint8_t *filter,
+			uint8_t len, mesh_io_recv_func_t cb, void *user_data)
+{
+	struct bt_hci_cmd_le_set_scan_enable cmd;
 	struct mesh_io_private *pvt = io->pvt;
 	struct pvt_rx_reg *rx_reg;
 	bool already_scanning;
+	bool active = false;
 
-	l_info("%s %d", __func__, filter_id);
-	if (!cb || !filter_id || filter_id > sizeof(pvt->filters))
+	if (!cb || !filter || !len)
 		return false;
 
-	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter_id,
-						L_UINT_TO_PTR(filter_id));
+	l_info("%s %2.2x", __func__, filter[0]);
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
 
-	if (!rx_reg) {
-		rx_reg = l_new(struct pvt_rx_reg, 1);
-		if (!rx_reg)
-			return false;
-	}
+	l_free(rx_reg);
+	rx_reg = l_malloc(sizeof(*rx_reg) + len);
 
-	rx_reg->filter_id = filter_id;
+	memcpy(rx_reg->filter, filter, len);
+	rx_reg->len = len;
 	rx_reg->cb = cb;
 	rx_reg->user_data = user_data;
 
@@ -761,62 +794,49 @@ static bool recv_register(struct mesh_io *io, uint8_t filter_id,
 
 	l_queue_push_head(pvt->rx_regs, rx_reg);
 
-	if (!already_scanning) {
-		cmd.type = 0x00;			/* Passive scanning */
-		cmd.interval = L_CPU_TO_LE16(0x0010);	/* 10 ms */
-		cmd.window = L_CPU_TO_LE16(0x0010);	/* 10 ms */
-		cmd.own_addr_type = 0x01;		/* ADDR_TYPE_RANDOM */
-		cmd.filter_policy = 0x00;		/* Accept all */
+	if (l_queue_find(pvt->rx_regs, find_active, NULL))
+		active = true;
+
+	if (!already_scanning || pvt->active != active) {
+		cmd.enable = 0x00;	/* Disable scanning */
+		cmd.filter_dup = 0x00;	/* Report duplicates */
+		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), scan_disable_rsp, pvt, NULL);
 
-		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
-				&cmd, sizeof(cmd),
-				set_recv_scan_enable, pvt, NULL);
 	}
 
 	return true;
 }
 
-static bool recv_deregister(struct mesh_io *io, uint8_t filter_id)
+static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len)
 {
-	struct bt_hci_cmd_le_set_scan_enable cmd;
+	struct bt_hci_cmd_le_set_scan_enable cmd = {0, 0};
 	struct mesh_io_private *pvt = io->pvt;
-
 	struct pvt_rx_reg *rx_reg;
+	bool active = false;
 
-	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter_id,
-						L_UINT_TO_PTR(filter_id));
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
 
 	if (rx_reg)
 		l_free(rx_reg);
 
+	if (l_queue_find(pvt->rx_regs, find_active, NULL))
+		active = true;
+
 	if (l_queue_isempty(pvt->rx_regs)) {
-		cmd.enable = 0x00;	/* Disable scanning */
-		cmd.filter_dup = 0x00;	/* Report duplicates */
 		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
-				&cmd, sizeof(cmd), NULL, NULL, NULL);
+					&cmd, sizeof(cmd), NULL, NULL, NULL);
 
+	} else if (active != pvt->active) {
+		pvt->active = active;
+		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), scan_disable_rsp, pvt, NULL);
 	}
 
 	return true;
 }
 
-static bool filter_set(struct mesh_io *io,
-		uint8_t filter_id, const uint8_t *data, uint8_t len,
-		mesh_io_status_func_t callback, void *user_data)
-{
-	struct mesh_io_private *pvt = io->pvt;
-
-	l_info("%s id: %d, --> %2.2x", __func__, filter_id, data[0]);
-	if (!data || !len || !filter_id || filter_id > sizeof(pvt->filters))
-		return false;
-
-	pvt->filters[filter_id - 1] = data[0];
-
-	/* TODO: Delayed Call to successful status */
-
-	return true;
-}
-
 const struct mesh_io_api mesh_io_generic = {
 	.init = dev_init,
 	.destroy = dev_destroy,
@@ -824,6 +844,5 @@ const struct mesh_io_api mesh_io_generic = {
 	.send = send_tx,
 	.reg = recv_register,
 	.dereg = recv_deregister,
-	.set = filter_set,
 	.cancel = tx_cancel,
 };
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 1ab173d9c..c4eaecefd 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -85,18 +85,6 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 	if (!io_list)
 		io_list = l_queue_new();
 
-	if (api->set) {
-		uint8_t pkt = MESH_AD_TYPE_NETWORK;
-		uint8_t prv = MESH_AD_TYPE_PROVISION;
-		uint8_t snb[2] = {MESH_AD_TYPE_BEACON, 0x01};
-		uint8_t prvb[2] = {MESH_AD_TYPE_BEACON, 0x00};
-
-		api->set(io, 1, snb, sizeof(snb), NULL, NULL);
-		api->set(io, 2, &prv, 1, NULL, NULL);
-		api->set(io, 3, &pkt, 1, NULL, NULL);
-		api->set(io, 4, prvb, sizeof(prvb), NULL, NULL);
-	}
-
 	if (l_queue_push_head(io_list, io))
 		return io;
 
@@ -133,35 +121,25 @@ bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps)
 	return false;
 }
 
-bool mesh_io_register_recv_cb(struct mesh_io *io, uint8_t filter_id,
-				mesh_io_recv_func_t cb, void *user_data)
+bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
+				uint8_t len, mesh_io_recv_func_t cb,
+				void *user_data)
 {
 	io = l_queue_find(io_list, match_by_io, io);
 
 	if (io && io->api && io->api->reg)
-		return io->api->reg(io, filter_id, cb, user_data);
+		return io->api->reg(io, filter, len, cb, user_data);
 
 	return false;
 }
 
-bool mesh_io_deregister_recv_cb(struct mesh_io *io, uint8_t filter_id)
+bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len)
 {
 	io = l_queue_find(io_list, match_by_io, io);
 
 	if (io && io->api && io->api->dereg)
-		return io->api->dereg(io, filter_id);
-
-	return false;
-}
-
-bool mesh_set_filter(struct mesh_io *io, uint8_t filter_id,
-				const uint8_t *data, uint8_t len,
-				mesh_io_status_func_t cb, void *user_data)
-{
-	io = l_queue_find(io_list, match_by_io, io);
-
-	if (io && io->api && io->api->set)
-		return io->api->set(io, filter_id, data, len, cb, user_data);
+		return io->api->dereg(io, filter, len);
 
 	return false;
 }
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 45ff00a3c..fc0422020 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -19,11 +19,6 @@
 
 struct mesh_io;
 
-#define MESH_IO_FILTER_BEACON		1
-#define MESH_IO_FILTER_PROV		2
-#define MESH_IO_FILTER_NET		3
-#define MESH_IO_FILTER_PROV_BEACON	4
-
 #define MESH_IO_TX_COUNT_UNLIMITED	0
 
 enum mesh_io_type {
@@ -38,6 +33,7 @@ enum mesh_io_timing_type {
 };
 
 struct mesh_io_recv_info {
+	const uint8_t *addr;
 	uint32_t instant;
 	uint8_t chan;
 	int8_t rssi;
@@ -78,26 +74,25 @@ typedef void (*mesh_io_recv_func_t)(void *user_data,
 					struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len);
 
-typedef void (*mesh_io_status_func_t)(void *user_data, int status,
-							uint8_t filter_id);
+typedef void (*mesh_io_recv_ext_func_t)(void *user_data,
+					struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len,
+					const uint8_t *addr);
 
 typedef void (*mesh_io_ready_func_t)(void *user_data, bool result);
 
-
 struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 				mesh_io_ready_func_t cb, void *user_data);
 void mesh_io_destroy(struct mesh_io *io);
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
 
-bool mesh_io_register_recv_cb(struct mesh_io *io, uint8_t filter_id,
-				mesh_io_recv_func_t cb, void *user_data);
+bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
+					uint8_t len, mesh_io_recv_func_t cb,
+					void *user_data);
 
-bool mesh_io_deregister_recv_cb(struct mesh_io *io, uint8_t filter_id);
-
-bool mesh_set_filter(struct mesh_io *io, uint8_t filter_id,
-				const uint8_t *data, uint8_t len,
-				mesh_io_status_func_t cb, void *user_data);
+bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len);
 
 bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 6d2f86b6d..247c3c9be 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -141,24 +141,28 @@ static void prov_rx(void *user_data, struct mesh_io_recv_info *info,
 
 bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data)
 {
+	uint8_t prov_filter[] = {MESH_AD_TYPE_PROVISION};
+
 	if (mesh.prov_rx && mesh.prov_rx != cb)
 		return false;
 
 	mesh.prov_rx = cb;
 	mesh.prov_data = user_data;
 
-	return mesh_io_register_recv_cb(mesh.io, MESH_IO_FILTER_PROV,
-							prov_rx, &mesh);
+	return mesh_io_register_recv_cb(mesh.io, prov_filter,
+					sizeof(prov_filter), prov_rx, &mesh);
 }
 
 void mesh_unreg_prov_rx(prov_rx_cb_t cb)
 {
+	uint8_t prov_filter[] = {MESH_AD_TYPE_PROVISION};
+
 	if (mesh.prov_rx != cb)
 		return;
 
 	mesh.prov_rx = NULL;
 	mesh.prov_data = NULL;
-	mesh_io_deregister_recv_cb(mesh.io, MESH_IO_FILTER_PROV);
+	mesh_io_deregister_recv_cb(mesh.io, prov_filter, sizeof(prov_filter));
 }
 
 static void io_ready_callback(void *user_data, bool result)
diff --git a/mesh/net.c b/mesh/net.c
index ec05b6be9..5cf358fbd 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2884,6 +2884,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 	first = l_queue_isempty(nets);
 	if (first) {
+		uint8_t snb[] = {MESH_AD_TYPE_BEACON, 0x01};
+		uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
+
 		if (!nets)
 			nets = l_queue_new();
 
@@ -2891,9 +2894,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 			fast_cache = l_queue_new();
 
 		l_info("Register io cb");
-		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
+		mesh_io_register_recv_cb(io, snb, sizeof(snb),
 							beacon_recv, NULL);
-		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
+		mesh_io_register_recv_cb(io, pkt, sizeof(pkt),
 							net_msg_recv, NULL);
 	}
 
@@ -2909,6 +2912,8 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 struct mesh_io *mesh_net_detach(struct mesh_net *net)
 {
+	uint8_t snb[] = {MESH_AD_TYPE_BEACON, 0x01};
+	uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
 	struct mesh_io *io;
 	uint8_t type = 0;
 
@@ -2918,8 +2923,8 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	io = net->io;
 
 	mesh_io_send_cancel(net->io, &type, 1);
-	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_BEACON);
-	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_NET);
+	mesh_io_deregister_recv_cb(io, snb, sizeof(snb));
+	mesh_io_deregister_recv_cb(io, pkt, sizeof(pkt));
 
 	net->io = NULL;
 	l_queue_remove(nets, net);
-- 
2.21.1

