Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/avctp: Fix reference counting
Date: Fri, 27 Mar 2015 23:31:27 +0100
Message-Id: <1427495487-16757-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Drop extra reference before exiting function.
---
 android/avctp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index d1d2f95..c92bb54 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -787,8 +787,10 @@ static void control_response(struct avctp_channel *control,
 		if (req->func && req->func(control->session, avc->code,
 						avc->subunit_type,
 						operands, operand_count,
-						req->user_data))
+						req->user_data)) {
+			avctp_unref(control->session);
 			return;
+		}
 
 		control->processed = g_slist_remove(control->processed, p);
 		pending_destroy(p, NULL);
@@ -833,12 +835,17 @@ static void browsing_response(struct avctp_channel *browsing,
 		avctp_ref(browsing->session);
 
 		if (req->func && req->func(browsing->session, operands,
-						operand_count, req->user_data))
+							operand_count,
+							req->user_data)) {
+			avctp_unref(browsing->session);
 			return;
+		}
 
 		browsing->processed = g_slist_remove(browsing->processed, p);
 		pending_destroy(p, NULL);
 
+		avctp_unref(browsing->session);
+
 		return;
 	}
 }
-- 
1.9.3

