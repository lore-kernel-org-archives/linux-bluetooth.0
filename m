Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6]  audio/avdtp: Fix not calling callback if GET_CAPABILITIES
 is rejected
Date: Fri, 22 May 2015 19:27:59 +0900
Message-id: <1432290483-2910-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If GET_CAPABILITIES command is rejected and a callback exists it should
be called with the reject error, this fixes test /TP/SIG/SMG/BI-04-C.

This patch is made based on cb5058cf26e4ad6fd857fd480675cd6fcd4b7985.
---
 profiles/audio/avdtp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 14f9a61..57f2d16 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2915,10 +2915,15 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 
 	switch (signal_id) {
 	case AVDTP_DISCOVER:
+	case AVDTP_GET_CAPABILITIES:
+	case AVDTP_GET_ALL_CAPABILITIES:
 		if (!seid_rej_to_err(buf, size, &err))
 			return FALSE;
-		error("DISCOVER request rejected: %s (%d)",
-				avdtp_strerror(&err), err.err.error_code);
+		error("%s request rejected: %s (%d)",
+			signal_id == AVDTP_DISCOVER ? "DISCOVER" :
+			signal_id == AVDTP_GET_CAPABILITIES ?
+			"GET_CAPABILITIES" : "GET_ALL_CAPABILITIES",
+			avdtp_strerror(&err), err.err.error_code);
 		if (session->discover) {
 			session->discover->cb(session, session->seps, &err,
 						session->discover->user_data);
@@ -2926,13 +2931,6 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			session->discover = NULL;
 		}
 		return TRUE;
-	case AVDTP_GET_CAPABILITIES:
-	case AVDTP_GET_ALL_CAPABILITIES:
-		if (!seid_rej_to_err(buf, size, &err))
-			return FALSE;
-		error("GET_CAPABILITIES request rejected: %s (%d)",
-				avdtp_strerror(&err), err.err.error_code);
-		return TRUE;
 	case AVDTP_OPEN:
 		if (!seid_rej_to_err(buf, size, &err))
 			return FALSE;
-- 
2.1.4

