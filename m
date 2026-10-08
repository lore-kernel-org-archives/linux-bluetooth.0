Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA5386441
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430868; cv=none; b=Cb0AgE/UEilXhHvn8HV1/Glxny7gO3PFvNGwu7JACSymCPXkmP2lkHy4U8/zDmBEmNKM3ApvwqoMdr8ytpr4VrTsY1Is2Eq86XCfsjTpyASyoE0CAEJFpte2sh900UTa4Gcxyp4X49r4VNDNR3UUnu8ficZA1SogPwvyH179XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430868; c=relaxed/simple;
	bh=dAm42HIaHbrwQXPeAGfjR9BvatE5GIgZKzxxZA9bK28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv2OC80VqyZio9VcMyp7LNAinML0lQ+bBJ9LTYWHGJfAy3J4UcKRbASvzzMT+6S2lFzFvHlPnlzf4Ju62l/B2lfb/GhSfK9uzsPRxzEx+Gk0YJ1Qg+rfVEmpeoI8si/sdQXXP+FBCQMYd9/CwDZeq/GiYug8cTswAVrSXb/h/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9Bv14Fa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9Bv14Fa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16d39964bso484135e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791430865; x=1792035665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Kuy/UYca7bz7mFXDyIKa77sKZrlHG1c9rKZ0cH26v4=;
        b=H9Bv14FaA7WuH3seOu5KU/eK364XHil23mQHMcox+lWp7aE0zGdtI12PyklLQixlK9
         Em6NsVOniZKMgagmR9Al3B/RSf4Gec4/ohdHAfdF+U2sywBtbFdIrHWVfd+/1s9/iPkf
         wpOkK0TfB1amSyU3yNAfF0WEPquFW1qWKqpmT6BSctyArACfReqMCwmqlgYvTg2GToge
         C+L9xop/Twi41kWs4kwQ/CU1s6rdfcKlRjXsFXrUG+B0E8xT+n5gO7Yknu/7EEZ+OO+l
         2dwUn977EdMj3HLLD6QOI3+FEQ/NzCUWQ7iv8/UJ3FB0cUE2GWiFd9ablAxfp4E5uto1
         bqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430865; x=1792035665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8Kuy/UYca7bz7mFXDyIKa77sKZrlHG1c9rKZ0cH26v4=;
        b=qLjjGuvFQKjc+at3hfTIitZKAMvS6zvu3jcmb7Cg85njkcBwJBXnkD89h6kCtymnkL
         jrTaDwXk9aZmQd4jBap8av2yTrOrfMUC0aQ/AhvGafDEcvGUXf1TogsWwNiVFObOQmza
         8aPO0ErANEL85LrMbxF0ZWImayQJKt7+YBBjwSFnilQSVUTCBry1ECfedSXKZ2nt5+UG
         7yZYuViGwQ0YXtkawvQLb6V82yLXeg8bCSfqEjWgZB2uQmhS4pfNy17z1m1o1HzxiiW3
         dhzvP2khBzkIN4v5qic6+e0X0Mq0cVwiK66we+Q/oZ839z6Ne/8YLgziKkykxIZ2/VOo
         fjgw==
X-Gm-Message-State: AFuF++mg3Lwj/aE1YG2fqT+vMG3wNUYOmNUsOw3ChhHEcH/qC1Qt7E7d
	Nh37LH4BWVzBHkOG1dCnEI2l12VK8ef8x3jBp/EvmcEVknxCs50VtiGm0lxcstGyTEo=
X-Gm-Gg: AYBFou24ElYKqNuve1PnK/8oLlZQXIdP+6Q9RlabosOOSgZ6+RCyVb6GR3rLBzp03La
	JVZUHBobHMMq3HPaXXVBp+ffaOzPGlRBu64P5MWQOzqBtCM0YZgoZTy++ntbZDA+vxMZMcV5zao
	ypd7EQRNak5yRGZldtpOtzrHk1m332kjJrpL2FG+Iqr/m8GclRMZ3rkrYWiT4bCStfLjeFlMIoN
	Eq+/L4vYFkH4oGoZJTVDTfhG8Cr7pIwuY+1F7zIBm0eIGB7y9q2FjWywtdpA9qINrpacxHE10jV
	1Fh8IcVE3/Nh8LlmRIeazJWVUMQB+/uwF5RcgP1KuzbyQZdSHWp9o4y6pWVL06ylFsLdfZqHmID
	dUVUOjQmJNCzwdYVf7/tzfRi05HK1grfjGFfRhpiOCQgcxy4FGk/b7U7jjLZ+bB2cqUXmMB1Tbi
	3ctP3kmFjKXXlAslYntXr5kGKdiJnzp64JJHnnX+gSTVbJ5PcTml+8MwTPPN2cxxB5Hot7ne6cN
	bxvwhR8W7MkIDVWPTY6o0xQx9rG/EZUquu7s0DTJIFwZhMnWhMp59esnAQB8rS6Qw==
