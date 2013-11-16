Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android: Refactor update_found_device function
Date: Sat, 16 Nov 2013 15:09:46 +0100
Message-Id: <1384610986-17990-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
References: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes function flow easier to follow and understand. Besides that
it also fix issue with sending to many bytes if some prop were not
present in EIR.
---
 android/bluetooth.c | 141 +++++++++++++++++++++-------------------------------
 1 file changed, 57 insertions(+), 84 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6a7ba9d..5c5c61e 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -776,54 +776,32 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 		error("Failed to send confirm name request");
 }
 
-static int fill_device_props(struct hal_property *prop, bdaddr_t *addr,
-					uint32_t cod, int8_t rssi, char *name)
-{
-	uint8_t num_props = 0;
-
-	/* fill Class of Device */
-	if (cod) {
-		prop->type = HAL_PROP_DEVICE_CLASS;
-		prop->len = sizeof(cod);
-		memcpy(prop->val, &cod, prop->len);
-		prop = ((void *) prop) + sizeof(*prop) + sizeof(cod);
-		num_props++;
-	}
 
-	/* fill RSSI */
-	if (rssi) {
-		prop->type = HAL_PROP_DEVICE_RSSI;
-		prop->len = sizeof(rssi);
-		memcpy(prop->val, &rssi, prop->len);
-		prop = ((void *) prop) + sizeof(*prop) + sizeof(rssi);
-		num_props++;
-	}
+static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
+							const void *val)
+{
+	struct hal_property *prop = buf;
 
-	/* fill name */
-	if (name) {
-		prop->type = HAL_PROP_DEVICE_NAME;
-		prop->len = strlen(name);
-		memcpy(prop->val, name, prop->len);
-		prop = ((void *) prop) + sizeof(*prop) + prop->len;
-		num_props++;
-	}
+	prop->type = type;
+	prop->len = len;
+	memcpy(prop->val, val, len);
 
-	return num_props;
+	return sizeof(*prop) + len;
 }
 
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
 {
-	bool is_new_dev = false;
-	size_t props_size = 0;
-	size_t buff_size = 0;
-	void *buf;
+	uint8_t buf[BLUEZ_HAL_MTU];
+	bool new_dev = false;
 	struct eir_data eir;
-	GSList *l;
-	bdaddr_t *remote = NULL;
+	uint8_t *num_prop;
+	uint8_t opcode;
+	int size = 0;
 	int err;
 
+	memset(buf, 0, sizeof(buf));
 	memset(&eir, 0, sizeof(eir));
 
 	err = eir_parse(&eir, data, data_len);
@@ -832,75 +810,70 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		return;
 	}
 
-	l = g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp);
-	if (l)
-		remote = l->data;
-
-	if (!remote) {
+	if (!g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp)) {
+		bdaddr_t *new_bdaddr;
 		char addr[18];
 
-		remote = g_new0(bdaddr_t, 1);
-		bacpy(remote, bdaddr);
+		new_bdaddr = g_new0(bdaddr_t, 1);
+		bacpy(new_bdaddr, bdaddr);
 
-		found_devices = g_slist_prepend(found_devices, remote);
-		is_new_dev = true;
+		found_devices = g_slist_prepend(found_devices, new_bdaddr);
 
-		ba2str(remote, addr);
+		ba2str(new_bdaddr, addr);
 		DBG("New device found: %s", addr);
-	}
 
-	props_size += sizeof(struct hal_property) + sizeof(eir.class);
-	props_size += sizeof(struct hal_property) + sizeof(rssi);
-
-	if (eir.name) {
-		props_size += sizeof(struct hal_property) + strlen(eir.name);
-		cache_device_name(remote, eir.name);
+		new_dev = true;
 	}
 
-	if (is_new_dev) {
-		struct hal_ev_device_found *ev = NULL;
-		struct hal_property *prop = NULL;
-
-		/* with new device we also send bdaddr prop */
-		props_size += sizeof(struct hal_property) + sizeof(eir.addr);
+	if (new_dev) {
+		struct hal_ev_device_found *ev = (void *) buf;
+		bdaddr_t android_bdaddr;
 
-		buff_size = sizeof(struct hal_ev_device_found) + props_size;
-		buf = g_new0(char, buff_size);
-		ev = buf;
-		prop = ev->props;
+		size += sizeof(*ev);
 
-		/* fill first prop with bdaddr */
-		prop->type = HAL_PROP_DEVICE_ADDR;
-		prop->len = sizeof(bdaddr_t);
-		bdaddr2android(bdaddr, prop->val);
-		prop = ((void *) prop) + sizeof(*prop) + sizeof(bdaddr_t);
-		ev->num_props += 1;
+		num_prop = &ev->num_props;
+		opcode = HAL_EV_DEVICE_FOUND;
 
-		/* fill eir, name, and cod props */
-		ev->num_props += fill_device_props(prop, remote, eir.class,
-								rssi, eir.name);
+		bdaddr2android(bdaddr, &android_bdaddr);
 
-		ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_DEVICE_FOUND, buff_size, ev, -1);
-		g_free(buf);
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
+				sizeof(android_bdaddr), &android_bdaddr);
+		(*num_prop)++;
 	} else {
-		struct hal_ev_remote_device_props *ev = NULL;
+		struct hal_ev_remote_device_props *ev = (void *) buf;
 
-		buff_size = sizeof(*ev) + props_size;
-		buf = g_new0(char, buff_size);
-		ev = buf;
+		size += sizeof(*ev);
 
-		ev->num_props = fill_device_props(ev->props, remote, eir.class,
-								rssi, eir.name);
+		num_prop = &ev->num_props;
+		opcode = HAL_EV_REMOTE_DEVICE_PROPS;
 
 		ev->status = HAL_STATUS_SUCCESS;
 		bdaddr2android(bdaddr, ev->bdaddr);
+	}
+
+	if (eir.class) {
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
+						sizeof(eir.class), &eir.class);
+		(*num_prop)++;
+	}
 
-		ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_REMOTE_DEVICE_PROPS, buff_size, ev, -1);
-		g_free(buf);
+	if (rssi) {
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
+							sizeof(rssi), &rssi);
+		(*num_prop)++;
+	}
+
+	if (eir.name) {
+		cache_device_name(bdaddr, eir.name);
+
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
+						strlen(eir.name), eir.name);
+		(*num_prop)++;
 	}
 
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf,
+									-1);
+
 	if (confirm) {
 		char addr[18];
 
-- 
1.8.4.2

