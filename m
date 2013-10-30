Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] android/hal: Extract bt property repacking code for further reuse
Date: Wed, 30 Oct 2013 11:00:29 +0100
Message-Id: <1383127232-25147-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This extracted part of code can be reused for repacking remote device
properties.

---
 android/hal-bluetooth.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 18a5e1c..06d85e3 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -37,33 +37,38 @@ static void handle_adapter_state_changed(void *buf)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
 
-static void handle_adapter_props_changed(void *buf, uint16_t len)
+static void repack_properties(bt_property_t *send_props,
+					struct hal_property *hal_prop,
+					uint8_t num_props,
+					void *buff_end)
 {
-	struct hal_ev_adapter_props_changed *ev = buf;
-	bt_property_t props[ev->num_props];
-	struct hal_property *hal_prop;
-	void *p;
-	int i;
+	void *p = hal_prop;
+	uint8_t i;
 
-	if (!bt_hal_cbacks->adapter_properties_cb)
-		return;
-
-	hal_prop = ev->props;
-	p = ev->props;
-
-	for (i = 0; i < ev->num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buf + len) {
+	for (i = 0; i < num_props; i++) {
+		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
 			error("invalid adapter properties event, aborting");
 			exit(EXIT_FAILURE);
 		}
 
-		props[i].type = hal_prop->type;
-		props[i].len = hal_prop->len;
-		props[i].val = hal_prop->val;
+		send_props[i].type = hal_prop->type;
+		send_props[i].len = hal_prop->len;
+		send_props[i].val = hal_prop->val;
 
 		p += sizeof(*hal_prop) + hal_prop->len;
 		hal_prop = p;
 	}
+}
+
+static void handle_adapter_props_changed(void *buf, uint16_t len)
+{
+	struct hal_ev_adapter_props_changed *ev = buf;
+	bt_property_t props[ev->num_props];
+
+	if (!bt_hal_cbacks->adapter_properties_cb)
+		return;
+
+	repack_properties(props, ev->props, ev->num_props, buf + len);
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
 }
-- 
1.8.4.1

