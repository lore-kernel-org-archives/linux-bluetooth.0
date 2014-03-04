Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/8] shared/hfp: Add hfp_gw_result_get_number_default function
Date: Tue,  4 Mar 2014 16:32:08 +0100
Message-Id: <1393947130-11999-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 15 +++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 44b5b55..e548672 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -224,6 +224,21 @@ static void next_field(struct hfp_gw_result *result)
 		result->offset++;
 }
 
+bool hfp_gw_result_get_number_default(struct hfp_gw_result *result,
+						unsigned int *val,
+						unsigned int default_val)
+{
+	skip_whitespace(result);
+
+	if (result->data[result->offset] == ',') {
+		if (val)
+			*val = default_val;
+		return true;
+	}
+
+	return hfp_gw_result_get_number(result, val);
+}
+
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val)
 {
 	int tmp = 0;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 4da5c97..743db65 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -114,6 +114,9 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);
 
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val);
+bool hfp_gw_result_get_number_default(struct hfp_gw_result *result,
+						unsigned int *val,
+						unsigned int default_val);
 bool hfp_gw_result_open_container(struct hfp_gw_result *result);
 bool hfp_gw_result_close_container(struct hfp_gw_result *result);
 bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
-- 
1.8.3.2

