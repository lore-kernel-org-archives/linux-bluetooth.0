Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E24C31E51
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8722082C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KMTowxhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfFRL1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:27:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45672 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfFRL1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 07:27:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so12692370lje.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHARI2K2eN3RR35SHQl/604qEc6WeNbN8t4LGBpTY88=;
        b=KMTowxhl2StzNguBh9ou9ZOyeHauOM09M9cnzrBv5eeTiZGd+q7UQZS2k+KB9OoSYp
         5mevA3gGXfjSmMX7fQHlzNpIpq3ys8JpVX25j9Tz6GzZ4JRE0+aFntInKo3ic8butzxN
         9ApxRcnjz6bJamslfFsyeUhyH7lQoErUrIc2VWQEoUBmOkOFhu0BudVT7rMHsbP8LjH8
         392SsjnZLhwcdv03sjmbg24yCMoj+0c7p2weeAs4yZ5I/DhUEeiaNgHURjuv6Gg/5Axp
         68wlRkument3ZppKsqlNf64sdhSvWfFx8qCuBhSVjqF7Q3kLXYHjlAA+tgwsduayPgMt
         +RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHARI2K2eN3RR35SHQl/604qEc6WeNbN8t4LGBpTY88=;
        b=iQ811ybItlvBUEjECQaF00PKvRRMfahypUTzCpfdA5stK/ZilC8s30z52mL4SiD4gO
         +DCWVh4B4/x6+kcCtvv6DKH/auVtBWNOMqOJ+lsXg9GcbhW4wTMV2ZP7JbMv6whHMKUX
         q9e5T98KF1PpS1X09N3UhY6UlkDuq5DWhyFXXiP5VrWJ8yS35r6HkutfAzK+RvyKILEC
         MTZSeJUKC/Elf4L0v/ypgw8G2YBXwEuY0j7/80ANtmH/ZZAsQImspi2jg9LwJJcRlkAI
         wsIG03l1Ao9mgwtvFoZLsSm5F+Ft1U5YCPWOFWy1vC4nEjkmO0WQ0lr+01ROUPyDRuXR
         772w==
X-Gm-Message-State: APjAAAWBQrwu/4EOU4XW7Z81kTXseNPw0y4cwbmW1CnkdHbfPGtHpl5G
        BFQmMQl8MXhLuD36ewhOvLLy3rmUDkA=
X-Google-Smtp-Source: APXvYqyU1dJ/RYfT38TMxtSqIPYnOUpLhp+odDTWfzz9XeM4FlvdiweyeC/r784xeoGxB1s8uBjNAg==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr11538448ljj.205.1560857222931;
        Tue, 18 Jun 2019 04:27:02 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id c19sm2135278lfi.39.2019.06.18.04.27.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 04:27:02 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Move HCI handling to mesh-io-generic
Date:   Tue, 18 Jun 2019 13:26:55 +0200
Message-Id: <20190618112655.19963-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
References: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch separates 'mesh' module from 'mesh_io', particularly
regarding configuration and initialization.

Main code is no longer aware of MGMT and HCI usage - querying available
HCI interfaces now happens in mesh-io-generic.
---
 mesh/main.c            |   4 +-
 mesh/mesh-io-api.h     |   3 +-
 mesh/mesh-io-generic.c | 203 ++++++++++++++++++++++++++++++++++++-----
 mesh/mesh-io.c         |  17 ++--
 mesh/mesh-io.h         |   2 +-
 mesh/mesh.c            | 189 +++-----------------------------------
 mesh/mesh.h            |   4 +-
 7 files changed, 209 insertions(+), 213 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 3cecd8fbf..262e3da48 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -35,6 +35,7 @@
 
 #include "mesh/mesh.h"
 #include "mesh/dbus.h"
