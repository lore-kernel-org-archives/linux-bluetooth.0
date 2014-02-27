Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/8] shared/hfp: Add function to get string
Date: Thu, 27 Feb 2014 10:40:05 +0100
Message-Id: <1393494006-20363-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for quoted sting and write it to given buffer.
---
 src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index abecb31..5239fcd 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -302,6 +302,39 @@ bool hfp_gw_result_close_container(struct hfp_gw_result *result)
 	return true;
 }
 
+bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
+								uint8_t len)
+{
+	int i = 0;
+	const char *data = result->data;
+
+	skip_whitespace(result);
+
+	if (data[result->offset] != '"')
+		return false;
+
+	result->offset++;
+
+	while (data[result->offset] != '\0' && data[result->offset] != '"') {
+		if (i < len)
+			buf[i++] = data[result->offset];
+		result->offset++;
+	}
+
+	if (i < len)
+		buf[i++] = '\0';
+
+	if (data[result->offset] == '"')
+		result->offset++;
+	else
+		return false;
+
+	skip_whitespace(result);
+	next_field(result);
+
+	return true;
+}
+
 static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 {
 	struct hfp_gw_result result;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 5ad214d..4a69486 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -115,3 +115,5 @@ bool hfp_gw_remove_prefix_handler(struct hfp_gw *hfp, char *prefix);
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
 bool hfp_gw_result_open_container(struct hfp_gw_result *result);
 bool hfp_gw_result_close_container(struct hfp_gw_result *result);
+bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
+								uint8_t len);
-- 
1.8.3.1

