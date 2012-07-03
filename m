Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 09/12] storage: Store address type in "linkkeys" file
Date: Tue,  3 Jul 2012 17:32:12 -0300
Message-Id: <1341347535-15343-10-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
 <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++--
 src/device.c  |    3 ++-
 src/event.c   |    6 +++++-
 src/storage.c |   21 +++++++++++++++++----
 src/storage.h |    6 ++++--
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 32412a8..f9075aa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1831,20 +1831,25 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, uint8_t bdaddr_type,
 static void create_stored_device_from_linkkeys(char *key, char *value,
 							void *user_data)
 {
+	char address[18];
+	uint8_t bdaddr_type;
 	struct adapter_keys *keys = user_data;
 	struct btd_adapter *adapter = keys->adapter;
 	struct btd_device *device;
 	struct link_key_info *info;
 
+	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
+		bdaddr_type = BDADDR_BREDR;
+
 	info = get_key_info(key, value);
 	if (info)
 		keys->keys = g_slist_append(keys->keys, info);
 
-	if (g_slist_find_custom(adapter->devices, key,
+	if (g_slist_find_custom(adapter->devices, address,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, BDADDR_BREDR);
+	device = device_create(connection, adapter, address, bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
diff --git a/src/device.c b/src/device.c
index b606a0d..d879aa2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1083,7 +1083,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
 		device_block(conn, device, FALSE);
 
-	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
+	if (read_link_key(&src, &device->bdaddr, device->bdaddr_type, NULL,
+								NULL) == 0) {
 		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
 	}
diff --git a/src/event.c b/src/event.c
index 9168013..002639f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -408,6 +408,7 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
+	uint8_t peer_type;
 	int ret;
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
@@ -415,7 +416,10 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	ret = write_link_key(local, peer, key, key_type, pin_length);
+	peer_type = device_get_addr_type(device);
+
+	ret = write_link_key(local, peer, peer_type, key, key_type,
+								pin_length);
 
 	if (ret == 0) {
 		device_set_bonded(device, TRUE);
diff --git a/src/storage.c b/src/storage.c
index ee35b13..0be071d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -608,9 +608,10 @@ int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, key, str);
 }
 
-int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length)
+int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+				unsigned char *key, uint8_t type, int length)
 {
-	char filename[PATH_MAX + 1], addr[18], str[38];
+	char filename[PATH_MAX + 1], addr[20], str[38];
 	int i;
 
 	memset(str, 0, sizeof(str));
@@ -623,6 +624,7 @@ int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t
 	create_file(filename, S_IRUSR | S_IWUSR);
 
 	ba2str(peer, addr);
+	sprintf(&addr[17], "#%hhu", peer_type);
 
 	if (length < 0) {
 		char *tmp = textfile_get(filename, addr);
@@ -636,18 +638,29 @@ int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t
 	return textfile_put(filename, addr, str);
 }
 
-int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *type)
+int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+					unsigned char *key, uint8_t *type)
 {
-	char filename[PATH_MAX + 1], addr[18], tmp[3], *str;
+	char filename[PATH_MAX + 1], addr[20], tmp[3], *str;
 	int i;
 
 	create_filename(filename, PATH_MAX, local, "linkkeys");
 
 	ba2str(peer, addr);
+	sprintf(&addr[17], "#%hhu", peer_type);
+
+	str = textfile_get(filename, addr);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	addr[17] = '\0';
+
 	str = textfile_get(filename, addr);
 	if (!str)
 		return -ENOENT;
 
+done:
 	if (!key) {
 		free(str);
 		return 0;
diff --git a/src/storage.h b/src/storage.h
index 7455be5..6fb9a2f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -58,8 +58,10 @@ int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 								struct tm *tm);
 int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 								struct tm *tm);
-int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length);
-int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *type);
+int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+				unsigned char *key, uint8_t type, int length);
+int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+					unsigned char *key, uint8_t *type);
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
 int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
-- 
1.7.9.5