+#include "mesh/mesh-io.h"
 
 static const struct option main_options[] = {
 	{ "index",	required_argument,	NULL, 'i' },
@@ -166,7 +167,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!mesh_init(index, config_dir)) {
+
+	if (!mesh_init(config_dir, MESH_IO_TYPE_GENERIC, &index)) {
 		l_error("Failed to initialize mesh");
 		status = EXIT_FAILURE;
 		goto done;
diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index acf12445d..4cdf1f80a 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -19,7 +19,7 @@
 
 struct mesh_io_private;
 
-typedef bool (*mesh_io_init_t)(uint16_t index, struct mesh_io *io);
+typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
 typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
@@ -47,7 +47,6 @@ struct mesh_io_api {
 
 struct mesh_io {
 	enum mesh_io_type		type;
-	uint16_t			index;
 	const struct mesh_io_api	*api;
 	struct mesh_io_private		*pvt;
 };
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 756dceabc..5bfe40700 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -26,6 +26,9 @@
 
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
 
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
@@ -68,6 +71,19 @@ struct tx_pattern {
 	uint8_t				len;
 };
 
+struct read_info_req {
+	int index;
+	struct mesh_io *io;
+};
+
+static struct l_queue *controllers;
+static struct mgmt *mgmt_mesh;
+
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
 static uint32_t get_instant(void)
 {
 	struct timeval tm;
@@ -278,40 +294,179 @@ static void configure_hci(struct mesh_io_private *io)
 				sizeof(cmd), hci_generic_callback, NULL, NULL);
 }
 
-static bool dev_init(uint16_t index, struct mesh_io *io)
+static bool hci_init(struct mesh_io *io)
 {
-	struct mesh_io_private *tmp;
-
-	if (!io || io->pvt)
+	io->pvt->hci = bt_hci_new_user_channel(io->pvt->index);
+	if (!io->pvt->hci) {
+		l_error("Failed to start mesh io (hci %u)", io->pvt->index);
 		return false;
+	}
 
-	tmp = l_new(struct mesh_io_private, 1);
+	configure_hci(io->pvt);
 
-	if (tmp == NULL)
-		return false;
+	bt_hci_register(io->pvt->hci, BT_HCI_EVT_LE_META_EVENT,
+						event_callback, io, NULL);
 
-	tmp->rx_regs = l_queue_new();
-	tmp->tx_pkts = l_queue_new();
-	if (!tmp->rx_regs || !tmp->tx_pkts)
-		goto fail;
+	l_debug("Started mesh on hci %u", io->pvt->index);
+	return true;
+}
 
-	tmp->hci = bt_hci_new_user_channel(index);
-	if (!tmp->hci)
-		goto fail;
+static void read_info_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct read_info_req *req = user_data;
+	const struct mgmt_rp_read_info *rp = param;
+	uint32_t current_settings, supported_settings;
 
-	configure_hci(tmp);
+	l_debug("hci %u status 0x%02x", req->index, status);
 
-	bt_hci_register(tmp->hci, BT_HCI_EVT_LE_META_EVENT,
-						event_callback, io, NULL);
+	if (status != MGMT_STATUS_SUCCESS) {
+		l_error("Failed to read info for hci index %u: %s (0x%02x)",
+				req->index, mgmt_errstr(status), status);
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
+	l_debug("settings: supp %8.8x curr %8.8x",
+					supported_settings, current_settings);
+
+	if (current_settings & MGMT_SETTING_POWERED) {
+		l_info("Controller hci %u is in use", req->index);
+		return;
+	}
+
+	if (!(supported_settings & MGMT_SETTING_LE)) {
+		l_info("Controller hci %u does not support LE", req->index);
+		return;
+	}
+
+	if (req->io->pvt->index != MGMT_INDEX_NONE &&
+					req->index != req->io->pvt->index) {
+		l_debug("Ignore index %d", req->index);
+		return;
+	}
+
+	req->io->pvt->index = req->index;
+	hci_init(req->io);
+}
+
+static void index_added(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct read_info_req *req;
+	struct mesh_io *io = user_data;
+
+	if (io->pvt->index != MGMT_INDEX_NONE &&
+					index != io->pvt->index) {
+		l_debug("Ignore index %d", index);
+		return;
+	}
+
+	if (l_queue_find(controllers, simple_match, L_UINT_TO_PTR(index)))
+		return;
+
+	l_queue_push_tail(controllers, L_UINT_TO_PTR(index));
+
+	req = l_new(struct read_info_req, 1);
+	req->index = index;
+	req->io = io;
+
+	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
+			read_info_cb, req, NULL) != 0)
+		return;
+
+	l_queue_remove(controllers, L_UINT_TO_PTR(index));
+}
+
+static void index_removed(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	l_warn("Hci dev %4.4x removed", index);
+	l_queue_remove(controllers, L_UINT_TO_PTR(index));
+}
+
+static void read_index_list_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_index_list *rp = param;
+	uint16_t num;
+	int i;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		l_error("Failed to read index list: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		l_error("Read index list response sixe too short");
+		return;
+	}
+
+	num = btohs(rp->num_controllers);
+
+	l_debug("Number of controllers: %u", num);
+
+	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
+		l_error("Incorrect packet size for index list response");
+		return;
+	}
+
+	for (i = 0; i < num; i++) {
+		uint16_t index;
+
+		index = btohs(rp->index[i]);
+		index_added(index, 0, NULL, user_data);
+	}
+}
+
+static bool mgmt_init(struct mesh_io *io)
+{
+	mgmt_mesh = mgmt_new_default();
+	if (!mgmt_mesh) {
+		l_error("Failed to initialize mesh management");
+		return false;
+	}
+
+	controllers = l_queue_new();
+
+	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+						index_added, io, NULL);
+	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+						index_removed, io, NULL);
+
+	/* Use MGMT to find a candidate controller */
+	l_debug("send read index_list");
+	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INDEX_LIST,
+					MGMT_INDEX_NONE, 0, NULL,
+					read_index_list_cb, io, NULL) <= 0)
+		return false;
 
