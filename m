Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 22 Jun 2011 08:47:58 -0400
Subject: [PATCH] Finalize discovery if all stream end points are In Use
Message-ID: <1308746878.4616.1.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When handling the discover response, if all stream end points are
in use, then we must finalize discovery, as no GET_CAPABILITIES
command will be issued.
---
 audio/avdtp.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index ead956e..0650bc3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2736,6 +2736,8 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 {
 	int sep_count, i;
 	uint8_t getcap_cmd;
+	int ret = 0;
+	gboolean getcap_pending = FALSE;
 
 	if (session->version >= 0x0103 && session->server->version >= 0x0103)
 		getcap_cmd = AVDTP_GET_ALL_CAPABILITIES;
@@ -2748,7 +2750,6 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 		struct avdtp_remote_sep *sep;
 		struct avdtp_stream *stream;
 		struct seid_req req;
-		int ret;
 
 		DBG("seid %d type %d media %d in use %d",
 				resp->seps[i].seid, resp->seps[i].type,
@@ -2774,12 +2775,14 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 
 		ret = send_request(session, TRUE, NULL, getcap_cmd,
 							&req, sizeof(req));
-		if (ret < 0) {
-			finalize_discovery(session, -ret);
+		if (ret < 0)
 			break;
-		}
+		getcap_pending = TRUE;
 	}
 
+	if (!getcap_pending)
+		finalize_discovery(session, -ret);
+
 	return TRUE;
 }
 
-- 
1.7.4.1