X-Received: by 2002:a05:600c:4ed0:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a1843e8e40mr27268935e9.0.1791430864462;
        Wed, 07 Oct 2026 20:41:04 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm8423010f8f.32.2026.10.07.20.41.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:41:04 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] unit/test-mgmt: Test unregistering from callbacks
Date: Thu,  8 Oct 2026 05:41:02 +0200
Message-ID: <20261008034102.707451-2-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
References: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add /mgmt/unregister/3 to /5, where a notification callback
unregisters its own entry, the next entry, or another entry followed
by mgmt_unregister_all(). The unregistered entry must not be notified
again, its destroy callback must not run inside the notification and
must have run once by the next idle callback, and unregistering it
again must fail.

Add /mgmt/unregister/6, which unregisters outside a notification: the
entry is destroyed at once and unregistering it again fails.

Without the previous patch, /4 faults under ASan (heap-use-after-free
in queue_foreach()), /3 never destroys the entry, and /5 gets true for
an entry already marked removed.
---
 unit/test-mgmt.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 691af79a4..7de612b58 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -416,6 +416,223 @@ static void test_destroy(gconstpointer data)
 	execute_context(context);
 }
 
+struct unregister_test;
+
+struct unregister_entry {
+	struct unregister_test *test;
+	unsigned int n;
+};
+
+/*
+ * An entry unregistered from a notification callback must not be notified
+ * again, must not be destroyed while the notification is dispatched, and
+ * must have been destroyed, once, by the next idle callback.
+ */
+struct unregister_test {
+	struct context *context;
+	unsigned int entries;
+	unsigned int events;
+	struct unregister_entry entry[3];
+	unsigned int id[3];
+	bool removed[3];
+	unsigned int called[3];
+	unsigned int expected[3];
+	unsigned int destroyed[3];
+};
+
+static void unregister_destroy(void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+
+	entry->test->destroyed[entry->n]++;
+	g_assert_cmpuint(entry->test->destroyed[entry->n], ==, 1);
+}
+
+static void unregister_add(struct unregister_test *test,
+				const struct command_test_data *data,
+				mgmt_notify_func_t callback)
+{
+	unsigned int n = test->entries++;
+
+	test->entry[n].test = test;
+	test->entry[n].n = n;
+	test->id[n] = mgmt_register(test->context->mgmt_client, data->opcode,
+					data->index, callback, &test->entry[n],
+					unregister_destroy);
+	g_assert_cmpuint(test->id[n], !=, 0);
+}
+
+static void unregister_check_alive(struct unregister_test *test)
+{
+	unsigned int i;
+
+	for (i = 0; i < test->entries; i++)
+		g_assert_cmpuint(test->destroyed[i], ==, 0);
+}
+
+static gboolean unregister_check_idle(gpointer user_data)
+{
+	struct unregister_test *test = user_data;
+	unsigned int i;
+
+	/* Entries unregistered while notifying are freed by now */
+	for (i = 0; i < test->entries; i++)
+		g_assert_cmpuint(test->destroyed[i], ==, test->removed[i]);
+
+	context_quit(test->context);
+
+	return FALSE;
+}
+
+static void unregister_from_cb(struct unregister_test *test, unsigned int n)
+{
+	struct mgmt *mgmt = test->context->mgmt_client;
+
+	g_assert_cmpint(mgmt_unregister(mgmt, test->id[n]), ==, true);
+	g_assert_cmpint(mgmt_unregister(mgmt, test->id[n]), ==, false);
+	test->removed[n] = true;
+
+	unregister_check_alive(test);
+}
+
+static void count_cb(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+
+	entry->test->called[entry->n]++;
+}
+
+static void unregister_self_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+
+	if (!entry->test->called[entry->n]++)
+		unregister_from_cb(entry->test, entry->n);
+}
+
+static void unregister_next_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+
+	if (!entry->test->called[entry->n]++)
+		unregister_from_cb(entry->test, entry->n + 1);
+}
+
+static void unregister_all_from_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+	struct unregister_test *test = entry->test;
+	struct mgmt *mgmt = test->context->mgmt_client;
+	unsigned int i;
+
+	test->called[entry->n]++;
+
+	unregister_from_cb(test, 1);
+	g_assert_cmpint(mgmt_unregister_all(mgmt), ==, true);
+
+	for (i = 0; i < test->entries; i++)
+		test->removed[i] = true;
+
+	g_assert_cmpint(mgmt_unregister(mgmt, test->id[2]), ==, false);
+
+	unregister_check_alive(test);
+
+	/* No registered entry is left to schedule the check */
+	g_idle_add(unregister_check_idle, test);
+}
+
+static void unregister_quit_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct unregister_entry *entry = user_data;
+	struct unregister_test *test = entry->test;
+
+	if (++test->called[entry->n] < test->events) {
+		unregister_check_alive(test);
+		return;
+	}
+
+	g_idle_add(unregister_check_idle, test);
+}
+
+static void unregister_run(struct unregister_test *test,
+				const struct command_test_data *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < test->events; i++)
+		g_assert_cmpint(write(test->context->fd, data->cmd_data,
+					data->cmd_size), ==, data->cmd_size);
+
+	execute_context(test->context);
+
+	for (i = 0; i < test->entries; i++) {
+		g_assert_cmpuint(test->called[i], ==, test->expected[i]);
+		g_assert_cmpuint(test->destroyed[i], ==, 1);
+	}
+}
+
+static void test_unregister_self(gconstpointer data)
+{
+	/* Calls per entry over two events; the first unregisters itself */
+	struct unregister_test test = { .context = create_context(),
+					.events = 2, .expected = { 1, 2, 2 } };
+
+	unregister_add(&test, data, unregister_self_cb);
+	unregister_add(&test, data, count_cb);
+	unregister_add(&test, data, unregister_quit_cb);
+
+	unregister_run(&test, data);
+}
+
+static void test_unregister_next(gconstpointer data)
+{
+	/* Calls per entry over two events; the first unregisters the second */
+	struct unregister_test test = { .context = create_context(),
+					.events = 2, .expected = { 2, 0, 2 } };
+
+	unregister_add(&test, data, unregister_next_cb);
+	unregister_add(&test, data, count_cb);
+	unregister_add(&test, data, unregister_quit_cb);
+
+	unregister_run(&test, data);
+}
+
+static void test_unregister_id_all(gconstpointer data)
+{
+	/* Calls per entry; the first unregisters the second, then all */
+	struct unregister_test test = { .context = create_context(),
+					.events = 1, .expected = { 1, 0, 0 } };
+
+	unregister_add(&test, data, unregister_all_from_cb);
+	unregister_add(&test, data, count_cb);
+	unregister_add(&test, data, count_cb);
+
+	unregister_run(&test, data);
+}
+
+static void test_unregister_direct(gconstpointer data)
+{
+	/* Calls per entry; the first is unregistered before the event */
+	struct unregister_test test = { .context = create_context(),
+					.events = 1, .expected = { 0, 1 } };
+	struct mgmt *mgmt = test.context->mgmt_client;
+
+	unregister_add(&test, data, count_cb);
+	unregister_add(&test, data, unregister_quit_cb);
+
+	g_assert_cmpint(mgmt_unregister(mgmt, test.id[0]), ==, true);
+	g_assert_cmpuint(test.destroyed[0], ==, 1);
+	g_assert_cmpint(mgmt_unregister(mgmt, test.id[0]), ==, false);
+	test.removed[0] = true;
+
+	unregister_run(&test, data);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -435,6 +652,14 @@ int main(int argc, char *argv[])
 							test_unregister_all);
 	g_test_add_data_func("/mgmt/unregister/2", &event_test_1,
 							test_unregister_index);
+	g_test_add_data_func("/mgmt/unregister/3", &event_test_1,
+							test_unregister_self);
+	g_test_add_data_func("/mgmt/unregister/4", &event_test_1,
+							test_unregister_next);
+	g_test_add_data_func("/mgmt/unregister/5", &event_test_1,
+							test_unregister_id_all);
+	g_test_add_data_func("/mgmt/unregister/6", &event_test_1,
+							test_unregister_direct);
 
 	g_test_add_data_func("/mgmt/destroy/1", &event_test_1, test_destroy);
 
-- 
2.43.0

