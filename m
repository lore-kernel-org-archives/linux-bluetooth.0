Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/6] shared/hfp: Add get_number implementation
Date: Sat,  1 Mar 2014 21:00:43 +0100
Message-Id: <1393704046-4317-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

User can call this function with hfp_gw_result, which will
be passed to prefix handler.
---
 src/shared/hfp.c | 31 +++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 945f36e..7cc9a30 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -218,6 +218,37 @@ done:
 	return true;
 }
 
+static void next_field(struct hfp_gw_result *result)
+{
+	if (result->data[result->offset] == ',')
+		result->offset++;
+}
+
+bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val)
+{
+	int tmp = 0;
+	int i;
+
+	skip_whitespace(result);
+
+	i = result->offset;
+
+	while (result->data[i] >= '0' && result->data[i] <= '9')
+		tmp = tmp * 10 + result->data[i++] - '0';
+
+	if (i == result->offset)
+		return false;
+
+	if (val)
+		*val = tmp;
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
index 0755a46..40adcb6 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -112,3 +112,5 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 						void *user_data,
 						hfp_destroy_func_t destroy);
 bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);
+
+bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val);
-- 
1.8.3.1

