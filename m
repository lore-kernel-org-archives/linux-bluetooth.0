Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/9] storage: Remove not used write_features_info
Date: Tue, 9 Oct 2012 14:11:59 +0200
Message-ID: <1349784722-14578-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was used in hciops.

---
 src/storage.c |   32 --------------------------------
 src/storage.h |    2 --
 2 files changed, 34 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 4dc2d17..297aba7 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -435,38 +435,6 @@ done:
 	return 0;
 }
 
-int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
-				unsigned char *page1, unsigned char *page2)
-{
-	char filename[PATH_MAX + 1], addr[18];
-	char str[] = "0000000000000000 0000000000000000";
-	char *old_value;
-	int i;
-
-	ba2str(peer, addr);
-
-	create_filename(filename, PATH_MAX, local, "features");
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	old_value = textfile_get(filename, addr);
-
-	if (page1)
-		for (i = 0; i < 8; i++)
-			sprintf(str + (i * 2), "%2.2X", page1[i]);
-	else if (old_value && strlen(old_value) >= 16)
-		strncpy(str, old_value, 16);
-
-	if (page2)
-		for (i = 0; i < 8; i++)
-			sprintf(str + 17 + (i * 2), "%2.2X", page2[i]);
-	else if (old_value && strlen(old_value) >= 33)
-		strncpy(str + 17, old_value + 17, 16);
-
-	free(old_value);
-
-	return textfile_put(filename, addr, str);
-}
-
 static int decode_bytes(const char *str, unsigned char *bytes, size_t len)
 {
 	unsigned int i;
diff --git a/src/storage.h b/src/storage.h
index e19e67f..8293ba8 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,8 +50,6 @@ int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
-				unsigned char *page1, unsigned char *page2);
 int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
 				unsigned char *page1, unsigned char *page2);
 int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
-- 
1.7.9.5

