Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B59ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiIVVio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiIVVig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:38:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D6103FF6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663882714; x=1695418714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSCWd4R4+IGAyuJwgOOMbgtu6XJWJTKNhE/twQVwaPM=;
  b=LtsNZ20teTt9x2V7DIQZIq35wlt3hpKkM1M0YYBli/wK61OlW+ygSgEX
   GRr3MXI6tVJKZ2KfcyYZtNR7A2baGZ7E6bN9cZREoqoP/YgPrXvxRWBIt
   7rWfk3q4jA3oy4SRUHOGmQSJH/Vk+Pxxccv0cU79vIxYWMs1BngLKGTES
   g5/NiE1VqsnYNsUjyVRE2Xd1BUZJUQ1v6F/F+Z1WNgSlPcd4oeX+psXTT
   SNl9YfiO+8WSFHfipuOkfMpxY4b8CpZDSYU9dM00CNs/FtmWeXmonJ3W4
   LEsCMiUJKIceN0wAJYt4XuGuY1OBWAD3bo+2jEXKXTG0PMmFLZTXEPu8x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364450479"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364450479"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571141913"
Received: from avarhadk-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.161.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:33 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 2/2] mesh: Add new kernel MGMT based IO transport
Date:   Thu, 22 Sep 2022 14:38:22 -0700
Message-Id: <20220922213822.600692-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922213822.600692-1-brian.gix@intel.com>
References: <20220922213822.600692-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

1. Re-structures MGMT handling such that it is used to detect kernel
   support of the mesh MGMT opcodes and events before selecting between
   using MGMT or the legacy raw HCI socket method.

2. Re-structures main() to allow command line to prefer MGMT over HCI or
   visa versa, plus optionally pass an explicte controller.

3. Adds mesh-io-mgmt as a transport.
---
 Makefile.mesh          |   9 +-
 mesh/main.c            |  39 ++++++++-
 mesh/mesh-io-api.h     |  11 ++-
 mesh/mesh-io-generic.c |  47 +++--------
 mesh/mesh-io-unit.c    |  13 ++-
 mesh/mesh-io.c         | 188 ++++++++++++++++++++++++++++++-----------
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++++++++++++++++++++++--------
 mesh/mesh-mgmt.h       |  12 ++-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 11 files changed, 354 insertions(+), 141 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index fc28b0557..3047f362b 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -13,12 +13,11 @@ endif
 mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/net-keys.h mesh/net-keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
-				mesh/mesh-mgmt.c mesh/mesh-mgmt.h \
+				mesh/mesh-mgmt.h  mesh/mesh-mgmt.c \
 				mesh/error.h mesh/mesh-io-api.h \
-				mesh/mesh-io-generic.h \
-				mesh/mesh-io-generic.c \
-				mesh/mesh-io-unit.h \
-				mesh/mesh-io-unit.c \
+				mesh/mesh-io-unit.h mesh/mesh-io-unit.c \
+				mesh/mesh-io-mgmt.h mesh/mesh-io-mgmt.c \
+				mesh/mesh-io-generic.h mesh/mesh-io-generic.c \
 				mesh/net.h mesh/net.c \
 				mesh/crypto.h mesh/crypto.c \
 				mesh/friend.h mesh/friend.c \
diff --git a/mesh/main.c b/mesh/main.c
index dd99c3085..619b17d88 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -123,6 +123,12 @@ static void disconnect_callback(void *user_data)
 	l_main_quit();
 }
 
