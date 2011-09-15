Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 5/5] Fix magic numbers for local/remote name length
Date: Thu, 15 Sep 2011 16:32:41 -0300
Message-Id: <1316115161-19874-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315572669-5006-6-git-send-email-claudio.takahasi@openbossa.org>
References: <1315572669-5006-6-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 00dc483..c64842c 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -237,8 +237,8 @@ int read_local_name(bdaddr_t *bdaddr, char *name)
 		return -ENOENT;
 
 	len = strlen(str);
-	if (len > 248)
-		str[248] = '\0';
+	if (len > HCI_MAX_NAME_LENGTH)
+		str[HCI_MAX_NAME_LENGTH] = '\0';
 	strcpy(name, str);
 
 	free(str);
@@ -319,11 +319,11 @@ int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class)
 
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
-	char filename[PATH_MAX + 1], addr[18], str[249];
+	char filename[PATH_MAX + 1], addr[18], str[HCI_MAX_NAME_LENGTH + 1];
 	int i;
 
 	memset(str, 0, sizeof(str));
-	for (i = 0; i < 248 && name[i]; i++)
+	for (i = 0; i < HCI_MAX_NAME_LENGTH && name[i]; i++)
 		if ((unsigned char) name[i] < 32 || name[i] == 127)
 			str[i] = '.';
 		else
@@ -349,8 +349,8 @@ int read_device_name(const char *src, const char *dst, char *name)
 		return -ENOENT;
 
 	len = strlen(str);
-	if (len > 248)
-		str[248] = '\0';
+	if (len > HCI_MAX_NAME_LENGTH)
+		str[HCI_MAX_NAME_LENGTH] = '\0';
 	strcpy(name, str);
 
 	free(str);
-- 
1.7.6.1

