Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/5] glib-helper: fix coding style issues
Date: Fri,  3 Dec 2010 11:28:51 -0300
Message-Id: <1291386532-4985-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/glib-helper.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index e71841b..2db307e 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -115,7 +115,7 @@ static sdp_session_t *get_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
 }
 
 static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
-				sdp_session_t *session)
+						sdp_session_t *session)
 {
 	struct cached_sdp_session *cached;
 
@@ -210,8 +210,8 @@ done:
 	search_context_cleanup(ctxt);
 }
 
-static gboolean search_process_cb(GIOChannel *chan,
-			GIOCondition cond, void *user_data)
+static gboolean search_process_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
 {
 	struct search_context *ctxt = user_data;
 	int err = 0;
@@ -240,7 +240,8 @@ failed:
 	return FALSE;
 }
 
-static gboolean connect_watch(GIOChannel *chan, GIOCondition cond, gpointer user_data)
+static gboolean connect_watch(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
 {
 	struct search_context *ctxt = user_data;
 	sdp_list_t *search, *attrids;
@@ -297,8 +298,7 @@ failed:
 }
 
 static int create_search_context(struct search_context **ctxt,
-				const bdaddr_t *src, const bdaddr_t *dst,
-				uuid_t *uuid)
+			const bdaddr_t *src, const bdaddr_t *dst, uuid_t *uuid)
 {
 	sdp_session_t *s;
 	GIOChannel *chan;
@@ -363,7 +363,7 @@ int bt_discover_services(const bdaddr_t *src, const bdaddr_t *dst,
 	return bt_search_service(src, dst, &uuid, cb, user_data, destroy);
 }
 
-static int find_by_bdaddr(const void *data, const void *user_data)
+static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 {
 	const struct search_context *ctxt = data, *search = user_data;
 
-- 
1.7.3.2

