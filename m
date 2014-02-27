Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/8] shared/hfp: Add get_number implementation
Date: Thu, 27 Feb 2014 10:40:03 +0100
Message-Id: <1393494006-20363-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

User can call this function with hfp_gw_result, which will
be passed to prefix handler.
---
 src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 6a39a36..f4cf3a4 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -237,12 +237,45 @@ static bool process_extended(struct hfp_gw *hfp, struct hfp_gw_result *result)
 	return true;
 }
 
+static void next_field(struct hfp_gw_result *result)
+{
+	if (result->data[result->offset] == ',')
+		result->offset++;
+}
+
 static void skip_whitespace(struct hfp_gw_result *result)
 {
 	while (result->data[result->offset] == ' ')
 		result->offset++;
 }
 
+bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val)
+{
+	int temp = 0;
+	int i;
+
+	skip_whitespace(result);
+
+	i = result->offset;
+
+	while (result->data[i] >= '0' && result->data[i] <= '9') {
+		temp *= 10;
+		temp += result->data[i++] - '0';
+	}
+
+	if (i == result->offset)
+		return false;
+
+	if (val)
+		*val = temp;
+	result->offset = i;
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
index 306824d..7642b7c 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -111,3 +111,5 @@ bool hfp_gw_set_prefix_handler(struct hfp_gw *hfp, hfp_result_func_t callback,
 						char *prefix, void *user_data,
 						hfp_destroy_func_t destroy);
 bool hfp_gw_remove_prefix_handler(struct hfp_gw *hfp, char *prefix);
+
+bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
-- 
1.8.3.1

