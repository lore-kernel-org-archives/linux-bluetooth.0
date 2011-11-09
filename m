Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCHv2 obexd] Add cleanup of '.pcsuite' file on pcsuite_init
Date: Wed,  9 Nov 2011 11:55:52 +0100
Message-Id: <1320836152-2936-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

File named '.pcsuite' is used to show to other applications
that PC-Suite connection is active - some operations shouldn't
be performed on device when synchronization is in progress.
In scenario when obexd will be killed or crashed during PC-Suite
connection this file will stay forever in filestystem, because
pcsuite_disconnect won't be called to do clean-up.

This patch adds function which will remove '.pcsuite' file
in such problematic scenarios on pcsuite_init.
---
 plugins/pcsuite.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 27a3496..69e184f 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -55,6 +55,7 @@
 
 #define PCSUITE_CHANNEL 24
 #define PCSUITE_WHO_SIZE 8
+#define PCSUITE_FILE_NAME ".pcsuite"
 
 #define PCSUITE_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
 <record>								\
@@ -130,7 +131,7 @@ static void *pcsuite_connect(struct obex_session *os, int *err)
 	if (ftp == NULL)
 		return NULL;
 
-	filename = g_build_filename(g_get_home_dir(), ".pcsuite", NULL);
+	filename = g_build_filename(g_get_home_dir(), PCSUITE_FILE_NAME, NULL);
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0644);
 	if (fd < 0 && errno != EEXIST) {
@@ -497,10 +498,31 @@ static struct obex_mime_type_driver backup = {
 	.flush = backup_flush,
 };
 
+static void pcsuite_file_cleanup(void)
+{
+	char *filename;
+	struct stat buf;
+
+	filename = g_build_filename(g_get_home_dir(), PCSUITE_FILE_NAME, NULL);
+
+	if (stat(filename, &buf) == 0) {
+		DBG("Removing unneeded pcsuite-file: %s", filename);
+		remove(filename);
+	}
+
+	g_free(filename);
+}
+
 static int pcsuite_init(void)
 {
 	int err;
 
+	/* In some cases '.pcsuite' file will be present on device even if
+	 * there is no PC-Suite connection active in the moment(eg. obexd
+	 * crashed or was killed while pcsuite connection was active)
+	 * Removing this file if not needed. */
+	pcsuite_file_cleanup();
+
 	err = obex_service_driver_register(&pcsuite);
 	if (err < 0)
 		return err;
-- 
1.7.0.4

