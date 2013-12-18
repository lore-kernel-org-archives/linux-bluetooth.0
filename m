Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/4] android/bluetooth: Add initial support for storing device info
Date: Wed, 18 Dec 2013 12:20:58 +0100
Message-Id: <1387365660-25281-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387365660-25281-1-git-send-email-szymon.janc@tieto.com>
References: <1387365660-25281-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to store information about remote device. For now this is
stored only for bonded devices. Currently stored data includes devices
ddress, type, name, friendly name, class and uuids.
---
 android/bluetooth.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 114a466..69412dd 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -196,6 +196,72 @@ static void load_adapter_config(void)
 	g_key_file_free(key_file);
 }
 
+static void store_device_info(struct device *dev)
+{
+	GKeyFile *key_file;
+	char addr[18];
+	gsize length = 0;
+	char **uuids = NULL;
+	char *str;
+
+	if (dev->bond_state != HAL_BOND_STATE_BONDED)
+		return;
+
+	ba2str(&dev->bdaddr, addr);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
+									NULL);
+
+	g_key_file_set_integer(key_file, addr, "Type", dev->bdaddr_type);
+
+	g_key_file_set_string(key_file, addr, "Name", dev->name);
+
+	if (dev->friendly_name)
+		g_key_file_set_string(key_file, addr, "FriendlyName",
+							dev->friendly_name);
+	else
+		g_key_file_remove_key(key_file, addr, "FriendlyName", NULL);
+
+	if (dev->class)
+		g_key_file_set_integer(key_file, addr, "Class", dev->class);
+	else
+		g_key_file_remove_key(key_file, addr, "Class", NULL);
+
+	if (dev->uuids) {
+		GSList *l;
+		int i;
+
+		uuids = g_new0(char *, g_slist_length(dev->uuids) + 1);
+
+		for (i = 0, l = dev->uuids; l; l = g_slist_next(l), i++) {
+			int j;
+			uint8_t *u = l->data;
+			char *uuid_str = g_malloc0(35);
+
+			uuid_str[0] = '0';
+			uuid_str[1] = 'x';
+
+			for (j = 0; j < 16; j++)
+				sprintf(uuid_str + 2 + (j * 2), "%2.2X", u[j]);
+
+			uuids[i] = uuid_str;
+		}
+
+		g_key_file_set_string_list(key_file, addr, "Services",
+						(const char **)uuids, i);
+	} else {
+		g_key_file_remove_key(key_file, addr, "Services", NULL);
+	}
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(ANDROID_STORAGEDIR"/devices", str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+	g_strfreev(uuids);
+}
+
 static int bdaddr_cmp(gconstpointer a, gconstpointer b)
 {
 	const bdaddr_t *bda = a;
@@ -458,6 +524,8 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 	if (dev->bond_state != state) {
 		dev->bond_state = state;
 		send_bond_state_change(&dev->bdaddr, status, state);
+
+		store_device_info(dev);
 	}
 }
 
@@ -498,6 +566,8 @@ static void set_device_uuids(struct device *dev, GSList *uuids)
 	g_slist_free_full(dev->uuids, g_free);
 	dev->uuids = uuids;
 
+	store_device_info(dev);
+
 	send_device_uuids_notif(dev);
 }
 
@@ -2539,7 +2609,7 @@ static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
 	g_free(dev->friendly_name);
 	dev->friendly_name = g_strndup((const char *) val, len);
 
-	/* TODO store friendly name */
+	store_device_info(dev);
 
 	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_FRIENDLY_NAME,
 				strlen(dev->friendly_name), dev->friendly_name);
-- 
1.8.3.2

