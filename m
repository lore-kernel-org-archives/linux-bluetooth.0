Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA42C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBXCHJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiBXCHH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E7BC14
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668397; x=1677204397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bM+/ZuEyWOEFwP74CBNA/J/qR51WuKedqkohDaDW36M=;
  b=UVvwTAhu8FM5KZ++u09cq9StKjsc2wY6V7icoyvrwz2xc08fXa46qYnM
   iI+ADfIzvlxNE/rsQ9b/jVOGYyRgeNaKixgaSOnEScLlYzwLWCGAbb2Fa
   Phh65M6M+rA9G3OAfnNei/qoCv+ij3MEaR2TL/4DgTd6x0WeuPCTOzNVj
   LfNJjxCLtUjnow2cOExMWVIlPk+I2jbYq0VLjY1JiMeBVsjfIMRU4j/Vw
   Du7OFfLDBOQ66+f3f4R7XafYHLH/V30hwB2kZdCIT7hWh+rCfOua2vLET
   KSQvalUYcHlOUCYsltddQFsfoyPCZqbmdagFG+kHSXDVFNwD48voI8Rmh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239525002"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239525002"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268572"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 4/7] mesh: rework Mesh-IO for multiple transports
Date:   Wed, 23 Feb 2022 18:06:21 -0800
Message-Id: <20220224020624.159247-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds mesh-io-mgmt (Kernel MGMT based transport) and
streamlines the handling of identifying and activating the
appropriate transport.
---
 mesh/mesh-io-api.h     |  11 +-
 mesh/mesh-io-generic.c |  47 +--
 mesh/mesh-io-generic.h |   1 +
 mesh/mesh-io-mgmt.c    | 787 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io-unit.c    |  11 +-
 mesh/mesh-io.c         | 190 +++++++---
 mesh/mesh-io.h         |   4 +-
 7 files changed, 957 insertions(+), 94 deletions(-)
 create mode 100644 mesh/mesh-io-mgmt.c

diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 61f79f224..21c505cd0 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -10,8 +10,7 @@
 
 struct mesh_io_private;
 
-typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts,
-				mesh_io_ready_func_t cb, void *user_data);
+typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts, void *user_data);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
 typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
