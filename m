Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] audio/avdtp: Fix not calling callback if GET_CONFIGURATION
 is rejected
Date: Fri, 22 May 2015 19:28:00 +0900
Message-id: <1432290483-2910-4-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If GET_CONFIGURATION command is rejected and a callback exists it should
be called with the reject error, this fixes test /TP/SIG/SMG/BI-10-C.

This patch is made based on 1ce1db5002f3b7714d1788a68ca06fd1849b68a0.
---
 profiles/audio/avdtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 57f2d16..ac89370 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2949,6 +2949,15 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
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
2.1.4

