Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 2/7] core/gatt: Create CCC for external characteristic
Date: Tue,  3 Mar 2015 20:30:06 -0800
Message-Id: <1425443411-11958-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1425443411-11958-1-git-send-email-armansito@chromium.org>
References: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for adding a CCC descriptor entry for an
external characteristic, if it has the 'notify' or 'indicate' property.
When the CCC descriptor is written to, bluetoothd calls the
'StartNotify' and 'StopNotify' methods on the characteristic in a
reference counted manner.
---
 src/gatt-database.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index db21d49..2ca9daa 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -94,8 +94,10 @@ struct external_chrc {
 	uint8_t props;
 	uint8_t ext_props;
 	struct gatt_db_attribute *attrib;
+	struct gatt_db_attribute *ccc;
 	struct queue *pending_reads;
 	struct queue *pending_writes;
+	unsigned int ntfy_cnt;
 };
 
 struct pending_op {
@@ -1171,10 +1173,13 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 			return;
 		}
 
-		/*
-		 * TODO: Determine descriptors count to add based on special
-		 * characteristic properties (e.g. extended properties).
-		 */
+		if ((chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
+				chrc->props & BT_GATT_CHRC_PROP_INDICATE) &&
+				!incr_attr_count(service, 1)) {
+			error("Failed to increment attribute count for CCC");
+			service->failed = true;
+			return;
+		}
 
 		queue_push_tail(service->chrcs, chrc);
 	} else
@@ -1507,6 +1512,73 @@ static uint32_t permissions_from_props(uint8_t props, uint8_t ext_props)
 	return perm;
 }
 
+static uint8_t ccc_write_cb(uint16_t value, void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+
+	DBG("External CCC write received with value: 0x%04x", value);
+
+	/* Notifications/indications disabled */
+	if (!value) {
+		if (!chrc->ntfy_cnt)
+			return 0;
+
+		if (__sync_sub_and_fetch(&chrc->ntfy_cnt, 1))
+			return 0;
+
+		/*
+		 * Send request to stop notifying. This is best-effort
+		 * operation, so simply ignore the return the value.
+		 */
+		g_dbus_proxy_method_call(chrc->proxy, "StopNotify", NULL,
+							NULL, NULL, NULL);
+		return 0;
+	}
+
+	/*
+	 * TODO: All of the errors below should fall into the so called
+	 * "Application Error" range. Since there is no well defined error for
+	 * these, we return a generic ATT protocol error for now.
+	 */
+
+	if (chrc->ntfy_cnt == UINT_MAX) {
+		/* Maximum number of per-device CCC descriptors configured */
+		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+	}
+
+	/* Don't support undefined CCC values yet */
+	if (value > 2 ||
+		(value == 1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
+		(value == 2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
+		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	/*
+	 * Always call StartNotify for an incoming enable and ignore the return
+	 * value for now.
+	 */
+	if (g_dbus_proxy_method_call(chrc->proxy,
+						"StartNotify", NULL, NULL,
+						NULL, NULL) == FALSE)
+		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
+
+	return 0;
+}
+
+static bool create_ccc_entry(struct external_service *service,
+						struct external_chrc *chrc)
+{
+	chrc->ccc = service_add_ccc(service->attrib, service->database,
+						ccc_write_cb, chrc, NULL);
+	if (!chrc->ccc) {
+		error("Failed to create CCC entry for characteristic");
+		return false;
+	}
+
+	return true;
+}
+
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
@@ -1533,10 +1605,16 @@ static bool database_add_chrc(struct external_service *service,
 						&uuid, perm,
 						chrc->props, chrc_read_cb,
 						chrc_write_cb, chrc);
+	if (!chrc->attrib) {
+		error("Failed to create characteristic entry in database");
+		return false;
+	}
 
-	/* TODO: Create descriptor entries */
+	if (chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
+				chrc->props & BT_GATT_CHRC_PROP_INDICATE)
+		return create_ccc_entry(service, chrc);
 
-	return chrc->attrib != NULL;
+	return true;
 }
 
 static bool create_service_entry(struct external_service *service)
-- 
2.2.0.rc0.207.ga3a616c