@@ -36,9 +35,13 @@ struct mesh_io_api {
 };
 
 struct mesh_io {
-	enum mesh_io_type		type;
-	const struct mesh_io_api	*api;
+	int				index;
+	int				favored_index;
+	mesh_io_ready_func_t		ready;
+	struct l_queue			*rx_regs;
 	struct mesh_io_private		*pvt;
+	void				*user_data;
+	const struct mesh_io_api	*api;
 };
 
 struct mesh_io_table {
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 6c0b8f0fd..0bf8fcd81 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -19,6 +19,7 @@
 
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
+#include "src/shared/mgmt.h"
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
@@ -29,14 +30,12 @@
 #include "mesh/mesh-io-generic.h"
 
 struct mesh_io_private {
+	struct mesh_io *io;
 	struct bt_hci *hci;
-	void *user_data;
-	mesh_io_ready_func_t ready_callback;
 	struct l_timeout *tx_timeout;
 	struct l_queue *rx_regs;
 	struct l_queue *tx_pkts;
 	struct tx_pkt *tx;
-	uint16_t index;
 	uint16_t interval;
 	bool sending;
 	bool active;
@@ -385,16 +384,13 @@ static void hci_init(void *user_data)
 {
 	struct mesh_io *io = user_data;
 	bool result = true;
-	bool restarted = false;
 
-	if (io->pvt->hci) {
-		restarted = true;
+	if (io->pvt->hci)
 		bt_hci_unref(io->pvt->hci);
-	}
 
-	io->pvt->hci = bt_hci_new_user_channel(io->pvt->index);
+	io->pvt->hci = bt_hci_new_user_channel(io->index);
 	if (!io->pvt->hci) {
-		l_error("Failed to start mesh io (hci %u): %s", io->pvt->index,
+		l_error("Failed to start mesh io (hci %u): %s", io->index,
 							strerror(errno));
 		result = false;
 	}
@@ -405,47 +401,26 @@ static void hci_init(void *user_data)
 		bt_hci_register(io->pvt->hci, BT_HCI_EVT_LE_META_EVENT,
 						event_callback, io, NULL);
 
-		l_debug("Started mesh on hci %u", io->pvt->index);
+		l_debug("Started mesh on hci %u", io->index);
 
-		if (restarted)
-			restart_scan(io->pvt);
+		restart_scan(io->pvt);
 	}
 
-	if (io->pvt->ready_callback)
-		io->pvt->ready_callback(io->pvt->user_data, result);
+	if (io->ready)
+		io->ready(io->user_data, result);
 }
 
-static void read_info(int index, void *user_data)
-{
-	struct mesh_io *io = user_data;
-
-	if (io->pvt->index != MGMT_INDEX_NONE &&
-					index != io->pvt->index) {
-		l_debug("Ignore index %d", index);
-		return;
-	}
-
-	io->pvt->index = index;
-	hci_init(io);
-}
-
-static bool dev_init(struct mesh_io *io, void *opts,
-				mesh_io_ready_func_t cb, void *user_data)
+static bool dev_init(struct mesh_io *io, void *opts, void *user_data)
 {
 	if (!io || io->pvt)
 		return false;
 
 	io->pvt = l_new(struct mesh_io_private, 1);
-	io->pvt->index = *(int *)opts;
 
 	io->pvt->rx_regs = l_queue_new();
 	io->pvt->tx_pkts = l_queue_new();
 
-	io->pvt->ready_callback = cb;
-	io->pvt->user_data = user_data;
-
-	if (io->pvt->index == MGMT_INDEX_NONE)
-		return mesh_mgmt_list(read_info, io);
+	io->pvt->io = io;
 
 	l_idle_oneshot(hci_init, io, NULL);
 
diff --git a/mesh/mesh-io-generic.h b/mesh/mesh-io-generic.h
index 915e376bf..546e15d62 100644
--- a/mesh/mesh-io-generic.h
+++ b/mesh/mesh-io-generic.h
@@ -9,3 +9,4 @@
  */
 
 extern const struct mesh_io_api mesh_io_generic;
+extern const struct mesh_io_api mesh_io_mgmt;
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
new file mode 100644
index 000000000..092e81e79
--- /dev/null
+++ b/mesh/mesh-io-mgmt.c
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <ell/ell.h>
+
+#include "monitor/bt.h"
+#include "lib/bluetooth.h"
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
+
+#include "mesh/mesh-defs.h"
+#include "mesh/util.h"
+#include "mesh/mesh-mgmt.h"
+#include "mesh/mesh-io.h"
+#include "mesh/mesh-io-api.h"
+#include "mesh/mesh-io-generic.h"
+
+struct mesh_io_private {
+	struct mesh_io *io;
+	void *user_data;
+	struct l_timeout *tx_timeout;
+	struct l_queue *dup_filters;
+	struct l_queue *rx_regs;
+	struct l_queue *tx_pkts;
+	struct tx_pkt *tx;
+	unsigned int tx_id;
+	unsigned int rx_id;
+	uint16_t send_idx;
+	uint16_t interval;
+	uint8_t handle;
+	bool sending;
+	bool active;
+};
+
+struct pvt_rx_reg {
+	mesh_io_recv_func_t cb;
+	void *user_data;
+	uint8_t len;
+	uint8_t filter[0];
+};
+
+struct process_data {
+	struct mesh_io_private		*pvt;
+	const uint8_t			*data;
+	uint8_t				len;
+	struct mesh_io_recv_info	info;
+};
+
+struct tx_pkt {
+	struct mesh_io_send_info	info;
+	bool				delete;
+	uint8_t				len;
+	uint8_t				pkt[30];
+};
+
+struct tx_pattern {
+	const uint8_t			*data;
+	uint8_t				len;
+};
+
+#define DUP_FILTER_TIME        1000
+/* Accept one instance of unique message a second */
+struct dup_filter {
+	uint64_t data;
+	uint32_t instant;
+	uint8_t addr[6];
+} __packed;
+
+static struct mesh_io_private *pvt;
+
+static uint32_t get_instant(void)
+{
+	struct timeval tm;
+	uint32_t instant;
+
+	gettimeofday(&tm, NULL);
+	instant = tm.tv_sec * 1000;
+	instant += tm.tv_usec / 1000;
+
+	return instant;
+}
+
+static uint32_t instant_remaining_ms(uint32_t instant)
+{
+	instant -= get_instant();
+	return instant;
+}
+
+static bool find_by_addr(const void *a, const void *b)
+{
+	const struct dup_filter *filter = a;
+	return !memcmp(filter->addr, b, 6);
+}
+
+static void filter_timeout (struct l_timeout *timeout, void *user_data)
+{
+	struct dup_filter *filter;
+	uint32_t instant, delta;
+
+	if (!pvt)
+		goto done;
+
+	instant = get_instant();
+
+	filter = l_queue_peek_tail(pvt->dup_filters);
+	while (filter) {
+		delta = instant - filter->instant;
+		if (delta >= DUP_FILTER_TIME) {
+			l_queue_remove(pvt->dup_filters, filter);
+			l_free(filter);
+		} else {
+			l_timeout_modify(timeout, 1);
+			return;
+		}
+
+		filter = l_queue_peek_tail(pvt->dup_filters);
+	}
+
+done:
+	l_timeout_remove(timeout);
+}
+
+/* Ignore consequtive duplicate advertisements within timeout period */
+static bool filter_dups(const uint8_t *addr, const uint8_t *adv,
+                                                       uint32_t instant)
+{
+	struct dup_filter *filter;
+	uint32_t instant_delta;
+	uint64_t data = l_get_be64(adv);
+
+	filter = l_queue_remove_if(pvt->dup_filters, find_by_addr, addr);
+	if (!filter) {
+		filter = l_new(struct dup_filter, 1);
+		memcpy(filter->addr, addr, 6);
+	}
+
+	/* Start filter expiration timer */
+	if (!l_queue_length(pvt->dup_filters))
+		l_timeout_create(1, filter_timeout, NULL, NULL);
+
+	l_queue_push_head(pvt->dup_filters, filter);
+	instant_delta = instant - filter->instant;
+
+	if (instant_delta >= DUP_FILTER_TIME || data != filter->data) {
+		filter->instant = instant;
+		filter->data = data;
+		return false;
+	}
+
+	return true;
+}
+
+static void process_rx_callbacks(void *v_reg, void *v_rx)
+{
+	struct pvt_rx_reg *rx_reg = v_reg;
+	struct process_data *rx = v_rx;
+
+	if (!memcmp(rx->data, rx_reg->filter, rx_reg->len))
+		rx_reg->cb(rx_reg->user_data, &rx->info, rx->data, rx->len);
+}
+
+static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
+					uint32_t instant, const uint8_t *addr,
+					const uint8_t *data, uint8_t len)
+{
+	struct process_data rx = {
+		.pvt = pvt,
+		.data = data,
+		.len = len,
+		.info.instant = instant,
+		.info.addr = addr,
+		.info.chan = 7,
+		.info.rssi = rssi,
+	};
+
+	print_packet("RX", data, len);
+	l_queue_foreach(pvt->rx_regs, process_rx_callbacks, &rx);
+}
+
+static void send_cmplt(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	print_packet("Mesh Send Complete", param, length);
+}
+
+static void event_device_found(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_mesh_device_found *ev = param;
+	struct mesh_io *io = user_data;
+	const uint8_t *adv;
+	const uint8_t *addr;
+	uint32_t instant;
+	uint16_t adv_len;
+	uint16_t len = 0;
+
+	if (ev->addr.type < 1 || ev->addr.type > 2)
+		return;
+
+	instant = get_instant();
+	adv = ev->eir;
+	adv_len = ev->eir_len;
+	addr = ev->addr.bdaddr.b;
+
+	if (filter_dups(addr, adv, instant))
+		return;
+
+	//print_packet("ADV pkt", adv, adv_len);
+	while (len < adv_len - 1) {
+		uint8_t field_len = adv[0];
+
+		/* Check for the end of advertising data */
+		if (field_len == 0)
+			break;
+
+		len += field_len + 1;
+
+		/* Do not continue data parsing if got incorrect length */
+		if (len > adv_len)
+			break;
+
+		/* TODO: Create an Instant to use */
+		if (adv[1] >= 0x29 && adv[1] <= 0x2B)
+		process_rx(io->pvt, ev->rssi, instant, addr, adv + 1, adv[0]);
+
+		adv += field_len + 1;
+	}
+}
+
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool find_by_ad_type(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	uint8_t ad_type = L_PTR_TO_UINT(b);
+
+	return !ad_type || ad_type == tx->pkt[0];
+}
+
+static bool find_by_pattern(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	const struct tx_pattern *pattern = b;
+
+	if (tx->len < pattern->len)
+		return false;
+
+	return (!memcmp(tx->pkt, pattern->data, pattern->len));
+}
+
+static bool find_active(const void *a, const void *b)
+{
+	const struct pvt_rx_reg *rx_reg = a;
+
+	/* Mesh specific AD types do *not* require active scanning,
+	 * so do not turn on Active Scanning on their account.
+	 */
+	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
+			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
+		return true;
+
+	return false;
+}
+
+static void mesh_up(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	int index = L_PTR_TO_UINT(user_data);
+
+	l_debug("HCI%d Mesh up status: %d", index, status);
+}
+
+static void le_up(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	int index = L_PTR_TO_UINT(user_data);
+
+	l_debug("HCI%d LE up status: %d", index, status);
+}
+
+static void ctl_up(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	int index = L_PTR_TO_UINT(user_data);
+	uint16_t len;
+	struct mgmt_cp_set_mesh *mesh;
+	uint8_t mesh_ad_types[] = { MESH_AD_TYPE_NETWORK,
+				MESH_AD_TYPE_BEACON, MESH_AD_TYPE_PROVISION };
+
+	l_debug("HCI%d is up status: %d", index, status);
+	if (status)
+		return;
+
+	len = sizeof(struct mgmt_cp_set_mesh) + sizeof(mesh_ad_types);
+	mesh = l_malloc(len);
+
+	mesh->enable = 1;
+	mesh->window = L_CPU_TO_LE16(0x1000);
+	mesh->period = L_CPU_TO_LE16(0x1000);
+	mesh->num_ad_types = sizeof(mesh_ad_types);
+	memcpy(mesh->ad_types, mesh_ad_types, sizeof(mesh_ad_types));
+
+	mesh_mgmt_send(MGMT_OP_SET_MESH_RECEIVER, index, len, mesh,
+			mesh_up, L_UINT_TO_PTR(index), NULL);
+	l_debug("done %d mesh startup", index);
+
+	l_free(mesh);
+
+	if (pvt->send_idx == MGMT_INDEX_NONE) {
+		pvt->send_idx = index;
+		if (pvt && pvt->io && pvt->io->ready) {
+			pvt->io->ready(pvt->io->user_data, true);
+			pvt->io->ready = NULL;
+		}
+	}
+}
+
+static void read_info_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	unsigned char le[] = { 0x01 };
+	int index = L_PTR_TO_UINT(user_data);
+	const struct mgmt_rp_read_info *rp = param;
+	uint32_t current_settings, supported_settings;
+
+	l_debug("hci %u status 0x%02x", index, status);
+
+	if (!pvt)
+		return;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		l_error("Failed to read info for hci index %u: %s (0x%02x)",
+				index, mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		l_error("Read info response too short");
+		return;
+	}
+
+	current_settings = btohl(rp->current_settings);
+	supported_settings = btohl(rp->supported_settings);
+
+	if (!(supported_settings & MGMT_SETTING_LE)) {
+		l_info("Controller hci %u does not support LE", index);
+		return;
+	}
+
+	if (!(current_settings & MGMT_SETTING_POWERED)) {
+		unsigned char power[] = { 0x01 };
+
+		/* TODO: Initialize this HCI controller */
+		l_info("Controller hci %u not in use", index);
+
+		mesh_mgmt_send(MGMT_OP_SET_LE, index,
+				sizeof(le), &le,
+				le_up, L_UINT_TO_PTR(index), NULL);
+
+		mesh_mgmt_send(MGMT_OP_SET_POWERED, index,
+				sizeof(power), &power,
+				ctl_up, L_UINT_TO_PTR(index), NULL);
+	} else {
+
+		l_info("Controller hci %u already in use (%x)",
+						index, current_settings);
+
+		/* Share this controller with bluetoothd */
+		mesh_mgmt_send(MGMT_OP_SET_LE, index,
+				sizeof(le), &le,
+				ctl_up, L_UINT_TO_PTR(index), NULL);
+
+	}
+}
+
+static bool dev_init(struct mesh_io *io, void *opts, void *user_data)
+{
+	uint16_t index = *(int *)opts;
+
+	if (!io || pvt)
+		return false;
+
+	pvt = l_new(struct mesh_io_private, 1);
+
+	pvt->send_idx = MGMT_INDEX_NONE;
+
+	mesh_mgmt_send(MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_cb, L_UINT_TO_PTR(index), NULL);
+
+	pvt->rx_id = mesh_mgmt_register(MGMT_EV_MESH_DEVICE_FOUND,
+				MGMT_INDEX_NONE, event_device_found, io, NULL);
+	pvt->tx_id = mesh_mgmt_register(MGMT_EV_MESH_PACKET_CMPLT,
+					MGMT_INDEX_NONE, send_cmplt, io, NULL);
+
+	pvt->dup_filters = l_queue_new();
+	pvt->rx_regs = l_queue_new();
+	pvt->tx_pkts = l_queue_new();
+
+	pvt->io = io;
+	io->pvt = pvt;
+
+	return true;
+}
+
+static void free_rx_reg(void *user_data)
+{
+	struct pvt_rx_reg *rx_reg = user_data;
+
+	l_free(rx_reg);
+}
+
+
+static bool dev_destroy(struct mesh_io *io)
+{
+	unsigned char param[] = { 0x00 };
+
+	if (io->pvt != pvt)
+		return true;
+
+	mesh_mgmt_send(MGMT_OP_SET_POWERED, io->index, sizeof(param), &param,
+							NULL, NULL, NULL);
+
+	mesh_mgmt_unregister(pvt->rx_id);
+	mesh_mgmt_unregister(pvt->tx_id);
+	l_timeout_remove(pvt->tx_timeout);
+	l_queue_destroy(pvt->dup_filters, l_free);
+	l_queue_destroy(pvt->rx_regs, free_rx_reg);
+	l_queue_destroy(pvt->tx_pkts, l_free);
+	io->pvt = NULL;
+	l_free(pvt);
+	pvt = NULL;
+
+	return true;
+}
+
+static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
+{
+	struct mesh_io_private *pvt = io->pvt;
+
+	if (!pvt || !caps)
+		return false;
+
+	caps->max_num_filters = 255;
+	caps->window_accuracy = 50;
+
+	return true;
+}
+
+static void send_cancel(struct mesh_io_private *pvt)
+{
+	struct mgmt_cp_mesh_send_cancel remove;
+
+	if (!pvt)
+		return;
+
+	if (pvt->handle) {
+		remove.handle = pvt->handle;
+		l_debug("Cancel TX");
+		mesh_mgmt_send(MGMT_OP_MESH_SEND_CANCEL, pvt->send_idx,
+						sizeof(remove), &remove,
+						NULL, NULL, NULL);
+	}
+}
+
+static void tx_to(struct l_timeout *timeout, void *user_data);
+static void send_queued(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct tx_pkt *tx = user_data;
+
+	if (status)
+		l_debug("Mesh Send Failed: %d", status);
+	else if (param && length >= 1)
+		pvt->handle = *(uint8_t *) param;
+
+	if (tx->delete) {
+		l_queue_remove_if(pvt->tx_pkts, simple_match, tx);
+		l_free(tx);
+		pvt->tx = NULL;
+	}
+
+	tx_to(pvt->tx_timeout, pvt);
+}
+
+static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
+							uint16_t interval)
+{
+	uint8_t buffer[sizeof(struct mgmt_cp_mesh_send) + tx->len];
+	struct mgmt_cp_mesh_send *send = (void *) buffer;
+	uint16_t index;
+	size_t len;
+
+	if (!pvt)
+		return;
+
+	index = pvt->send_idx;
+
+	len = sizeof(buffer);
+	memset(send, 0, len);
+	send->addr.type = BDADDR_LE_RANDOM;
+	send->instant = 0;
+	send->delay = 0;
+	send->cnt = 1;
+	memcpy(send->data, tx->pkt, tx->len);
+	mesh_mgmt_send(MGMT_OP_MESH_SEND, index,
+			len, send, send_queued, tx, NULL);
+	print_packet("Mesh Send Start", tx->pkt, tx->len);
+	pvt->tx = tx;
+}
+
+static void tx_to(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct tx_pkt *tx;
+	uint16_t ms;
+	uint8_t count;
+
+	if (!pvt)
+		return;
+
+	tx = l_queue_pop_head(pvt->tx_pkts);
+	if (!tx) {
+		l_timeout_remove(timeout);
+		pvt->tx_timeout = NULL;
+		send_cancel(pvt);
+		pvt->tx = NULL;
+		return;
+	}
+
+	if (tx->info.type == MESH_IO_TIMING_TYPE_GENERAL) {
+		ms = tx->info.u.gen.interval;
+		count = tx->info.u.gen.cnt;
+		if (count != MESH_IO_TX_COUNT_UNLIMITED)
+			tx->info.u.gen.cnt--;
+	} else {
+		ms = 25;
+		count = 1;
+	}
+
+	tx->delete = !!(count == 1);
+
+	send_pkt(pvt, tx, ms);
+
+	if (count == 1) {
+		/* Recalculate wakeup if we are responding to POLL */
+		tx = l_queue_peek_head(pvt->tx_pkts);
+
+		if (tx && tx->info.type == MESH_IO_TIMING_TYPE_POLL_RSP) {
+			ms = instant_remaining_ms(tx->info.u.poll_rsp.instant +
+						tx->info.u.poll_rsp.delay);
+		}
+	} else
+		l_queue_push_tail(pvt->tx_pkts, tx);
+
+	if (timeout) {
+		pvt->tx_timeout = timeout;
+		l_timeout_modify_ms(timeout, ms);
+	} else
+		pvt->tx_timeout = l_timeout_create_ms(ms, tx_to, pvt, NULL);
+}
+
+static void tx_worker(void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct tx_pkt *tx;
+	uint32_t delay;
+
+	tx = l_queue_peek_head(pvt->tx_pkts);
+	if (!tx)
+		return;
+
+	switch (tx->info.type) {
+	case MESH_IO_TIMING_TYPE_GENERAL:
+		if (tx->info.u.gen.min_delay == tx->info.u.gen.max_delay)
+			delay = tx->info.u.gen.min_delay;
+		else {
+			l_getrandom(&delay, sizeof(delay));
+			delay %= tx->info.u.gen.max_delay -
+						tx->info.u.gen.min_delay;
+			delay += tx->info.u.gen.min_delay;
+		}
+		break;
+
+	case MESH_IO_TIMING_TYPE_POLL:
+		if (tx->info.u.poll.min_delay == tx->info.u.poll.max_delay)
+			delay = tx->info.u.poll.min_delay;
+		else {
+			l_getrandom(&delay, sizeof(delay));
+			delay %= tx->info.u.poll.max_delay -
+						tx->info.u.poll.min_delay;
+			delay += tx->info.u.poll.min_delay;
+		}
+		break;
+
+	case MESH_IO_TIMING_TYPE_POLL_RSP:
+		/* Delay until Instant + Delay */
+		delay = instant_remaining_ms(tx->info.u.poll_rsp.instant +
+						tx->info.u.poll_rsp.delay);
+		if (delay > 255)
+			delay = 0;
+		break;
+
+	default:
+		return;
+	}
+
+	if (!delay)
+		tx_to(pvt->tx_timeout, pvt);
+	else if (pvt->tx_timeout)
+		l_timeout_modify_ms(pvt->tx_timeout, delay);
+	else
+		pvt->tx_timeout = l_timeout_create_ms(delay, tx_to, pvt, NULL);
+}
+
+static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct tx_pkt *tx;
+	bool sending = false;
+
+	if (!info || !data || !len || len > sizeof(tx->pkt))
+		return false;
+
+	tx = l_new(struct tx_pkt, 1);
+
+	memcpy(&tx->info, info, sizeof(tx->info));
+	memcpy(&tx->pkt, data, len);
+	tx->len = len;
+
+	if (info->type == MESH_IO_TIMING_TYPE_POLL_RSP)
+		l_queue_push_head(pvt->tx_pkts, tx);
+	else {
+		if (pvt->tx)
+			sending = true;
+		else
+			sending = !l_queue_isempty(pvt->tx_pkts);
+
+		l_queue_push_tail(pvt->tx_pkts, tx);
+	}
+
+	if (!sending) {
+		l_timeout_remove(pvt->tx_timeout);
+		pvt->tx_timeout = NULL;
+		l_idle_oneshot(tx_worker, pvt, NULL);
+	}
+
+	return true;
+}
+
+static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
+{
+	struct mesh_io_private *pvt = io->pvt;
+	struct tx_pkt *tx;
+
+	if (!data)
+		return false;
+
+	if (len == 1) {
+		do {
+			tx = l_queue_remove_if(pvt->tx_pkts, find_by_ad_type,
+							L_UINT_TO_PTR(data[0]));
+			l_free(tx);
+
+			if (tx == pvt->tx)
+				pvt->tx = NULL;
+
+		} while (tx);
+	} else {
+		struct tx_pattern pattern = {
+			.data = data,
+			.len = len
+		};
+
+		do {
+			tx = l_queue_remove_if(pvt->tx_pkts, find_by_pattern,
+								&pattern);
+			l_free(tx);
+
+			if (tx == pvt->tx)
+				pvt->tx = NULL;
+
+		} while (tx);
+	}
+
+	if (l_queue_isempty(pvt->tx_pkts)) {
+		send_cancel(pvt);
+		l_timeout_remove(pvt->tx_timeout);
+		pvt->tx_timeout = NULL;
+	}
+
+	return true;
+}
+
+static bool find_by_filter(const void *a, const void *b)
+{
+	const struct pvt_rx_reg *rx_reg = a;
+	const uint8_t *filter = b;
+
+	return !memcmp(rx_reg->filter, filter, rx_reg->len);
+}
+
+static bool recv_register(struct mesh_io *io, const uint8_t *filter,
+			uint8_t len, mesh_io_recv_func_t cb, void *user_data)
+{
+	struct pvt_rx_reg *rx_reg;
+	bool active = false;
+
+	if (!cb || !filter || !len || io->pvt != pvt)
+		return false;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
+
+	free_rx_reg(rx_reg);
+	rx_reg = l_malloc(sizeof(*rx_reg) + len);
+
+	memcpy(rx_reg->filter, filter, len);
+	rx_reg->len = len;
+	rx_reg->cb = cb;
+	rx_reg->user_data = user_data;
+
+	l_queue_push_head(pvt->rx_regs, rx_reg);
+
+	/* Look for any AD types requiring Active Scanning */
+	if (l_queue_find(pvt->rx_regs, find_active, NULL))
+		active = true;
+
+	if (pvt->active != active) {
+		pvt->active = active;
+		/* TODO: Request active or passive scanning */
+	}
+
+	return true;
+}
+
+static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len)
+{
+	struct pvt_rx_reg *rx_reg;
+	bool active = false;
+
+	if (io->pvt != pvt)
+		return false;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
+
+	free_rx_reg(rx_reg);
+
+	/* Look for any AD types requiring Active Scanning */
+	if (l_queue_find(pvt->rx_regs, find_active, NULL))
+		active = true;
+
+	if (active != pvt->active) {
+		pvt->active = active;
+		/* TODO: Request active or passive scanning */
+	}
+
+	return true;
+}
+
+const struct mesh_io_api mesh_io_mgmt = {
+	.init = dev_init,
+	.destroy = dev_destroy,
+	.caps = dev_caps,
+	.send = send_tx,
+	.reg = recv_register,
+	.dereg = recv_deregister,
+	.cancel = tx_cancel,
+};
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index f4b615ac8..81d9de837 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -28,10 +28,10 @@
 #include "mesh/mesh-io-generic.h"
 
 struct mesh_io_private {
+	struct mesh_io *io;
 	struct l_io *sio;
 	void *user_data;
 	char *unique_name;
-	mesh_io_ready_func_t ready_callback;
 	struct l_timeout *tx_timeout;
 	struct l_queue *rx_regs;
 	struct l_queue *tx_pkts;
@@ -203,14 +203,13 @@ static void unit_up(void *user_data)
 
 	l_debug("Started io-unit");
 
-	if (pvt->ready_callback)
-		pvt->ready_callback(pvt->user_data, true);
+	if (pvt->io && pvt->io->ready)
+		pvt->io->ready(pvt->user_data, true);
 
 	l_timeout_create_ms(1, get_name, pvt, NULL);
 }
 
