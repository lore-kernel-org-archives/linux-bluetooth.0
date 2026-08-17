Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E94B0497
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000451; cv=none; b=EWsUycnEM4hpPvnVrVUqCqsomJa7L8KJQVrz4hNYP0bWoipbSE1knVHYjRNCBnzpOJUu2WdfFSpjCVhJ7g230PhF4g5u6PDxNlC/lvoELivHQKNqwWM5NM6BTiZP8UVAZjUaOvoM8PEIbItgFsw4KUkLachErE2HDRKjD0qtugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000451; c=relaxed/simple;
	bh=TEVvOnCW3+Om8voazBxQAoJIXebPtE0NnIvYOEgbYUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EduxakVjaoTNkinLH8jHvJ+wxvh1AtUxG5OMXOHk3TgQ4KWs15dpeT9NaGpP2dWJnQGUDCxrIWm93XytkIbnJO+sIAy8YgJustH8jvwWoSM+DH6Ps0cr9x5tE2SvQwluqaE5th7BYujfvqwavWzb6A6Hne2Q7uyjD9RhEfJmnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/Xt5Mrv; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/Xt5Mrv"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-977fca41f52so1752865241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000448; x=1787605248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=19aE1gvd3JhQHdOu41/zzwUsXW3sfHO92kUTft3Ndd0=;
        b=r/Xt5Mrv8qv1efyrf+dCCERmW7YcP4Qhna7Md8eRofU7NLcHNS5ICe0Fw1C6oJrVah
         MpdojxhJM6EkloFI9GMyFUkb2ZC22QQFHkIhNDtG/+VJ3NiLd/kGbP7jUFTqsL5wdT6G
         V9cKcKQsloJlzPtH22Kyn9jQpJPSn6e3aTrFIg1/coWafHIDr1SegBEpH26PWZhPhBlG
         AhOwFRgmB5uEBLTL+T3EaWeBlp/+I+6MLsQhqN/yb2eZE+/fRYtHZdP9aipjvhDuPTam
         knvGZJoapPaDKdfb9ut3zamN9mODkECX2bTUBhpit7As+lTpBzXlaV8lmWoXmLTi7Qgu
         UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000448; x=1787605248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=19aE1gvd3JhQHdOu41/zzwUsXW3sfHO92kUTft3Ndd0=;
        b=qZrZFATGATLVNStkwICQnEpOCaYjsWBVVKrLOxH55QwYMoWbIov+I/A1CrA1SNUGcq
         iTxb/D0ct6GqhWCWYexlWT0C48MdusOoXmpGoERtw5c1LqUwDawKDNH4pnKIJOOSJgNZ
         6KhcLI1w11GurfD0vcsKwildMSNyArEbzd0o9c6FHG4/4pjXPd0aeFia93WzWzjrvccL
         /81S78zJNVLvIax0dPzh0M0vg/G+po4LSNa6lZfTj5stR/hOpv4yf428ilWWUXVrTedk
         /wJT/JEPRnoGnqFC19aaXLwgX0JsCtgTv0SUiJLRWoqPqQb10ruCBptOZa5Z+pNb/BXg
         I35Q==
X-Gm-Message-State: AOJu0Ywn+8/+VEHAmUXx/3KaCPivRY/7xD3FPGyCRZhvPAizWuJoKjl2
	K3SjLy/Z+kMbevZpq1Lu/SAgoyrpBLf6Q3PSDkyxecpwNwNrGfCOhEGEWhCbSVEn6bogSg==
X-Gm-Gg: AR+sD12gYU/9c9URHzAdvEfK504oD84UeP/RoLxH2lAUrmSpEedg7pooNQrup1KW8+U
	cWqvyBcsh7E+8uPj+0IIDDYxjqkoA/nPjjN5WmjNkExwjdaIHtM8dQEunVhEQIqqQZR3Lh1haAO
	Ft9KxLEGLKv5I6Eu/dAZkN7bQ2T/ETlaKe5Ybftdp+WIxusp5PpWTdV0Ax4rTsjuqoW8gJ+B8tY
	jKdIu8kk0k5BBk57mLxpyG0XdBFiwPpL8dnvHXWhCrWB7YLi6GvSTIPJzY0hzcOVjWkzLhb9A19
	hVzZMfxoCKVO6Qx4hvdKZe/BcoGUJzOUMhD1Bo2yqVSVh5HusvxwKKNnyCpUpqS50fQsf7cYSW/
	VepWNjH9o4UzEV6aUr91k2w1HbkC2HQzxlK4E0wEkU5m1gw+WHkE8cMhxtpkO2CZeca14kk8/4m
	X2xGkSKdhHXmdQTZpFUem/uCFrYY3t/IXccoVtGoMctc1Sf7yRnJOt9xAD19bBw9I8vQNngI8XN
	dSpo8UA00ZqQw5RKovXo5BE8SZk0mv1qZ41QoVFx1ESNZ6QVlxENrI=
X-Received: by 2002:a05:6102:512a:b0:76b:12e9:a443 with SMTP id ada2fe7eead31-76f2c43cbd6mr5860636137.9.1787000448408;
        Mon, 17 Aug 2026 14:00:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c29e934sm2121511241.3.2026.08.17.14.00.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:00:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] sdp-xml: Use a queue to collect sequence members
Date: Mon, 17 Aug 2026 17:00:35 -0400
Message-ID: <20260817210038.1839617-1-luiz.dentz@gmail.com>
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
 Makefile.tools |  4 +++-
 src/sdp-xml.c  | 60 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 1a4e5660813b..b3ef4ae1c3df 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -437,7 +437,9 @@ tools_hciconfig_LDADD = lib/libbluetooth-internal.la
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c
 tools_hcitool_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
 
-tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
+tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c \
+			src/shared/queue.h src/shared/queue.c \
+			src/shared/util.h src/shared/util.c
 tools_sdptool_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
 
 tools_ciptool_LDADD = lib/libbluetooth-internal.la
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

