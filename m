Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 16/18] storage: Keep backward compatibility in "blocked" file
Date: Fri, 25 May 2012 12:47:08 -0300
Message-Id: <1337960830-3506-17-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "blocked" file is shared by both BR/EDR and LE devices, so we must
keep backward compatibility with the old storage format.
---
 src/storage.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 33dcace..cb7cde2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1155,9 +1155,17 @@ gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
 	sprintf(&key[17], "#%hhu", bdaddr_type);
 
 	str = textfile_caseget(filename, key);
-	if (!str)
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
 		return FALSE;
 
+done:
 	free(str);
 
 	return TRUE;
-- 
1.7.7.6

