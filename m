Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 02/10] shared/hfp: Rename hfp_hf_result to common hfp_context
Date: Mon,  3 Nov 2014 10:35:53 +0100
Message-Id: <1415007361-4177-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 29 ++++++++++++-----------------
 src/shared/hfp.h |  4 +---
 unit/test-hfp.c  |  4 ++--
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 565ddd3..f3f75ab 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -99,14 +99,9 @@ struct hfp_context {
 	unsigned int offset;
 };
 
-struct hfp_hf_result {
-	const char *data;
-	unsigned int offset;
-};
-
 struct cmd_response {
 	hfp_response_func_t resp_cb;
-	struct hfp_hf_result *response;
+	struct hfp_context *response;
 	char *resp_data;
 	void *user_data;
 };
@@ -903,10 +898,10 @@ static void hf_write_watch_destroy(void *user_data)
 	hfp->writer_active = false;
 }
 
-static void hf_skip_whitespace(struct hfp_hf_result *result)
+static void hf_skip_whitespace(struct hfp_context *context)
 {
-	while (result->data[result->offset] == ' ')
-		result->offset++;
+	while (context->data[context->offset] == ' ')
+		context->offset++;
 }
 
 static bool is_response(const char *prefix, enum hfp_result *result)
@@ -968,22 +963,22 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 {
 	struct event_handler *handler;
 	const char *separators = ";:\0";
-	struct hfp_hf_result result_data;
+	struct hfp_context context;
 	enum hfp_result result;
 	char lookup_prefix[18];
 	uint8_t pref_len = 0;
 	const char *prefix;
 	int i;
 
-	result_data.offset = 0;
-	result_data.data = data;
+	context.offset = 0;
+	context.data = data;
 
-	hf_skip_whitespace(&result_data);
+	hf_skip_whitespace(&context);
 
-	if (strlen(data + result_data.offset) < 2)
+	if (strlen(data + context.offset) < 2)
 		return;
 
-	prefix = data + result_data.offset;
+	prefix = data + context.offset;
 
 	pref_len = strcspn(prefix, separators);
 	if (pref_len > 17 || pref_len < 2)
@@ -993,7 +988,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 		lookup_prefix[i] = toupper(prefix[i]);
 
 	lookup_prefix[pref_len] = '\0';
-	result_data.offset += pref_len + 1;
+	context.offset += pref_len + 1;
 
 	if (is_response(lookup_prefix, &result)) {
 		struct cmd_response *cmd;
@@ -1016,7 +1011,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 	if (!handler)
 		return;
 
-	handler->callback(&result_data, handler->user_data);
+	handler->callback(&context, handler->user_data);
 }
 
 static char *find_cr_lf(char *str, size_t len)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 998525c..6bb6d35 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -128,9 +128,7 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
 						char *buf, uint8_t len);
 bool hfp_gw_result_has_next(struct hfp_context *context);
 
-struct hfp_hf_result;
-
-typedef void (*hfp_hf_result_func_t)(struct hfp_hf_result *result,
+typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
 							void *user_data);
 
 typedef void (*hfp_response_func_t)(enum hfp_result result, void *user_data);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 6e58204..f6bbe2b 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -469,7 +469,7 @@ static void test_hf_init(gconstpointer data)
 
 static bool unsolicited_resp = false;
 
-static void hf_unsolicited_resp_cb(struct hfp_hf_result *result,
+static void hf_unsolicited_resp_cb(struct hfp_context *context,
 							void *user_data) {
 	unsolicited_resp = true;
 }
@@ -526,7 +526,7 @@ static void test_hf_send_command(gconstpointer data)
 	execute_context(context);
 }
 
-static void hf_result_handler(struct hfp_hf_result *result,
+static void hf_result_handler(struct hfp_context *result,
 							void *user_data)
 {
 	struct context *context = user_data;
-- 
1.8.4

