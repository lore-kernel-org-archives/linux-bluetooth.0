Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 16/20] audio/avdtp: Add handling missing cases in avdtp_parse_rej
Date: Fri, 27 Feb 2015 17:03:04 +0200
Message-Id: <1425049388-18333-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch adds handling some missing cases in avdtp_parse_rej().
---
 profiles/audio/avdtp.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index aa1fec5..64e09fd 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3116,8 +3116,17 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 	case AVDTP_GET_ALL_CAPABILITIES:
 		if (!seid_rej_to_err(buf, size, &err))
 			return FALSE;
-		error("GET_CAPABILITIES request rejected: %s (%d)",
-				avdtp_strerror(&err), err.err.error_code);
+		error("%s request rejected: %s (%d)",
+			signal_id == AVDTP_DISCOVER ? "DISCOVER" :
+			signal_id == AVDTP_GET_CAPABILITIES ?
+			"GET_CAPABILITIES" : "GET_ALL_CAPABILITIES",
+			avdtp_strerror(&err), err.err.error_code);
+		if (session->discover) {
+			session->discover->cb(session, session->seps, &err,
+						session->discover->user_data);
+			g_free(session->discover);
+			session->discover = NULL;
+		}
 		return TRUE;
 	case AVDTP_OPEN:
 		if (!seid_rej_to_err(buf, size, &err))
@@ -3137,6 +3146,15 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			sep->cfm->set_configuration(session, sep, stream,
 							&err, sep->user_data);
 		return TRUE;
+	case AVDTP_GET_CONFIGURATION:
+		if (!seid_rej_to_err(buf, size, &err))
+			return FALSE;
+		error("GET_CONFIGURATION request rejected: %s (%d)",
+				avdtp_strerror(&err), err.err.error_code);
+		if (sep && sep->cfm && sep->cfm->get_configuration)
+			sep->cfm->get_configuration(session, sep, stream, &err,
+								sep->user_data);
+		return TRUE;
 	case AVDTP_RECONFIGURE:
 		if (!conf_rej_to_err(buf, size, &err))
 			return FALSE;
-- 
2.1.0

