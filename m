Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/6] shared/hfp: Add open/close container function
Date: Fri, 28 Feb 2014 21:33:54 +0100
Message-Id: <1393619636-23762-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for "(" or ")" parenthesis and skip it if found.
---
 src/shared/hfp.c | 26 ++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index d168ac4..807ddf2 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -251,6 +251,32 @@ bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val)
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
index 37d5c9b..dcde28f 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -115,3 +115,5 @@ bool hfp_gw_register_prefix_handler(struct hfp_gw *hfp,
 bool hfp_gw_unregister_prefix_handler(struct hfp_gw *hfp, const char *prefix);
 
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
+bool hfp_gw_result_open_container(struct hfp_gw_result *result);
+bool hfp_gw_result_close_container(struct hfp_gw_result *result);
-- 
1.8.3.1

