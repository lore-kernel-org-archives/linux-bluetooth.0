Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/8] shared/hfp: Add initial implementiation of processing commands
Date: Thu, 27 Feb 2014 10:40:01 +0100
Message-Id: <1393494006-20363-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index e164dd6..cf54a8f 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -69,6 +69,11 @@ struct prefix_handler_data {
 	hfp_result_func_t callback;
 };
 
+struct hfp_gw_result {
+	const char *data;
+	int offset;
+};
+
 static void destroy_prefix_handler_data(void *data)
 {
 	struct prefix_handler_data *handler = data;
@@ -130,6 +135,46 @@ static void wakeup_writer(struct hfp_gw *hfp)
 	hfp->writer_active = true;
 }
 
+static bool process_basic(struct hfp_gw *hfp, struct hfp_gw_result *result)
+{
+	return false;
+}
+
+static bool process_extended(struct hfp_gw *hfp, struct hfp_gw_result *result)
+{
+	return false;
+}
+
+static void skip_whitespace(struct hfp_gw_result *result)
+{
+	while (result->data[result->offset] == ' ')
+		result->offset++;
+}
+
+static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
+{
+	struct hfp_gw_result result;
+
+	result.offset = 0;
+	result.data = data;
+
+	skip_whitespace(&result);
+
+	if (strlen(data + result.offset) < 3)
+		return false;
+
+	if (strncmp(data + result.offset, "AT", 2))
+		if (strncmp(data + result.offset, "at", 2))
+			return false;
+
+	result.offset += 2;
+
+	if (data[result.offset] == '+')
+		return process_extended(hfp, &result);
+	else
+		return process_basic(hfp, &result);
+}
+
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
@@ -163,10 +208,12 @@ static void process_input(struct hfp_gw *hfp)
 
 	len = ringbuf_drain(hfp->read_buf, count + 1);
 
-	if (hfp->command_callback)
-		hfp->command_callback(ptr, hfp->command_data);
-	else
-		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+	if (!call_prefix_handler(hfp, ptr)) {
+		if (hfp->command_callback)
+			hfp->command_callback(ptr, hfp->command_data);
+		else
+			hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+	}
 
 	free(ptr);
 }
-- 
1.8.3.1

