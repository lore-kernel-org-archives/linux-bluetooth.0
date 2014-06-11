Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/2] android: Store remote's Identity Resolving Key
Date: Wed, 11 Jun 2014 10:00:13 +0200
Message-Id: <1402473614-26767-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Persistent storage is used so we can load IRKs on startup.
---
 android/bluetooth.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 36b073e..8638f84 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1964,6 +1964,62 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		store_csrk(dev);
 }
 
+static void store_irk(struct device *dev, const uint8_t *val)
+{
+	GKeyFile *key_file;
+	char key_str[33];
+	char addr[18];
+	int i;
+	gsize length = 0;
+	char *data;
+
+	ba2str(&dev->bdaddr, addr);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + (i * 2), "%2.2X", val[i]);
+
+	g_key_file_set_string(key_file, addr, "IdentityResolvingKey", key_str);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static void new_irk_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_new_irk *ev = param;
+	const struct mgmt_addr_info *addr = &ev->key.addr;
+	struct device *dev;
+	char dst[18], rpa[18];
+
+	if (length < sizeof(*ev)) {
+		error("To small New Irk Event (%u bytes)", length);
+		return;
+	}
+
+	ba2str(&ev->key.addr.bdaddr, dst);
+	ba2str(&ev->rpa, rpa);
+
+	DBG("new IRK for %s, RPA %s", dst, rpa);
+
+	/* TODO: handle new Identity to RPA mapping */
+	dev = find_device(&addr->bdaddr);
+	if (!dev)
+		return;
+
+	if (ev->store_hint)
+		store_irk(dev, ev->key.val);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(mgmt_if, MGMT_EV_NEW_SETTINGS, adapter.index,
@@ -2017,6 +2073,9 @@ static void register_mgmt_handlers(void)
 	mgmt_register(mgmt_if, MGMT_EV_NEW_CSRK, adapter.index,
 						new_csrk_callback, NULL, NULL);
 
+	mgmt_register(mgmt_if, MGMT_EV_NEW_IRK, adapter.index, new_irk_callback,
+								NULL, NULL);
+
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
2.0.0

