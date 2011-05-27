Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix possible buffer overflow when sending avdtp commands
Date: Fri, 27 May 2011 11:37:24 +0300
Message-Id: <1306485444-2110-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Buffer size should be as big as the maximum of imtu and omtu, otherwise
it may overflow when sending messages which are bigger then imtu.
---
 audio/avdtp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 056b455..5659f38 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -61,6 +61,10 @@
 
 #define MAX_SEID 0x3E
 
+#ifndef MAX
+# define MAX(x, y) ((x) > (y) ? (x) : (y))
+#endif
+
 #define AVDTP_DISCOVER				0x01
 #define AVDTP_GET_CAPABILITIES			0x02
 #define AVDTP_SET_CONFIGURATION			0x03
@@ -2408,7 +2412,7 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
 		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
 
-		session->buf = g_malloc0(session->imtu);
+		session->buf = g_malloc0(MAX(session->imtu, session->omtu));
 		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTED);
 
 		if (session->io_id)
-- 
1.7.5.2

