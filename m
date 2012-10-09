Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/9] storage: Remove not used read_remote_eir
Date: Tue, 9 Oct 2012 14:11:57 +0200
Message-ID: <1349784722-14578-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not used. Previously it was used to determine if
remote device is legacy or not.

---
 src/storage.c |   41 -----------------------------------------
 src/storage.h |    2 --
 2 files changed, 43 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 55dc591..d4189c5 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -435,47 +435,6 @@ done:
 	return 0;
 }
 
-int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, uint8_t *data)
-{
-	char filename[PATH_MAX + 1], key[18], *str;
-	int i;
-
-	create_filename(filename, PATH_MAX, local, "eir");
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", peer_type);
-
-	str = textfile_get(filename, key);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	key[17] = '\0';
-
-	str = textfile_get(filename, key);
-	if (!str)
-		return -ENOENT;
-
-done:
-	if (!data) {
-		free(str);
-		return 0;
-	}
-
-	if (strlen(str) < 480) {
-		free(str);
-		return -EIO;
-	}
-
-	for (i = 0; i < HCI_MAX_EIR_LENGTH; i++)
-		sscanf(str + (i * 2), "%02hhX", &data[i]);
-
-	free(str);
-
-	return 0;
-}
-
 int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint16_t manufacturer, uint8_t lmp_ver,
 					uint16_t lmp_subver)
diff --git a/src/storage.h b/src/storage.h
index d6aa8ec..0a91d47 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,8 +50,6 @@ int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, uint8_t *data);
 int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
 				uint16_t manufacturer, uint8_t lmp_ver,
 				uint16_t lmp_subver);
-- 
1.7.9.5