-	io->pvt = tmp;
 	return true;
+}
+
+static bool dev_init(struct mesh_io *io, void *opts)
+{
+	if (!io || io->pvt)
+		return false;
+
+	io->pvt = l_new(struct mesh_io_private, 1);
+	io->pvt->index = *(int *)opts;
 
-fail:
-	l_queue_destroy(tmp->rx_regs, l_free);
-	l_queue_destroy(tmp->tx_pkts, l_free);
-	l_free(tmp);
-	return false;
+	io->pvt->rx_regs = l_queue_new();
+	io->pvt->tx_pkts = l_queue_new();
+
+	if (io->pvt->index == MGMT_INDEX_NONE)
+		return mgmt_init(io);
+	else
+		return hci_init(io);
 }
 
 static bool dev_destroy(struct mesh_io *io)
@@ -327,6 +482,8 @@ static bool dev_destroy(struct mesh_io *io)
 	l_queue_destroy(pvt->tx_pkts, l_free);
 	l_free(pvt);
 	io->pvt = NULL;
+	l_queue_destroy(controllers, NULL);
+	mgmt_unref(mgmt_mesh);
 
 	return true;
 }
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 37153ea9d..b6ad2f995 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -39,26 +39,26 @@ static const struct mesh_io_table table[] = {
 
 static struct l_queue *io_list;
 
+
 static bool match_by_io(const void *a, const void *b)
 {
 	return a == b;
 }
 
-static bool match_by_index(const void *a, const void *b)
+static bool match_by_type(const void *a, const void *b)
 {
 	const struct mesh_io *io = a;
+	const enum mesh_io_type *type = b;
 
-	return io->index == L_PTR_TO_UINT(b);
+	return io->type == *type;
 }
 
-struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type)
+struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts)
 {
 	const struct mesh_io_api *api = NULL;
 	struct mesh_io *io;
 	uint16_t i;
 
-	l_info("%s %d\n", __func__, type);
-
 	for (i = 0; i < L_ARRAY_SIZE(table); i++) {
 		if (table[i].type == type) {
 			api = table[i].api;
@@ -66,7 +66,8 @@ struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type)
 		}
 	}
 
-	io = l_queue_find(io_list, match_by_index, L_UINT_TO_PTR(index));
+
+	io = l_queue_find(io_list, match_by_type, &type);
 
 	if (!api || !api->init || io)
 		return NULL;
@@ -77,9 +78,9 @@ struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type)
 		return NULL;
 
 	io->type = type;
