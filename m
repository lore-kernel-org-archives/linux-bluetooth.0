Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android: Add device found notifications passing
Date: Thu, 31 Oct 2013 15:25:33 +0100
Message-Id: <1383229534-17157-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds remote device found and remote device properties changed
notifications passing using IPC.

---
 android/adapter.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 154dd06..e72e45b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -398,11 +398,45 @@ static int bdaddr_cmp(gconstpointer a, gconstpointer b)
 	return bacmp(bdb, bda);
 }
 
+static int fill_device_props(struct hal_property *prop, bdaddr_t *addr,
+					uint32_t cod, int8_t rssi, char *name)
+{
+	uint8_t num_props = 0;
+
+	/* fill cod */
+	prop->type = HAL_PROP_DEVICE_CLASS;
+	prop->len = sizeof(cod);
+	memcpy(prop->val, &cod, prop->len);
+	prop = ((void *) prop) + sizeof(*prop) + sizeof(cod);
+	num_props++;
+
+	/* fill rssi */
+	prop->type = HAL_PROP_DEVICE_RSSI;
+	prop->len = sizeof(rssi);
+	memcpy(prop->val, &rssi, prop->len);
+	prop = ((void *) prop) + sizeof(*prop) + sizeof(rssi);
+	num_props++;
+
+	/* fill name */
+	if (name) {
+		prop->type = HAL_PROP_DEVICE_NAME;
+		prop->len = HAL_MAX_NAME_LENGTH;
+		strncpy((char *) prop->val, name, HAL_MAX_NAME_LENGTH - 1);
+		prop = ((void *) prop) + sizeof(*prop) + HAL_MAX_NAME_LENGTH;
+		num_props++;
+	}
+
+	return num_props;
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
 {
 	bool is_new_dev = false;
+	size_t props_size = 0;
+	size_t buff_size = 0;
+	void *buf;
 	struct eir_data eir;
 	GSList *l;
 	bdaddr_t *remote = NULL;
@@ -433,10 +467,56 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		DBG("New device found: %s", addr);
 	}
 
+	props_size += sizeof(struct hal_property) + sizeof(eir.class);
+	props_size += sizeof(struct hal_property) + sizeof(rssi);
+
+	if (eir.name)
+		props_size += sizeof(struct hal_property) + HAL_MAX_NAME_LENGTH;
+
 	if (is_new_dev) {
-		/* TODO: notify device found */
+		struct hal_ev_device_found *ev = NULL;
+		struct hal_property *prop = NULL;
+
+		/* with new device we also send bdaddr prop */
+		props_size += sizeof(struct hal_property) + sizeof(eir.addr);
+
+		buff_size = sizeof(struct hal_ev_device_found) + props_size;
+		buf = g_new0(char, buff_size);
+		ev = buf;
+		prop = ev->props;
+
+		/* fill first prop with bdaddr */
+		prop->type = HAL_PROP_DEVICE_ADDR;
+		prop->len = sizeof(bdaddr_t);
+		bdaddr2android(bdaddr, prop->val);
+		prop = ((void *) prop) + sizeof(*prop) + sizeof(bdaddr_t);
+		ev->num_props += 1;
+
+		/* fill eir, name, and cod props */
+		ev->num_props += fill_device_props(prop, remote, eir.class,
+								rssi, eir.name);
+
+		ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+							HAL_EV_DEVICE_FOUND,
+							buff_size, ev, -1);
+		g_free(buf);
 	} else {
-		/* TODO: notify device state changed */
+		struct hal_ev_remote_device_props *ev = NULL;
+
+		buff_size = sizeof(*ev) + props_size;
+		buf = g_new0(char, buff_size);
+		ev = buf;
+
+		ev->num_props = fill_device_props(ev->props, remote, eir.class,
+								rssi, eir.name);
+
+		ev->status = HAL_STATUS_SUCCESS;
+		bdaddr2android(bdaddr, ev->bdaddr);
+
+		ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+						HAL_EV_REMOTE_DEVICE_PROPS,
+						buff_size, ev, -1);
+		g_free(buf);
 	}
 
 	/* TODO: name confirmation */
-- 
1.8.4.1

