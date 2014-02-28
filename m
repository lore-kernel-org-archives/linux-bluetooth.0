Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/6] shared/hfp: Add function to get string
Date: Fri, 28 Feb 2014 21:33:55 +0100
Message-Id: <1393619636-23762-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for quoted sting and write it to given buffer.
---
 src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 807ddf2..4d3bdc9 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -277,6 +277,39 @@ bool hfp_gw_result_close_container(struct hfp_gw_result *result)
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
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index dcde28f..96c6ef9 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -117,3 +117,5 @@ bool hfp_gw_unregister_prefix_handler(struct hfp_gw *hfp, const char *prefix);
 bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
 bool hfp_gw_result_open_container(struct hfp_gw_result *result);
 bool hfp_gw_result_close_container(struct hfp_gw_result *result);
+bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
+								uint8_t len);
-- 
1.8.3.1

