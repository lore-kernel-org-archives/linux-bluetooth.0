Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] obexd: Add function to get the destination from the obc_session
Date: Mon, 10 Jun 2013 13:01:37 +0200
Message-Id: <1370862099-31046-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1370862099-31046-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1370862099-31046-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/session.c | 5 +++++
 obexd/client/session.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index f1915db..288807a 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -892,6 +892,11 @@ const char *obc_session_get_owner(struct obc_session *session)
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
index b0b3655..319d529 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -48,6 +48,7 @@ int obc_session_set_owner(struct obc_session *session, const char *name,
 			GDBusWatchFunction func);
 const char *obc_session_get_owner(struct obc_session *session);
 
+const char *obc_session_get_destination(struct obc_session *session);
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 
-- 
1.8.2.3