-static bool unit_init(struct mesh_io *io, void *opt,
-				mesh_io_ready_func_t cb, void *user_data)
+static bool unit_init(struct mesh_io *io, void *opt, void *user_data)
 {
 	struct mesh_io_private *pvt;
 	char *sk_path;
@@ -247,7 +246,7 @@ static bool unit_init(struct mesh_io *io, void *opt,
 	pvt->rx_regs = l_queue_new();
 	pvt->tx_pkts = l_queue_new();
 
-	pvt->ready_callback = cb;
+	pvt->io = io;
 	pvt->user_data = user_data;
 
 	io->pvt = pvt;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 96891313a..95ee9a7f2 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -15,8 +15,11 @@
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/mesh-mgmt.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
 
@@ -24,86 +27,150 @@
 #include "mesh/mesh-io-generic.h"
 #include "mesh/mesh-io-unit.h"
 
+struct mesh_io_reg {
+	mesh_io_recv_func_t cb;
+	void *user_data;
+	uint8_t len;
+	uint8_t filter[];
+} packed;
+
 /* List of Supported Mesh-IO Types */
 static const struct mesh_io_table table[] = {
-	{MESH_IO_TYPE_GENERIC, &mesh_io_generic},
+	{MESH_IO_TYPE_MGMT,	&mesh_io_mgmt},
+	{MESH_IO_TYPE_GENERIC,	&mesh_io_generic},
 	{MESH_IO_TYPE_UNIT_TEST, &mesh_io_unit},
 };
 
-static struct l_queue *io_list;
+static struct mesh_io *default_io;
 
-static bool match_by_io(const void *a, const void *b)
+static const struct mesh_io_api *io_api(enum mesh_io_type type)
 {
-	return a == b;
+	uint16_t i;
+
+	for (i = 0; i < L_ARRAY_SIZE(table); i++) {
+		if (table[i].type == type) {
+			return table[i].api;
+		}
+	}
+
+	return NULL;
 }
 
-static bool match_by_type(const void *a, const void *b)
+static void refresh_rx(void *a, void *b)
 {
-	const struct mesh_io *io = a;
-	const enum mesh_io_type type = L_PTR_TO_UINT(b);
+	struct mesh_io_reg *rx_reg = a;
+	struct mesh_io *io = b;
 
-	return io->type == type;
+	if (io->api && io->api->reg)
+		io->api->reg(io, rx_reg->filter, rx_reg->len, rx_reg->cb,
+							rx_reg->user_data);
 }
 
-struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
-				mesh_io_ready_func_t cb, void *user_data)
+static void ctl_alert(int index, bool up, bool pwr, bool mesh, void *user_data)
 {
+	enum mesh_io_type type = L_PTR_TO_UINT(user_data);
 	const struct mesh_io_api *api = NULL;
-	struct mesh_io *io;
-	uint16_t i;
 
-	for (i = 0; i < L_ARRAY_SIZE(table); i++) {
-		if (table[i].type == type) {
-			api = table[i].api;
-			break;
-		}
-	}
+	l_warn("up:%d pwr: %d mesh: %d", up, pwr, mesh);
 
-	io = l_queue_find(io_list, match_by_type, L_UINT_TO_PTR(type));
+	/* If specific IO controller requested, honor it */
+	if (default_io->favored_index != MGMT_INDEX_NONE &&
+					default_io->favored_index != index)
+		return;
 
-	if (!api || !api->init || io)
-		return NULL;
-
-	io = l_new(struct mesh_io, 1);
+	if (!up && default_io->index == index) {
+		/* Our controller has disappeared */
+		if (default_io->api && default_io->api->destroy) {
+			default_io->api->destroy(default_io);
+			default_io->api = NULL;
+		}
 
-	io->type = type;
-	io->api = api;
+		/* Re-enumerate controllers */
+		mesh_mgmt_list(ctl_alert, user_data);
+		return;
+	}
 
-	if (!api->init(io, opts, cb, user_data))
-		goto fail;
+	/* If we already have an API, keep using it */
+	if (!up || default_io->api)
+		return;
 
-	if (!io_list)
-		io_list = l_queue_new();
+	if (mesh && type != MESH_IO_TYPE_GENERIC) {
+		api = io_api(MESH_IO_TYPE_MGMT);
+	}
 
-	if (l_queue_push_head(io_list, io))
-		return io;
+	else if (!pwr) {
+		api = io_api(MESH_IO_TYPE_GENERIC);
+	}
 
-fail:
-	if (api->destroy)
-		api->destroy(io);
+	if (api) {
+		default_io->index = index;
+		default_io->api = api;
+		api->init(default_io, &index, default_io->user_data);
 
-	l_free(io);
-	return NULL;
+		l_queue_foreach(default_io->rx_regs, refresh_rx, default_io);
+	}
 }
 
-void mesh_io_destroy(struct mesh_io *io)
+static void free_io(struct mesh_io *io)
 {
-	io = l_queue_remove_if(io_list, match_by_io, io);
 
 	if (io && io->api && io->api->destroy)
 		io->api->destroy(io);
 
+	l_queue_destroy(io->rx_regs, l_free);
+	io->rx_regs = NULL;
 	l_free(io);
+	l_warn("Destroy %p", io);
+}
+
+struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
+				mesh_io_ready_func_t cb, void *user_data)
+{
+	const struct mesh_io_api *api = NULL;
+
+	/* Only allow one IO */
+	if (default_io)
+		return NULL;
+
+	default_io = l_new(struct mesh_io, 1);
+	default_io->ready = cb;
+	default_io->user_data = user_data;
+	default_io->favored_index = *(int *) opts;
+	default_io->rx_regs = l_queue_new();
 
-	if (l_queue_isempty(io_list)) {
-		l_queue_destroy(io_list, NULL);
-		io_list = NULL;
+	if (type >= MESH_IO_TYPE_AUTO) {
+		if (!mesh_mgmt_list(ctl_alert, L_UINT_TO_PTR(type)))
+			goto fail;
+
+		return default_io;
 	}
+
+	api = io_api(type);
+
+	if (!api || !api->init)
+		goto fail;
+
+	default_io->api = api;
+
+	if (!api->init(default_io, &default_io->favored_index, user_data))
+		goto fail;
+
+	return default_io;
+
+fail:
+	free_io(default_io);
+	default_io = NULL;
+	return NULL;
+}
+
+void mesh_io_destroy(struct mesh_io *io)
+{
 }
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps)
 {
-	io = l_queue_find(io_list, match_by_io, io);
+	if (io != default_io)
+		return false;
 
 	if (io && io->api && io->api->caps)
 		return io->api->caps(io, caps);
@@ -115,7 +182,17 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 				uint8_t len, mesh_io_recv_func_t cb,
 				void *user_data)
 {
-	io = l_queue_find(io_list, match_by_io, io);
+	struct mesh_io_reg *rx_reg;
+
+	if (io != default_io)
+		return false;
+
+	rx_reg = l_malloc(sizeof(struct mesh_io_reg) + len);
+	rx_reg->cb = cb;
+	rx_reg->len = len;
+	rx_reg->user_data = user_data;
+	memcpy(rx_reg->filter, filter, len);
+	l_queue_push_head(io->rx_regs, rx_reg);
 
 	if (io && io->api && io->api->reg)
 		return io->api->reg(io, filter, len, cb, user_data);
@@ -123,10 +200,24 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 	return false;
 }
 
