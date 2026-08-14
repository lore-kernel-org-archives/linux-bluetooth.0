Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748664908A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728757; cv=none; b=hSrxP7MLHfiC8cOBzOawNXOUzEwH1csyikTUgpXSSh2sb99Oji5ATsK4krE33xLTPSn05kvEJgp6XFjCzIUTKidUrfg9ik3Km2rWuREbO1LsvXwZ1D8+YudOzhOqy/3GbDoLI3i8H6wbJx6UmvO8epE60eSdpOAIxlUK8UYbZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728757; c=relaxed/simple;
	bh=jFPl9iaiCuAvwDvlpnaXYcAFP+RYMmUB38Pr9h0n3Fg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GRMLvqrA6oVRFPY4WZi+h/UQx7ggl8XESOAZ1T6bkZlbaKkO8fOzVwXsjFOZOGSFVTaduBxVkWUp7hkUNVRIWO2g25Uz1YnPoRyOW0AcypVvD550QBhGRhyWVX0V9M/X1VC6jI+4odsu2BfRGbDQwaZDuVJddGU+D7leCtq0R40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8f6gGq1; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8f6gGq1"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97bf8f10ebfso623488241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786728754; x=1787333554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJhE0NpCI8j8E3w5TBurtz6ECrwIDqGtzD/6pTdr3v0=;
        b=Z8f6gGq1dGxSbN14z4W3wJLC/BRwVAP25Fizdf5aLTwGMpyl+My3I2drGtMWFkfDfQ
         YqjhoJxK/zguw1oaAJvUDoyhMt38qMaWO3lynGs3ipsCX++s3puMbLPysEpFPCkWsyju
         WzHMJDloyIKeike1VvGGDh+sV/ITRGnhArcqyjxymnUCDbJN8Nw6UCwJc4/yGxDOx7Fj
         Yoi2ITlzBqwPlOGs2x0ZwnhsO1bVBRudkmgYdKnLv2hOoZIc2Kvc6rDmJd5JL0WYZekH
         svB54QK7TU+lkgqT+ILOdJgGajxrLvyTWv9kXA2pVyi+bGePy5XlOTgmW5SQtXUAFf+i
         kcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786728754; x=1787333554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UJhE0NpCI8j8E3w5TBurtz6ECrwIDqGtzD/6pTdr3v0=;
        b=scXMH7wsc3VdbQIT99L3mmWFAL6aaJGW9T3EV1snUY1BaZEM59jaPqHmF+L9TedMq0
         mowa3oUjpdr0wM8A5sCKSqp6Hru3vQD8OBYb16E2TlQwETAPl+/XePO3sCRD7IUm8HgL
         xuGVDK/DB3aPFfJdQz53ebLM1Rx4/1oKQS1Dc82Wl3oRmXsVzOkTq7a5eibTZCXo5BnH
         7wQzh91NTqJbcByIsOei1qjNcjztDiV3DurtHqzZGJq7oxHq1xuYo21OyWVUOZv6q2eP
         WB6yveyumNFQ4cbJyTQPXwWU30iPRYrgf41gOQYBQ7f8jNk6QyRxTxBCz4Dty9v1KUkq
         32uA==
X-Gm-Message-State: AOJu0Yw0bzT7HjOrxRGsz1bAbsPU6Gjlqo5p1K0qUfvOC/1nODrGPGAU
	uGJXnEQwFBBOANJKqAQs8t/mBK6m2kIxIWCz8AReP6NDlKYMxoDZ/QmU3G3gKmwQ
X-Gm-Gg: AR+sD115YZS+IEFcSz2NiH47Pb2C5vUv/p1YUTqsnM7oX1ry9OtbIHD9aTk3ZpLN6Ec
	1aTkjr/0wXrqKJ2mJ9xhZ6xN1s2xiMDXvVsT+VxndiSzNgIsNnGLqXU4u4A9FedqewPVDGxOyq1
	wNmUDftaHDRZ3EHZYWLbwJ01MVJWX7EOo0bXDdSdolschwX6FuguxhqQJJ6kD86vMNm0TSQS2ja
	AK++9SI6MBRdBHM7sM2UZEh+Ih7/1xs0pvm0UIDar1zgMTXvDg3K5skKy7FBEEzlpekuB8Fgim2
	81lxNB/RA/InEyAxHvSSZuT12yyRewU1dSQWqhP/xLYhrXh5JY2r0Bs1YiqJOq+7njPkNQMCJZA
	ebynVQguE1lyYsk560KUi00xKSl5Dl0tP27VRsIQCLgEb91gNKhPhAAxdM02P2HzMWTDCbEujMS
	66vP8rVrpsjPeqE30bwv/o/MRyYFbma2zwIZPOOAXqL/Jf8U+qeS5gATv2ce54kXgXHh0SbQMhn
	kCdwo8REGCIktsotqitYWRCiKkgCEaWDyKmPReEKmr0rPO+gYikyHM=
