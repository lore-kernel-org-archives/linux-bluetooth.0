Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684049;
	b=BQtj7MdaMe6sNVE/LKVMHWwOzXURWWiet991xvE8269qXjtnWcZeUl39Grl5LcG1zMr3
	 5WruYoopxHcJA7rclCNCioN+Bg1ilGjeyAVpMJm6fg0q5DEpYTS2cGxfFa1kpy1Vu6BKZ
	 4Xr52l1W+bPJLSBt8rBbZ9oLtexyupeEVENrEp3qVo6lt4/Dg2sKBxIYN46yTcgGfufwy
	 Jt7ERwORyhWuxiy6WtmXNw2yKpZ5vp2Jx2HVOXnQxsiGDcG7qLknzgRxhw7Om+gVshNbM
	 C6uAjWBsiPSW7npnyT9BB9iZvZl04Id5dM4WnzcRDzAs/oDGmyXvI6JR//Oev2jJEFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=spa9b+LnU33u2RivsdBMkFFs/uV7kw1N0UVsjGQmyTU=;
	b=iwhUvwRiNKoExR/EptV6KnJWQ9qwAyObGX31sJZuHC49zZwiXviOfabJC7WpUQ+PpJTX
	 KYErlwHdmXHF/35t/kPJVgpXzLhI8H9BJFdkPcVLyYmzi/ny0lWruQ+Re0uVc0Y92DfbX
	 VhCROLpiPp5j48lMf3bdIInwav8IDCyO4kLkSm1S0OTyvlSAO3B/ABAqLhr+nF5VjIogC
	 GTlcIDy5MJ7meyjs7Fx44IQlU7cOO/YlHc2FMdNhz/ogQqjclm4szji6rim+dC5RqOVFV
	 yzmDYmHcT4n3FtAVX7y8gPetM0VNo2d8TKIdhY4LUmWeNcaiNAqxn+KvxvRenu2FMsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sQ+OYKcE;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA6606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EA6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sQ+OYKcE
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so816e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684047; x=1793288847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=spa9b+LnU33u2RivsdBMkFFs/uV7kw1N0UVsjGQmyTU=;
        b=sQ+OYKcEwBQgsQOaE22w5LPhgjHrehb4U2TDEnm9m4ZaG04d4x/CtHh8VFN8Dp1HVX
         1aCzYL8Q8zna4+qulGSxcHeWbVBOn/SHXrwBiI0ywj33gTwUSuFlwb7fQad8g2BFokPU
         hC7+m+ky3fz5Xn8UqP3HBrkmBxRP4h6BbJ6+9vmff5LKh29D469EBScdEhc+XNvks2hB
         gR9UIl8ybre5yrwAF2pLrNpWtZBFf0Sw2elaTK6Y4tKhECKfFblQrkeGogR7fUUVpXEN
         AjYNlT5/UN/eEDxcIuxr3lTekAq7ukWaxctuZIrcNPTRNcZXfJx8yh/q1XV9XVjreG6u
         DxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684047; x=1793288847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=spa9b+LnU33u2RivsdBMkFFs/uV7kw1N0UVsjGQmyTU=;
        b=TKyOOPlLfE7eiZnUws5ZUDhev2vGR2zWN3OlxOetR4PnePZi4TH+8m12wzo7PTHskz
         80iK6A8HXsied2duD91NYqYWHLiu8PhmiyMehKLgJuAC04WIbu+kg4uNoUjk943gpxvL
         iEtH7JrUqqZHWh11Q39+732iNfU5qHClEg+K54N57HGFvIwc1G5dzciLnRnp3Piw0gvK
         4t4828gW/hpADvJdmZr+MP4D7qi7PoqXpyxLX25mMx+8cTEczUrVNhuec2NfHpsRy4Ve
         IJ7v0PU7l9kcxjzR7pxuw0jzpoRUjEsoFp1owheRQHKzAZwnjJeU0WPOY5+bX7nq+ZBg
         YjSg==
X-Gm-Message-State: AFq9FYJv27oZoGy8lpSFD2rBfl74HTkzKJdsayKh9lBO2SpUgaDyxbss
	OQt2YlhiiVUgPy6D2eJsBQbQ4jR2j/Bt64fZxm0B3g4gzuTiEYV31KEd5HjRs/4ck0Y=