+static bool by_filter(const void *a, const void *b)
+{
+	const struct mesh_io_reg *rx_reg = a;
+	const uint8_t *filter = b;
+
+	return rx_reg->filter[0] == filter[0];
+}
+
 bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
 								uint8_t len)
 {
-	io = l_queue_find(io_list, match_by_io, io);
+	struct mesh_io_reg *rx_reg;
+
+	if (io != default_io)
+		return false;
+
+	rx_reg = l_queue_remove_if(io->rx_regs, by_filter, filter);
+	l_free(rx_reg);
 
 	if (io && io->api && io->api->dereg)
 		return io->api->dereg(io, filter, len);
@@ -137,10 +228,11 @@ bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
 bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len)
 {
-	io = l_queue_find(io_list, match_by_io, io);
+	if (io && io != default_io)
+		return false;
 
 	if (!io)
-		io = l_queue_peek_head(io_list);
+		io = default_io;
 
 	if (io && io->api && io->api->send)
 		return io->api->send(io, info, data, len);
@@ -151,7 +243,11 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 bool mesh_io_send_cancel(struct mesh_io *io, const uint8_t *pattern,
 								uint8_t len)
 {
-	io = l_queue_find(io_list, match_by_io, io);
+	if (io && io != default_io)
+		return false;
+
+	if (!io)
+		io = default_io;
 
 	if (io && io->api && io->api->cancel)
 		return io->api->cancel(io, pattern, len);
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 80ef3fa3e..9dd946cdf 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -14,8 +14,10 @@ struct mesh_io;
 
 enum mesh_io_type {
 	MESH_IO_TYPE_NONE = 0,
+	MESH_IO_TYPE_UNIT_TEST,
+	MESH_IO_TYPE_AUTO, /* If MGMT required, add after here */
+	MESH_IO_TYPE_MGMT,
 	MESH_IO_TYPE_GENERIC,
-	MESH_IO_TYPE_UNIT_TEST
 };
 
 enum mesh_io_timing_type {
-- 
2.35.1

