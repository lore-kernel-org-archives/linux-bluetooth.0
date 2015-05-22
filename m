Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] audio/avdtp: Fix not calling callback if DISCOVER is
 rejected
Date: Fri, 22 May 2015 19:27:58 +0900
Message-id: <1432290483-2910-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If DISCOVER command is rejected and a callback exists it should be
called with the reject error, this fixes test /TP/SIG/SMG/BI-01-C

This patches is made based on
262e11982bfb94d0da66a862facf6e71330ef23fjk.
---
 profiles/audio/avdtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f38188f..14f9a61 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2919,6 +2919,12 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			return FALSE;
 		error("DISCOVER request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
+		if (session->discover) {
+			session->discover->cb(session, session->seps, &err,
+						session->discover->user_data);
+			g_free(session->discover);
+			session->discover = NULL;
+		}
 		return TRUE;
 	case AVDTP_GET_CAPABILITIES:
 	case AVDTP_GET_ALL_CAPABILITIES:
-- 
2.1.4