X-Gm-Gg: AYBFou2+7vfQw0y4Lzpaf22Uwh5BQVYMpibExoc7FmwKRl6lYhFnY79lj0S43l95qTh
	unBfeH+ELvOdHcszVXswSshszcueeAa8BUZypkB9qloyDXoZWqY4EtmC6sEi8yzXYfRArg+cx1C
	C6cngYT08Ae4KXGJpJZL5qWtGTHh1WND9uKHixd6FkyZeQyHCVK+jXf9O9rBQ73VMz7Kz/M9SfL
	t/Xqz78zyqvkKx78VbRSYbTuVkKxIsrI1ekpIN7JrodTPmTqxDYZuav0Ut6siYjyzU/E2fqXFGL
	mKwOjfKbaQrOFGdaEJilZrJz6qRvFIbvFR5rKSVpzzldWfsHIf2LX6XVdWiG/50XiZIntR9+R0M
	ti0K6DKyGdUA8J0ZEiWUUzmTzq4jY2rhkXcI+dAQKulATO3kiWtdFdh610V2whrHkTwdgxjNxP7
	fNvTvrsXWOB85M5Odx38ACsl83mKPpCCE8OuoH/BIX+Acrg4ROar9nsnOQkhjaHNSVG8Lw32lBb
	y+zVQjkcrEPuDRvMrAFnyAVQMZjBNOjzthaQ/NYzV/79k5jubop4rqbX2m+zaDZZCOxZLc0xtsT
	xxrx1yvgBOPj5qu+xqjtRK7jyeyv5gsW+raZ2yfszQn7p7NPOvh7AbFXq0+FmW6xG5g=
X-Received: by 2002:a05:6122:e265:b0:5ea:d10f:2394 with SMTP id 71dfb90a1353d-5eaebdb3491mr2458427e0c.10.1792684047307;
        Thu, 22 Oct 2026 08:47:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 19/27] shared/tester: Remove GLib dependency
Date: Thu, 22 Oct 2026 11:46:52 -0400
Message-ID: <20261022154701.3959500-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use timeout_add() with 0 for the idle callbacks, struct queue for the
tests, CLOCK_MONOTONIC for the execution times and getopt_long() for the
options, and build it into libshared-mainloop as well, so testers can
run on the mainloop instead of GLib.

GLib's main loop reads the clock for every source on every iteration,
which under User Mode Linux is a system call through the host, about 6
us each: it was 78% of the system calls of mgmt-tester, 1.2 million in
one run.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.am         |   3 +-
 src/shared/tester.c | 250 +++++++++++++++++++++++++++-----------------
 2 files changed, 156 insertions(+), 97 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 453cc7c584e4..f8821a109b49 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -272,7 +272,8 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/timeout-mainloop.c \
 				src/shared/mainloop.h src/shared/mainloop.c \
 				src/shared/mainloop-notify.h \
-				src/shared/mainloop-notify.c
+				src/shared/mainloop-notify.c \
+				src/shared/tester.c
 src_libshared_mainloop_la_LDFLAGS = $(AM_LDFLAGS)
 src_libshared_mainloop_la_CFLAGS = $(AM_CFLAGS)
 
diff --git a/src/shared/tester.c b/src/shared/tester.c
index 4065545793aa..72b280a1f3d5 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -20,11 +20,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <getopt.h>
+#include <time.h>
 #include <sys/signalfd.h>
 #include <sys/socket.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
 
@@ -38,6 +38,7 @@
 #include "src/shared/tester.h"
 #include "src/shared/log.h"
 #include "src/shared/timeout.h"
