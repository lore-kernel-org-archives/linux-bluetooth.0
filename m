Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FF2F7445
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708498; cv=pass; b=LhH13WZ36MfXGtEUJ0T/OYDO1WlAAdIO0OVLrqCBzXtUBYkZCGeGyzoTbO/SCIW47GAaD78hZU26Ird7e4JELXEe9rWqcfEm22qYyP3IOiBLkxOVAmqFjaQdLmuPmsUsqGXgJpEH3dz+s05tEcQKRJlNsK4XOQAbFRW2/xn1Edg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708498; c=relaxed/simple;
	bh=4qgbBIBOct5BMbNNXoqfGp8iPXscbumiGeoTKfj8Qq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TugohLnAoRpZPd7mtFtSaATqIPXbJ7Tvq7SzdtbZZZBdogeY0qglf/fj/5gwrR6M1LH8zVursdjRusmbXZ5izs98FaZpxfkJtpgn2cjbDWX6paXofQuqA6ahZ8fqk1HwZes8DACNngQS82TicIELCFFPJB3GyfaAUzzYpOIL5go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RUHc3f/w; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=e/ZMgFDM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RUHc3f/w";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="e/ZMgFDM"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dLXsb19pdz49Q7m
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 22:48:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764708483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KdhHgQMAe4BWL8C5WJhGKRj7o8PisUYelbuNuCj3g=;
	b=RUHc3f/wj5Mp4BGkO458kQ86Hek2Ly0sbk3zSsBqBJLW7xUwIzMehyAfneRHJfUse64QQd
	VLHnMTG4hHdXIgK+SSczusM0aTUFFae9i+cA1P8KToprOS2nmHu9tQo+eBB9lCsZhQLA0O
	DHPrE/e2flnRaglVABQBoMGY8vgDEKtTEwZFPUT1oQ9bFVS+KIH4Tr73wrHnrw9J+6007E
	CRJOBFe3vvEycTFF2Rf2hCaznb4VCPq1PXOXufJwn0QPtxUa9h11qLmnj0K35TjHxhTWAI
	9MT0qz4d7+CtCzyS4orFl2Gknd4h6hoFwKIMHAPcwTcEGvkR8O0mysEZ6TDbRg==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsQ5HP9z107f;
	Tue,  2 Dec 2025 22:47:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KdhHgQMAe4BWL8C5WJhGKRj7o8PisUYelbuNuCj3g=;
	b=e/ZMgFDMlGqdui/CqN5+PhSNzOCfHj8LsdHHZD/AV6H/13lJvGR8yJFGcO4m4f3Zek3ync
	y+fiiic9OiSpyvYStxGbaVaBreJpL9GazlhVxwvW8+03xTFYwgbIfSrfW7I5Rmux6CaEeF
	o9KPvYR2OhBaF176zbxzFAhGfvhB//U=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708474;
	b=DiRHhFb/KWf6erLF2kIFyHnB1ZsHJdHBztCp5EUZVY+8RcLmv/Q9FyOt5oKb8U2Q3Ps9TS
	CAq+xT5i5d85iocyhgo4vZE8xrJbXheXh+OH9YlQUCsDn6rKZNLg8qW+zNrqcAbQb3zh7d
	6t9q3eE/YYhh2/+cm2Suo3NyYAI7Nsw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KdhHgQMAe4BWL8C5WJhGKRj7o8PisUYelbuNuCj3g=;
	b=FU/7K/J7+EqZ0sVq2uueDO0JYTFX+u7220JcbdD3XrDCcf8L3FmVKrOiHH8p+4lc05EqPw
	oQCo1d34EILQ4Ft/tiuLOGu6HHrz2xgS80J1k8sCfUW/vtw9qYbWNtux5A+FXocUe5fYJd
	nDkMJ03h2jDISpd/fKVa5489CGhmfKA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/7] test-profile: add tests for profile sorting
Date: Tue,  2 Dec 2025 22:47:47 +0200
Message-ID: <b93c49b85f27bc15e393b0f9bb46b7fb88c5632e.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
References: <cover.1764708372.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to check btd_profile_sort_list() works correctly.

The test uses queue instead of GSList in case device.c is converted to
use queue later.

Makefile.am: separate out bluetoothd_internal_sources (excludes plugins
& main.c) and add stub for symbols in main.c.  The profile.c pulls in
large parts of these so it's simpler to depend on them all for the test.
This doesn't cause any recompilation.
---

