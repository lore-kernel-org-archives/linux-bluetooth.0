Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] core/device: Update storage if CSRK counter change
Date: Wed, 25 Feb 2015 15:42:13 +0200
Message-Id: <1424871733-14610-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
References: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure the counter is stored so once the device is loaded again
it should contain the proper value.
---
 src/device.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/device.c b/src/device.c
index a801bb3..20aaa3e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -345,6 +345,19 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 								list, len);
 }
 
+static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
+							const char *group)
+{
+	char key[33];
+	int i;
+
+	for (i = 0; i < 16; i++)
+		sprintf(key + (i * 2), "%2.2X", csrk->key[i]);
+
+	g_key_file_set_string(key_file, group, "Key", key);
+	g_key_file_set_integer(key_file, group, "Counter", csrk->counter);
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -423,6 +436,12 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_group(key_file, "DeviceID", NULL);
 	}
 
+	if (device->local_csrk)
+		store_csrk(device->local_csrk, key_file, "LocalSignatureKey");
+
+	if (device->remote_csrk)
+		store_csrk(device->remote_csrk, key_file, "RemoteSignatureKey");
+
 	create_file(filename, S_IRUSR | S_IWUSR);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
@@ -4021,6 +4040,8 @@ static bool local_counter(uint32_t *sign_cnt, void *user_data)
 
 	*sign_cnt = dev->local_csrk->counter++;
 
+	store_device_info(dev);
+
 	return true;
 }
 
@@ -4033,6 +4054,8 @@ static bool remote_counter(uint32_t *sign_cnt, void *user_data)
 
 	dev->remote_csrk->counter = *sign_cnt;
 
+	store_device_info(dev);
+
 	return true;
 }
 
-- 
2.1.0

