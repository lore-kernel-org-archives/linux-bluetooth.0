Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/8] shared/hfp: Rename hfp_hf_result to common hfp_context
Date: Fri, 10 Oct 2014 01:50:46 +0200
Message-Id: <1412898652-12281-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 29 ++++++++++++-----------------
 src/shared/hfp.h |  3 +--
 unit/test-hfp.c  |  4 ++--
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 1b15da6..8170a16 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -99,15 +99,10 @@ struct hfp_context {
 	unsigned int offset;
 };
 
-struct hfp_hf_result {
-	const char *data;
-	unsigned int offset;
-};
-
 struct cmd_response {
 	char *prefix;
 	hfp_response_func_t resp_cb;
-	struct hfp_hf_result *response;
+	struct hfp_context *response;
 	char *resp_data;
 	void *user_data;
 };
@@ -902,10 +897,10 @@ static void hf_write_watch_destroy(void *user_data)
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
@@ -975,22 +970,22 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
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
@@ -1000,7 +995,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 		lookup_prefix[i] = toupper(prefix[i]);
 
 	lookup_prefix[pref_len] = '\0';
-	result_data.offset += pref_len + 1;
+	context.offset += pref_len + 1;
 
 	if (is_response(lookup_prefix, &result)) {
 		struct cmd_response *cmd;
@@ -1023,7 +1018,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 	if (!handler)
 		return;
 
-	handler->callback(&result_data, handler->user_data);
+	handler->callback(&context, handler->user_data);
 }
 
 static char *find_cr_lf(char *str, size_t len)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index e57306a..02df713 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -70,12 +70,11 @@ enum hfp_gw_cmd_type {
 };
 
 struct hfp_context;
-struct hfp_hf_result;
 
 typedef void (*hfp_result_func_t)(struct hfp_context *context,
 				enum hfp_gw_cmd_type type, void *user_data);
 
-typedef void (*hfp_hf_result_func_t)(struct hfp_hf_result *result,
+typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
 							void *user_data);
 
 typedef void (*hfp_destroy_func_t)(void *user_data);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index da8a5c9..7dd3b33 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -470,7 +470,7 @@ static void test_hf_init(gconstpointer data)
 
 static bool unsolicited_resp = false;
 
-static void hf_unsolicited_resp_cb(struct hfp_hf_result *result,
+static void hf_unsolicited_resp_cb(struct hfp_context *context,
 							void *user_data) {
 	unsolicited_resp = true;
 }
@@ -530,7 +530,7 @@ static void test_hf_send_command(gconstpointer data)
 	execute_context(context);
 }
 
-static void hf_result_handler(struct hfp_hf_result *result,
+static void hf_result_handler(struct hfp_context *result,
 							void *user_data)
 {
 	struct context *context = user_data;
-- 
1.8.4

