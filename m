Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/13] client: introduce obc_session_cancel
Date: Mon, 30 Jan 2012 07:30:32 -0800
Message-Id: <1327937436-15480-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327937436-15480-1-git-send-email-luiz.dentz@gmail.com>
References: <1327937436-15480-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/session.c |   21 +++++++++++++++++++++
 client/session.h |    2 ++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 44d86f2..f2be457 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1399,3 +1399,24 @@ guint obc_session_delete(struct obc_session *session, const char *file,
 	session->p = p;
 	return p->id;
 }
+
+void obc_session_cancel(struct obc_session *session, guint id,
+							gboolean remove)
+{
+	struct pending_request *p = session->p;
+
+	if (p == NULL || p->id != id)
+		return;
+
+	if (p->req_id == 0)
+		return;
+
+	g_obex_cancel_req(session->obex, p->req_id, remove);
+	if (!remove)
+		return;
+
+	pending_request_free(p);
+	session->p = NULL;
+
+	session_process_queue(session);
+}
diff --git a/client/session.h b/client/session.h
index ac5c27a..008b466 100644
--- a/client/session.h
+++ b/client/session.h
@@ -89,3 +89,5 @@ guint obc_session_move(struct obc_session *session, const char *filename,
 guint obc_session_delete(struct obc_session *session, const char *file,
 				session_callback_t func, void *user_data,
 				GError **err);
+void obc_session_cancel(struct obc_session *session, guint id,
+							gboolean remove);
-- 
1.7.7.6

