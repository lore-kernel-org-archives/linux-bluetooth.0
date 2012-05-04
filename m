Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 5/6] client: Flip parameter order in transfer API
Date: Fri,  4 May 2012 14:39:37 +0200
Message-Id: <1336135178-21707-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This minor change makes the transfer API more consistent with the
parameter-order used in the session API.
---
 client/session.c  |    4 ++--
 client/transfer.c |    8 ++++----
 client/transfer.h |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/client/session.c b/client/session.c
index 8523a86..f8f8da4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -970,7 +970,7 @@ guint obc_session_get(struct obc_session *session, const char *type,
 		return 0;
 	}
 
-	transfer = obc_transfer_get(targetfile, name, type, apparam,
+	transfer = obc_transfer_get(type, name, targetfile, apparam,
 							apparam_size, err);
 	if (transfer == NULL)
 		return 0;
@@ -989,7 +989,7 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 		return 0;
 	}
 
-	transfer = obc_transfer_put(filename, name, NULL, NULL, 0, NULL, 0,
+	transfer = obc_transfer_put(NULL, name, filename, NULL, 0, NULL, 0,
 									err);
 	if (transfer == NULL)
 		return 0;
diff --git a/client/transfer.c b/client/transfer.c
index 7bf687c..ecf3232 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -319,9 +319,9 @@ done:
 	return TRUE;
 }
 
-struct obc_transfer *obc_transfer_get(const char *filename,
+struct obc_transfer *obc_transfer_get(const char *type,
 					const char *name,
-					const char *type,
+					const char *filename,
 					const void *params, size_t psize,
 					GError **err)
 {
@@ -340,9 +340,9 @@ struct obc_transfer *obc_transfer_get(const char *filename,
 	return transfer;
 }
 
-struct obc_transfer *obc_transfer_put(const char *filename,
+struct obc_transfer *obc_transfer_put(const char *type,
 					const char *name,
-					const char *type,
+					const char *filename,
 					const void *contents, size_t csize,
 					const void *params, size_t psize,
 					GError **err)
diff --git a/client/transfer.h b/client/transfer.h
index aebba7f..94bb800 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -27,14 +27,14 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					gint64 transferred, GError *err,
 					void *user_data);
 
-struct obc_transfer *obc_transfer_get(const char *filename,
+struct obc_transfer *obc_transfer_get(const char *type,
 					const char *name,
-					const char *type,
+					const char *filename,
 					const void *params, size_t psize,
 					GError **err);
-struct obc_transfer *obc_transfer_put(const char *filename,
+struct obc_transfer *obc_transfer_put(const char *type,
 					const char *name,
-					const char *type,
+					const char *filename,
 					const void *contents, size_t csize,
 					const void *params, size_t psize,
 					GError **err);
-- 
1.7.7.6

