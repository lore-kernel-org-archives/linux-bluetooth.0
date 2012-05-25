Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 18/18] storage: Keep backward compatibility in "aliases" file
Date: Fri, 25 May 2012 12:47:10 -0300
Message-Id: <1337960830-3506-19-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "aliases" file is shared by both BR/EDR and LE devices, so we must
keep backward compatibility with the old storage format.
---
 src/storage.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 97817cc..3374fc0 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -73,9 +73,17 @@ int read_device_alias(const char *src, const char *dst, uint8_t bdaddr_type,
 	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
 
 	tmp = textfile_get(filename, key);
-	if (!tmp)
+	if (tmp != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	tmp = textfile_get(filename, key);
+	if (tmp == NULL)
 		return -ENXIO;
 
+done:
 	err = snprintf(alias, size, "%s", tmp);
 
 	free(tmp);
-- 
1.7.7.6