+static void kill_to(struct l_timeout *timeout, void *user_data)
+{
+	l_timeout_remove(timeout);
+	l_main_quit();
+}
+
 static void signal_handler(uint32_t signo, void *user_data)
 {
 	static bool terminated;
@@ -131,13 +137,38 @@ static void signal_handler(uint32_t signo, void *user_data)
 		return;
 
 	l_info("Terminating");
-	l_main_quit();
+	mesh_cleanup(true);
+	l_timeout_create(1, kill_to, NULL, NULL);
 	terminated = true;
 }
 
 static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
 {
-	if (strstr(optarg, "generic") == optarg) {
+	if (strstr(optarg, "auto") == optarg) {
+		int *index = l_new(int, 1);
+
+		*type = MESH_IO_TYPE_AUTO;
+		*opts = index;
+
+		optarg += strlen("auto");
+		if (!*optarg) {
+			*index = MGMT_INDEX_NONE;
+			return true;
+		}
+
+		if (*optarg != ':')
+			return false;
+
+		optarg++;
+
+		if (sscanf(optarg, "hci%d", index) == 1)
+			return true;
+
+		if (sscanf(optarg, "%d", index) == 1)
+			return true;
+
+		return false;
+	} else if (strstr(optarg, "generic") == optarg) {
 		int *index = l_new(int, 1);
 
 		*type = MESH_IO_TYPE_GENERIC;
@@ -251,7 +282,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (!io)
-		io = l_strdup_printf("generic");
+		io = l_strdup_printf("auto");
 
 	if (!parse_io(io, &io_type, &io_opts)) {
 		l_error("Invalid io: %s", io);
@@ -295,7 +326,7 @@ done:
 	l_free(io);
 	l_free(io_opts);
 
-	mesh_cleanup();
+	mesh_cleanup(false);
 	l_dbus_destroy(dbus);
 	l_main_exit();
 
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
index 2d7ef261e..827128ec8 100644
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
 
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index bf3f808e4..f4f619803 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -25,13 +25,13 @@
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
-#include "mesh/mesh-io-generic.h"
+#include "mesh/mesh-io-unit.h"
 
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
index 96891313a..32e6e2521 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -15,95 +15,160 @@
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/mesh-mgmt.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
 
 /* List of Mesh-IO Type headers */
+#include "mesh/mesh-io-mgmt.h"
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
+		if (table[i].type == type)
+			return table[i].api;
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
-
-	io = l_queue_find(io_list, match_by_type, L_UINT_TO_PTR(type));
+	l_warn("up:%d pwr: %d mesh: %d", up, pwr, mesh);
 
-	if (!api || !api->init || io)
-		return NULL;
+	/* If specific IO controller requested, honor it */
+	if (default_io->favored_index != MGMT_INDEX_NONE &&
+					default_io->favored_index != index)
+		return;
 
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
+	if (mesh && type != MESH_IO_TYPE_GENERIC)
+		api = io_api(MESH_IO_TYPE_MGMT);
 
-	if (l_queue_push_head(io_list, io))
-		return io;
+	else if (!pwr)
+		api = io_api(MESH_IO_TYPE_GENERIC);
 
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
 
-	if (l_queue_isempty(io_list)) {
-		l_queue_destroy(io_list, NULL);
-		io_list = NULL;
+	/* Only allow one IO */
+	if (default_io)
+		return NULL;
+
+	default_io = l_new(struct mesh_io, 1);
+	default_io->ready = cb;
+	default_io->user_data = user_data;
+	default_io->favored_index = *(int *) opts;
+	default_io->rx_regs = l_queue_new();
+
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
@@ -115,7 +180,17 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
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
@@ -123,10 +198,24 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
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
@@ -137,10 +226,11 @@ bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
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
@@ -151,7 +241,11 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
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
diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index 754093dbc..32254613b 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -12,35 +12,78 @@
 #include <config.h>
 #endif
 
+#include <ell/ell.h>
+
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 
-#include "ell/queue.h"
-#include "ell/log.h"
-#include "ell/util.h"
-
 #include "mesh/mesh-mgmt.h"
 
-struct read_info_reg {
-	mesh_mgmt_read_info_func_t cb;
-	void *user_data;
+struct mesh_controler {
+	int	index;
+	bool	mesh_support;
+	bool	powered;
 };
 
-struct read_info_req {
-	int index;
-	struct mesh_io *io;
+static mesh_mgmt_read_info_func_t ctl_info;
+static struct mgmt *mgmt_mesh;
+static struct l_queue *ctl_list;
+static void *list_user_data;
+static bool mesh_detected;
+
+static const uint8_t set_exp_feat_param_mesh[] = {
+       0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f, 0x05, 0xbf, /* UUID - Mesh */
+       0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
+       0x01,                                           /* Action - enable */
 };
 
-static struct mgmt *mgmt_mesh;
-static struct l_queue *read_info_regs;
+static bool by_index(const void *a, const void *b)
+{
+	const struct mesh_controler *ctl = a;
+	int index = L_PTR_TO_UINT(b);
+
+	return ctl->index == index;
+}
 
-static void process_read_info_req(void *data, void *user_data)
+static void index_removed(uint16_t index, uint16_t length, const void *param,
+							void *user_data);
+static void features_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
 {
-	struct read_info_reg *reg = data;
 	int index = L_PTR_TO_UINT(user_data);
+	struct mesh_controler *ctl;
+
 
-	reg->cb(index, reg->user_data);
+	ctl = l_queue_find(ctl_list, by_index, L_UINT_TO_PTR(index));
+	if (!ctl)
+		return;
+
+	l_debug("Status: %d, Length: %d", status, length);
+	if (status != MGMT_STATUS_NOT_SUPPORTED &&
+					status != MGMT_STATUS_UNKNOWN_COMMAND) {
+		ctl->mesh_support = true;
+		if (!mesh_detected) {
+			mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED,
+					MGMT_INDEX_NONE, index_removed,
+					NULL, NULL);
+		}
+		mesh_detected = true;
+	} else
+		l_debug("Kernel mesh not supported for hci%u", index);
+
+	if (ctl_info)
+		ctl_info(index, true, ctl->powered, ctl->mesh_support,
+							list_user_data);
+}
+
+static void set_exp_mesh_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	int index = L_PTR_TO_UINT(user_data);
+
+	mesh_mgmt_send(MGMT_OP_MESH_READ_FEATURES, index, 0, NULL,
+				features_cb, L_UINT_TO_PTR(index), NULL);
 }
 
 static void read_info_cb(uint8_t status, uint16_t length,
@@ -49,12 +92,25 @@ static void read_info_cb(uint8_t status, uint16_t length,
 	int index = L_PTR_TO_UINT(user_data);
 	const struct mgmt_rp_read_info *rp = param;
 	uint32_t current_settings, supported_settings;
+	struct mesh_controler *ctl;
 
 	l_debug("hci %u status 0x%02x", index, status);
 
+	ctl = l_queue_find(ctl_list, by_index, L_UINT_TO_PTR(index));
+	if (!ctl)
+		return;
+
 	if (status != MGMT_STATUS_SUCCESS) {
+		ctl = l_queue_remove_if(ctl_list, by_index,
+						L_UINT_TO_PTR(index));
 		l_error("Failed to read info for hci index %u: %s (0x%02x)",
 				index, mgmt_errstr(status), status);
+
+		l_warn("Hci dev %d removal detected", index);
+		if (ctl && ctl_info)
+			ctl_info(index, false, false, false, list_user_data);
+
+		l_free(ctl);
 		return;
 	}
 
@@ -69,23 +125,36 @@ static void read_info_cb(uint8_t status, uint16_t length,
 	l_debug("settings: supp %8.8x curr %8.8x",
 					supported_settings, current_settings);
 
-	if (current_settings & MGMT_SETTING_POWERED) {
-		l_info("Controller hci %u is in use", index);
-		return;
-	}
-
 	if (!(supported_settings & MGMT_SETTING_LE)) {
 		l_info("Controller hci %u does not support LE", index);
+		l_queue_remove(ctl_list, ctl);
+		l_free(ctl);
 		return;
 	}
 
-	l_queue_foreach(read_info_regs, process_read_info_req,
-							L_UINT_TO_PTR(index));
+	if (current_settings & MGMT_SETTING_POWERED)
+		ctl->powered = true;
+
+	mesh_mgmt_send(MGMT_OP_SET_EXP_FEATURE, index,
+			sizeof(set_exp_feat_param_mesh),
+			set_exp_feat_param_mesh,
+			set_exp_mesh_cb, L_UINT_TO_PTR(index), NULL);
 }
 
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
+	struct mesh_controler *ctl = l_queue_find(ctl_list, by_index,
+							L_UINT_TO_PTR(index));
+
+	if (!ctl) {
+		ctl = l_new(struct mesh_controler, 1);
+		ctl->index = index;
+		l_queue_push_head(ctl_list, ctl);
+	} else {
+		ctl->mesh_support = ctl->powered = false;
+	}
+
 	mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
 				read_info_cb, L_UINT_TO_PTR(index), NULL);
 }
@@ -93,7 +162,9 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 static void index_removed(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
-	l_warn("Hci dev %4.4x removed", index);
+	mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_cb, L_UINT_TO_PTR(index), NULL);
+
 }
 
 static void read_index_list_cb(uint8_t status, uint16_t length,
@@ -133,8 +204,8 @@ static void read_index_list_cb(uint8_t status, uint16_t length,
 
 static bool mesh_mgmt_init(void)
 {
-	if (!read_info_regs)
-		read_info_regs = l_queue_new();
+	if (!ctl_list)
+		ctl_list = l_queue_new();
 
 	if (!mgmt_mesh) {
 		mgmt_mesh = mgmt_new_default();
@@ -146,8 +217,6 @@ static bool mesh_mgmt_init(void)
 
 		mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED,
 				MGMT_INDEX_NONE, index_added, NULL, NULL);
-		mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED,
-				MGMT_INDEX_NONE, index_removed, NULL, NULL);
 	}
 
 	return true;
@@ -155,16 +224,11 @@ static bool mesh_mgmt_init(void)
 
 bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data)
 {
-	struct read_info_reg *reg;
-
 	if (!mesh_mgmt_init())
 		return false;
 
-	reg = l_new(struct read_info_reg, 1);
-	reg->cb = cb;
-	reg->user_data = user_data;
-
-	l_queue_push_tail(read_info_regs, reg);
+	ctl_info = cb;
+	list_user_data = user_data;
 
 	/* Use MGMT to find a candidate controller */
 	l_debug("send read index_list");
@@ -175,3 +239,35 @@ bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data)
 
 	return true;
 }
+
+void mesh_mgmt_destroy(void)
+{
+	mgmt_unref(mgmt_mesh);
+	mgmt_mesh = NULL;
+	ctl_info = NULL;
+	list_user_data = NULL;
+	l_queue_destroy(ctl_list, l_free);
+	ctl_list = NULL;
+}
+
+unsigned int mesh_mgmt_send(uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_send_timeout(mgmt_mesh, opcode, index, length, param,
+					callback, user_data, destroy, 0);
+}
+
+unsigned int mesh_mgmt_register(uint16_t event, uint16_t index,
+				mgmt_notify_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_register(mgmt_mesh, event, index, callback,
+						user_data, destroy);
+}
+
+bool mesh_mgmt_unregister(unsigned int id)
+{
+	return mgmt_unregister(mgmt_mesh, id);
+}
diff --git a/mesh/mesh-mgmt.h b/mesh/mesh-mgmt.h
index 90ac14e73..a3cd72faf 100644
--- a/mesh/mesh-mgmt.h
+++ b/mesh/mesh-mgmt.h
@@ -9,6 +9,16 @@
  */
 #include <stdbool.h>
 
-typedef void (*mesh_mgmt_read_info_func_t)(int index, void *user_data);
+typedef void (*mesh_mgmt_read_info_func_t)(int index, bool added, bool powered,
+						bool mesh, void *user_data);
 
 bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data);
+unsigned int mesh_mgmt_send(uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy);
+unsigned int mesh_mgmt_register(uint16_t event, uint16_t index,
+				mgmt_notify_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy);
+bool mesh_mgmt_unregister(unsigned int id);
+void mesh_mgmt_destroy(void);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 62d650328..91cf25175 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -324,11 +324,15 @@ static void free_pending_join_call(bool failed)
 	join_pending = NULL;
 }
 
-void mesh_cleanup(void)
+void mesh_cleanup(bool signaled)
 {
 	struct l_dbus_message *reply;
 
 	mesh_io_destroy(mesh.io);
+	mesh.io = NULL;
+
+	if (signaled)
+		return;
 
 	if (join_pending) {
 
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 0f77ebc58..c30a8d1f0 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -28,7 +28,7 @@ typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 					enum mesh_io_type type, void *opts,
 					mesh_ready_func_t cb, void *user_data);
-void mesh_cleanup(void);
+void mesh_cleanup(bool signaled);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
 const char *mesh_status_str(uint8_t err);
-- 
2.37.3

