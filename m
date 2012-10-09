Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/9] storage: Remove not used write_version_info
Date: Tue, 9 Oct 2012 14:11:58 +0200
Message-ID: <1349784722-14578-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was used in hciops only.

---
 src/storage.c |   17 -----------------
 src/storage.h |    3 ---
 2 files changed, 20 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index d4189c5..4dc2d17 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -435,23 +435,6 @@ done:
 	return 0;
 }
 
-int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
-					uint16_t manufacturer, uint8_t lmp_ver,
-					uint16_t lmp_subver)
-{
-	char filename[PATH_MAX + 1], addr[18], str[16];
-
-	memset(str, 0, sizeof(str));
-	sprintf(str, "%d %d %d", manufacturer, lmp_ver, lmp_subver);
-
-	create_filename(filename, PATH_MAX, local, "manufacturers");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, addr);
-	return textfile_put(filename, addr, str);
-}
-
 int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
 				unsigned char *page1, unsigned char *page2)
 {
diff --git a/src/storage.h b/src/storage.h
index 0a91d47..e19e67f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,9 +50,6 @@ int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
-				uint16_t manufacturer, uint8_t lmp_ver,
-				uint16_t lmp_subver);
 int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
 				unsigned char *page1, unsigned char *page2);
 int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
-- 
1.7.9.5

