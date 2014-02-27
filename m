Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/8] shared/hfp: Add open/close container function
Date: Thu, 27 Feb 2014 10:40:04 +0100
Message-Id: <1393494006-20363-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for "(" or ")" parenthesis and skip it if found.
---
 src/shared/hfp.c | 26 ++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f4cf3a4..abecb31 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -276,6 +276,32 @@ bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val)
 	return true;
 }
 
+bool hfp_gw_result_open_container(struct hfp_gw_result *result)
+{
+	skip_whitespace(result);
+
+	/* The list shall be preceded by a left parenthesis "(") */
+	if (result->data[result->offset] != '(')
+		return false;
+
+	result->offset++;
+
+	return true;
+}
+
+bool hfp_gw_result_close_container(struct hfp_gw_result *result)
+{
+	skip_whitespace(result);
+
+	/* The list shall be followed by a right parenthesis (")" V250 5.7.3.1*/
+	if (result->data[result->offset] != ')')
+		return false;
+
+	result->offset++;
+
+	return true;
+}
+
 static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 {
 	struct hfp_gw_result result;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 7642b7c..5ad214d 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -113,3 +113,5 @@ bool hfp_gw_set_prefix_handler(struct hfp_gw *hfp, hfp_result_func_t callback,
 bool hfp_gw_remove_prefix_handler(struct hfp_gw *hfp, char *prefix);
 
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
+bool hfp_gw_result_open_container(struct hfp_gw_result *result);
+bool hfp_gw_result_close_container(struct hfp_gw_result *result);
-- 
1.8.3.1

