Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/6] shared/hfp: Add get_number implementation
Date: Fri, 28 Feb 2014 10:22:35 +0100
Message-Id: <1393579358-11514-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393579358-11514-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393579358-11514-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

User can call this function with hfp_gw_result, which will
be passed to prefix handler.
---
 src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index e4cb011..b5a0e44 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -218,6 +218,39 @@ done:
 	return true;
 }
 
+static void next_field(struct hfp_gw_result *result)
+{
+	if (result->data[result->offset] == ',')
+		result->offset++;
+}
+
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
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 4dc293f..2e1a8a2 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -112,3 +112,5 @@ bool hfp_gw_register_prefix_handler(struct hfp_gw *hfp,
 						char *prefix, void *user_data,
 						hfp_destroy_func_t destroy);
 bool hfp_gw_unregister_prefix_handler(struct hfp_gw *hfp, char *prefix);
+
+bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val);
-- 
1.8.5.3

