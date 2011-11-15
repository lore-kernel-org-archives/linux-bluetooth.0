Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/16] Remove use of obex_object_t from service.h
Date: Tue, 15 Nov 2011 15:27:55 +0200
Message-Id: <1321363687-32490-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Plugins including service.h need to include openobex headers because of
this.
---
 plugins/ftp.c           |    8 ++++----
 plugins/ftp.h           |    8 ++++----
 plugins/irmc.c          |    3 +--
 plugins/mas.c           |    7 +++----
 plugins/opp.c           |    5 ++---
 plugins/pbap.c          |    6 ++----
 plugins/pcsuite.c       |   20 ++++++++------------
 plugins/syncevolution.c |    6 ++----
 src/obex.c              |    8 ++++----
 src/service.h           |   12 ++++--------
 10 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 7a736ae..2b5cc2e 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -163,7 +163,7 @@ void *ftp_connect(struct obex_session *os, int *err)
 	return ftp;
 }
 
-int ftp_get(struct obex_session *os, obex_object_t *obj, void *user_data)
+int ftp_get(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *type = obex_get_type(os);
@@ -228,7 +228,7 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 	return ret;
 }
 
-int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data)
+int ftp_put(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name = obex_get_name(os);
@@ -251,7 +251,7 @@ int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data)
 	return 0;
 }
 
-int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
+int ftp_setpath(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *root_folder, *name;
@@ -480,7 +480,7 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 	return ret;
 }
 
-int ftp_action(struct obex_session *os, obex_object_t *obj, void *user_data)
+int ftp_action(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name, *destname;
diff --git a/plugins/ftp.h b/plugins/ftp.h
index 86c7725..f06de84 100644
--- a/plugins/ftp.h
+++ b/plugins/ftp.h
@@ -22,9 +22,9 @@
  */
 
 void *ftp_connect(struct obex_session *os, int *err);
-int ftp_get(struct obex_session *os, obex_object_t *obj, void *user_data);
+int ftp_get(struct obex_session *os, void *user_data);
 int ftp_chkput(struct obex_session *os, void *user_data);
-int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data);
-int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data);
+int ftp_put(struct obex_session *os, void *user_data);
+int ftp_setpath(struct obex_session *os, void *user_data);
 void ftp_disconnect(struct obex_session *os, void *user_data);
-int ftp_action(struct obex_session *os, obex_object_t *obj, void *user_data);
+int ftp_action(struct obex_session *os, void *user_data);
diff --git a/plugins/irmc.c b/plugins/irmc.c
index 4ea76c5..2a198c8 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -237,8 +237,7 @@ static void *irmc_connect(struct obex_session *os, int *err)
 	return irmc;
 }
 
