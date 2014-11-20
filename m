Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/8] shared/hfp: Improve handling AT command
Date: Thu, 20 Nov 2014 16:55:10 +0100
Message-Id: <1416498915-19534-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If for some reason there is more than one AT command in the ring
buffer we should make sure that after upper layer sends result, AT
parser gets back to reading data from ring buffer.
---
 src/shared/hfp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 3b61759..42e4c6b 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -722,7 +722,14 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 
 	wakeup_writer(hfp);
 
-	hfp->result_pending = false;
+	/*
+	 * There might be already something to read in the ring buffer.
+	 * If so, let's read it.
+	 */
+	if (hfp->result_pending) {
+		hfp->result_pending = false;
+		can_read_data(hfp->io, hfp);
+	}
 
 	return true;
 }
-- 
1.8.4

