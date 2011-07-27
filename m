Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Make mime type matching case-insensitive
Date: Wed, 27 Jul 2011 16:57:32 +0200
Message-Id: <1311778652-7652-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes mime type checking performed inside plugins case-insensitive, to
be in line with d37af12d8cb76d1eb893955938cb6475333dddb9.
---
 plugins/ftp.c  |    2 +-
 plugins/opp.c  |    2 +-
 plugins/pbap.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 2ec008f..08d4e34 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -179,7 +179,7 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	if (type == NULL && name == NULL)
 		return -EBADR;
 
-	if (g_strcmp0(type, CAP_TYPE) == 0)
+	if (g_ascii_strcasecmp(type, CAP_TYPE) == 0)
 		return obex_get_stream_start(os, capability);
 
 	path = g_build_filename(ftp->folder, name, NULL);
diff --git a/plugins/opp.c b/plugins/opp.c
index 4f0ed08..4aca594 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -182,7 +182,7 @@ static int opp_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 	if (type == NULL)
 		return -EPERM;
 
-	if (g_str_equal(type, VCARD_TYPE)) {
+	if (g_ascii_strcasecmp(type, VCARD_TYPE)) {
 		if (obex_get_stream_start(os, VCARD_FILE) < 0)
 			return -ENOENT;
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 82963af..4892d7a 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -654,14 +654,14 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 
 	pbap->params = params;
 
-	if (strcmp(type, PHONEBOOK_TYPE) == 0) {
+	if (g_ascii_strcasecmp(type, PHONEBOOK_TYPE) == 0) {
 		/* Always contains the absolute path */
 		if (g_path_is_absolute(name))
 			path = g_strdup(name);
 		else
 			path = g_build_filename("/", name, NULL);
 
-	} else if (strcmp(type, VCARDLISTING_TYPE) == 0) {
+	} else if (g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
 		if (!name || strlen(name) == 0)
 			/* Current folder */
@@ -670,7 +670,7 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 			/* Current folder + relative path */
 			path = g_build_filename(pbap->folder, name, NULL);
 
-	} else if (strcmp(type, VCARDENTRY_TYPE) == 0) {
+	} else if (g_ascii_strcasecmp(type, VCARDENTRY_TYPE) == 0) {
 		/* File name only */
 		path = g_strdup(name);
 	} else
-- 
1.7.4.1

