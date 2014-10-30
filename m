Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v3] obexd/ftp: Update ftp transfer progress
Date: Thu, 30 Oct 2014 20:24:54 +0530
Message-id: <1414680894-27631-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds support for updating file transfer progress for FTP
---
 obexd/plugins/ftp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 773861d..35497a2 100644
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
@@ -136,6 +139,13 @@ int ftp_get(struct obex_session *os, void *user_data)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Below code takes care about the actual file transfer
+	 * not other ftp operations.
+	 */
+	if (type == NULL)
+		manager_emit_transfer_started(ftp->transfer);
+
 	return 0;
 }
 
@@ -181,6 +191,9 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 
 	ret = obex_put_stream_start(os, path);
 
+	if (ret == 0)
+		manager_emit_transfer_started(ftp->transfer);
+
 	g_free(path);
 
 	return ret;
@@ -471,16 +484,26 @@ void ftp_disconnect(struct obex_session *os, void *user_data)
 
 	manager_unregister_session(os);
 
+	manager_unregister_transfer(ftp->transfer);
+
 	g_free(ftp->folder);
 	g_free(ftp);
 }
 
+static void ftp_progress(struct obex_session *os, void *user_data)
+{
+	struct ftp_session *ftp = user_data;
+
+	manager_emit_transfer_progress(ftp->transfer);
+}
+
 static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
 	.connect = ftp_connect,
+	.progress = ftp_progress,
 	.get = ftp_get,
 	.put = ftp_put,
 	.chkput = ftp_chkput,
-- 
1.9.1