-	io->index = index;
+
 	io->api = api;
-	if (!api->init(index, io))
+	if (!api->init(io, opts))
 		goto fail;
 
 	if (!io_list)
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 71d3cb980..6585205c7 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -80,7 +80,7 @@ typedef void (*mesh_io_recv_func_t)(void *user_data,
 typedef void (*mesh_io_status_func_t)(void *user_data, int status,
 							uint8_t filter_id);
 
-struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type);
+struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts);
 void mesh_io_destroy(struct mesh_io *io);
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 231a6bca4..26acfd4dc 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -24,11 +24,6 @@
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
-#include "lib/bluetooth.h"
-#include "lib/mgmt.h"
-
-#include "src/shared/mgmt.h"
-
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
@@ -76,9 +71,6 @@ struct join_data{
 };
 
 static struct bt_mesh mesh;
-static struct l_queue *controllers;
-static struct mgmt *mgmt_mesh;
-static bool initialized;
 
 /* We allow only one outstanding Join request */
 static struct join_data *join_pending;
@@ -91,29 +83,6 @@ static bool simple_match(const void *a, const void *b)
 	return a == b;
 }
 
-static void start_io(uint16_t index)
-{
-	struct mesh_io *io;
-	struct mesh_io_caps caps;
-
-	l_debug("Starting mesh on hci %u", index);
-
-	io = mesh_io_new(index, MESH_IO_TYPE_GENERIC);
-	if (!io) {
-		l_error("Failed to start mesh io (hci %u)", index);
-		return;
-	}
-
-	mesh_io_get_caps(io, &caps);
-	mesh.max_filters = caps.max_num_filters;
-
-	mesh.io = io;
-
-	l_debug("Started mesh (io %p) on hci %u", mesh.io, index);
-
-	node_attach_io_all(io);
-}
-
 /* Used for any outbound traffic that doesn't have Friendship Constraints */
 /* This includes Beacons, Provisioning and unrestricted Network Traffic */
 bool mesh_send_pkt(uint8_t count, uint16_t interval,
@@ -167,143 +136,13 @@ void mesh_unreg_prov_rx(prov_rx_cb_t cb)
 	mesh_io_deregister_recv_cb(mesh.io, MESH_IO_FILTER_PROV);
 }
 
