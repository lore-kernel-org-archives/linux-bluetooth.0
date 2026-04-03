Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358741D6DB5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205699; cv=none; b=a6/bQVjsu5MSRAmt+j6pzF6+LY286la05ORyClMHakknHzkSnCEQ1M5u/RKMLMgFwMjmrf6VfeHprDaq+w+A8+ZIho5NpdbcR9c6MaOD5on6CtJBz1FBjKvAz2WIo57yqKH3+kYm2hgPj5PJNOl9YKPYIQkAhlrfslY1Ex774Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205699; c=relaxed/simple;
	bh=skx15EzSiu6DFzCLuMjVwYV0gtJA3udv3fLIxN7wg+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bMrkNgCOG+x4z6Gci4rwFIJKUHj7U09dfHfTQh/1bG+XFWnXWRhxFca5xdr+Uf5KFSBNygjN9iuyZrXogVfR3XUEULjteSkcnnaXKE4oi+GV7lMmHDg3tIAeu6z0pDMENhY4ek2D6Gtnz5bsPSEyoP/lDVzJeOI0Y0JhtgO5Y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C32E33EBC0
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/queue: Add way to iterate over queue contents
Date: Fri,  3 Apr 2026 10:40:54 +0200
Message-ID: <20260403084128.348931-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEFHnWv4DhrV6PkZbMjgoX6LKhTQdPRawzPUv0fbW/sly9RO6Us4H6A0HvdEw6GNDF1tp7bqX5cTGvGoOvTmReHHEKLyf4cqDHemyPWe7CTYvzAUiU0R7mV0MhE79s90ql90za0Dx16MavoRnIRxOs0ZzBC2PgXI6CVYiFMmol1gdeZdtXebAAq/66PlKInZ2fQVDi1QMV2qbkrRHnqCQ4qLtyX1rGUdjq6v9ZVN/V4T/naserGaEPZrd8DXLyfDAIFCwQThQbCYcqSRVc2VOSUgvWlbnovAmwXAIUHA3WflWyjK1MIM8tcbauDAAjgY9PaL5uHyLpBVky2kj1ufMXKrJQ/Q/FTETosjiQn1rDrUkzLJK817lRmXV7nSfNJ7WXP82TS4T0mPPQIysl2uqIW+DVz0apcq7PjQOuYaU36aHpxsu3VJHazHEZWYl/DbZhzQvPXB3ZnnwuZTuiv3wXuX91v4VZDQMbVLdDmJwBeVX+l95mNaIbkP+LNzLcNsGW3rpzeuW3dL8crqWhgEYEnE2wgdCU+gksPZEVAEtk4OHdJVpziI3MtASsyA9hnWifU8HrXBxmAnF4MmtBNQ59yCGY5R4sIR7BpW4Mxsc0iiBoNLrrSyLxzmwcNTMzaN8BcbTvjV/wqChLBxYlTaO0Yi1lVTzcfFTmANO41aszzoQ

There were no accessors that would give us an iteratable structure,
leaving us with just *_foreach() constructs that are cumbersome.

Add a way to get the first entry in the queue.
---
 src/shared/queue.c |  8 ++++++++
 src/shared/queue.h |  1 +
 unit/test-queue.c  | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 0b53b5b7976e..20fe2a913f58 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -179,6 +179,14 @@ void *queue_peek_head(struct queue *queue)
 	return queue->head->data;
 }
 
+struct queue_entry *queue_peek_head_entry(struct queue *queue)
+{
+	if (!queue || !queue->head)
+		return NULL;
+
+	return queue->head;
+}
+
 void *queue_peek_tail(struct queue *queue)
 {
 	if (!queue || !queue->tail)
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 122f4eaa6c2f..5ea7ce4fd768 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -27,6 +27,7 @@ bool queue_push_head(struct queue *queue, void *data);
 bool queue_push_after(struct queue *queue, void *entry, void *data);
 void *queue_pop_head(struct queue *queue);
 void *queue_peek_head(struct queue *queue);
+struct queue_entry *queue_peek_head_entry(struct queue *queue);
 void *queue_peek_tail(struct queue *queue);
 
 typedef void (*queue_foreach_func_t)(void *data, void *user_data);
diff --git a/unit/test-queue.c b/unit/test-queue.c
index 46018ef9cf1f..e47199497d41 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -246,6 +246,25 @@ static void test_remove_all(const void *data)
 	tester_test_passed();
 }
 
+static void test_peek_head_entry(const void *data)
+{
+	struct queue *queue;
+	struct queue_entry *entry;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	g_assert(queue_push_tail(queue, INT_TO_PTR(10)));
+
+	entry = queue_peek_head_entry(queue);
+	g_assert(entry->data == queue_peek_head(queue));
+	g_assert_cmpint(PTR_TO_INT(entry->data), ==, PTR_TO_INT(queue_peek_head(queue)));
+	g_assert_cmpint(PTR_TO_INT(entry->data), ==, 10);
+
+	queue_destroy(queue, NULL);
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -263,6 +282,7 @@ int main(int argc, char *argv[])
 						test_destroy_remove, NULL);
 	tester_add("/queue/push_after",  NULL, NULL, test_push_after, NULL);
 	tester_add("/queue/remove_all",  NULL, NULL, test_remove_all, NULL);
+	tester_add("/queue/peek_head_entry", NULL, NULL, test_peek_head_entry, NULL);
 
 	return tester_run();
 }
-- 
2.53.0

