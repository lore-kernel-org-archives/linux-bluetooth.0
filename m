Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 10/15] core: Fix creating device from "longtermkeys" file
Date: Wed, 23 May 2012 15:48:28 -0300
Message-Id: <1337798914-20974-11-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0a168b4..11abcad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1792,7 +1792,8 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 	return info;
 }
 
-static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
+static struct smp_ltk_info *get_ltk_info(const char *addr, uint8_t bdaddr_type,
+							const char *value)
 {
 	struct smp_ltk_info *ltk;
 	char *ptr;
@@ -1807,14 +1808,15 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
 
 	str2ba(addr, &ltk->bdaddr);
 
+	ltk->bdaddr_type = bdaddr_type;
+
 	str2buf(value, ltk->val, sizeof(ltk->val));
 
 	ptr = (char *) value + 2 * sizeof(ltk->val) + 1;
 
-	ret = sscanf(ptr, " %hhd %hhd %hhd %hhd %hd %n",
-					(uint8_t *) &ltk->bdaddr_type,
-					&ltk->authenticated, &ltk->master,
-					&ltk->enc_size, &ltk->ediv, &i);
+	ret = sscanf(ptr, " %hhd %hhd %hhd %hd %n",
+		     &ltk->authenticated, &ltk->master, &ltk->enc_size,
+							&ltk->ediv, &i);
 	if (ret < 2) {
 		g_free(ltk);
 		return NULL;
@@ -1856,26 +1858,30 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	struct btd_adapter *adapter = keys->adapter;
 	struct btd_device *device;
 	struct smp_ltk_info *info;
-	char srcaddr[18];
+	char address[18], srcaddr[18];
+	uint8_t bdaddr_type;
 	bdaddr_t src;
 
-	info = get_ltk_info(key, value);
+	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
+		return;
+
+	info = get_ltk_info(address, bdaddr_type, value);
 	if (info == NULL)
 		return;
 
 	keys->keys = g_slist_append(keys->keys, info);
 
-	if (g_slist_find_custom(adapter->devices, key,
+	if (g_slist_find_custom(adapter->devices, address,
 					(GCompareFunc) device_address_cmp))
 		return;
 
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
 
-	if (g_strcmp0(srcaddr, key) == 0)
+	if (g_strcmp0(srcaddr, address) == 0)
 		return;
 
-	device = device_create(connection, adapter, key, info->bdaddr_type);
+	device = device_create(connection, adapter, address, bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
-- 
1.7.7.6

