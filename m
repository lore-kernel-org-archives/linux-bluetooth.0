Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/9] storage: Remove not used read_remote_features
Date: Tue, 9 Oct 2012 14:12:00 +0200
Message-ID: <1349784722-14578-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was only usefull with hciops.

---
 src/storage.c |   45 ---------------------------------------------
 src/storage.h |    2 --
 2 files changed, 47 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 297aba7..ac66021 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -435,51 +435,6 @@ done:
 	return 0;
 }
 
-static int decode_bytes(const char *str, unsigned char *bytes, size_t len)
-{
-	unsigned int i;
-
-	for (i = 0; i < len; i++) {
-		if (sscanf(str + (i * 2), "%02hhX", &bytes[i]) != 1)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
-				unsigned char *page1, unsigned char *page2)
-{
-	char filename[PATH_MAX + 1], addr[18], *str;
-	size_t len;
-	int err;
-
-	if (page1 == NULL && page2 == NULL)
-		return -EINVAL;
-
-	create_filename(filename, PATH_MAX, local, "features");
-
-	ba2str(peer, addr);
-
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -ENOENT;
-
-	len = strlen(str);
-
-	err = -ENOENT;
-
-	if (page1 && len >= 16)
-		err = decode_bytes(str, page1, 8);
-
-	if (page2 && len >= 33)
-		err = decode_bytes(str + 17, page2, 8);
-
-	free(str);
-
-	return err;
-}
-
 int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm)
 {
diff --git a/src/storage.h b/src/storage.h
index 8293ba8..e334828 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,8 +50,6 @@ int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
-				unsigned char *page1, unsigned char *page2);
 int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm);
 int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
-- 
1.7.9.5

