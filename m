Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 06/10] shared/hfp: Add hfp_context_get_range function
Date: Mon,  3 Nov 2014 10:35:57 +0100
Message-Id: <1415007361-4177-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds hfp_contex_get_range function which is useful in parsing
response like this : +CIND: ("battchr",(1-5))
---
 src/shared/hfp.c | 31 +++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index e375d27..6c804f5 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -415,6 +415,37 @@ bool hfp_context_has_next(struct hfp_context *context)
 	return context->data[context->offset] != '\0';
 }
 
+bool hfp_context_get_range(struct hfp_context *context, uint32_t *min,
+								uint32_t *max)
+{
+	uint32_t l, h;
+	uint32_t start;
+
+	start = context->offset;
+
+	if (!hfp_context_get_number(context, &l))
+		goto failed;
+
+	if (context->data[context->offset] != '-')
+		goto failed;
+
+	context->offset++;
+
+	if (!hfp_context_get_number(context, &h))
+		goto failed;
+
+	*min = l;
+	*max = h;
+
+	next_field(context);
+
+	return true;
+
+failed:
+	context->offset = start;
+	return false;
+}
+
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index be7cbb8..5ba020d 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -127,6 +127,8 @@ bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len);
 bool hfp_context_get_unquoted_string(struct hfp_context *context,
 						char *buf, uint8_t len);
+bool hfp_context_get_range(struct hfp_context *context, unsigned int *min,
+							unsigned int *max);
 bool hfp_context_has_next(struct hfp_context *context);
 
 typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
-- 
1.8.4

