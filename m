Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/4 v2] Add basic support for action commands on ftp driver
Date: Fri, 17 Jun 2011 14:21:56 +0300
Message-Id: <1308309716-9798-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add basic support for copy and move actions for ftp service driver
---
 plugins/ftp.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 79223bf..dc5470a 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -403,6 +403,106 @@ done:
 	return err;
 }
 
+static char *ftp_build_filename(struct ftp_session *ftp, const char *destname)
+{
+	char *filename;
+
+	/* DestName can either be relative or absolute (FTP style) */
+	if (g_path_is_absolute(destname))
+		filename = g_build_filename(obex_get_root_folder(ftp->os),
+						g_path_skip_root(destname),
+						NULL);
+	else
+		filename = g_build_filename(ftp->folder, destname, NULL);
+
+	/* Check if destination is inside root path */
+	if (g_str_has_prefix(filename, ftp->folder))
+		return filename;
+
+	g_free(filename);
+
+	return NULL;
+}
+
+static int ftp_copy(struct ftp_session *ftp, const char *name,
+							const char *destname)
+{
+	char *source, *destination;
+	int ret;
+
+	DBG("%p name %s destination %s", ftp, name, destname);
+
+	if (ftp->folder == NULL) {
+		error("No folder set");
+		return -ENOENT;
+	}
+
+	if (name == NULL || destname == NULL)
+		return -EINVAL;
+
+	destination = ftp_build_filename(ftp, destname);
+
+	source = g_build_filename(ftp->folder, name, NULL);
+
+	ret = obex_copy(ftp->os, source, destination);
+
+	g_free(source);
+	g_free(destination);
+
+	return ret;
+}
+
+static int ftp_move(struct ftp_session *ftp, const char *name,
+							const char *destname)
+{
+	char *source, *destination;
+	int ret;
+
+	DBG("%p name %s destname %s", ftp, name, destname);
+
+	if (ftp->folder == NULL) {
+		error("No folder set");
+		return -ENOENT;
+	}
+
+	if (name == NULL || destname == NULL)
+		return -EINVAL;
+
+	destination = ftp_build_filename(ftp, destname);
+
+	source = g_build_filename(ftp->folder, name, NULL);
+
+	ret = obex_move(ftp->os, source, destination);
+
+	g_free(source);
+	g_free(destination);
+
+	return ret;
+}
+
+static int ftp_action(struct obex_session *os, obex_object_t *obj,
+							void *user_data)
+{
+	struct ftp_session *ftp = user_data;
+	const char *name, *destname;
+	uint8_t action_id;
+
+	name = obex_get_name(os);
+	destname = obex_get_destname(os);
+	action_id = obex_get_action_id(os);
+
+	DBG("%p action 0x%x", ftp, action_id);
+
+	switch (action_id) {
+	case 0x00: /* Copy Object */
+		return ftp_copy(ftp, name, destname);
+	case 0x01: /* Move/Rename Object */
+		return ftp_move(ftp, name, destname);
+	default:
+		return -EINVAL;
+	}
+}
+
 void ftp_disconnect(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
@@ -427,6 +527,7 @@ static struct obex_service_driver ftp = {
 	.put = ftp_put,
 	.chkput = ftp_chkput,
 	.setpath = ftp_setpath,
+	.action = ftp_action,
 	.disconnect = ftp_disconnect
 };
 
-- 
1.7.5.4

