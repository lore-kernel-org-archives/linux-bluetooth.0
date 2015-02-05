Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] shared/hfp: Fix calling io read function directly
Date: Thu,  5 Feb 2015 16:07:10 +0100
Message-Id: <1423148831-25507-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423148831-25507-1-git-send-email-szymon.janc@tieto.com>
References: <1423148831-25507-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

can_read_data function should by called only from IO read callback.
can_read_data feeds ringbuffer but don't call process_input() if
there is pending result. So it is enought to just call process_input
cause any pending data are already present in ring_buffer.

This fix blocking read in unit/test-hfp exposed by previous patch.
---
 src/shared/hfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index ea6494d..90e17c7 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -762,7 +762,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 	 */
 	if (hfp->result_pending) {
 		hfp->result_pending = false;
-		can_read_data(hfp->io, hfp);
+		process_input(hfp);
 	}
 
 	return true;
-- 
1.9.1

