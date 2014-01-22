Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <natanael.copa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2 3/3] unit: prevent use of glibc's error(3)
Date: Wed, 22 Jan 2014 13:50:20 +0000
Message-Id: <1390398620-1916-4-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
 <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When building the test-sdp we don't want src/sdpd-request.c end up
using the incompatible GNU libc's error(3).

This also fixes the following compile error with musl libc which
misses the error(3) GNU extension:

src/sdpd-request.o: In function `extract_des':
/home/ncopa/src/bluez/src/sdpd-request.c:126: undefined reference to `error'
src/sdpd-request.o: In function `process_request':
/home/ncopa/src/bluez/src/sdpd-request.c:1022: undefined reference to `error'
/home/ncopa/src/bluez/src/sdpd-request.c:1045: undefined reference to `error'
---
 Makefile.am     | 1 +
 unit/test-sdp.c | 9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 917f545..a05cacc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -251,6 +251,7 @@ unit_tests += unit/test-sdp
 unit_test_sdp_SOURCES = unit/test-sdp.c \
 				src/shared/util.h src/shared/util.c \
 				src/sdpd.h src/sdpd-database.c \
+				src/log.h src/log.c \
 				src/sdpd-service.c src/sdpd-request.c
 unit_test_sdp_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 6d699e2..ba0e637 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -128,12 +128,6 @@ static void sdp_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
-void btd_debug(const char *format, ...);
-
-void btd_debug(const char *format, ...)
-{
-}
-
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -797,6 +791,9 @@ int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
+	if (g_test_verbose())
+		__btd_log_init("*", 0);
+
 	/*
 	 * Service Search Request
 	 *
-- 
1.8.5.3