-static void read_info_cb(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
+bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 {
-	uint16_t index = L_PTR_TO_UINT(user_data);
-	const struct mgmt_rp_read_info *rp = param;
-	uint32_t current_settings, supported_settings;
+	struct mesh_io_caps caps;
 
 	if (mesh.io)
-		/* Already initialized */
-		return;
-
-	l_debug("hci %u status 0x%02x", index, status);
-
-	if (status != MGMT_STATUS_SUCCESS) {
-		l_error("Failed to read info for hci index %u: %s (0x%02x)",
-					index, mgmt_errstr(status), status);
-		return;
-	}
-
-	if (length < sizeof(*rp)) {
-		l_error("Read info response too short");
-		return;
-	}
-
-	current_settings = btohl(rp->current_settings);
-	supported_settings = btohl(rp->supported_settings);
-
-	l_debug("settings: supp %8.8x curr %8.8x",
-					supported_settings, current_settings);
-
-	if (current_settings & MGMT_SETTING_POWERED) {
-		l_info("Controller hci %u is in use", index);
-		return;
-	}
-
-	if (!(supported_settings & MGMT_SETTING_LE)) {
-		l_info("Controller hci %u does not support LE", index);
-		return;
-	}
-
-	start_io(index);
-}
-
-static void index_added(uint16_t index, uint16_t length, const void *param,
-							void *user_data)
-{
-	l_debug("hci device %u", index);
-
-	if (mesh.req_index != MGMT_INDEX_NONE &&
-					index != mesh.req_index) {
-		l_debug("Ignore index %d", index);
-		return;
-	}
-
-	if (l_queue_find(controllers, simple_match, L_UINT_TO_PTR(index)))
-		return;
-
-	l_queue_push_tail(controllers, L_UINT_TO_PTR(index));
-
-	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
-			read_info_cb, L_UINT_TO_PTR(index), NULL) > 0)
-		return;
-
-	l_queue_remove(controllers, L_UINT_TO_PTR(index));
-}
-
-static void index_removed(uint16_t index, uint16_t length, const void *param,
-							void *user_data)
-{
-	l_warn("Hci dev %4.4x removed", index);
-	l_queue_remove(controllers, L_UINT_TO_PTR(index));
-}
-
-static void read_index_list_cb(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	const struct mgmt_rp_read_index_list *rp = param;
-	uint16_t num;
-	int i;
-
-	if (status != MGMT_STATUS_SUCCESS) {
-		l_error("Failed to read index list: %s (0x%02x)",
-						mgmt_errstr(status), status);
-		return;
-	}
-
-	if (length < sizeof(*rp)) {
-		l_error("Read index list response sixe too short");
-		return;
-	}
-
-	num = btohs(rp->num_controllers);
-
-	l_debug("Number of controllers: %u", num);
-
-	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
-		l_error("Incorrect packet size for index list response");
-		return;
-	}
-
-	for (i = 0; i < num; i++) {
-		uint16_t index;
-
-		index = btohs(rp->index[i]);
-		index_added(index, 0, NULL, user_data);
-	}
-}
-
-static bool init_mgmt(void)
-{
-	mgmt_mesh = mgmt_new_default();
-	if (!mgmt_mesh)
-		return false;
-
-	controllers = l_queue_new();
-	if (!controllers)
-		return false;
-
-	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
-						index_added, NULL, NULL);
-	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
-						index_removed, NULL, NULL);
-	return true;
-}
-
-bool mesh_init(uint16_t index, const char *config_dir)
-{
-	if (initialized)
 		return true;
 
-	if (index == MGMT_INDEX_NONE && !init_mgmt()) {
-		l_error("Failed to initialize mesh management");
-		return false;
-	}
-
-	mesh.req_index = index;
-
 	mesh_model_init();
 	mesh_agent_init();
 
@@ -319,18 +158,16 @@ bool mesh_init(uint16_t index, const char *config_dir)
 	if (!storage_load_nodes(config_dir))
 		return false;
 
-	if (index == MGMT_INDEX_NONE) {
-		/* Use MGMT to find a candidate controller */
-		l_debug("send read index_list");
-		if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INDEX_LIST,
-					MGMT_INDEX_NONE, 0, NULL,
-					read_index_list_cb, NULL, NULL) <= 0)
-			return false;
-	} else {
-		/* Open specified controller without searching */
-		start_io(mesh.req_index);
-		return mesh.io != NULL;
-	}
+	mesh.io = mesh_io_new(type, opts);
+	if (!mesh.io)
+		return false;
+
+	l_debug("io %p", mesh.io);
+	mesh_io_get_caps(mesh.io, &caps);
+	mesh.max_filters = caps.max_num_filters;
+
+	node_attach_io_all(mesh.io);
+
 	return true;
 }
 
@@ -366,7 +203,6 @@ void mesh_cleanup(void)
 	struct l_dbus_message *reply;
 
 	mesh_io_destroy(mesh.io);
-	mgmt_unref(mgmt_mesh);
 
 	if (join_pending) {
 
@@ -384,7 +220,6 @@ void mesh_cleanup(void)
 	node_cleanup_all();
 	mesh_model_cleanup();
 
-	l_queue_destroy(controllers, NULL);
 	l_dbus_object_remove_interface(dbus_get_bus(), BLUEZ_MESH_PATH,
 							MESH_NETWORK_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), MESH_NETWORK_INTERFACE);
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 320a108ed..14b1fb517 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -28,9 +28,11 @@
 #define MESH_PROVISIONER_INTERFACE "org.bluez.mesh.Provisioner1"
 #define ERROR_INTERFACE "org.bluez.mesh.Error"
 
+enum mesh_io_type;
+
 typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 								uint16_t len);
-bool mesh_init(uint16_t index, const char *in_config_name);
+bool mesh_init(const char *in_config_name, enum mesh_io_type type, void *opts);
 void mesh_cleanup(void);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
-- 
2.19.1

