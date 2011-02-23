Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Add more debug logs for ftp driver
Date: Wed, 23 Feb 2011 11:54:37 +0200
Message-Id: <1298454881-7941-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
References: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 plugins/ftp.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 546b58c..633abf3 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -158,6 +158,8 @@ struct pcsuite_session {
 
 static void set_folder(struct ftp_session *ftp, const char *new_folder)
 {
+	DBG("%p folder %s", ftp, new_folder);
+
 	g_free(ftp->folder);
 
 	ftp->folder = new_folder ? g_strdup(new_folder) : NULL;
@@ -171,6 +173,8 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	char *path;
 	int err;
 
+	DBG("%p name %s type %s", ftp, name, type);
+
 	if (type == NULL && name == NULL)
 		return -EBADR;
 
@@ -190,6 +194,8 @@ static void *ftp_connect(struct obex_session *os, int *err)
 	struct ftp_session *ftp;
 	const char *root_folder;
 
+	DBG("");
+
 	root_folder = obex_get_root_folder(os);
 
 	manager_register_session(os);
@@ -201,6 +207,8 @@ static void *ftp_connect(struct obex_session *os, int *err)
 	if (err)
 		*err = 0;
 
+	DBG("session %p created", ftp);
+
 	return ftp;
 }
 
@@ -211,6 +219,8 @@ static int ftp_get(struct obex_session *os, obex_object_t *obj,
 	const char *type = obex_get_type(os);
 	int ret;
 
+	DBG("%p", ftp);
+
 	if (ftp->folder == NULL)
 		return -ENOENT;
 
@@ -229,6 +239,8 @@ static int ftp_delete(struct ftp_session *ftp, const char *name)
 	char *path;
 	int ret = 0;
 
+	DBG("%p name %s", ftp, name);
+
 	if (!(ftp->folder && name))
 		return -EINVAL;
 
@@ -249,6 +261,8 @@ static int ftp_chkput(struct obex_session *os, void *user_data)
 	char *path;
 	int ret;
 
+	DBG("%p name %s", ftp, name);
+
 	if (name == NULL)
 		return -EBADR;
 
@@ -271,6 +285,8 @@ static int ftp_put(struct obex_session *os, obex_object_t *obj,
 	const char *name = obex_get_name(os);
 	ssize_t size = obex_get_size(os);
 
+	DBG("%p name %s size %zd", ftp, name, size);
+
 	if (ftp->folder == NULL)
 		return -EPERM;
 
@@ -303,6 +319,8 @@ static int ftp_setpath(struct obex_session *os, obex_object_t *obj,
 	root_folder = obex_get_root_folder(os);
 	root = g_str_equal(root_folder, ftp->folder);
 
+	DBG("%p name %s", ftp, name);
+
 	/* Check flag "Backup" */
 	if ((nonhdr[0] & 0x01) == 0x01) {
 		DBG("Set to parent path");
@@ -390,6 +408,8 @@ static void ftp_disconnect(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 
+	DBG("%p", ftp);
+
 	manager_unregister_session(os);
 
 	g_free(ftp->folder);
-- 
1.7.1