+#include "src/shared/queue.h"
 
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_BLACK	"\x1B[0;30m"
@@ -90,8 +91,8 @@ struct test_case {
 	tester_data_func_t teardown_func;
 	tester_data_func_t post_teardown_func;
 	tester_data_func_t io_complete_func;
-	gdouble start_time;
-	gdouble end_time;
+	double start_time;
+	double end_time;
 	unsigned int timeout;
 	unsigned int timeout_id;
 	unsigned int teardown_id;
@@ -101,15 +102,16 @@ struct test_case {
 
 static char *tester_name;
 
-static GList *test_list;
-static GList *test_current;
-static GTimer *test_timer;
+static struct queue *test_list;
+static const struct queue_entry *test_current;
+static double test_timer_start;
+static double test_timer_stop;
 
-static gboolean option_version = FALSE;
-static gboolean option_quiet = FALSE;
-static gboolean option_debug = FALSE;
-static gboolean option_monitor = FALSE;
-static gboolean option_list = FALSE;
+static bool option_version;
+static bool option_quiet;
+static bool option_debug;
+static bool option_monitor;
+static bool option_list;
 static const char *option_prefix = NULL;
 static const char *option_string = NULL;
 
@@ -126,7 +128,20 @@ struct monitor_l2cap_hdr {
 	uint16_t psm;
 } __attribute__((packed));
 
-static void test_destroy(gpointer data)
+/* Seconds since tester_run(), on the clock the timeouts use */
+static double test_timer_elapsed(void)
+{
+	struct timespec ts;
+
+	if (test_timer_stop)
+		return test_timer_stop - test_timer_start;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+
+	return ts.tv_sec + ts.tv_nsec / 1e9 - test_timer_start;
+}
+
+static void test_destroy(void *data)
 {
 	struct test_case *test = data;
 
@@ -134,7 +149,7 @@ static void test_destroy(gpointer data)
 		timeout_remove(test->timeout_id);
 
 	if (test->teardown_id > 0)
-		g_source_remove(test->teardown_id);
+		timeout_remove(test->teardown_id);
 
 	if (test->destroy)
 		test->destroy(test->user_data);
@@ -285,7 +300,8 @@ void tester_add_full(const char *name, const void *test_data,
 	if (!test_func)
 		return;
 
-	if (option_prefix && !g_str_has_prefix(name, option_prefix)) {
+	if (option_prefix && strncmp(name, option_prefix,
+						strlen(option_prefix))) {
 		if (destroy)
 			destroy(user_data);
 		return;
@@ -338,7 +354,7 @@ void tester_add_full(const char *name, const void *test_data,
 	test->destroy = destroy;
 	test->user_data = user_data;
 
-	test_list = g_list_append(test_list, test);
+	queue_push_tail(test_list, test);
 }
 
 void tester_add(const char *name, const void *test_data,
@@ -371,17 +387,17 @@ void *tester_get_data(void)
 static int tester_summarize(void)
 {
 	unsigned int not_run = 0, passed = 0, failed = 0;
-	gdouble execution_time;
-	GList *list;
+	double execution_time;
+	const struct queue_entry *list;
 
 	tester_log("");
 	print_text(COLOR_HIGHLIGHT, "");
 	print_text(COLOR_HIGHLIGHT, "Test Summary");
 	print_text(COLOR_HIGHLIGHT, "------------");
 
-	for (list = g_list_first(test_list); list; list = g_list_next(list)) {
+	for (list = queue_get_entries(test_list); list; list = list->next) {
 		struct test_case *test = list->data;
-		gdouble exec_time;
+		double exec_time;
 
 		exec_time = test->end_time - test->start_time;
 
@@ -417,22 +433,22 @@ static int tester_summarize(void)
 			(float) passed * 100 / (not_run + passed + failed) : 0,
 			failed, not_run);
 
-	execution_time = g_timer_elapsed(test_timer, NULL);
+	execution_time = test_timer_elapsed();
 	tester_log("Overall execution time: %.3g seconds", execution_time);
 
 	return failed;
 }
 
-static gboolean done_callback(gpointer user_data);
+static bool done_callback(void *user_data);
 
-static bool teardown_timeout(gpointer user_data)
+static bool teardown_timeout(void *user_data)
 {
 	struct test_case *test = user_data;
 
 	test->timeout_id = 0;
 
 	if (!test_current || test_current->data != test)
-		return FALSE;
+		return false;
 
 	/* Give up waiting, e.g. for an index that was never added to be
 	 * removed, rather than blocking for good. Its callbacks may still
@@ -448,9 +464,9 @@ static bool teardown_timeout(gpointer user_data)
 	while (test_current->next)
 		test_current = test_current->next;
 
-	g_idle_add(done_callback, test);
+	timeout_add(0, done_callback, test, NULL);
 
-	return FALSE;
+	return false;
 }
 
 /* Teardown may have to wait for the kernel to time out commands still sent
@@ -472,7 +488,7 @@ static void teardown_timeout_start(struct test_case *test)
 					teardown_timeout, test, NULL);
 }
 
-static gboolean teardown_callback(gpointer user_data)
+static bool teardown_callback(void *user_data)
 {
 	struct test_case *test = user_data;
 
@@ -488,24 +504,24 @@ static gboolean teardown_callback(gpointer user_data)
 	VALGRIND_DO_ADDED_LEAK_CHECK;
 #endif
 
-	return FALSE;
+	return false;
 }
 
-static bool test_timeout(gpointer user_data)
+static bool test_timeout(void *user_data)
 {
 	struct test_case *test = user_data;
 
 	test->timeout_id = 0;
 
 	if (!test_current)
-		return FALSE;
+		return false;
 
 	test->result = TEST_RESULT_TIMED_OUT;
 	print_progress(test->name, COLOR_RED, "test timed out");
 
-	g_idle_add(teardown_callback, test);
+	timeout_add(0, teardown_callback, test, NULL);
 
-	return FALSE;
+	return false;
 }
 
 static void next_test_case(void)
@@ -513,12 +529,12 @@ static void next_test_case(void)
 	struct test_case *test;
 
 	if (test_current)
-		test_current = g_list_next(test_current);
+		test_current = test_current->next;
 	else
-		test_current = test_list;
+		test_current = queue_get_entries(test_list);
 
 	if (!test_current) {
-		g_timer_stop(test_timer);
+		test_timer_stop = test_timer_elapsed() + test_timer_start;
 
 		mainloop_quit();
 		return;
@@ -529,7 +545,7 @@ static void next_test_case(void)
 	tester_log("");
 	print_progress(test->name, COLOR_BLACK, "init");
 
-	test->start_time = g_timer_elapsed(test_timer, NULL);
+	test->start_time = test_timer_elapsed();
 
 	if (test->timeout > 0)
 		test->timeout_id = timeout_add_seconds(test->timeout,
@@ -541,7 +557,7 @@ static void next_test_case(void)
 	test->pre_setup_func(test->test_data);
 }
 
-static gboolean setup_callback(gpointer user_data)
+static bool setup_callback(void *user_data)
 {
 	struct test_case *test = user_data;
 
@@ -550,10 +566,10 @@ static gboolean setup_callback(gpointer user_data)
 	print_progress(test->name, COLOR_BLUE, "setup");
 	test->setup_func(test->test_data);
 
-	return FALSE;
+	return false;
 }
 
-static gboolean run_callback(gpointer user_data)
+static bool run_callback(void *user_data)
 {
 	struct test_case *test = user_data;
 
@@ -562,19 +578,19 @@ static gboolean run_callback(gpointer user_data)
 	print_progress(test->name, COLOR_BLACK, "run");
 	test->test_func(test->test_data);
 
-	return FALSE;
+	return false;
 }
 
-static gboolean done_callback(gpointer user_data)
+static bool done_callback(void *user_data)
 {
 	struct test_case *test = user_data;
 
-	test->end_time = g_timer_elapsed(test_timer, NULL);
+	test->end_time = test_timer_elapsed();
 
 	print_progress(test->name, COLOR_BLACK, "done");
 	next_test_case();
 
-	return FALSE;
+	return false;
 }
 
 void tester_pre_setup_complete(void)
@@ -589,7 +605,7 @@ void tester_pre_setup_complete(void)
 	if (test->stage != TEST_STAGE_PRE_SETUP)
 		return;
 
-	g_idle_add(setup_callback, test);
+	timeout_add(0, setup_callback, test, NULL);
 }
 
 void tester_pre_setup_failed(void)
@@ -613,7 +629,7 @@ void tester_pre_setup_failed(void)
 
 	print_progress(test->name, COLOR_RED, "pre setup failed");
 
-	g_idle_add(done_callback, test);
+	timeout_add(0, done_callback, test, NULL);
 }
 
 void tester_pre_setup_abort(void)
@@ -635,7 +651,7 @@ void tester_pre_setup_abort(void)
 
 	print_progress(test->name, COLOR_YELLOW, "not run");
 
-	g_idle_add(done_callback, test);
+	timeout_add(0, done_callback, test, NULL);
 }
 
 bool tester_pre_setup_skip_by_default(void)
@@ -662,7 +678,7 @@ void tester_setup_complete(void)
 
 	print_progress(test->name, COLOR_BLUE, "setup complete");
 
-	g_idle_add(run_callback, test);
+	timeout_add(0, run_callback, test, NULL);
 }
 
 void tester_setup_failed(void)
@@ -729,7 +745,7 @@ static void test_result(enum test_result result)
 	if (test->teardown_id > 0)
 		return;
 
-	test->teardown_id = g_idle_add(teardown_callback, test);
+	test->teardown_id = timeout_add(0, teardown_callback, test, NULL);
 }
 
 void tester_test_passed(void)
@@ -800,7 +816,7 @@ void tester_post_teardown_complete(void)
 
 	print_progress(test->name, COLOR_MAGENTA, "teardown complete");
 
-	g_idle_add(done_callback, test);
+	timeout_add(0, done_callback, test, NULL);
 }
 
 void tester_post_teardown_failed(void)
@@ -822,16 +838,19 @@ void tester_post_teardown_failed(void)
 
 	print_progress(test->name, COLOR_RED, "teardown failed");
 
-	g_idle_add(done_callback, test);
+	timeout_add(0, done_callback, test, NULL);
 }
 
-static gboolean start_tester(gpointer user_data)
+static bool start_tester(void *user_data)
 {
-	test_timer = g_timer_new();
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	test_timer_start = ts.tv_sec + ts.tv_nsec / 1e9;
 
 	next_test_case();
 
-	return FALSE;
+	return false;
 }
 
 struct wait_data {
@@ -841,7 +860,7 @@ struct wait_data {
 	void *user_data;
 };
 
-static gboolean wait_callback(gpointer user_data)
+static bool wait_callback(void *user_data)
 {
 	struct wait_data *wait = user_data;
 	struct test_case *test = wait->test;
@@ -851,7 +870,7 @@ static gboolean wait_callback(gpointer user_data)
 	if (wait->seconds > 0) {
 		print_progress(test->name, COLOR_BLACK, "%u seconds left",
 								wait->seconds);
-		return TRUE;
+		return true;
 	}
 
 	print_progress(test->name, COLOR_BLACK, "waiting done");
@@ -860,7 +879,7 @@ static gboolean wait_callback(gpointer user_data)
 
 	free(wait);
 
-	return FALSE;
+	return false;
 }
 
 void tester_wait(unsigned int seconds, tester_wait_func_t func,
@@ -883,7 +902,7 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 	wait->func = func;
 	wait->user_data = user_data;
 
-	g_timeout_add(1000, wait_callback, wait);
+	timeout_add(1000, wait_callback, wait, NULL);
 
 	print_progress(test->name, COLOR_BLACK, "waiting %u seconds", seconds);
 }
@@ -905,53 +924,88 @@ static void signal_callback(int signum, void *user_data)
 
 bool tester_use_quiet(void)
 {
-	return option_quiet == TRUE ? true : false;
+	return option_quiet;
 }
 
 bool tester_use_debug(void)
 {
-	return option_debug == TRUE ? true : false;
+	return option_debug;
 }
 
-static GOptionEntry options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
-	{ "quiet", 'q', 0, G_OPTION_ARG_NONE, &option_quiet,
-				"Run tests without logging" },
-	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_debug,
-				"Run tests with debug output" },
-	{ "monitor", 'm', 0, G_OPTION_ARG_NONE, &option_monitor,
-				"Enable monitor output" },
-	{ "list", 'l', 0, G_OPTION_ARG_NONE, &option_list,
-				"Only list the tests to be run" },
-	{ "prefix", 'p', 0, G_OPTION_ARG_STRING, &option_prefix,
-				"Run tests matching provided prefix" },
-	{ "string", 's', 0, G_OPTION_ARG_STRING, &option_string,
-				"Run tests matching provided string" },
-	{ NULL },
+static const struct option options[] = {
+	{ "version",	no_argument,		NULL, 'v' },
+	{ "quiet",	no_argument,		NULL, 'q' },
+	{ "debug",	no_argument,		NULL, 'd' },
+	{ "monitor",	no_argument,		NULL, 'm' },
+	{ "list",	no_argument,		NULL, 'l' },
+	{ "prefix",	required_argument,	NULL, 'p' },
+	{ "string",	required_argument,	NULL, 's' },
+	{ "help",	no_argument,		NULL, 'h' },
+	{ }
 };
 
+static void usage(const char *name)
+{
+	printf("Usage:\n"
+		"\t%s [options]\n"
+		"Options:\n"
+		"\t-v, --version          Show version information and exit\n"
+		"\t-q, --quiet            Run tests without logging\n"
+		"\t-d, --debug            Run tests with debug output\n"
+		"\t-m, --monitor          Enable monitor output\n"
+		"\t-l, --list             Only list the tests to be run\n"
+		"\t-p, --prefix=<prefix>  Run tests matching provided prefix\n"
+		"\t-s, --string=<string>  Run tests matching provided string\n"
+		"\t-h, --help             Show help options\n", name);
+}
+
 void tester_init(int *argc, char ***argv)
 {
-	GOptionContext *context;
-	GError *error = NULL;
+	int opt, i;
 
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, options, NULL);
+	for (;;) {
+		opt = getopt_long(*argc, *argv, "vqdmlp:s:h", options, NULL);
+		if (opt < 0)
+			break;
 
-	if (g_option_context_parse(context, argc, argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
+		switch (opt) {
+		case 'v':
+			option_version = true;
+			break;
+		case 'q':
+			option_quiet = true;
+			break;
+		case 'd':
+			option_debug = true;
+			break;
+		case 'm':
+			option_monitor = true;
+			break;
+		case 'l':
+			option_list = true;
+			break;
+		case 'p':
+			option_prefix = optarg;
+			break;
+		case 's':
+			option_string = optarg;
+			break;
+		case 'h':
+			usage((*argv)[0]);
+			exit(EXIT_SUCCESS);
+		default:
+			exit(EXIT_FAILURE);
+		}
 	}
 
-	g_option_context_free(context);
+	/* Leave the program name and the arguments that are not options */
+	for (i = optind; i < *argc; i++)
+		(*argv)[i - optind + 1] = (*argv)[i];
+	*argc -= optind - 1;
+	(*argv)[*argc] = NULL;
 
-	if (option_version == TRUE) {
-		g_print("%s\n", VERSION);
+	if (option_version) {
+		printf("%s\n", VERSION);
 		exit(EXIT_SUCCESS);
 	}
 
@@ -963,7 +1017,7 @@ void tester_init(int *argc, char ***argv)
 	else
 		tester_name = strdup(++tester_name);
 
-	test_list = NULL;
+	test_list = queue_new();
 	test_current = NULL;
 }
 
@@ -1029,7 +1083,8 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);
 
-	g_assert_cmpint(len, ==, iov->iov_len);
+	if (len != (ssize_t) iov->iov_len)
+		abort();
 
 	if (!test->iovcnt && test->io_complete_func) {
 		test->io_complete_func(test->test_data);
@@ -1053,7 +1108,8 @@ static bool test_io_recv(struct io *io, void *user_data)
 
 	len = read(fd, buf, sizeof(buf));
 
-	g_assert(len > 0);
+	if (len <= 0)
+		abort();
 
 	tester_monitor('>', 0x0004, 0x0000, buf, len);
 
@@ -1067,9 +1123,11 @@ static bool test_io_recv(struct io *io, void *user_data)
 		tester_monitor('!', 0x0004, 0x0000, iov->iov_base,
 							iov->iov_len);
 
-	g_assert_cmpint(len, ==, iov->iov_len);
+	if (len != (ssize_t) iov->iov_len)
+		abort();
 
-	g_assert(memcmp(buf, iov->iov_base, len) == 0);
+	if (memcmp(buf, iov->iov_base, len))
+		abort();
 
 	if (test->iovcnt)
 		io_set_write_handler(io, test_io_send, NULL, NULL);
@@ -1160,13 +1218,13 @@ int tester_run(void)
 		return EXIT_SUCCESS;
 	}
 
-	g_idle_add(start_tester, NULL);
+	timeout_add(0, start_tester, NULL, NULL);
 
 	mainloop_run_with_signal(signal_callback, NULL);
 
 	ret = tester_summarize();
 
-	g_list_free_full(test_list, test_destroy);
+	queue_destroy(test_list, test_destroy);
 
 	if (option_monitor)
 		bt_log_close();
-- 
2.56.0

