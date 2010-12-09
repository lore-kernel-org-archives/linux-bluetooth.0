Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2] Change obex_service_driver put() signature
Date: Thu,  9 Dec 2010 08:08:00 +0100
Message-Id: <1291878480-14865-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This API change is needed for implementing Message Access Profile, as
MAP uses application parameters in puts also (for example
SetMessageStatus function, see MAP specification, chapter 5.7) and in
order to access application parameters headers, access to obex object
is required.
---
 plugins/ftp.c           |    3 ++-
 plugins/opp.c           |    3 ++-
 plugins/syncevolution.c |    3 ++-
 src/obex.c              |    2 +-
 src/service.h           |    3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 91c77a3..a952f64 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -258,7 +258,8 @@ static int ftp_chkput(struct obex_session *os, void *user_data)
 	return ret;
 }
 
-static int ftp_put(struct obex_session *os, void *user_data)
+static int ftp_put(struct obex_session *os, obex_object_t *obj,
+						void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name = obex_get_name(os);
diff --git a/plugins/opp.c b/plugins/opp.c
index 05f944f..17c4356 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -155,7 +155,8 @@ skip_auth:
 	return ret;
 }
 
-static int opp_put(struct obex_session *os, void *user_data)
+static int opp_put(struct obex_session *os, obex_object_t *obj,
+						void *user_data)
 {
 	const char *name = obex_get_name(os);
 	const char *folder = obex_get_root_folder(os);
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index bf436a9..8041df6 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -243,7 +243,8 @@ failed:
 	return NULL;
 }
 
-static int synce_put(struct obex_session *os, void *user_data)
+static int synce_put(struct obex_session *os, obex_object_t *obj,
+					void *user_data)
 {
 	return 0;
 }
diff --git a/src/obex.c b/src/obex.c
index 6d4430d..1649cd0 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1089,7 +1089,7 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return;
 	}
 
-	err = os->service->put(os, os->service_data);
+	err = os->service->put(os, obj, os->service_data);
 	if (err < 0)
 		os_set_response(obj, err);
 }
diff --git a/src/service.h b/src/service.h
index 1726c43..a844885 100644
--- a/src/service.h
+++ b/src/service.h
@@ -34,7 +34,8 @@ struct obex_service_driver {
 	void (*progress) (struct obex_session *os, void *user_data);
 	int (*get) (struct obex_session *os, obex_object_t *obj,
 			gboolean *stream, void *user_data);
-	int (*put) (struct obex_session *os, void *user_data);
+	int (*put) (struct obex_session *os, obex_object_t *obj,
+			void *user_data);
 	int (*chkput) (struct obex_session *os, void *user_data);
 	int (*setpath) (struct obex_session *os, obex_object_t *obj,
 							void *user_data);
-- 
1.7.1

