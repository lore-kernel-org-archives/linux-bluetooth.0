Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/bluetooth: Always store device info
Date: Tue, 21 Jan 2014 16:01:35 +0100
Message-Id: <1390316497-18451-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com>
References: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to cache remote device informations.
---
 android/bluetooth.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 3314267..f32dd91 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -207,23 +207,11 @@ static void store_device_info(struct device *dev)
 	char **uuids = NULL;
 	char *str;
 
-	/* We only store bonded devices and need to modify the storage
-	 * if the state is either NONE or BONDED.
-	 */
-	if (dev->bond_state != HAL_BOND_STATE_BONDED &&
-					dev->bond_state != HAL_BOND_STATE_NONE)
-		return;
-
 	ba2str(&dev->bdaddr, addr);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
 
-	if (dev->bond_state == HAL_BOND_STATE_NONE) {
-		g_key_file_remove_group(key_file, addr, NULL);
-		goto done;
-	}
-
 	g_key_file_set_integer(key_file, addr, "Type", dev->bdaddr_type);
 
 	g_key_file_set_string(key_file, addr, "Name", dev->name);
@@ -264,7 +252,6 @@ static void store_device_info(struct device *dev)
 		g_key_file_remove_key(key_file, addr, "Services", NULL);
 	}
 
-done:
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(DEVICES_FILE, str, length, NULL);
 	g_free(str);
@@ -542,6 +529,33 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 	g_key_file_free(key_file);
 }
 
+static void remove_stored_link_key(const bdaddr_t *dst)
+{
+	GKeyFile *key_file;
+	gsize length = 0;
+	char addr[18];
+	char *data;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL))
+		return;
+
+	ba2str(dst, addr);
+
+	DBG("%s", addr);
+
+	g_key_file_remove_key(key_file, addr, "LinkKey", NULL);
+	g_key_file_remove_key(key_file, addr, "LinkKeyType", NULL);
+	g_key_file_remove_key(key_file, addr, "LinkKeyPinLength", NULL);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
 static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 								uint8_t state)
 {
@@ -2443,6 +2457,8 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS)
 		return;
 
+	remove_stored_link_key(&rp->addr.bdaddr);
+
 	set_device_bond_state(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_NONE);
 }
-- 
1.8.3.2

