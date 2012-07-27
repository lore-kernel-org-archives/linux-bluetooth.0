Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH v3 BlueZ 11/12] storage: Store address type in "eir" file
Date: Fri, 27 Jul 2012 16:43:22 -0300
Message-Id: <1343418203-15335-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

---
 src/event.c   |    2 +-
 src/storage.c |   30 +++++++++++++++++++++---------
 src/storage.h |    7 ++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/src/event.c b/src/event.c
index 002639f..1586293 100644
--- a/src/event.c
+++ b/src/event.c
@@ -270,7 +270,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 	update_lastseen(local, peer, bdaddr_type);
 
 	if (data)
-		write_remote_eir(local, peer, data, data_len);
+		write_remote_eir(local, peer, bdaddr_type, data, data_len);
 
 	adapter_update_found_devices(adapter, peer, bdaddr_type, rssi,
 						confirm_name, data, data_len);
diff --git a/src/storage.c b/src/storage.c
index f28ffac..9e0ea12 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -430,10 +430,10 @@ done:
 	return 0;
 }
 
-int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data,
-							uint8_t data_len)
+int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+						uint8_t *data, uint8_t data_len)
 {
-	char filename[PATH_MAX + 1], addr[18], str[481];
+	char filename[PATH_MAX + 1], key[20], str[481];
 	int i;
 
 	memset(str, 0, sizeof(str));
@@ -444,23 +444,35 @@ int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data,
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(peer, addr);
-	return textfile_put(filename, addr, str);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
+
+	return textfile_put(filename, key, str);
 }
 
-int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data)
+int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								uint8_t *data)
 {
-	char filename[PATH_MAX + 1], addr[18], *str;
+	char filename[PATH_MAX + 1], key[18], *str;
 	int i;
 
 	create_filename(filename, PATH_MAX, local, "eir");
 
-	ba2str(peer, addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
 
-	str = textfile_get(filename, addr);
+	str = textfile_get(filename, key);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	str = textfile_get(filename, key);
 	if (!str)
 		return -ENOENT;
 
+done:
 	if (!data) {
 		free(str);
 		return 0;
diff --git a/src/storage.h b/src/storage.h
index 56fb14e..b8cdb3c 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -48,9 +48,10 @@ int write_device_name(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 								char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data,
-							uint8_t data_len);
-int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data);
+int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+					uint8_t *data, uint8_t data_len);
+int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								uint8_t *data);
 int write_version_info(bdaddr_t *local, bdaddr_t *peer, uint16_t manufacturer, uint8_t lmp_ver, uint16_t lmp_subver);
 int write_features_info(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
 int read_remote_features(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
-- 
1.7.10.4

