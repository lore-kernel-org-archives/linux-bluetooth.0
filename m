Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/7] shared/hfp: Use unsigned int for offset
Date: Tue, 11 Mar 2014 00:10:32 +0100
Message-Id: <1394493034-2417-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index e481360..3256931 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -72,7 +72,7 @@ struct cmd_handler {
 
 struct hfp_gw_result {
 	const char *data;
-	int offset;
+	unsigned int offset;
 };
 
 static void destroy_cmd_handler(void *data)
@@ -245,8 +245,8 @@ bool hfp_gw_result_get_number_default(struct hfp_gw_result *result,
 
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val)
 {
+	unsigned int i;
 	int tmp = 0;
-	int i;
 
 	skip_whitespace(result);
 
-- 
1.9.0

