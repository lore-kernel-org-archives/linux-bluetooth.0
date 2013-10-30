Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/2] android: Add supported uuids when adapter initialized
Date: Wed, 30 Oct 2013 16:18:34 +0100
Message-ID: <1383146314-13456-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383146314-13456-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383146314-13456-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will set class of device with proper service hints.
We set it statically because we don't want to change
class of device while adding/removing sdp services.
---
 android/adapter.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 325d0f0..e54264d 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -37,6 +37,24 @@
 
 static GIOChannel *notification_io = NULL;
 
+/*
+ * This is an array of supported uuids and service hints. We add them via mgmt
+ * interface when adapter is initialized. Uuids are in reverse orded.
+ */
+static const struct mgmt_cp_add_uuid sup_uuids[] = {
+	/* OBEX */
+	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
+	0x10, 0x00, 0x00, 0x05, 0x11, 0x00, 0x00}, 0x10},
+	/* TELEPHONY */
+	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
+	0x10, 0x00, 0x00, 0x1f, 0x11, 0x00, 0x00}, 0x40},
+	/* CAPTURING */
+	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
+	0x10, 0x00, 0x00, 0x0d, 0x11, 0x00, 0x00}, 0x08},
+	/* NETWORKING */
+	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
+	0x10, 0x00, 0x00, 0x15, 0x11, 0x00, 0x00}, 0x02} };
+
 struct bt_adapter {
 	uint16_t index;
 	struct mgmt *mgmt;
@@ -252,6 +270,38 @@ static void load_link_keys(GSList *keys)
 	g_free(cp);
 }
 
+static void add_uuid_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to add UUID: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+}
+
+static void add_uuids(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(sup_uuids) / sizeof(sup_uuids[0]); i++)
+		mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID, adapter->index,
+				sizeof(sup_uuids[i]), &sup_uuids[i],
+				add_uuid_complete, NULL, NULL);
+}
+
+static void clear_uuids(void)
+{
+	struct mgmt_cp_remove_uuid cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID, adapter->index,
+			sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
 static void set_mode_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -330,6 +380,9 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 
 	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
+	clear_uuids();
+	add_uuids();
+
 	return;
 
 failed:
-- 
1.8.4.1

