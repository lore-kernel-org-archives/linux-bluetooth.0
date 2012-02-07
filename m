Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/13 v2] client: introduce obc_session_copy
Date: Tue,  7 Feb 2012 16:25:45 +0200
Message-Id: <1328624752-26061-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
References: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/session.c |   30 ++++++++++++++++++++++++++++++
 client/session.h |    3 +++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 62ec4e0..1d69004 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1302,3 +1302,33 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	session->p = p;
 	return p->id;
 }
+
+guint obc_session_copy(struct obc_session *session, const char *filename,
+				const char *destname, session_callback_t func,
+				void *user_data, GError **err)
+{
+	struct pending_request *p;
+
+	if (session->obex == NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
+							strerror(-ENOTCONN));
+		return 0;
+	}
+
+	if (session->p != NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -EBUSY, strerror(-EBUSY));
+		return 0;
+	}
+
+	p = pending_request_new(session, NULL, NULL, func, user_data);
+
+	p->req_id = g_obex_copy(session->obex, filename, destname, async_cb, p,
+									err);
+	if (*err != NULL) {
+		pending_request_free(p);
+		return 0;
+	}
+
+	session->p = p;
+	return p->id;
+}
diff --git a/client/session.h b/client/session.h
index a424054..57f3fcd 100644
--- a/client/session.h
+++ b/client/session.h
@@ -80,3 +80,6 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 guint obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err);
+guint obc_session_copy(struct obc_session *session, const char *filename,
+				const char *destname, session_callback_t func,
+				void *user_data, GError **err);
-- 
1.7.7.6

