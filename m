Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd] client: fix unreported canceled transfers
Date: Mon, 27 Feb 2012 15:14:37 +0100
Message-Id: <1330352077-1196-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A session can be shutted down from D-Bus, and therefore the pending
transfer callbacks must be reported.
---
 client/session.c  |   15 ++++++++++++++-
 client/transfer.c |    4 +---
 client/transfer.h |    3 +++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/client/session.c b/client/session.c
index 417295e..f5740ce 100644
--- a/client/session.c
+++ b/client/session.c
@@ -485,12 +485,25 @@ proceed:
 
 void obc_session_shutdown(struct obc_session *session)
 {
+	struct pending_request *p;
+	GError *err;
+
 	DBG("%p", session);
 
 	obc_session_ref(session);
 
 	/* Unregister any pending transfer */
-	g_queue_foreach(session->queue, (GFunc) pending_request_free, NULL);
+	err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
+							strerror(ECANCELED));
+
+	while ((p = g_queue_pop_head(session->queue))) {
+		if (p->func)
+			p->func(session, err, p->data);
+
+		pending_request_free(p);
+	}
+
+	g_error_free(err);
 
 	/* Unregister interfaces */
 	if (session->path)
diff --git a/client/transfer.c b/client/transfer.c
index d1edef2..4735c17 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -44,8 +44,6 @@
 
 #define DEFAULT_BUFFER_SIZE 4096
 
-#define OBC_TRANSFER_ERROR obc_transfer_error_quark()
-
 static guint64 counter = 0;
 
 struct transfer_callback {
@@ -73,7 +71,7 @@ struct obc_transfer {
 	int err;
 };
 
-static GQuark obc_transfer_error_quark(void)
+GQuark obc_transfer_error_quark(void)
 {
 	return g_quark_from_static_string("obc-transfer-error-quark");
 }
diff --git a/client/transfer.h b/client/transfer.h
index e7e1000..c05e51b 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -21,6 +21,9 @@
  *
  */
 
+#define OBC_TRANSFER_ERROR obc_transfer_error_quark()
+GQuark obc_transfer_error_quark(void);
+
 struct obc_transfer_params {
 	guint8 *data;
 	size_t size;
-- 
1.7.6.5

