Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 9/9] storage: Rename appearance file to appearances
Date: Sat, 26 May 2012 21:40:54 -0300
Message-Id: <1338079254-14054-10-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the "appearance" file to "appearances" to be more
suitable with its content.
---
 src/storage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 722abde..7d65fe1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -286,7 +286,7 @@ int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 {
 	char filename[PATH_MAX + 1], key[20], *str;
 
-	create_filename(filename, PATH_MAX, local, "appearance");
+	create_filename(filename, PATH_MAX, local, "appearances");
 
 	ba2str(peer, key);
 	sprintf(&key[17], "#%hhu", bdaddr_type);
@@ -310,7 +310,7 @@ int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
 {
 	char filename[PATH_MAX + 1], key[20], str[7];
 
-	create_filename(filename, PATH_MAX, local, "appearance");
+	create_filename(filename, PATH_MAX, local, "appearances");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-- 
1.7.7.6

