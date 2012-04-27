Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 1/6] client: Minor buffer access API changes
Date: Fri, 27 Apr 2012 12:33:35 +0200
Message-Id: <1335522820-11826-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivial changes in buffer getters in both session and transfer,
regarding the access of transfer parameters:
	- const qualifiers added, to avoid unwanted frees
	- Buffers are now returned as void* instead of guint8*
---
 client/pbap.c     |    2 +-
 client/session.c  |   17 +++++++----------
 client/session.h  |    2 +-
 client/transfer.c |   12 +++++++-----
 client/transfer.h |    6 +++---
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index baf2ca6..d96b651 100644
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
index e277fa0..824ef49 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1156,22 +1156,19 @@ int obc_session_get_contents(struct obc_session *session, char **contents,
 	return obc_transfer_get_contents(transfer, contents, size);
 }
 
-void *obc_session_get_params(struct obc_session *session, size_t *size)
+const void *obc_session_get_params(struct obc_session *session, size_t *size)
 {
 	struct obc_transfer *transfer;
-	struct obc_transfer_params params;
 
-	transfer= obc_session_get_transfer(session);
-	if (transfer == NULL)
-		return NULL;
+	transfer = obc_session_get_transfer(session);
+	if (transfer == NULL) {
+		if (size != NULL)
+			*size = 0;
 
-	if (obc_transfer_get_params(transfer, &params) < 0)
 		return NULL;
+	}
 
-	if (size)
-		*size = params.size;
-
-	return params.data;
+	return obc_transfer_get_params(transfer, size);
 }
 
 static void setpath_complete(struct obc_session *session, GError *err,
diff --git a/client/session.h b/client/session.h
index c443392..b44cf3f 100644
--- a/client/session.h
+++ b/client/session.h
@@ -54,7 +54,7 @@ const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 int obc_session_get_contents(struct obc_session *session, char **contents,
 								size_t *size);
-void *obc_session_get_params(struct obc_session *session, size_t *size);
+const void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 guint obc_session_send(struct obc_session *session, const char *filename,
 				const char *name, GError **err);
diff --git a/client/transfer.c b/client/transfer.c
index 8b5d126..89690d0 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -631,13 +631,15 @@ guint8 obc_transfer_get_operation(struct obc_transfer *transfer)
 	return transfer->op;
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
+	if (size != NULL)
+		*size = transfer->params->size;
+
+	return transfer->params->data;
 }
 
 int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
diff --git a/client/transfer.h b/client/transfer.h
index 3f5e22d..f42e21f 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -22,7 +22,7 @@
  */
 
 struct obc_transfer_params {
-	guint8 *data;
+	void *data;
 	size_t size;
 };
 
@@ -59,8 +59,8 @@ gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
 								GError **err);
 guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
 
-int obc_transfer_get_params(struct obc_transfer *transfer,
-					struct obc_transfer_params *params);
+const void *obc_transfer_get_params(struct obc_transfer *transfer,
+								size_t *size);
 int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 								size_t *size);
 
-- 
1.7.7.6

