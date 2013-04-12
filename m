Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] obexd: Add obc_session_get_attribute to session
Date: Fri, 12 Apr 2013 11:29:04 +0200
Message-Id: <1365758946-8682-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a obc_session_get_attribute function to the client session.
The function allows querying the session specific service attributes.
---
 obexd/client/session.c | 11 +++++++++++
 obexd/client/session.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 2e8b113..63707f1 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -827,6 +827,17 @@ fail:
 	return NULL;
 }
 
+const void *obc_session_get_attribute(struct obc_session *session,
+							int attribute_id)
+{
+	if (session && session->id > 0 && session->transport &&
+			session->transport->getattribute)
+		return session->transport->getattribute(session->id,
+								attribute_id);
+
+	return NULL;
+}
+
 const char *obc_session_get_owner(struct obc_session *session)
 {
 	if (session == NULL)
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 402c042..b0b3655 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -54,6 +54,9 @@ const char *obc_session_get_target(struct obc_session *session);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 
+const void *obc_session_get_attribute(struct obc_session *session,
+							int attribute_id);
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-- 
1.8.2.1

