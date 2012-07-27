Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH v3 BlueZ 05/12] storage: Store address type in "lastseen" file
Date: Fri, 27 Jul 2012 16:43:16 -0300
Message-Id: <1343418203-15335-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

---
 src/event.c   |    6 +++---
 src/storage.c |   11 +++++++----
 src/storage.h |    3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/event.c b/src/event.c
index 17fc250..12eb9d9 100644
--- a/src/event.c
+++ b/src/event.c
@@ -233,7 +233,7 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
+static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 {
 	time_t t;
 	struct tm *tm;
@@ -241,7 +241,7 @@ static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
 	t = time(NULL);
 	tm = gmtime(&t);
 
-	write_lastseen_info(sba, dba, tm);
+	write_lastseen_info(sba, dba, dba_type, tm);
 }
 
 static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
@@ -267,7 +267,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 		return;
 	}
 
-	update_lastseen(local, peer);
+	update_lastseen(local, peer, bdaddr_type);
 
 	if (data)
 		write_remote_eir(local, peer, data, data_len);
diff --git a/src/storage.c b/src/storage.c
index 252b383..89c28e0 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -572,9 +572,10 @@ int read_remote_features(bdaddr_t *local, bdaddr_t *peer,
 	return err;
 }
 
-int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
+int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								struct tm *tm)
 {
-	char filename[PATH_MAX + 1], addr[18], str[24];
+	char filename[PATH_MAX + 1], key[20], str[24];
 
 	memset(str, 0, sizeof(str));
 	strftime(str, sizeof(str), "%Y-%m-%d %H:%M:%S %Z", tm);
@@ -583,8 +584,10 @@ int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(peer, addr);
-	return textfile_put(filename, addr, str);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
+
+	return textfile_put(filename, key, str);
 }
 
 int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
diff --git a/src/storage.h b/src/storage.h
index 3231fec..f54812b 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -54,7 +54,8 @@ int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data);
 int write_version_info(bdaddr_t *local, bdaddr_t *peer, uint16_t manufacturer, uint8_t lmp_ver, uint16_t lmp_subver);
 int write_features_info(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
 int read_remote_features(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
-int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm);
+int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								struct tm *tm);
 int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm);
 int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length);
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *type);
-- 
1.7.10.4

