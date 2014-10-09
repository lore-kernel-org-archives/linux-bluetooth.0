Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 6/8] shared/hfp: Add hfp_context_get_range function
Date: Fri, 10 Oct 2014 01:50:50 +0200
Message-Id: <1412898652-12281-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds hfp_contex_get_range function which is useful in parsing
response like this : +CIND: ("battchr",(1-5))
---
 src/shared/hfp.c | 31 +++++++++++++++++++++++++++++++
 src/shared/hfp.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 1ccbd16..fe9f1c0 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -419,6 +419,37 @@ bool hfp_context_has_next(struct hfp_context *result)
 	return result->data[result->offset] != '\0';
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
index e4a70e0..c2153a8 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -137,6 +137,8 @@ bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len);
 bool hfp_context_get_unquoted_string(struct hfp_context *context,
 						char *buf, uint8_t len);
+bool hfp_context_get_range(struct hfp_context *context, unsigned int *min,
+							unsigned int *max);
 bool hfp_context_has_next(struct hfp_context *context);
 
 struct hfp_hf *hfp_hf_new(int fd);
-- 
1.8.4

