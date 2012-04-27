Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v0 5/6] client: Remove deprecated part of session API
Date: Fri, 27 Apr 2012 12:33:39 +0200
Message-Id: <1335522820-11826-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once the modules are using the new callback style, the session API can
be simplified and the old functions to access session->p removed.
---
 client/session.c |   40 ----------------------------------------
 client/session.h |    3 ---
 2 files changed, 0 insertions(+), 43 deletions(-)

diff --git a/client/session.c b/client/session.c
index 50947d3..ea717a6 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1140,46 +1140,6 @@ const char *obc_session_get_target(struct obc_session *session)
 	return session->driver->target;
 }
 
-static struct obc_transfer *obc_session_get_transfer(
-						struct obc_session *session)
-{
-	if (session->p == NULL)
-		return NULL;
-
-	return session->p->transfer;
-}
-
-int obc_session_get_contents(struct obc_session *session, char **contents,
-								size_t *size)
-{
-	struct obc_transfer *transfer;
-
-	transfer = obc_session_get_transfer(session);
-	if (transfer == NULL) {
-		if (size != NULL)
-			*size = 0;
-
-		return -EINVAL;
-	}
-
-	return obc_transfer_get_contents(transfer, contents, size);
-}
-
-const void *obc_session_get_params(struct obc_session *session, size_t *size)
-{
-	struct obc_transfer *transfer;
-
-	transfer = obc_session_get_transfer(session);
-	if (transfer == NULL) {
-		if (size != NULL)
-			*size = 0;
-
-		return NULL;
-	}
-
-	return obc_transfer_get_params(transfer, size);
-}
-
 static void setpath_complete(struct obc_session *session, GError *err,
 							void *user_data)
 {
diff --git a/client/session.h b/client/session.h
index d97abc3..2717194 100644
--- a/client/session.h
+++ b/client/session.h
@@ -56,9 +56,6 @@ const char *obc_session_get_agent(struct obc_session *session);
 
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
-int obc_session_get_contents(struct obc_session *session, char **contents,
-								size_t *size);
-const void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 guint obc_session_send(struct obc_session *session, const char *filename,
 				const char *name, GError **err);
-- 
1.7.7.6

