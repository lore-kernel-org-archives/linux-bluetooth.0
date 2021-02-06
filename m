Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 05:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B6164FCA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 05:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBFFvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 00:51:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:48292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBFFvR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 00:51:17 -0500
IronPort-SDR: LEeho/rarq9D91qyuZLRFt/6NcxrDd7JDD7Ln9uFdN2UFgBW9lyTZuwbrgi9JwK2hca2dH+Q0y
 /BnoFXJZ8/Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200540947"
X-IronPort-AV: E=Sophos;i="5.81,157,1610438400"; 
   d="scan'208";a="200540947"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 21:50:34 -0800
IronPort-SDR: Zg7mXB0u7T9/UlCQKGODs9bKHvLgnjuO1Ym0MDdEQGybHZ7/iobWorMCbvAjRlZNgY0X7heOgd
 a50vNxh7R/Ww==
X-IronPort-AV: E=Sophos;i="5.81,157,1610438400"; 
   d="scan'208";a="397733225"
Received: from yxiong5-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.99.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 21:50:34 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com
Subject: [PATCH BlueZ v3 2/3] mesh: Add unit test IO
Date:   Fri,  5 Feb 2021 21:50:22 -0800
Message-Id: <20210206055023.401381-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206055023.401381-1-inga.stotland@intel.com>
References: <20210206055023.401381-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This adds a new type of mesh IO that is used for non-interactive testing.
The new io option can be specified on command line as:
--io unit:<socket_name>

When the bluetooth-meshd daemon starts with the "unit" IO type,
the daemon opens a socket (fd to open is provided after "unit:"
in <socket_name>). The communication with the daemon is done either
through the loop-back using mesh DBus-based APIs or the specified
named socket.
---
 Makefile.mesh       |   2 +
 mesh/main.c         |  41 +++-
 mesh/mesh-io-unit.c | 533 ++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io-unit.h |  11 +
 mesh/mesh-io.c      |   9 +-
 mesh/mesh-io.h      |   3 +-
 6 files changed, 582 insertions(+), 17 deletions(-)
 create mode 100644 mesh/mesh-io-unit.c
 create mode 100644 mesh/mesh-io-unit.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 228dd1b5f..73eaded4a 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -17,6 +17,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/error.h mesh/mesh-io-api.h \
 				mesh/mesh-io-generic.h \
 				mesh/mesh-io-generic.c \
+				mesh/mesh-io-unit.h \
+				mesh/mesh-io-unit.c \
 				mesh/net.h mesh/net.c \
 				mesh/crypto.h mesh/crypto.c \
 				mesh/friend.h mesh/friend.c \
diff --git a/mesh/main.c b/mesh/main.c
index 4356e3f65..1b466598b 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -61,7 +61,7 @@ static void usage(void)
 	       "\t--help            Show %s information\n", __func__);
 	fprintf(stderr,
 	       "io:\n"
-	       "\t([hci]<index> | generic[:[hci]<index>])\n"
+	       "\t([hci]<index> | generic[:[hci]<index>] | unit:<fd_path>)\n"
 	       "\t\tUse generic HCI io on interface hci<index>, or the first\n"
 	       "\t\tavailable one\n");
 }
