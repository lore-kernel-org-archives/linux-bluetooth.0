Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android/bluetooth: Add support for restoring devices from storage
Date: Wed, 18 Dec 2013 15:05:58 +0100
Message-Id: <1387375558-17976-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support to restore bonded devices from storage (including
linkkeys).
---
 android/bluetooth.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index dd16a54..c7fb95f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1576,6 +1576,117 @@ static void clear_uuids(void)
 					sizeof(cp), &cp, NULL, NULL, NULL);
 }
 
+static void create_device_from_info(GKeyFile *key_file, const char *peer)
+{
+	struct device *dev;
+	uint8_t type;
+	bdaddr_t bdaddr;
+	char **uuids;
+	char *str;
+
+	DBG("%s", peer);
+
+	type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+
+	str2ba(peer, &bdaddr);
+	dev = create_device(&bdaddr, type);
+
+	dev->bond_state = HAL_BOND_STATE_BONDED;
+
+	str = g_key_file_get_string(key_file, peer, "Name", NULL);
+	if (str) {
+		g_free(dev->name);
+		dev->name = str;
+	}
+
+	str = g_key_file_get_string(key_file, peer, "FriendlyName", NULL);
+	if (str) {
+		g_free(dev->friendly_name);
+		dev->friendly_name = str;
+	}
+
+	dev->class = g_key_file_get_integer(key_file, peer, "Class", NULL);
+
+	uuids = g_key_file_get_string_list(key_file, peer, "Services", NULL,
+									NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++) {
+			uint8_t *u = g_malloc0(16);
+			int i;
+
+			for (i = 0; i < 16; i++)
+				sscanf((*uuid) + (i * 2), "%02hhX", &u[i]);
+
+			dev->uuids = g_slist_append(dev->uuids, u);
+		}
+
+		g_strfreev(uuids);
+	}
+}
+
+static struct mgmt_link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
+{
+	struct mgmt_link_key_info *info = NULL;
+	char *str;
+	unsigned int i;
+
+	str = g_key_file_get_string(key_file, peer, "LinkKey", NULL);
+	if (!str || strlen(str) != 32)
+		goto failed;
+
+	info = g_new0(struct mgmt_link_key_info, 1);
+
+	str2ba(peer, &info->addr.bdaddr);
+
+	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+
+	for (i = 0; i < sizeof(info->val); i++)
+		sscanf(str + (i * 2), "%02hhX", &info->val[i]);
+
+	info->type = g_key_file_get_integer(key_file, peer, "LinkKeyType",
+									NULL);
+	info->pin_len = g_key_file_get_integer(key_file, peer,
+						"LinkKeyPINLength", NULL);
+
+failed:
+	g_free(str);
+
+	return info;
+}
+
+static void load_devices_info(bt_bluetooth_ready cb)
+{
+	GKeyFile *key_file;
+	gchar **devs;
+	gsize len = 0;
+	unsigned int i;
+	GSList *keys = NULL;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
+									NULL);
+
+	devs = g_key_file_get_groups(key_file, &len);
+
+	for (i = 0; i < len; i++) {
+		struct mgmt_link_key_info *key_info;
+
+		create_device_from_info(key_file, devs[i]);
+
+		key_info = get_key_info(key_file, devs[i]);
+		if (key_info)
+			keys = g_slist_prepend(keys, key_info);
+
+		/* TODO ltk */
+	}
+
+	load_link_keys(keys, cb);
+	g_slist_free_full(keys, g_free);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1630,7 +1741,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	clear_uuids();
 
-	load_link_keys(NULL, cb);
+	load_devices_info(cb);
 
 	set_io_capability();
 	set_device_id();
-- 
1.8.3.2

