Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/handsfree: Relax AT+CMER handling
Date: Mon,  9 Feb 2015 11:31:36 +0100
Message-Id: <1423477896-5082-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423477896-5082-1-git-send-email-szymon.janc@tieto.com>
References: <1423477896-5082-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Spec says that HF may (not should) use AT+CMER=3,0,0,1 command to
activate indicators. Since AT+CMER has additional bfr parameter that
may be send by HF we should just skip it instead of failing.

This fix connection with Jaguar XF 2009 carkit.
---
 android/handsfree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 4020ed5..4af2a89 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1197,11 +1197,14 @@ static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		if (!hfp_context_get_number(result, &val) || val > 1)
 			break;
 
+		dev->indicators_enabled = val;
+
+		/* skip bfr if present */
+		hfp_context_get_number(result, &val);
+
 		if (hfp_context_has_next(result))
 			break;
 
-		dev->indicators_enabled = val;
-
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		if (dev->features & HFP_HF_FEAT_3WAY)
-- 
1.9.1

