Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 01/11] client: minor buffer access api changes
Date: Mon, 12 Mar 2012 14:32:35 +0100
Message-Id: <1331559165-28367-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivial changes in buffer getters in both session and transfer:
	- const qualifiers added, to avoid unwanted frees
	- Buffers are now returned as void* instead of guint8*

Also, obc_session_get_buffer does not clear the internal buffer any
more. This doesn't have any impact in the current code though, since
transfers are unregistered immediately after.
---
 client/pbap.c     |    2 +-
 client/session.c  |   22 +++++-----------------
 client/session.h  |    4 ++--
 client/transfer.c |   17 +++++++----------
 client/transfer.h |   10 +++++-----
 5 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 53a608e..2e1cc10 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -294,7 +294,7 @@ static void pbap_setpath_cb(struct obc_session *session, GError *err,
 static void read_return_apparam(struct obc_session *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
-	struct apparam_hdr *hdr;
+	const struct apparam_hdr *hdr;
 	size_t size;
 
 	*phone_book_size = 0;
diff --git a/client/session.c b/client/session.c
index a9883c7..c597bac 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1156,10 +1156,9 @@ static struct obc_transfer *obc_session_get_transfer(
 	return session->p->transfer;
 }
 
-const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
+const void *obc_session_get_buffer(struct obc_session *session, size_t *size)
 {
 	struct obc_transfer *transfer;
-	const char *buf;
 
 	transfer = obc_session_get_transfer(session);
 	if (transfer == NULL) {
@@ -1169,29 +1168,18 @@ const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
 		return NULL;
 	}
 
-	buf = obc_transfer_get_buffer(transfer, size);
-
-	obc_transfer_clear_buffer(transfer);
-
-	return buf;
+	return obc_transfer_get_buffer(transfer, size);
 }
 
-void *obc_session_get_params(struct obc_session *session, size_t *size)
+const void *obc_session_get_params(struct obc_session *session, size_t *size)
 {
 	struct obc_transfer *transfer;
-	struct obc_transfer_params params;
 
-	transfer= obc_session_get_transfer(session);
+	transfer = obc_session_get_transfer(session);
 	if (transfer == NULL)
 		return NULL;
 
-	if (obc_transfer_get_params(transfer, &params) < 0)
-		return NULL;
-
-	if (size)
-		*size = params.size;
-
-	return params.data;
+	return obc_transfer_get_params(transfer, size);
 }
 
 static void setpath_complete(struct obc_session *session, GError *err,
diff --git a/client/session.h b/client/session.h
index 4bfb41d..40be9ca 100644
--- a/client/session.h
+++ b/client/session.h
@@ -52,8 +52,8 @@ const char *obc_session_get_agent(struct obc_session *session);
 
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
-const char *obc_session_get_buffer(struct obc_session *session, size_t *size);
-void *obc_session_get_params(struct obc_session *session, size_t *size);
+const void *obc_session_get_buffer(struct obc_session *session, size_t *size);
+const void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 int obc_session_send(struct obc_session *session, const char *filename,
 				const char *name);
diff --git a/client/transfer.c b/client/transfer.c
index 60c2e4f..988ec10 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -610,21 +610,18 @@ done:
 	return 0;
 }
 
-int obc_transfer_get_params(struct obc_transfer *transfer,
-					struct obc_transfer_params *params)
+const void *obc_transfer_get_params(struct obc_transfer *transfer, size_t *size)
 {
-	params->data = transfer->params->data;
-	params->size = transfer->params->size;
+	if (transfer->params == NULL)
+		return NULL;
 
-	return 0;
-}
+	if (size != NULL)
+		*size = transfer->params->size;
 
-void obc_transfer_clear_buffer(struct obc_transfer *transfer)
-{
-	transfer->filled = 0;
+	return transfer->params->data;
 }
 
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
+const void *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
 {
 	if (size)
 		*size = transfer->filled;
diff --git a/client/transfer.h b/client/transfer.h
index da7d151..c399129 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -22,7 +22,7 @@
  */
 
 struct obc_transfer_params {
-	guint8 *data;
+	void *data;
 	size_t size;
 };
 
@@ -49,11 +49,11 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 int obc_transfer_get(struct obc_transfer *transfer);
 int obc_transfer_put(struct obc_transfer *transfer);
 
-int obc_transfer_get_params(struct obc_transfer *transfer,
-					struct obc_transfer_params *params);
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size);
+const void *obc_transfer_get_params(struct obc_transfer *transfer,
+								size_t *size);
+const void *obc_transfer_get_buffer(struct obc_transfer *transfer,
+								size_t *size);
 void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
-void obc_transfer_clear_buffer(struct obc_transfer *transfer);
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
 void obc_transfer_set_filename(struct obc_transfer *transfer,
-- 
1.7.7.6

