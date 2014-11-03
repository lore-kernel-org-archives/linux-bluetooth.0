Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 04/10] shared/hfp: Add handling +CME ERROR to parser
Date: Mon,  3 Nov 2014 10:35:55 +0100
Message-Id: <1415007361-4177-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 34 +++++++++++++++++++++++++++++++---
 src/shared/hfp.h |  5 ++++-
 unit/test-hfp.c  |  4 +++-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 037f63d..e047574 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -904,40 +904,67 @@ static void hf_skip_whitespace(struct hfp_context *context)
 		context->offset++;
 }
 
-static bool is_response(const char *prefix, enum hfp_result *result)
+static bool is_response(const char *prefix, enum hfp_result *result,
+						enum hfp_error *cme_err,
+						struct hfp_context *context)
 {
 	if (strcmp(prefix, "OK") == 0) {
 		*result = HFP_RESULT_OK;
+		/*
+		 * Set cme_err to 0 as this is not valid when result is not
+		 * CME ERROR
+		 */
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "ERROR") == 0) {
 		*result = HFP_RESULT_ERROR;
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "NO CARRIER") == 0) {
 		*result = HFP_RESULT_NO_CARRIER;
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "NO ANSWER") == 0) {
 		*result = HFP_RESULT_NO_ANSWER;
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "BUSY") == 0) {
 		*result = HFP_RESULT_BUSY;
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "DELAYED") == 0) {
 		*result = HFP_RESULT_DELAYED;
+		*cme_err = 0;
 		return true;
 	}
 
 	if (strcmp(prefix, "BLACKLISTED") == 0) {
 		*result = HFP_RESULT_BLACKLISTED;
+		*cme_err = 0;
+		return true;
+	}
+
+	if (strcmp(prefix, "+CME ERROR") == 0) {
+		uint32_t val;
+
+		*result = HFP_RESULT_CME_ERROR;
+
+		if (hfp_context_get_number(context, &val) &&
+					val <= HFP_ERROR_NETWORK_NOT_ALLOWED)
+			*cme_err = val;
+		else
+			*cme_err = HFP_ERROR_AG_FAILURE;
+
 		return true;
 	}
 
@@ -965,6 +992,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 	const char *separators = ";:\0";
 	struct hfp_context context;
 	enum hfp_result result;
+	enum hfp_error cme_err;
 	char lookup_prefix[18];
 	uint8_t pref_len = 0;
 	const char *prefix;
@@ -990,14 +1018,14 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 	lookup_prefix[pref_len] = '\0';
 	context.offset += pref_len + 1;
 
-	if (is_response(lookup_prefix, &result)) {
+	if (is_response(lookup_prefix, &result, &cme_err, &context)) {
 		struct cmd_response *cmd;
 
 		cmd = queue_peek_head(hfp->cmd_queue);
 		if (!cmd)
 			return;
 
-		cmd->resp_cb(result, cmd->user_data);
+		cmd->resp_cb(result, cme_err, cmd->user_data);
 
 		queue_remove(hfp->cmd_queue, cmd);
 		free(cmd);
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 4ab7150..be7cbb8 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -34,6 +34,7 @@ enum hfp_result {
 	HFP_RESULT_NO_ANSWER	= 8,
 	HFP_RESULT_DELAYED	= 9,
 	HFP_RESULT_BLACKLISTED	= 10,
+	HFP_RESULT_CME_ERROR	= 11,
 };
 
 enum hfp_error {
@@ -131,7 +132,9 @@ bool hfp_context_has_next(struct hfp_context *context);
 typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
 							void *user_data);
 
-typedef void (*hfp_response_func_t)(enum hfp_result result, void *user_data);
+typedef void (*hfp_response_func_t)(enum hfp_result result,
+							enum hfp_error cme_err,
+							void *user_data);
 
 struct hfp_hf;
 
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index e992cf7..19250f6 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -475,6 +475,7 @@ static void hf_unsolicited_resp_cb(struct hfp_context *context,
 }
 
 static void hf_response_with_data(enum hfp_result res,
+							enum hfp_error cme_err,
 							void *user_data)
 {
 	struct context *context = user_data;
@@ -485,7 +486,8 @@ static void hf_response_with_data(enum hfp_result res,
 	hfp_hf_disconnect(context->hfp_hf);
 }
 
-static void hf_response_cb(enum hfp_result res, void *user_data)
+static void hf_response_cb(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
 {
 	struct context *context = user_data;
 
-- 
1.8.4

