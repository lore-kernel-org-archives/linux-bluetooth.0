Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] shared/hfp: Fix not processing input from hfp_gw_send_error
Date: Thu,  5 Feb 2015 16:07:11 +0100
Message-Id: <1423148831-25507-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423148831-25507-1-git-send-email-szymon.janc@tieto.com>
References: <1423148831-25507-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If for some reason there is more than one AT command in the ring
buffer we should make sure that after upper layer sends error, AT
parser gets back to reading data from ring buffer.

Same is already done in hfp_gw_send_result() and we should handle
this in error response as well.
---
 src/shared/hfp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 90e17c7..74ee979 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -778,7 +778,14 @@ bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
 
 	wakeup_writer(hfp);
 
-	hfp->result_pending = false;
+	/*
+	 * There might be already something to read in the ring buffer.
+	 * If so, let's read it.
+	 */
+	if (hfp->result_pending) {
+		hfp->result_pending = false;
+		process_input(hfp);
+	}
 
 	return true;
 }
-- 
1.9.1

