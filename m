Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] android/avctp: Fix reference counting
Date: Fri, 27 Mar 2015 23:48:55 +0100
Message-Id: <1427496535-17777-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Drop extra reference before exiting function.
---
V2: get ref before loop and drop after

 android/avctp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index d1d2f95..6d7d8cf 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -775,6 +775,8 @@ static void control_response(struct avctp_channel *control,
 								control);
 	}
 
+	avctp_ref(control->session);
+
 	for (l = control->processed; l; l = l->next) {
 		p = l->data;
 		req = p->data;
@@ -788,15 +790,15 @@ static void control_response(struct avctp_channel *control,
 						avc->subunit_type,
 						operands, operand_count,
 						req->user_data))
-			return;
+			break;
 
 		control->processed = g_slist_remove(control->processed, p);
 		pending_destroy(p, NULL);
 
-		avctp_unref(control->session);
-
-		return;
+		break;
 	}
+
+	avctp_unref(control->session);
 }
 
 static void browsing_response(struct avctp_channel *browsing,
@@ -823,6 +825,8 @@ static void browsing_response(struct avctp_channel *browsing,
 								browsing);
 	}
 
+	avctp_ref(browsing->session);
+
 	for (l = browsing->processed; l; l = l->next) {
 		p = l->data;
 		req = p->data;
@@ -830,17 +834,17 @@ static void browsing_response(struct avctp_channel *browsing,
 		if (p->transaction != avctp->transaction)
 			continue;
 
-		avctp_ref(browsing->session);
-
 		if (req->func && req->func(browsing->session, operands,
 						operand_count, req->user_data))
-			return;
+			break;
 
 		browsing->processed = g_slist_remove(browsing->processed, p);
 		pending_destroy(p, NULL);
 
-		return;
+		break;
 	}
+
+	avctp_unref(browsing->session);
 }
 
 static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
-- 
1.9.3