X-Received: by 2002:a05:6122:88f:b0:5c5:731e:801e with SMTP id 71dfb90a1353d-5c591f6d3eemr1811961e0c.13.1786728754109;
        Fri, 14 Aug 2026 10:32:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97bfa5a111esm1413148241.4.2026.08.14.10.32.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:32:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] sdp-xml: Use a queue to collect sequence members
Date: Fri, 14 Aug 2026 13:32:25 -0400
Message-ID: <20260814173225.1410500-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Appending a member to a sequence with sdp_seq_append() walks the
single-linked list to find its tail, so building a sequence is O(n^2).

This was previously worked around by caching the tail of the sequence in
struct sdp_xml_data, which required the caller to pick between appending
to the cached tail and initialising val.dataseq, and to keep the cache in
sync on every append.

Collect the members in a struct queue instead, which tracks its own tail,
and link them into val.dataseq once the element is closed. Appending is a
plain queue_push_tail(), and the queue is destroyed along with the rest
of the element so members that were never linked, such as on malformed
input, are still freed.

The sequence_on_squared() test stays at less than 0.1 seconds.

Assisted-by: Claude:claude-opus-5
---
 src/sdp-xml.c | 60 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 5b448fe83410..bad9e289344f 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -25,6 +25,8 @@
 #include "bluetooth/sdp.h"
 #include "bluetooth/sdp_lib.h"
 
+#include "shared/queue.h"
+
 #include "sdp-xml.h"
 
 #define DBG(...) (void)(0)
@@ -44,7 +46,7 @@ struct sdp_xml_data {
 	char type;			/* 0 = Text or Hexadecimal */
 	char *name;			/* Name, optional in the dtd */
 	/* TODO: What is it used for? */
-	sdp_data_t *tail;		/* Tail for O(1) dataseq append */
+	struct queue *seq;		/* Members of a dataseq, if any */
 };
 
 struct context_data {
@@ -510,8 +512,37 @@ static void element_start(GMarkupParseContext *context,
 	}
 }
 
+/*
+ * Link the members collected in elem->seq into elem->data->val.dataseq.
+ *
+ * Members are collected in a queue so that appending is O(1), sdp_seq_append()
+ * would otherwise have to walk to the tail of the sequence on every append.
+ */
+static void sdp_xml_data_flush_seq(struct sdp_xml_data *elem)
+{
+	const struct queue_entry *entry;
+	sdp_data_t *tail = NULL;
+
+	if (!elem->seq)
+		return;
+
+	for (entry = queue_get_entries(elem->seq); entry; entry = entry->next) {
+		if (tail)
+			sdp_seq_append(tail, entry->data);
+		else
+			elem->data->val.dataseq = sdp_seq_append(NULL,
+								entry->data);
+		tail = entry->data;
+	}
+
+	queue_destroy(elem->seq, NULL);
+	elem->seq = NULL;
+}
+
 static void sdp_xml_data_free(struct sdp_xml_data *elem)
 {
+	queue_destroy(elem->seq, (queue_destroy_func_t) sdp_data_free);
+
 	if (elem->data)
 		sdp_data_free(elem->data);
 
@@ -568,6 +599,8 @@ static void element_end(GMarkupParseContext *context,
 		return;
 	}
 
+	sdp_xml_data_flush_seq(ctx_data->stack_head);
+
 	if (!strcmp(element_name, "sequence")) {
 		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
 			g_set_error(err, G_MARKUP_ERROR,
@@ -610,28 +643,21 @@ static void element_end(GMarkupParseContext *context,
 
 	if (ctx_data->stack_head->next && ctx_data->stack_head->data &&
 					ctx_data->stack_head->next->data) {
-		sdp_data_t *tail;
-		switch (ctx_data->stack_head->next->data->dtd) {
+		struct sdp_xml_data *parent = ctx_data->stack_head->next;
+
+		switch (parent->data->dtd) {
 		case SDP_SEQ8:
 		case SDP_SEQ16:
 		case SDP_SEQ32:
 		case SDP_ALT8:
 		case SDP_ALT16:
 		case SDP_ALT32:
-			tail = ctx_data->stack_head->next->data->val.dataseq ?
-				ctx_data->stack_head->next->tail : NULL;
-			if (tail) {
-				sdp_seq_append(tail,
-					ctx_data->stack_head->data);
-			} else {
-				ctx_data->stack_head->next->data->val.dataseq =
-					sdp_seq_append(NULL,
-						ctx_data->stack_head->data);
-			}
-			ctx_data->stack_head->next->tail =
-					ctx_data->stack_head->data;
-			ctx_data->stack_head->data = NULL;
-			ctx_data->stack_head->tail = NULL;
+			if (!parent->seq)
+				parent->seq = queue_new();
+
+			if (queue_push_tail(parent->seq,
+						ctx_data->stack_head->data))
+				ctx_data->stack_head->data = NULL;
 			break;
 		}
 
-- 
2.54.0

