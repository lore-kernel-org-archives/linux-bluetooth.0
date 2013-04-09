Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] obexd: Add function to get the destination from the obc_session
Date: Tue,  9 Apr 2013 13:55:23 +0200
Message-Id: <1365508525-13251-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/session.c | 5 +++++
 obexd/client/session.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 3cf3864..b286a34 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -845,6 +845,11 @@ const char *obc_session_get_owner(struct obc_session *session)
 	return session->owner;
 }
 
+const char *obc_session_get_destination(struct obc_session *session)
+{
+	return session->destination;
+}
+
 const char *obc_session_get_path(struct obc_session *session)
 {
 	return session->path;
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 8a3d629..2475fe4 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -48,6 +48,7 @@ int obc_session_set_owner(struct obc_session *session, const char *name,
 			GDBusWatchFunction func);
 const char *obc_session_get_owner(struct obc_session *session);
 
+const char *obc_session_get_destination(struct obc_session *session);
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 
-- 
1.8.2.1