Notes:
    v3:
    - new commit

 .gitignore          |   1 +
 Makefile.am         |  22 ++-
 unit/btd.c          |  41 ++++++
 unit/test-profile.c | 344 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 403 insertions(+), 5 deletions(-)
 create mode 100644 unit/btd.c
 create mode 100644 unit/test-profile.c

diff --git a/.gitignore b/.gitignore
index ba29d9d5e..80427e1dd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -120,6 +120,7 @@ unit/test-bass
 unit/test-battery
 unit/test-tmap
 unit/test-gmap
+unit/test-profile
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index 7221e4cba..e152ae648 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -304,9 +304,9 @@ include Makefile.plugins
 
 pkglibexec_PROGRAMS += src/bluetoothd
 
-src_bluetoothd_SOURCES = $(builtin_sources) \
+bluetoothd_internal_sources = \
 			$(attrib_sources) $(btio_sources) \
-			src/main.c src/log.h src/log.c \
+			src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
@@ -316,7 +316,6 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/sdp-client.h src/sdp-client.c \
 			src/textfile.h src/textfile.c \
 			src/uuid-helper.h src/uuid-helper.c \
-			src/plugin.h src/plugin.c \
 			src/storage.h src/storage.c \
 			src/advertising.h src/advertising.c \
 			src/agent.h src/agent.c \
@@ -333,10 +332,17 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/settings.h src/settings.c \
 			src/set.h src/set.c \
 			src/bearer.h src/bearer.c
