Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH v3 BlueZ 06/12] storage: Store address type in "lastused" file
Date: Fri, 27 Jul 2012 16:43:17 -0300
Message-Id: <1343418203-15335-7-git-send-email-vinicius.gomes@openbossa.org>
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
index 12eb9d9..9168013 100644
--- a/src/event.c
+++ b/src/event.c
@@ -244,7 +244,7 @@ static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 	write_lastseen_info(sba, dba, dba_type, tm);
 }
 
-static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
+static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 {
 	time_t t;
 	struct tm *tm;
@@ -252,7 +252,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
 	t = time(NULL);
 	tm = gmtime(&t);
 
-	write_lastused_info(sba, dba, tm);
+	write_lastused_info(sba, dba, dba_type, tm);
 }
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
@@ -460,7 +460,7 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_typ
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return;
 
-	update_lastused(local, peer);
+	update_lastused(local, peer, bdaddr_type);
 
 	if (dev_class != NULL) {
 		uint32_t class = dev_class[0] | (dev_class[1] << 8) |
diff --git a/src/storage.c b/src/storage.c
index 89c28e0..c10f9ae 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -590,9 +590,10 @@ int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, key, str);
 }
 
-int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
+int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								struct tm *tm)
 {
-	char filename[PATH_MAX + 1], addr[18], str[24];
+	char filename[PATH_MAX + 1], key[20], str[24];
 
 	memset(str, 0, sizeof(str));
 	strftime(str, sizeof(str), "%Y-%m-%d %H:%M:%S %Z", tm);
@@ -601,8 +602,10 @@ int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(peer, addr);
-	return textfile_put(filename, addr, str);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
+
+	return textfile_put(filename, key, str);
 }
 
 int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length)
diff --git a/src/storage.h b/src/storage.h
index f54812b..cd7b161 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -56,7 +56,8 @@ int write_features_info(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, u
 int read_remote_features(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
 int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 								struct tm *tm);
-int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm);
+int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								struct tm *tm);
 int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length);
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *type);
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
-- 
1.7.10.4

