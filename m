Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/8] shared/hfp: Add function to check if reach end of command
Date: Tue,  4 Mar 2014 16:32:07 +0100
Message-Id: <1393947130-11999-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 5 +++++
 src/shared/hfp.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b10316e..44b5b55 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -336,6 +336,11 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 	return true;
 }
 
+bool hfp_gw_result_has_next(struct hfp_gw_result *result)
+{
+	return result->data[result->offset] != '\0';
+}
+
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 649b77e..4da5c97 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -120,3 +120,4 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len);
 bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len);
+bool hfp_gw_result_has_next(struct hfp_gw_result *result);
-- 
1.8.3.2

