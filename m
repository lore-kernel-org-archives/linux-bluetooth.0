Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] obexd: Add obc_session_get_service_record to session
Date: Tue,  9 Apr 2013 13:54:04 +0200
Message-Id: <1365508448-13171-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a obc_session_get_service_record function to the client session.
The function allows querying the session specific service record.
---
 obexd/client/session.c | 9 +++++++++
 obexd/client/session.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 2e8b113..7f4a192 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -827,6 +827,15 @@ fail:
 	return NULL;
 }
 
+const void *obc_session_get_service_record(struct obc_session *session)
+{
+	if (session && session->id > 0 && session->transport &&
+			session->transport->get_service_record)
+		return session->transport->get_service_record(session->id);
+
+	return NULL;
+}
+
 const char *obc_session_get_owner(struct obc_session *session)
 {
 	if (session == NULL)
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 402c042..8a3d629 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -54,6 +54,8 @@ const char *obc_session_get_target(struct obc_session *session);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 
+const void *obc_session_get_service_record(struct obc_session *session);
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-- 
1.8.2.1

