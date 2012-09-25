Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 6/8] scan: Register notification handler
Date: Tue, 25 Sep 2012 12:26:40 -0300
Message-Id: <1348586802-32613-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
 <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch registers the GAttrib notification handler for Refresh
Characteristic notification.
---
 profiles/scanparam/scan.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 7285774..08d04a7 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -53,6 +53,8 @@ struct scan {
 	guint attioid;
 	uint16_t interval;
 	uint16_t window;
+	uint16_t refresh_handle;
+	uint16_t refresh_cb_id;
 };
 
 GSList *servers = NULL;
@@ -65,9 +67,30 @@ static gint scan_device_cmp(gconstpointer a, gconstpointer b)
 	return (device == scan->device ? 0 : -1);
 }
 
+static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
+						gpointer user_data)
+{
+	struct scan *scan = user_data;
+	uint16_t handle;
+
+	if (len < 4) { /* 1-byte opcode + 2-byte handle + refresh */
+		error("Malformed ATT notification");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+
+	if (handle != scan->refresh_handle)
+		return;
+
+	DBG("Server requires refresh: %d", pdu[3]);
+}
+
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct scan *scan = user_data;
+
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
 						att_ecode2str(status));
@@ -75,6 +98,10 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 	}
 
 	DBG("Scan Refresh: notification enabled");
+
+	scan->refresh_cb_id = g_attrib_register(scan->attrib,
+					ATT_OP_HANDLE_NOTIFY, refresh_value_cb,
+					user_data, NULL);
 }
 
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
@@ -103,7 +130,7 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 
 	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 	gatt_write_char(scan->attrib, handle, value, sizeof(value),
-						ccc_written_cb, NULL);
+						ccc_written_cb, user_data);
 done:
 	att_data_list_free(list);
 }
@@ -135,6 +162,8 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 	if (start >= end)
 		return;
 
+	scan->refresh_handle = chr->value_handle;
+
 	gatt_find_info(scan->attrib, start, end,
 				discover_descriptor_cb, user_data);
 }
@@ -218,6 +247,11 @@ void scan_unregister(struct btd_device *device)
 	scan = l->data;
 	servers = g_slist_remove(servers, scan);
 
+	if (scan->refresh_cb_id) {
+		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
+		scan->refresh_cb_id = 0;
+	}
+
 	btd_device_remove_attio_callback(scan->device, scan->attioid);
 	btd_device_unref(scan->device);
 	g_attrib_unref(scan->attrib);
-- 
1.7.12

