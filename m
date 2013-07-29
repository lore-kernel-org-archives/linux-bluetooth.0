Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] audio/AVCTP: Do not process browsing queue until connection completes
Date: Mon, 29 Jul 2013 17:04:39 +0300
Message-Id: <1375106679-14645-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Any request processed before the connection completes will likely fail
in avctp_browsing_send so instead delay the processing.
---
 profiles/audio/avctp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 2c1aa94..845027f 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1107,6 +1107,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 							gpointer data)
 {
 	struct avctp *session = data;
+	struct avctp_channel *browsing = session->browsing;
 	char address[18];
 	uint16_t imtu, omtu;
 	GError *gerr = NULL;
@@ -1131,18 +1132,25 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 
 	DBG("AVCTP Browsing: connected to %s", address);
 
-	if (session->browsing == NULL)
-		session->browsing = avctp_channel_create(session, chan,
+	if (browsing == NULL) {
+		browsing = avctp_channel_create(session, chan,
 						avctp_destroy_browsing);
+		session->browsing = browsing;
+	}
 
-	session->browsing->imtu = imtu;
-	session->browsing->omtu = omtu;
-	session->browsing->buffer = g_malloc0(MAX(imtu, omtu));
-	session->browsing->watch = g_io_add_watch(session->browsing->io,
+	browsing->imtu = imtu;
+	browsing->omtu = omtu;
+	browsing->buffer = g_malloc0(MAX(imtu, omtu));
+	browsing->watch = g_io_add_watch(session->browsing->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_browsing_cb, session);
 
 	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED);
+
+	/* Process any request that was pending the connection to complete */
+	if (browsing->process_id == 0 && !g_queue_is_empty(browsing->queue))
+		browsing->process_id = g_idle_add(process_queue, browsing);
+
 	return;
 
 fail:
@@ -1543,6 +1551,10 @@ int avctp_send_browsing_req(struct avctp *session,
 
 	g_queue_push_tail(browsing->queue, p);
 
+	/* Connection did not complete, delay process of the request */
+	if (browsing->watch == 0)
+		return 0;
+
 	if (browsing->process_id == 0)
 		browsing->process_id = g_idle_add(process_queue, browsing);
 
-- 
1.8.3.1

