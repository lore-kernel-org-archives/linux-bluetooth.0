Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/8] shared/hfp: Fix setting result pending flag
Date: Thu, 20 Nov 2014 16:55:09 +0100
Message-Id: <1416498915-19534-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Let's set result_pending flag only when we are waiting for result from
upper layer. It will be used in following patch.
---
 src/shared/hfp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 7ad6e42..3b61759 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -505,13 +505,13 @@ static void process_input(struct hfp_gw *hfp)
 		*ptr = '\0';
 	}
 
-	hfp->result_pending = true;
-
 	if (!call_prefix_handler(hfp, str)) {
-		if (hfp->command_callback)
+		if (hfp->command_callback) {
 			hfp->command_callback(str, hfp->command_data);
-		else
+			hfp->result_pending = true;
+		} else {
 			hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+		}
 	}
 
 	len = ringbuf_drain(hfp->read_buf, count + 1);
-- 
1.8.4

