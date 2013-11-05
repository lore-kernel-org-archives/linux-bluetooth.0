Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 4/6] android: Add supported uuids when adapter is initialized
Date: Tue, 5 Nov 2013 14:21:38 +0100
Message-ID: <1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will set class of device with proper service hints.
We set it statically because we want to keep code simple.

---
 android/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 0f24cac..70b9265 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -52,6 +52,29 @@ static GIOChannel *notification_io = NULL;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
+/*
+ * This is an array of supported uuids and service hints. We add them via mgmt
+ * interface when adapter is initialized. Uuids are in reverse orded.
+ */
+static const struct mgmt_cp_add_uuid supported_services[] = {
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
@@ -980,6 +1003,39 @@ static void load_link_keys(GSList *keys)
 	}
 }
 
+static void add_uuid_complete(uint8_t status, uint16_t length,
+				const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to add UUID: %s (0x%02x)",
+				mgmt_errstr(status), status);
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
+	for (i = 0; i < NELEM(supported_services); i++)
+		mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID, adapter->index,
+				sizeof(supported_services[i]),
+				&supported_services[i], add_uuid_complete,
+				NULL, NULL);
+}
+
+static void clear_uuids(void)
+{
+	struct mgmt_cp_remove_uuid cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID, adapter->index,
+					sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
 static void set_mode_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -995,6 +1051,9 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	 * event handling functions here.
 	 */
 	new_settings_callback(adapter->index, length, param, NULL);
+
+	clear_uuids();
+	add_uuids();
 }
 
 static bool set_mode(uint16_t opcode, uint8_t mode)
-- 
1.8.4.1

