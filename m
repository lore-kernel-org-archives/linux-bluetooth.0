Return-Path: <cyrus@holtmann.org>
From: Mike Brudevold <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Brudevold <michael.brudevold@logicpd.com>
Subject: [PATCH] audio: Fix AVDTP General Reject message
Date: Fri, 27 Apr 2012 12:22:21 -0500
Message-Id: <1335547341-19459-1-git-send-email-puffy.taco@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michael Brudevold <michael.brudevold@logicpd.com>

As per spec, bits other than Transaction Label and Packet Type are RFA. This
fixes the RFA bits which were previously set to the invalid signal_id.

Test case TP/SIG/SMG/BI-28-C.
---
 audio/avdtp.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 34d49d2..6dd19ba 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1348,11 +1348,10 @@ static GSList *caps_to_list(uint8_t *data, int size,
 	return caps;
 }
 
-static gboolean avdtp_unknown_cmd(struct avdtp *session, uint8_t transaction,
-							uint8_t signal_id)
+static gboolean avdtp_unknown_cmd(struct avdtp *session, uint8_t transaction)
 {
 	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_GEN_REJECT,
-							signal_id, NULL, 0);
+							0, NULL, 0);
 }
 
 static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
@@ -1412,7 +1411,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 	}
 
 	if (get_all && session->server->version < 0x0103)
-		return avdtp_unknown_cmd(session, transaction, cmd);
+		return avdtp_unknown_cmd(session, transaction);
 
 	if (!sep->ind->get_capability(session, sep, get_all, &caps,
 							&err, sep->user_data))
@@ -1894,7 +1893,7 @@ failed:
 static gboolean avdtp_secctl_cmd(struct avdtp *session, uint8_t transaction,
 					struct seid_req *req, int size)
 {
-	return avdtp_unknown_cmd(session, transaction, AVDTP_SECURITY_CONTROL);
+	return avdtp_unknown_cmd(session, transaction);
 }
 
 static gboolean avdtp_delayreport_cmd(struct avdtp *session,
@@ -1988,7 +1987,7 @@ static gboolean avdtp_parse_cmd(struct avdtp *session, uint8_t transaction,
 		return avdtp_delayreport_cmd(session, transaction, buf, size);
 	default:
 		DBG("Received unknown request id %u", signal_id);
-		return avdtp_unknown_cmd(session, transaction, signal_id);
+		return avdtp_unknown_cmd(session, transaction);
 	}
 }
 
-- 
1.7.5.4

