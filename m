Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 6/6] shared/hfp: Add function to get unquoted string
Date: Sat,  1 Mar 2014 21:00:46 +0100
Message-Id: <1393704046-4317-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 28 ++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 10734fc..b10316e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -308,6 +308,34 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 	return true;
 }
 
+bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
+								uint8_t len)
+{
+	const char *data = result->data;
+	int i = 0;
+	char c;
+
+	skip_whitespace(result);
+
+	c = data[result->offset];
+	if (c == '"' || c == ')' || c == '(')
+		return false;
+
+	while (data[result->offset] != '\0' && data[result->offset] != ','
+					&& data[result->offset] != ')') {
+		if (i < len)
+			buf[i++] = data[result->offset];
+		result->offset++;
+	}
+
+	if (i < len)
+		buf[i++] = '\0';
+
+	next_field(result);
+
+	return true;
+}
+
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 3313d91..649b77e 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -118,3 +118,5 @@ bool hfp_gw_result_open_container(struct hfp_gw_result *result);
 bool hfp_gw_result_close_container(struct hfp_gw_result *result);
 bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len);
+bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
+								uint8_t len);
-- 
1.8.3.1

