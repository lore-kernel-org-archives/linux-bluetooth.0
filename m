Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/2] obexd/ftp: Update ftp transfer progress
Date: Tue, 28 Oct 2014 19:24:22 +0530
Message-id: <1414504462-25412-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds support for updating file transfer progress for FTP
---
 obexd/plugins/ftp.c | 21 ++++++++++++++++++++-
 obexd/plugins/ftp.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 773861d..2004a77 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -59,6 +59,7 @@ static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 
 struct ftp_session {
 	struct obex_session *os;
+	struct obex_transfer *transfer;
 	char *folder;
 };
 
@@ -116,6 +117,8 @@ void *ftp_connect(struct obex_session *os, int *err)
 	if (err)
 		*err = 0;
 
+	ftp->transfer = manager_register_transfer(os);
+
 	DBG("session %p created", ftp);
 
 	return ftp;
@@ -136,6 +139,9 @@ int ftp_get(struct obex_session *os, void *user_data)
 	if (ret < 0)
 		return ret;
 
+	if (type == NULL)
+		manager_emit_transfer_started(ftp->transfer);
+
 	return 0;
 }
 
@@ -181,6 +187,9 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 
 	ret = obex_put_stream_start(os, path);
 
+	if (ret == 0)
+		manager_emit_transfer_started(ftp->transfer);
+
 	g_free(path);
 
 	return ret;
@@ -471,10 +480,19 @@ void ftp_disconnect(struct obex_session *os, void *user_data)
 
 	manager_unregister_session(os);
 
+	manager_unregister_transfer(ftp->transfer);
+
 	g_free(ftp->folder);
 	g_free(ftp);
 }
 
+void ftp_progress(struct obex_session *os, void *user_data)
+{
+	struct ftp_session *ftp = user_data;
+
+	manager_emit_transfer_progress(ftp->transfer);
+}
+
 static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
@@ -486,7 +504,8 @@ static struct obex_service_driver ftp = {
 	.chkput = ftp_chkput,
 	.setpath = ftp_setpath,
 	.action = ftp_action,
-	.disconnect = ftp_disconnect
+	.disconnect = ftp_disconnect,
+	.progress = ftp_progress
 };
 
 static int ftp_init(void)
diff --git a/obexd/plugins/ftp.h b/obexd/plugins/ftp.h
index f06de84..c0e97a7 100644
--- a/obexd/plugins/ftp.h
+++ b/obexd/plugins/ftp.h
@@ -28,3 +28,4 @@ int ftp_put(struct obex_session *os, void *user_data);
 int ftp_setpath(struct obex_session *os, void *user_data);
 void ftp_disconnect(struct obex_session *os, void *user_data);
 int ftp_action(struct obex_session *os, void *user_data);
+void ftp_progress(struct obex_session *os, void *user_data);
-- 
1.9.1

