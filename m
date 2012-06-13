Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] mgmtops: Handle EBUSY status from MGMT_OP_ADD_UUID commands
Date: Wed, 13 Jun 2012 16:03:52 +0200
Message-ID: <1339596233-16643-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MGMT_OP_ADD_UUID may fail with EBUSY due to ongoing CoD update. In case
of EBUSY error wait for Class Of Device changed event before adding
more UUIDs.
---
 plugins/mgmtops.c |   59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index a196b1f..4ce3ee4 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -78,6 +78,7 @@ static struct controller_info {
 	uint8_t minor;
 
 	gboolean pending_powered;
+	gboolean pending_cod_change;
 } *controllers = NULL;
 
 static int mgmt_sock = -1;
@@ -1272,18 +1273,12 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
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
+	DBG("index %d", index);
 
 	info = &controllers[index];
 
@@ -1311,6 +1306,19 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 	g_free(pending);
 }
 
+static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in add_uuid_complete event", index);
+		return;
+	}
+
+	handle_pending_uuids(index);
+}
+
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
@@ -1434,6 +1442,16 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	}
 }
 
+static void mgmt_add_uuid_busy(int sk, uint16_t index)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	info = &controllers[index];
+	info->pending_cod_change = TRUE;
+}
+
 static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_status *ev = buf;
@@ -1460,6 +1478,10 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		read_local_oob_data_failed(sk, index);
 		break;
+	case MGMT_OP_ADD_UUID:
+		if (ev->status == MGMT_STATUS_BUSY)
+			mgmt_add_uuid_busy(sk, index);
+		break;
 	}
 }
 
@@ -1709,6 +1731,25 @@ static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
 		bonding_complete(info, &ev->key.addr.bdaddr, 0);
 }
 
+static void mgmt_cod_changed(int sk, uint16_t index)
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
+	if (info->pending_cod_change) {
+		info->pending_cod_change = FALSE;
+		handle_pending_uuids(index);
+	}
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1772,7 +1813,7 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 		mgmt_new_settings(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CLASS_OF_DEV_CHANGED:
-		DBG("hci%u Class of Device changed", index);
+		mgmt_cod_changed(sk, index);
 		break;
 	case MGMT_EV_NEW_LINK_KEY:
 		mgmt_new_link_key(sk, index, buf + MGMT_HDR_SIZE, len);
-- 
on behalf of ST-Ericsson

