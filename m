Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH 3/5] network: Release session's interface from bridge when unregistering
Date: Tue, 21 Aug 2012 13:45:53 +0300
Message-Id: <1345545955-13144-4-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/server.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 1703f38..5d64ee2 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -586,6 +586,25 @@ static uint32_t register_server_record(struct network_server *ns)
 	return record->handle;
 }
 
+static void server_remove_sessions(struct network_server *ns)
+{
+	GSList *list;
+
+	for (list = ns->sessions; list; list = list->next) {
+		struct network_session *session = list->data;
+
+		if (*session->dev == '\0')
+			continue;
+
+		bnep_del_from_bridge(session->dev, ns->bridge);
+		bnep_if_down(session->dev);
+	}
+
+	g_slist_free_full(ns->sessions, session_free);
+
+	ns->sessions = NULL;
+}
+
 static void server_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct network_server *ns = user_data;
@@ -678,7 +697,8 @@ static void server_free(struct network_server *ns)
 	if (!ns)
 		return;
 
-	/* FIXME: Missing release/free all bnepX interfaces */
+	server_remove_sessions(ns);
+
 	if (ns->record_id)
 		remove_record_from_server(ns->record_id);
 
@@ -686,8 +706,6 @@ static void server_free(struct network_server *ns)
 	g_free(ns->name);
 	g_free(ns->bridge);
 
-	g_slist_free_full(ns->sessions, session_free);
-
 	g_free(ns);
 }
 
-- 
1.7.8.6

