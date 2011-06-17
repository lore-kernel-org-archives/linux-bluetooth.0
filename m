Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] Add support for Action command to pcsuite plugin
Date: Fri, 17 Jun 2011 09:26:46 +0300
Message-Id: <1308292007-2111-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

PCSuite service relies on ftp driver
---
 plugins/ftp.c     |    3 +--
 plugins/ftp.h     |    1 +
 plugins/pcsuite.c |   11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 7e2f1e4..4cf0135 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -478,8 +478,7 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 	return ret;
 }
 
-static int ftp_action(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+int ftp_action(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name, *destname;
diff --git a/plugins/ftp.h b/plugins/ftp.h
index 2374125..710bfa4 100644
--- a/plugins/ftp.h
+++ b/plugins/ftp.h
@@ -28,3 +28,4 @@ int ftp_chkput(struct obex_session *os, void *user_data);
 int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data);
 int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data);
 void ftp_disconnect(struct obex_session *os, void *user_data);
+int ftp_action(struct obex_session *os, obex_object_t *obj, void *user_data);
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 5545917..125f25a 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -219,6 +219,16 @@ static int pcsuite_setpath(struct obex_session *os, obex_object_t *obj,
 	return ftp_setpath(os, obj, pcsuite->ftp);
 }
 
+static int pcsuite_action(struct obex_session *os, obex_object_t *obj,
+							void *user_data)
+{
+	struct pcsuite_session *pcsuite = user_data;
+
+	DBG("%p", pcsuite);
+
+	return ftp_action(os, obj, pcsuite->ftp);
+}
+
 static void pcsuite_disconnect(struct obex_session *os, void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
@@ -253,6 +263,7 @@ static struct obex_service_driver pcsuite = {
 	.put = pcsuite_put,
 	.chkput = pcsuite_chkput,
 	.setpath = pcsuite_setpath,
+	.action = pcsuite_action,
 	.disconnect = pcsuite_disconnect
 };
 
-- 
1.7.5.4