-src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
+
+bluetoothd_internal_ldadd = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
-			$(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt \
+			$(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
+
+src_bluetoothd_SOURCES = $(builtin_sources) \
+			$(bluetoothd_internal_sources) \
+			src/plugin.h src/plugin.c \
+			src/main.c
+src_bluetoothd_LDADD = $(bluetoothd_internal_ldadd) \
 			$(builtin_ldadd)
 
 if EXTERNAL_PLUGINS
@@ -576,6 +582,12 @@ unit_tests += unit/test-uhid
 unit_test_uhid_SOURCES = unit/test-uhid.c
 unit_test_uhid_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-profile
+
+unit_test_profile_SOURCES = unit/test-profile.c \
+			unit/btd.c $(bluetoothd_internal_sources)
+unit_test_profile_LDADD = $(bluetoothd_internal_ldadd)
+
 unit_tests += unit/test-sdp
 
 unit_test_sdp_SOURCES = unit/test-sdp.c \
diff --git a/unit/btd.c b/unit/btd.c
new file mode 100644
index 000000000..06b2a1220
--- /dev/null
+++ b/unit/btd.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+/* Stub replacement for daemon main.c for tests */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "../src/btd.h"
+
+struct btd_opts btd_opts;
+
+GKeyFile *btd_get_main_conf(void)
+{
+	return NULL;
+}
+
+bool btd_kernel_experimental_enabled(const char *uuid)
+{
+	return false;
+}
+
+void btd_exit(void)
+{
+}
diff --git a/unit/test-profile.c b/unit/test-profile.c
new file mode 100644
index 000000000..31c96596e
--- /dev/null
+++ b/unit/test-profile.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/tester.h"
+
+#include "src/adapter.h"
+#include "src/profile.h"
+
+#define FAIL_TEST() \
+	do { tester_warn("%s:%d: failed in %s", __FILE__, __LINE__, __func__); \
+		tester_test_failed(); } while (0)
+
+struct test_config {
+	const struct btd_profile *profiles;
+	unsigned int profiles_count;
+	unsigned int shuffle_count;
+	const char *cycle_break;
+};
+
+struct test_data {
+	const struct test_config *cfg;
+};
+
+#define define_test(name, _cfg, setup, function)		\
+	do {							\
+		static struct test_data data;			\
+		data.cfg = _cfg;				\
+		tester_add(name, &data, setup, function,	\
+						test_teardown);	\
+	} while (0)
+
+static void test_teardown(const void *user_data)
+{
+	tester_teardown_complete();
+}
+
+#define SORT_PROFILE(expect_pos_, ...) \
+	{ .name = UINT_TO_PTR(expect_pos_), __VA_ARGS__ }
+#define AFTER(...) \
+	.after_services = BTD_PROFILE_UUID_CB(NULL, __VA_ARGS__)
+
+const struct test_config sort_priority = {
+	.profiles = (const struct btd_profile []) {
+		SORT_PROFILE(3, .priority = 1),
+		SORT_PROFILE(4, .priority = 1),
+		SORT_PROFILE(1, .priority = 2),
+		SORT_PROFILE(5, .priority = 0),
+		SORT_PROFILE(2, .priority = 2),
+		SORT_PROFILE(6, .priority = 0),
+	},
+	.profiles_count = 6,
+};
+
+const struct test_config sort_after_service = {
+	.profiles = (const struct btd_profile []) {
+		SORT_PROFILE(4, .priority = 1, AFTER("B", "C")),
+		SORT_PROFILE(3, .priority = 1, .remote_uuid = "C"),
+		SORT_PROFILE(2, .priority = 2, AFTER("B")),
+		SORT_PROFILE(1, .priority = 2, .remote_uuid = "B"),
+		SORT_PROFILE(6, .priority = 0),
+		SORT_PROFILE(5, .priority = 1, AFTER("invalid")),
+	},
+	.profiles_count = 6,
+};
+
+const struct test_config sort_cycle = {
+	.profiles = (const struct btd_profile []) {
+		SORT_PROFILE(2, .remote_uuid = "B", AFTER("F")),
+		SORT_PROFILE(4, .remote_uuid = "D", AFTER("A", "C")),
+		SORT_PROFILE(5, .remote_uuid = "E", AFTER("D")),
+		SORT_PROFILE(3, .remote_uuid = "C", AFTER("B")),
+		SORT_PROFILE(6, .remote_uuid = "F", AFTER("E")),
+		SORT_PROFILE(1, .remote_uuid = "A"),
+	},
+	.profiles_count = 6,
+	.cycle_break = "F",
+};
+
+const struct test_config sort_fuzz = {
+	.profiles_count = 50,
+	.shuffle_count = 100,
+};
+
+static const struct btd_profile *sort_get(void *item, void *user_data)
+{
+	return item;
+}
+
+static bool check_sort(struct queue *list, unsigned int count,
+							const char *cycle_break)
+{
+	int priority = INT_MAX;
+	GHashTable *uuids, *items;
+	const struct queue_entry *entry;
+	unsigned int n;
+
+	uuids = g_hash_table_new(g_str_hash, g_str_equal);
+	items = g_hash_table_new(NULL, NULL);
+
+	if (queue_length(list) != count) {
+		FAIL_TEST();
+		return false;
+	}
+
+	for (entry = queue_get_entries(list), n = 0; entry;
+						entry = entry->next, ++n) {
+		const struct btd_profile *profile = entry->data;
+
+		g_hash_table_add(uuids, (void *)profile->remote_uuid);
+	}
+
+	if (cycle_break)
+		g_hash_table_remove(uuids, (void *)cycle_break);
+
+	for (entry = queue_get_entries(list), n = 0; entry;
+						entry = entry->next, ++n) {
+		const struct btd_profile *profile = entry->data;
+		unsigned int i;
+
+		/* No duplicates */
+		if (g_hash_table_contains(items, profile)) {
+			FAIL_TEST();
+			return false;
+		}
+		g_hash_table_add(items, (void *)profile);
+
+		/* Decreasing priority */
+		if (profile->priority > priority) {
+			FAIL_TEST();
+			return false;
+		} else if (profile->priority < priority) {
+			priority = profile->priority;
+		}
+
+		/* Ordered by after_services */
+		g_hash_table_remove(uuids, (void *)profile->remote_uuid);
+
+		for (i = 0; i < profile->after_services.count; ++i) {
+			if (g_hash_table_contains(uuids,
+					profile->after_services.uuids[i])) {
+				FAIL_TEST();
+				return false;
+			}
+		}
+
+		/* Manual sort check */
+		if (profile->name && profile->name != UINT_TO_PTR(n + 1)) {
+			FAIL_TEST();
+			return false;
+		}
+	}
+
+	g_hash_table_destroy(uuids);
+	g_hash_table_destroy(items);
+
+	return true;
+}
+
+static struct queue *make_profile_list(const struct btd_profile *profiles,
+							unsigned int count)
+{
+	struct queue *list = queue_new();
+	unsigned int i;
+
+	for (i = 0; i < count; ++i) {
+		struct btd_profile *profile;
+
+		profile = util_memdup(&profiles[i], sizeof(*profile));
+		if (profile->remote_uuid)
+			profile->remote_uuid = g_strdup(profile->remote_uuid);
+		else
+			profile->remote_uuid = g_strdup_printf("%d", i);
+
+		queue_push_tail(list, profile);
+	}
+
+	return list;
+}
+
+static void free_profile_list(struct queue *list)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(list); entry; entry = entry->next) {
+		const struct btd_profile *profile = entry->data;
+
+		g_free((void *)profile->remote_uuid);
+		free((void *)profile);
+	}
+
+	queue_destroy(list, NULL);
+}
+
+static void *queue_peek_nth(struct queue *list, unsigned int i)
+{
+	const struct queue_entry *entry;
+	unsigned int n = 0;
+
+	for (entry = queue_get_entries(list); entry; entry = entry->next, n++) {
+		if (n == i)
+			return entry->data;
+	}
+
+	return NULL;
+}
+
+static void shuffle_list(struct queue *list)
+{
+	struct queue *shuffled = queue_new();
+
+	while (!queue_isempty(list)) {
+		int i = g_random_int_range(0, queue_length(list));
+		void *data = queue_peek_nth(list, i);
+
+		queue_remove(list, data);
+		queue_push_tail(shuffled, data);
+	}
+
+	/* Put back to original list */
+	while (!queue_isempty(shuffled))
+		queue_push_tail(list, queue_pop_head(shuffled));
+	queue_destroy(shuffled, NULL);
+}
+
+static void btd_profile_sort(struct queue *queue, btd_profile_list_get get,
+							void *user_data)
+{
+	const struct queue_entry *entry;
+	GSList *list = NULL, *item;
+
+	for (entry = queue_get_entries(queue); entry; entry = entry->next)
+		list = g_slist_append(list, entry->data);
+
+	list = btd_profile_sort_list(list, get, user_data);
+
+	queue_remove_all(queue, NULL, NULL, NULL);
+
+	for (item = list; item; item = item->next)
+		queue_push_tail(queue, item->data);
+
+	g_slist_free(list);
+}
+
+static void test_sort(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	const struct test_config *cfg = data->cfg;
+	struct queue *list;
+
+	list = make_profile_list(cfg->profiles, cfg->profiles_count);
+
+	btd_profile_sort(list, sort_get, NULL);
+	check_sort(list, cfg->profiles_count, cfg->cycle_break);
+
+	free_profile_list(list);
+	tester_test_passed();
+}
+
+static void test_sort_fuzz(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	const struct test_config *cfg = data->cfg;
+	unsigned int i, j;
+
+	for (i = 0; i < cfg->shuffle_count; ++i) {
+		struct queue *list;
+		struct btd_profile profiles[64] = { 0 };
+		char *uuids[64];
+
+		g_random_set_seed(i);
+
+		for (j = 0; j < ARRAY_SIZE(uuids); ++j)
+			uuids[j] = g_strdup_printf("%d", j);
+
+		for (j = 0; j < cfg->profiles_count; ++j) {
+			int count;
+
+			profiles[j].priority = 3 - 3 * j / cfg->profiles_count;
+
+			if (g_random_int_range(0, 3) == 0 || j == 0)
+				continue;
+
+			count = g_random_int_range(1, j + 1);
+			if (count > 5)
+				count = 5;
+			profiles[j].after_services.count = count;
+			profiles[j].after_services.uuids = (const char **)uuids
+				+ g_random_int_range(0, j + 1 - count);
+		}
+
+		list = make_profile_list(profiles, cfg->profiles_count);
+		shuffle_list(list);
+
+		btd_profile_sort(list, sort_get, NULL);
+		if (!check_sort(list, cfg->profiles_count, NULL))
+			return;
+
+		free_profile_list(list);
+
+		for (j = 0; j < ARRAY_SIZE(uuids); ++j)
+			g_free(uuids[j]);
+	}
+
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	define_test("Sort Priority - Success", &sort_priority, NULL, test_sort);
+	define_test("Sort After Service - Success", &sort_after_service, NULL,
+								test_sort);
+	define_test("Sort Cycle - Success", &sort_cycle, NULL, test_sort);
+	define_test("Sort Fuzz - Success", &sort_fuzz, NULL, test_sort_fuzz);
+
+	return tester_run();
+}
-- 
2.51.1

