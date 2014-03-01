Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 4/6] shared/hfp: Add open/close container function
Date: Sat,  1 Mar 2014 21:00:44 +0100
Message-Id: <1393704046-4317-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for "(" or ")" parenthesis and skip it if found.
---
 src/shared/hfp.c | 26 ++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 7cc9a30..d7cca32 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -249,6 +249,32 @@ bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val)
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
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 40adcb6..00905de 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -114,3 +114,5 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);
 
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val);
+bool hfp_gw_result_open_container(struct hfp_gw_result *result);
+bool hfp_gw_result_close_container(struct hfp_gw_result *result);
-- 
1.8.3.1

