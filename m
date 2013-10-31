Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH] android: Add supported uuids when adapter initialized
Date: Thu, 31 Oct 2013 14:17:53 +0100
Message-ID: <1383225473-24811-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will set class of device with proper service hints.
We set it statically because we don't want to change
class of device while adding/removing sdp services.
---
 android/adapter.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index a3f9aa6..5a1cc9b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -39,6 +39,29 @@
 
 static GIOChannel *notification_io = NULL;
 
+/*
+ * This is an array of supported uuids and service hints. We add them via mgmt
+ * interface when adapter is initialized. Uuids are in reverse orded.
+ */
+static const struct mgmt_cp_add_uuid sup_uuids[] = {
+	/* OBEX_OPP_UUID */
+	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x05, 0x11, 0x00, 0x00 },
+	.svc_hint = 0x10 },
+	/* HFP_AG_UUID */
+	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x1f, 0x11, 0x00, 0x00 },
+	.svc_hint = 0x40 },
+	/* ADVANCED_AUDIO_UUID */
+	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x0d, 0x11, 0x00, 0x00 },
+	.svc_hint = 0x08 },
+	/* PANU_UUID */
+	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x15, 0x11, 0x00, 0x00 },
+	.svc_hint = 0x02 }
+};
+
 struct bt_adapter {
 	uint16_t index;
 	struct mgmt *mgmt;
@@ -438,6 +461,38 @@ static void load_link_keys(GSList *keys)
 	}
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
@@ -530,6 +585,9 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	set_io_capability();
 	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
+	clear_uuids();
+	add_uuids();
+
 	return;
 
 failed:
-- 
1.8.4.1