-static int irmc_get(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int irmc_get(struct obex_session *os, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 	const char *type = obex_get_type(os);
diff --git a/plugins/mas.c b/plugins/mas.c
index 7d47212..b104d8f 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -165,7 +165,7 @@ static void mas_disconnect(struct obex_session *os, void *user_data)
 	mas_clean(mas);
 }
 
-static int mas_get(struct obex_session *os, obex_object_t *obj, void *user_data)
+static int mas_get(struct obex_session *os, void *user_data)
 {
 	struct mas_session *mas = user_data;
 	const char *type = obex_get_type(os);
@@ -190,7 +190,7 @@ failed:
 	return ret;
 }
 
-static int mas_put(struct obex_session *os, obex_object_t *obj, void *user_data)
+static int mas_put(struct obex_session *os, void *user_data)
 {
 	struct mas_session *mas = user_data;
 	const char *type = obex_get_type(os);
@@ -406,8 +406,7 @@ proceed:
 		obex_object_set_io_flags(mas, G_IO_IN, err);
 }
 
-static int mas_setpath(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int mas_setpath(struct obex_session *os, void *user_data)
 {
 	const char *name;
 	const uint8_t *nonhdr;
diff --git a/plugins/opp.c b/plugins/opp.c
index ee4fecb..f93206d 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -165,8 +165,7 @@ failed:
 	return err;
 }
 
-static int opp_put(struct obex_session *os, obex_object_t *obj,
-						void *user_data)
+static int opp_put(struct obex_session *os, void *user_data)
 {
 	const char *name = obex_get_name(os);
 	const char *folder = obex_option_root_folder();
@@ -180,7 +179,7 @@ static int opp_put(struct obex_session *os, obex_object_t *obj,
 	return 0;
 }
 
-static int opp_get(struct obex_session *os, obex_object_t *obj, void *user_data)
+static int opp_get(struct obex_session *os, void *user_data)
 {
 	const char *type;
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 2e607b3..7de1dff 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -625,8 +625,7 @@ static void *pbap_connect(struct obex_session *os, int *err)
 	return pbap;
 }
 
-static int pbap_get(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int pbap_get(struct obex_session *os, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	const char *type = obex_get_type(os);
@@ -693,8 +692,7 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	return ret;
 }
 
-static int pbap_setpath(struct obex_session *os, obex_object_t *obj,
-		void *user_data)
+static int pbap_setpath(struct obex_session *os, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	const char *name;
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 27a3496..cbb4ba0 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -180,14 +180,13 @@ fail:
 	return NULL;
 }
 
-static int pcsuite_get(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int pcsuite_get(struct obex_session *os, void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
 
 	DBG("%p", pcsuite);
 
-	return ftp_get(os, obj, pcsuite->ftp);
+	return ftp_get(os, pcsuite->ftp);
 }
 
 static int pcsuite_chkput(struct obex_session *os, void *user_data)
@@ -199,34 +198,31 @@ static int pcsuite_chkput(struct obex_session *os, void *user_data)
 	return ftp_chkput(os, pcsuite->ftp);
 }
 
-static int pcsuite_put(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int pcsuite_put(struct obex_session *os, void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
 
 	DBG("%p", pcsuite);
 
-	return ftp_put(os, obj, pcsuite->ftp);
+	return ftp_put(os, pcsuite->ftp);
 }
 
-static int pcsuite_setpath(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int pcsuite_setpath(struct obex_session *os, void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
 
 	DBG("%p", pcsuite);
 
-	return ftp_setpath(os, obj, pcsuite->ftp);
+	return ftp_setpath(os, pcsuite->ftp);
 }
 
-static int pcsuite_action(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int pcsuite_action(struct obex_session *os, void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
 
 	DBG("%p", pcsuite);
 
-	return ftp_action(os, obj, pcsuite->ftp);
+	return ftp_action(os, pcsuite->ftp);
 }
 
 static void pcsuite_disconnect(struct obex_session *os, void *user_data)
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index fcf6d2b..0a50a24 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -244,14 +244,12 @@ failed:
 	return NULL;
 }
 
-static int synce_put(struct obex_session *os, obex_object_t *obj,
-					void *user_data)
+static int synce_put(struct obex_session *os, void *user_data)
 {
 	return 0;
 }
 
-static int synce_get(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+static int synce_get(struct obex_session *os, void *user_data)
 {
 	return obex_get_stream_start(os, NULL);
 }
diff --git a/src/obex.c b/src/obex.c
index 3a06775..7d8d0e8 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -851,7 +851,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return;
 	}
 
-	err = os->service->get(os, obj, os->service_data);
+	err = os->service->get(os, os->service_data);
 
 	if (err < 0)
 		goto done;
@@ -933,7 +933,7 @@ static void cmd_setpath(struct obex_session *os,
 
 	os->nonhdr_len = OBEX_ObjectGetNonHdrData(obj, &os->nonhdr);
 
-	err = os->service->setpath(os, obj, os->service_data);
+	err = os->service->setpath(os, os->service_data);
 	os_set_response(obj, err);
 }
 
@@ -1132,7 +1132,7 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return;
 	}
 
-	err = os->service->put(os, obj, os->service_data);
+	err = os->service->put(os, os->service_data);
 	if (err < 0) {
 		os_set_response(obj, err);
 		return;
@@ -1240,7 +1240,7 @@ static void cmd_action(struct obex_session *os, obex_t *obex,
 		return;
 	}
 
-	err = os->service->action(os, obj, os->service_data);
+	err = os->service->action(os, os->service_data);
 	if (err < 0) {
 		os_set_response(obj, err);
 		return;
diff --git a/src/service.h b/src/service.h
index 68c4474..3dee7d7 100644
--- a/src/service.h
+++ b/src/service.h
@@ -33,15 +33,11 @@ struct obex_service_driver {
 	const char *record;
 	void *(*connect) (struct obex_session *os, int *err);
 	void (*progress) (struct obex_session *os, void *user_data);
-	int (*get) (struct obex_session *os, obex_object_t *obj,
-							void *user_data);
-	int (*put) (struct obex_session *os, obex_object_t *obj,
-			void *user_data);
+	int (*get) (struct obex_session *os, void *user_data);
+	int (*put) (struct obex_session *os, void *user_data);
 	int (*chkput) (struct obex_session *os, void *user_data);
-	int (*setpath) (struct obex_session *os, obex_object_t *obj,
-							void *user_data);
-	int (*action) (struct obex_session *os, obex_object_t *obj,
-							void *user_data);
+	int (*setpath) (struct obex_session *os, void *user_data);
+	int (*action) (struct obex_session *os, void *user_data);
 	void (*disconnect) (struct obex_session *os, void *user_data);
 	void (*reset) (struct obex_session *os, void *user_data);
 };
-- 
1.7.7.1

