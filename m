Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 2/3] unit: prevent unintended use of glibc's error(3)
Date: Fri, 14 Mar 2014 09:59:26 +0000
Message-Id: <1394791167-29933-3-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
References: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When building the test-sdp we don't want src/sdpd-request.c end up
using the incompatible GNU libc's error(3) instead of the intended
src/log.c's error().

This also fixes the following compile error on Alpine Linux with musl
libc which does not implement the error(3) GNU extension:

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
index fb11230..700b956 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -265,6 +265,7 @@ unit_tests += unit/test-sdp
 unit_test_sdp_SOURCES = unit/test-sdp.c \
 				src/shared/util.h src/shared/util.c \
 				src/sdpd.h src/sdpd-database.c \
+				src/log.h src/log.c \
 				src/sdpd-service.c src/sdpd-request.c
 unit_test_sdp_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 9b82343..853576d 100644
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
1.9.0

