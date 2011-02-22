Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Add support for pcsuite lock file
Date: Tue, 22 Feb 2011 11:43:38 +0200
Message-Id: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should make others applications able to detect when pcsuite is
connected.
---
 plugins/ftp.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 154 insertions(+), 6 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index a952f64..38d058c 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -150,8 +150,16 @@ struct ftp_session {
 	char *folder;
 };
 
+struct pcsuite_session {
+	struct ftp_session *ftp;
+	char *lock_file;
+	int fd;
+};
+
 static void set_folder(struct ftp_session *ftp, const char *new_folder)
 {
+	DBG("%p folder %s", ftp, new_folder);
+
 	g_free(ftp->folder);
 
 	ftp->folder = new_folder ? g_strdup(new_folder) : NULL;
@@ -165,6 +173,8 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	char *path;
 	int err;
 
+	DBG("%p name %s type %s", ftp, name, type);
+
 	if (type == NULL && name == NULL)
 		return -EBADR;
 
@@ -184,6 +194,8 @@ static void *ftp_connect(struct obex_session *os, int *err)
 	struct ftp_session *ftp;
 	const char *root_folder;
 
+	DBG("");
+
 	root_folder = obex_get_root_folder(os);
 
 	manager_register_session(os);
@@ -195,6 +207,8 @@ static void *ftp_connect(struct obex_session *os, int *err)
 	if (err)
 		*err = 0;
 
+	DBG("session %p created", ftp);
+
 	return ftp;
 }
 
@@ -205,6 +219,8 @@ static int ftp_get(struct obex_session *os, obex_object_t *obj,
 	const char *type = obex_get_type(os);
 	int ret;
 
+	DBG("%p", ftp);
+
 	if (ftp->folder == NULL)
 		return -ENOENT;
 
@@ -223,6 +239,8 @@ static int ftp_delete(struct ftp_session *ftp, const char *name)
 	char *path;
 	int ret = 0;
 
+	DBG("%p name %s", ftp, name);
+
 	if (!(ftp->folder && name))
 		return -EINVAL;
 
@@ -243,6 +261,8 @@ static int ftp_chkput(struct obex_session *os, void *user_data)
 	char *path;
 	int ret;
 
+	DBG("%p name %s", ftp, name);
+
 	if (name == NULL)
 		return -EBADR;
 
@@ -265,6 +285,8 @@ static int ftp_put(struct obex_session *os, obex_object_t *obj,
 	const char *name = obex_get_name(os);
 	ssize_t size = obex_get_size(os);
 
+	DBG("%p name %s size %d", ftp, name, size);
+
 	if (ftp->folder == NULL)
 		return -EPERM;
 
@@ -297,6 +319,8 @@ static int ftp_setpath(struct obex_session *os, obex_object_t *obj,
 	root_folder = obex_get_root_folder(os);
 	root = g_str_equal(root_folder, ftp->folder);
 
+	DBG("%p name %s", ftp, name);
+
 	/* Check flag "Backup" */
 	if ((nonhdr[0] & 0x01) == 0x01) {
 		DBG("Set to parent path");
@@ -384,12 +408,136 @@ static void ftp_disconnect(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 
+	DBG("%p", ftp);
+
 	manager_unregister_session(os);
 
 	g_free(ftp->folder);
 	g_free(ftp);
 }
 
+static void *pcsuite_connect(struct obex_session *os, int *err)
+{
+	struct pcsuite_session *pcsuite;
+	struct ftp_session *ftp;
+	int fd;
+	char *filename;
+
+	DBG("");
+
+	ftp = ftp_connect(os, err);
+	if (ftp == NULL)
+		return NULL;
+
+	filename = g_build_filename(g_get_home_dir(), ".pcsuite", NULL);
+
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0644);
+	if (fd < 0 && errno != EEXIST) {
+		error("open(%s): %s(%d)", filename, strerror(errno), errno);
+		goto fail;
+	}
+
+	/* Try to remove the file before retrying since it could be
+	   that some process left/crash without removing it */
+	if (fd < 0) {
+		if (remove(filename) < 0) {
+			error("remove(%s): %s(%d)", filename, strerror(errno),
+									errno);
+			goto fail;
+		}
+
+		fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0644);
+		if (fd < 0) {
+			error("open(%s): %s(%d)", filename, strerror(errno),
+									errno);
+			goto fail;
+		}
+	}
+
+	DBG("%s created", filename);
+
+	pcsuite = g_new0(struct pcsuite_session, 1);
+	pcsuite->ftp = ftp;
+	pcsuite->lock_file = filename;
+	pcsuite->fd = fd;
+
+	DBG("session %p created", pcsuite);
+
+	if (err)
+		*err = 0;
+
+	return pcsuite;
+
+fail:
+	if (ftp)
+		ftp_disconnect(os, ftp);
+	if (err)
+		*err = -errno;
+
+	g_free(filename);
+
+	return NULL;
+}
+
+static int pcsuite_get(struct obex_session *os, obex_object_t *obj,
+					gboolean *stream, void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	return ftp_get(os, obj, stream, pcsuite->ftp);
+}
+
+static int pcsuite_chkput(struct obex_session *os, void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	return ftp_chkput(os, pcsuite->ftp);
+}
+
+static int pcsuite_put(struct obex_session *os, obex_object_t *obj,
+							void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	return ftp_put(os, obj, pcsuite->ftp);
+}
+
+static int pcsuite_setpath(struct obex_session *os, obex_object_t *obj,
+							void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	return ftp_setpath(os, obj, pcsuite->ftp);
+}
+
+static void pcsuite_disconnect(struct obex_session *os, void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	if (pcsuite->fd >= 0)
+		close(pcsuite->fd);
+
+	if (pcsuite->lock_file) {
+		remove(pcsuite->lock_file);
+		g_free(pcsuite->lock_file);
+	}
+
+	if (pcsuite->ftp)
+		ftp_disconnect(os, pcsuite->ftp);
+
+	g_free(pcsuite);
+}
+
 static struct obex_service_driver pcsuite = {
 	.name = "Nokia OBEX PC Suite Services",
 	.service = OBEX_PCSUITE,
@@ -399,12 +547,12 @@ static struct obex_service_driver pcsuite = {
 	.target_size = TARGET_SIZE,
 	.who = PCSUITE_WHO,
 	.who_size = PCSUITE_WHO_SIZE,
-	.connect = ftp_connect,
-	.get = ftp_get,
-	.put = ftp_put,
-	.chkput = ftp_chkput,
-	.setpath = ftp_setpath,
-	.disconnect = ftp_disconnect
+	.connect = pcsuite_connect,
+	.get = pcsuite_get,
+	.put = pcsuite_put,
+	.chkput = pcsuite_chkput,
+	.setpath = pcsuite_setpath,
+	.disconnect = pcsuite_disconnect
 };
 
 static struct obex_service_driver ftp = {
-- 
1.7.1

