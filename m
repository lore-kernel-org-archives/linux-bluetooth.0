Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/20] android/handsfree: Fix checking AT+COPS parameters
Date: Sat,  8 Mar 2014 01:19:57 +0100
Message-Id: <1394238004-15691-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e88b06a..8a5a6cf 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -239,7 +239,7 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (!hfp_gw_result_get_number(result, &val) || val != 3)
 			break;
 
-		if (!hfp_gw_result_get_number(result, &val) || val != 1)
+		if (!hfp_gw_result_get_number(result, &val) || val != 0)
 			break;
 
 		if (hfp_gw_result_has_next(result))
-- 
1.8.5.3

