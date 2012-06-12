Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] mgmtops: Use cod_busy to track events that may change CoD
Date: Tue, 12 Jun 2012 21:35:50 +0200
Message-Id: <1339529750-14642-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339529750-14642-1-git-send-email-szymon@janc.net.pl>
References: <1339529750-14642-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

MGMT_OP_ADD_UUID, MGMT_OP_SET_DEV_CLASS and MGMT_OP_SET_POWERED
commands may result in change of CoD. Make sure that only one command
is send at time. This is to avoid EBUSY error when adding UUIDs while
setting new CoD.
---
 plugins/mgmtops.c |   85 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 8229da1..83743a1 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -934,6 +934,7 @@ static void read_index_list_complete(int sk, void *buf, size_t len)
 static int mgmt_set_powered(int index, gboolean powered)
 {
 	struct controller_info *info = &controllers[index];
+	int ret;
 
 	DBG("index %d powered %d cod_busy %u", index, powered, info->cod_busy);
 
@@ -946,7 +947,13 @@ static int mgmt_set_powered(int index, gboolean powered)
 		info->pending_powered = FALSE;
 	}
 
-	return mgmt_set_mode(index, MGMT_OP_SET_POWERED, powered);
+	ret = mgmt_set_mode(index, MGMT_OP_SET_POWERED, powered);
+	if (ret < 0)
+		return ret;
+
+	info->cod_busy = powered;
+
+	return ret;
 }
 
 static int mgmt_set_name(int index, const char *name)
@@ -997,6 +1004,8 @@ static int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor)
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
 
+	info->cod_busy = TRUE;
+
 	return 0;
 }
 
@@ -1271,23 +1280,15 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
 		oob_read_local_data_complete(adapter, NULL, NULL);
 }
 
-static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
-								size_t len)
+static void handle_pending_uuids(uint16_t index)
 {
 	struct controller_info *info;
 	struct pending_uuid *pending;
 
-	DBG("add_uuid complete");
-
-	if (index > max_index) {
-		error("Unexpected index %u in add_uuid_complete event", index);
-		return;
-	}
+	DBG("");
 
 	info = &controllers[index];
 
-	info->cod_busy = FALSE;
-
 	if (g_slist_length(info->pending_uuids) == 0) {
 		if (info->pending_class) {
 			info->pending_class = FALSE;
@@ -1310,6 +1311,45 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 	g_free(pending);
 }
 
+static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in add_uuid_complete event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	info->cod_busy = FALSE;
+
+	handle_pending_uuids(index);
+}
+
+static void mgmt_set_dev_class_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in mgmt_set_dev_class_complete "
+								"event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	info->cod_busy = FALSE;
+
+	handle_pending_uuids(index);
+}
+
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
@@ -1361,7 +1401,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		DBG("remove_uuid complete");
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
-		DBG("set_dev_class complete");
+		mgmt_set_dev_class_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
 		DBG("load_link_keys complete");
@@ -1708,6 +1748,25 @@ static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
 		bonding_complete(info, &ev->key.addr.bdaddr, 0);
 }
 
+static void mgmt_cod_changed(uint16_t index)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in mgmt_cod_changed event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	if (info->cod_busy) {
+		info->cod_busy = FALSE;
+		handle_pending_uuids(index);
+	}
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1771,7 +1830,7 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 		mgmt_new_settings(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CLASS_OF_DEV_CHANGED:
-		DBG("hci%u Class of Device changed", index);
+		mgmt_cod_changed(index);
 		break;
 	case MGMT_EV_NEW_LINK_KEY:
 		mgmt_new_link_key(sk, index, buf + MGMT_HDR_SIZE, len);
-- 
1.7.10.4


