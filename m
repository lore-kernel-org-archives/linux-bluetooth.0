Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Gopal Tiwari <gtiwari@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: dzickus@redhat.com, gtiwari@redhat.com
Subject: [PATCH BlueZ 1/2] Fixing possible use_after_free.
Date: Fri, 20 Jul 2018 10:03:58 +0530
Message-Id: <1532061239-22481-1-git-send-email-gtiwari@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the code review of code. Found some of the possible
double free scenario's. So fixing them.
---
 gobex/gobex-transfer.c | 6 ++++++
 obexd/client/session.c | 6 +++++-
 tools/mesh/prov-db.c   | 4 +++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index bc99306..11980d0 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -428,6 +428,12 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 	va_start(args, first_hdr_id);
 	transfer_put_req_first(transfer, req, first_hdr_id, args);
 	va_end(args);
+
+	/* Checking transfer in case transfer_put_req_first has
+	 * freed it to avoid double free */
+	if(!transfer)
+		return 0;
+
 	if (!g_slist_find(transfers, transfer))
 		return 0;
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 5bd2d26..077224b 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -938,7 +938,11 @@ static void session_terminate_transfer(struct obc_session *session,
 	if (session->p == NULL)
 		session_process_queue(session);
 
-	obc_session_unref(session);
+	/* Verifying the session variable for double free
+	 */
+
+	if (session)
+		obc_session_unref(session);
 }
 
 static void session_notify_complete(struct obc_session *session,
diff --git a/tools/mesh/prov-db.c b/tools/mesh/prov-db.c
index 05b2547..74915d2 100644
--- a/tools/mesh/prov-db.c
+++ b/tools/mesh/prov-db.c
@@ -876,8 +876,10 @@ bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov)
 
 	res = true;
 done:
+	/* Varify in_str for double free */
 
-	g_free(in_str);
+	if(in_str)
+		g_free(in_str);
 
 	if(jmain)
 		json_object_put(jmain);
-- 
2.7.5

