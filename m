Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB221BA062
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930288; cv=none; b=Z0+zx/+N78aH+dqq1qisxRVkgm3cvIIF9xvKGPVsAQRiZjy9CoCuWPZ6hdJk8vTOWUmThklhrNQTJnVoVsHinC35LKgnY6HKcJrVY3gSa+64ZY5NkvcAAWorkhKSdBbH/8I+6547Q1dAsboUZF8pFaZBPwhRjb5So3QhQYMzP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930288; c=relaxed/simple;
	bh=Ou0kGDa50CgH9PnCyq7XPN19GakFWGQO/fwUzDZK+Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKBnmmjkQ+QGV+oMIVTe7l2ZcnQIguj58Why9HbVZzw+oA8z/KiPsnaC5wHQCZyRma5QYNsWdkTJk6N9tSXVPx/YUZZ8LR6SoZc4E0yBfNxB24SLcTXffRcK0UdOWJgfYtgaoNGShVc/HJrH62bG3lnnd3tmMF9s+C5xM6x6JpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95A5E24000E;
	Tue,  2 Jul 2024 14:24:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 4/9] obexd: Fix possible memleak
Date: Tue,  2 Jul 2024 16:23:36 +0200
Message-ID: <20240702142436.833138-5-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142436.833138-1-hadess@hadess.net>
References: <20240702142436.833138-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Fix possible resource leak if a attribute is repeated, overriding the
original value.

Error: RESOURCE_LEAK (CWE-772): [#def28] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:362:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:362:4: var_assign: Assigning: "entry->handle" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:362:4: overwrite_var: Overwriting "entry->handle" in "entry->handle = g_strdup_inline(values[i])" leaks the storage that "entry->handle" points to.
360|	for (i = 0 ; names[i]; ++i) {
361|		if (g_strcmp0(names[i], "handle") == 0) {
362|->			entry->handle = g_strdup(values[i]);
363|			mld->size++;
364|			continue;

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:367:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:367:4: var_assign: Assigning: "entry->attachment_size" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:367:4: overwrite_var: Overwriting "entry->attachment_size" in "entry->attachment_size = g_strdup_inline(values[i])" leaks the storage that "entry->attachment_size" points to.
365|		}
366|		if (g_strcmp0(names[i], "attachment_size") == 0) {
367|->			entry->attachment_size = g_strdup(values[i]);
368|			continue;
369|		}

Error: RESOURCE_LEAK (CWE-772): [#def30] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:371:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:371:4: var_assign: Assigning: "entry->datetime" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:371:4: overwrite_var: Overwriting "entry->datetime" in "entry->datetime = g_strdup_inline(values[i])" leaks the storage that "entry->datetime" points to.
369|		}
370|		if (g_strcmp0(names[i], "datetime") == 0) {
371|->			entry->datetime = g_strdup(values[i]);
372|			continue;
373|		}

Error: RESOURCE_LEAK (CWE-772): [#def31] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:375:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:375:4: var_assign: Assigning: "entry->subject" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:375:4: overwrite_var: Overwriting "entry->subject" in "entry->subject = g_strdup_inline(values[i])" leaks the storage that "entry->subject" points to.
373|		}
374|		if (g_strcmp0(names[i], "subject") == 0) {
375|->			entry->subject = g_strdup(values[i]);
376|			continue;
377|		}

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:379:4: overwrite_var: Overwriting "entry->recipient_addressing" in "entry->recipient_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->recipient_addressing" points to.
377|		}
378|		if (g_strcmp0(names[i], "recipient_addressing") == 0) {
379|->			entry->recipient_addressing = g_strdup(values[i]);
380|			continue;
381|		}

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:383:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:383:4: var_assign: Assigning: "entry->sender_addressing" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:383:4: overwrite_var: Overwriting "entry->sender_addressing" in "entry->sender_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->sender_addressing" points to.
381|		}
382|		if (g_strcmp0(names[i], "sender_addressing") == 0) {
383|->			entry->sender_addressing = g_strdup(values[i]);
384|			continue;
385|		}

Error: RESOURCE_LEAK (CWE-772): [#def34] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:387:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:387:4: var_assign: Assigning: "entry->type" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:387:4: overwrite_var: Overwriting "entry->type" in "entry->type = g_strdup_inline(values[i])" leaks the storage that "entry->type" points to.
385|		}
386|		if (g_strcmp0(names[i], "type") == 0) {
387|->			entry->type = g_strdup(values[i]);
388|			continue;
389|		}

Error: RESOURCE_LEAK (CWE-772): [#def35] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:391:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:391:4: var_assign: Assigning: "entry->reception_status" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:391:4: overwrite_var: Overwriting "entry->reception_status" in "entry->reception_status = g_strdup_inline(values[i])" leaks the storage that "entry->reception_status" points to.
389|		}
390|		if (g_strcmp0(names[i], "reception_status") == 0)
391|->			entry->reception_status = g_strdup(values[i]);
392|	}
393|
---
 obexd/plugins/messages-dummy.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index e37b52df6266..92378dab4b20 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -359,36 +359,45 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 
 	for (i = 0 ; names[i]; ++i) {
 		if (g_strcmp0(names[i], "handle") == 0) {
+			g_free(entry->handle);
 			entry->handle = g_strdup(values[i]);
 			mld->size++;
 			continue;
 		}
 		if (g_strcmp0(names[i], "attachment_size") == 0) {
+			g_free(entry->attachment_size);
 			entry->attachment_size = g_strdup(values[i]);
 			continue;
 		}
 		if (g_strcmp0(names[i], "datetime") == 0) {
+			g_free(entry->datetime);
 			entry->datetime = g_strdup(values[i]);
 			continue;
 		}
 		if (g_strcmp0(names[i], "subject") == 0) {
+			g_free(entry->subject);
 			entry->subject = g_strdup(values[i]);
 			continue;
 		}
 		if (g_strcmp0(names[i], "recipient_addressing") == 0) {
+			g_free(entry->recipient_addressing);
 			entry->recipient_addressing = g_strdup(values[i]);
 			continue;
 		}
 		if (g_strcmp0(names[i], "sender_addressing") == 0) {
+			g_free(entry->sender_addressing);
 			entry->sender_addressing = g_strdup(values[i]);
 			continue;
 		}
 		if (g_strcmp0(names[i], "type") == 0) {
+			g_free(entry->type);
 			entry->type = g_strdup(values[i]);
 			continue;
 		}
-		if (g_strcmp0(names[i], "reception_status") == 0)
+		if (g_strcmp0(names[i], "reception_status") == 0) {
+			g_free(entry->reception_status);
 			entry->reception_status = g_strdup(values[i]);
+		}
 	}
 
 	if (mld->size > mld->offset)
-- 
2.45.2

