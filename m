Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 17/18] storage: Keep backward compatibility in "names" file
Date: Fri, 25 May 2012 12:47:09 -0300
Message-Id: <1337960830-3506-18-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "names" file is shared by both BR/EDR and LE devices, so we must keep
backward compatibility with the old storage format.
---
 src/storage.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index cb7cde2..97817cc 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -400,9 +400,17 @@ int read_device_name(const char *src, const char *dst, uint8_t bdaddr_type,
 	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
 
 	str = textfile_get(filename, key);
-	if (!str)
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	str = textfile_get(filename, key);
+	if (str == NULL)
 		return -ENOENT;
 
+done:
 	len = strlen(str);
 	if (len > HCI_MAX_NAME_LENGTH)
 		str[HCI_MAX_NAME_LENGTH] = '\0';
-- 
1.7.7.6

