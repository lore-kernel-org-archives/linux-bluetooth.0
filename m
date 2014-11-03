Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/10] shared/hfp: Add function to skip field in hfp_context
Date: Mon,  3 Nov 2014 10:36:00 +0100
Message-Id: <1415007361-4177-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some fields in AT commands are not used by HFP spec. When parsing such
commands it is convinient to just skip it without looking what is inside
there
---
 src/shared/hfp.c | 12 ++++++++++++
 src/shared/hfp.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 6c804f5..a35cb7b 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -415,6 +415,18 @@ bool hfp_context_has_next(struct hfp_context *context)
 	return context->data[context->offset] != '\0';
 }
 
+void hfp_context_skip_field(struct hfp_context *context)
+{
+	const char *data = context->data;
+	unsigned int offset = context->offset;
+
+	while (data[offset] != '\0' && data[offset] != ',')
+		offset++;
+
+	context->offset = offset;
+	next_field(context);
+}
+
 bool hfp_context_get_range(struct hfp_context *context, uint32_t *min,
 								uint32_t *max)
 {
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 5ba020d..2eb7838 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -130,6 +130,7 @@ bool hfp_context_get_unquoted_string(struct hfp_context *context,
 bool hfp_context_get_range(struct hfp_context *context, unsigned int *min,
 							unsigned int *max);
 bool hfp_context_has_next(struct hfp_context *context);
+void hfp_context_skip_field(struct hfp_context *context);
 
 typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
 							void *user_data);
-- 
1.8.4

