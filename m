Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v2] unit: Use g_memdup replacing g_malloc0+memcpy
Date: Mon, 01 Jun 2015 16:14:34 +0530
Message-id: <1433155474-29992-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace use of g_malloc0+memcpy with g_memdup.
---
 unit/test-gattrib.c | 3 +--
 unit/test-sdp.c     | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 416e596..d9c52d7 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -224,8 +224,7 @@ static void result_canary(guint8 status, const guint8 *pdu, guint16 len,
 	struct result_data *result = data;
 
 	result->status = status;
-	result->pdu = g_malloc0(len);
-	memcpy(result->pdu, pdu, len);
+	result->pdu = g_memdup(pdu, len);
 	result->len = len;
 
 	if (g_test_verbose())
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index b4ef4d1..9d716d8 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -189,9 +189,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	pdu_len = req_pdu->raw_size + context->cont_size;
 
-	buf = g_malloc0(pdu_len);
-
-	memcpy(buf, req_pdu->raw_data, req_pdu->raw_size);
+	buf = g_memdup(req_pdu->raw_data, pdu_len);
 
 	if (context->cont_size > 0)
 		memcpy(buf + req_pdu->raw_size, context->cont_data,
-- 
1.9.1

