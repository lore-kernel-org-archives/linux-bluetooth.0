Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	claudio.takahasi@openbossa.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix release all sessions on powering adapter off
Date: Wed, 19 Oct 2011 11:19:58 +0300
Message-Id: <1319012398-13859-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adapter is powered off, all sessions should be released without
changing mode, which is contrary to what session_remove does. This
prevents from such situation when powering off leads to new mode
derived from mode_sessions.

Currently, if there are multiple mode sessions requested by different
clients, powering adapter off results in powering immediately it on.
---
 src/adapter.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d1ef17c..6d982a0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2313,19 +2313,9 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	DBG("");
 
-	/*
-	 * g_slist_free is not called after g_slist_foreach because the list is
-	 * updated using g_slist_remove in session_remove.
-	 */
 	if (adapter->mode == MODE_OFF) {
-		GSList *l;
-
-		for (l = adapter->mode_sessions; l;) {
-			struct session_req *req = l->data;
-			l = g_slist_next(l);
-			session_remove(req);
-			session_free(req);
-		}
+		g_slist_free_full(adapter->mode_sessions, session_free);
+		adapter->mode_sessions = NULL;
 	}
 
 	if (adapter->pending_mode == NULL)
-- 
1.7.4.1