@@ -77,6 +77,7 @@ static void mesh_ready_callback(void *user_data, bool success)
 {
 	struct l_dbus *dbus = user_data;
 
+	l_info("mesh_ready_callback");
 	if (!success) {
 		l_error("Failed to start mesh");
 		l_main_quit();
@@ -92,10 +93,8 @@ static void mesh_ready_callback(void *user_data, bool success)
 static void request_name_callback(struct l_dbus *dbus, bool success,
 					bool queued, void *user_data)
 {
-	l_info("Request name %s",
-		success ? "success": "failed");
-
-	if (!success) {
+	if (!success && io_type != MESH_IO_TYPE_UNIT_TEST) {
+		l_info("Request name failed");
 		l_main_quit();
 		return;
 	}
@@ -159,6 +158,21 @@ static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
 			return true;
 
 		return false;
+
+	} else if (strstr(optarg, "unit") == optarg) {
+		char *test_path;
+
+		*type = MESH_IO_TYPE_UNIT_TEST;
+
+		optarg += strlen("unit");
+		if (*optarg != ':')
+			return false;
+
+		optarg++;
+		test_path = strdup(optarg);
+
+		*opts = test_path;
+		return true;
 	}
 
 	return false;
@@ -187,11 +201,19 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "i:s:c:ndbh", main_options, NULL);
+		opt = getopt_long(argc, argv, "u:i:s:c:ndbh", main_options,
+									NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
+		case 'u':
+			if (sscanf(optarg, "%d", &hci_index) == 1 ||
+					sscanf(optarg, "%d", &hci_index) == 1)
+				io = l_strdup_printf("unit:%d", hci_index);
+			else
+				io = l_strdup(optarg);
+			break;
 		case 'i':
 			if (sscanf(optarg, "hci%d", &hci_index) == 1 ||
 					sscanf(optarg, "%d", &hci_index) == 1)
@@ -261,11 +283,8 @@ int main(int argc, char *argv[])
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
-	if (io)
-		l_free(io);
-
-	if (io_opts)
-		l_free(io_opts);
+	l_free(io);
+	l_free(io_opts);
 
 	mesh_cleanup();
 	l_dbus_destroy(dbus);
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
new file mode 100644
index 000000000..c5aae6741
--- /dev/null
+++ b/mesh/mesh-io-unit.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
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
+#include <sys/time.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+#include "mesh/dbus.h"
+#include "mesh/mesh-io.h"
+#include "mesh/mesh-io-api.h"
+#include "mesh/mesh-io-generic.h"
+
+struct mesh_io_private {
+	struct l_io *sio;
+	void *user_data;
+	char *unique_name;
+	mesh_io_ready_func_t ready_callback;
+	struct l_timeout *tx_timeout;
+	struct l_queue *rx_regs;
+	struct l_queue *tx_pkts;
+	struct sockaddr_un addr;
+	int fd;
+	uint16_t interval;
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
+	l_queue_foreach(pvt->rx_regs, process_rx_callbacks, &rx);
+}
+
+static bool incoming(struct l_io *sio, void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	uint32_t instant;
+	uint8_t buf[31];
+	size_t size;
+
+	instant = get_instant();
+
+	size = recv(pvt->fd, buf, sizeof(buf), MSG_DONTWAIT);
+
+	if (size > 9 && buf[0]) {
+		process_rx(pvt, -20, instant, NULL, buf + 1, (uint8_t)size);
+	} else if (size == 1 && !buf[0] && pvt->unique_name) {
+
+		/* Return DBUS unique name */
+		size = strlen(pvt->unique_name);
+
+		if (size > sizeof(buf) - 2)
+			return true;
+
+		buf[0] = 0;
+		memcpy(buf + 1, pvt->unique_name, size + 1);
+		send(pvt->fd, buf, size + 2, MSG_DONTWAIT);
+	}
+
+	return true;
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
+static void free_socket(struct mesh_io_private *pvt)
+{
+	l_io_destroy(pvt->sio);
+	close(pvt->fd);
+	unlink(pvt->addr.sun_path);
+}
+
+static void hello_callback(struct l_dbus_message *msg, void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+
+	pvt->unique_name = l_strdup(l_dbus_message_get_destination(msg));
+	l_debug("User-Daemon unique name: %s", pvt->unique_name);
+}
+
+static void get_name(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+
+	l_timeout_remove(timeout);
+	if (!dbus) {
+		l_timeout_create_ms(20, get_name, pvt, NULL);
+		return;
+	}
+
+	/* Retrieve unique name */
+	msg = l_dbus_message_new_method_call(dbus, "org.freedesktop.DBus",
+							"/org/freedesktop/DBus",
+							"org.freedesktop.DBus",
+							"GetId");
+
+	l_dbus_message_set_arguments(msg, "");
+
+	l_dbus_send_with_reply(dbus, msg, hello_callback, pvt, NULL);
+}
+
+static void unit_up(void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+
+	l_debug("Started io-unit");
+
+	if (pvt->ready_callback)
+		pvt->ready_callback(pvt->user_data, true);
+
+	l_timeout_create_ms(1, get_name, pvt, NULL);
+}
+
+static bool unit_init(struct mesh_io *io, void *opt,
+				mesh_io_ready_func_t cb, void *user_data)
+{
+	struct mesh_io_private *pvt;
+	char *sk_path;
+	size_t size;
+
+	l_debug("Starting Unit test IO");
+	if (!io || io->pvt)
+		return false;
+
+	sk_path = (char *) opt;
+
+	pvt = l_new(struct mesh_io_private, 1);
+
+	pvt->addr.sun_family = AF_LOCAL;
+	snprintf(pvt->addr.sun_path, sizeof(pvt->addr.sun_path), "%s",
+								sk_path);
+
+	pvt->fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (pvt->fd < 0)
+		goto fail;
+
+	unlink(pvt->addr.sun_path);
+	size = offsetof(struct sockaddr_un, sun_path) +
+						strlen(pvt->addr.sun_path);
+
+	if (bind(pvt->fd, (struct sockaddr *) &pvt->addr, size) < 0)
+		goto fail;
+
+	/* Setup socket handlers */
+	pvt->sio = l_io_new(pvt->fd);
+	if (!l_io_set_read_handler(pvt->sio, incoming, pvt, NULL))
+		goto fail;
+
+	pvt->rx_regs = l_queue_new();
+	pvt->tx_pkts = l_queue_new();
+
+	pvt->ready_callback = cb;
+	pvt->user_data = user_data;
+
+	io->pvt = pvt;
+
+	l_idle_oneshot(unit_up, pvt, NULL);
+
+	return true;
+
+fail:
+	l_error("Failed to bind Unit Test socket");
+	free_socket(pvt);
+	l_free(pvt);
+
+	return false;
+}
+
+static bool unit_destroy(struct mesh_io *io)
+{
+	struct mesh_io_private *pvt = io->pvt;
+
+	if (!pvt)
+		return true;
+
+	l_free(pvt->unique_name);
+	l_timeout_remove(pvt->tx_timeout);
+	l_queue_destroy(pvt->rx_regs, l_free);
+	l_queue_destroy(pvt->tx_pkts, l_free);
+
+	free_socket(pvt);
+
+	l_free(pvt);
+	io->pvt = NULL;
+
+	return true;
+}
+
+static bool unit_caps(struct mesh_io *io, struct mesh_io_caps *caps)
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
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
+							uint16_t interval)
+{
+	send(pvt->fd, tx->pkt, tx->len, MSG_DONTWAIT);
+
+	if (tx->delete) {
+		l_queue_remove_if(pvt->tx_pkts, simple_match, tx);
+		l_free(tx);
+	}
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
+	struct mesh_io_private *pvt = io->pvt;
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
+		sending = !l_queue_isempty(pvt->tx_pkts);
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
+		} while (tx);
+	}
+
+	if (l_queue_isempty(pvt->tx_pkts)) {
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
+	struct mesh_io_private *pvt = io->pvt;
+	struct pvt_rx_reg *rx_reg;
+
+	if (!cb || !filter || !len)
+		return false;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
+
+	l_free(rx_reg);
+	rx_reg = l_malloc(sizeof(*rx_reg) + len);
+
+	memcpy(rx_reg->filter, filter, len);
+	rx_reg->len = len;
+	rx_reg->cb = cb;
+	rx_reg->user_data = user_data;
+
+	l_queue_push_head(pvt->rx_regs, rx_reg);
+
+	return true;
+}
+
+static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
+								uint8_t len)
+{
+	return true;
+}
+
+const struct mesh_io_api mesh_io_unit = {
+	.init = unit_init,
+	.destroy = unit_destroy,
+	.caps = unit_caps,
+	.send = send_tx,
+	.reg = recv_register,
+	.dereg = recv_deregister,
+	.cancel = tx_cancel,
+};
diff --git a/mesh/mesh-io-unit.h b/mesh/mesh-io-unit.h
new file mode 100644
index 000000000..846eea7bc
--- /dev/null
+++ b/mesh/mesh-io-unit.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+extern const struct mesh_io_api mesh_io_unit;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 62fc5d12e..96891313a 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -22,10 +22,12 @@
 
 /* List of Mesh-IO Type headers */
 #include "mesh/mesh-io-generic.h"
+#include "mesh/mesh-io-unit.h"
 
 /* List of Supported Mesh-IO Types */
 static const struct mesh_io_table table[] = {
-	{MESH_IO_TYPE_GENERIC,	&mesh_io_generic}
+	{MESH_IO_TYPE_GENERIC, &mesh_io_generic},
+	{MESH_IO_TYPE_UNIT_TEST, &mesh_io_unit},
 };
 
 static struct l_queue *io_list;
@@ -64,12 +66,9 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 
 	io = l_new(struct mesh_io, 1);
 
-	if (!io)
-		return NULL;
-
 	io->type = type;
-
 	io->api = api;
+
 	if (!api->init(io, opts, cb, user_data))
 		goto fail;
 
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index b11c6c6e1..80ef3fa3e 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -14,7 +14,8 @@ struct mesh_io;
 
 enum mesh_io_type {
 	MESH_IO_TYPE_NONE = 0,
-	MESH_IO_TYPE_GENERIC
+	MESH_IO_TYPE_GENERIC,
+	MESH_IO_TYPE_UNIT_TEST
 };
 
 enum mesh_io_timing_type {
-- 
2.26.2

