Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/9] event: Don't store EIR in btd_event_device_found
Date: Tue, 9 Oct 2012 14:11:56 +0200
Message-ID: <1349784722-14578-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is never read and was usefull only to gather EIR data for testing
which can also be done with hcidump etc.

---
 src/event.c   |    3 ---
 src/storage.c |   21 ---------------------
 src/storage.h |    2 --
 3 files changed, 26 deletions(-)

diff --git a/src/event.c b/src/event.c
index ac7140c..bd5ee1e 100644
--- a/src/event.c
+++ b/src/event.c
@@ -257,9 +257,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 
 	update_lastseen(local, peer, bdaddr_type);
 
-	if (data)
-		write_remote_eir(local, peer, bdaddr_type, data, data_len);
-
 	adapter_update_found_devices(adapter, peer, bdaddr_type, rssi,
 					confirm_name, legacy, data, data_len);
 }
diff --git a/src/storage.c b/src/storage.c
index df6b0aa..55dc591 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -435,27 +435,6 @@ done:
 	return 0;
 }
 
-int write_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, uint8_t *data,
-					uint8_t data_len)
-{
-	char filename[PATH_MAX + 1], key[20], str[481];
-	int i;
-
-	memset(str, 0, sizeof(str));
-	for (i = 0; i < data_len; i++)
-		sprintf(str + (i * 2), "%2.2X", data[i]);
-
-	create_filename(filename, PATH_MAX, local, "eir");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", peer_type);
-
-	return textfile_put(filename, key, str);
-}
-
 int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, uint8_t *data)
 {
diff --git a/src/storage.h b/src/storage.h
index 741b8a7..d6aa8ec 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,8 +50,6 @@ int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int write_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
-			uint8_t peer_type, uint8_t *data, uint8_t data_len);
 int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, uint8_t *data);
 int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
-- 
1.7.9.5

