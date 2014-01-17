Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <natanael.copa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 3/3] unit: prevent use of glibc's error(3)
Date: Fri, 17 Jan 2014 12:08:26 +0000
Message-Id: <1389960506-10273-3-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
References: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When building the test-sdp we don't want src/sdpd-request.c end up
using the incompatible GNU libc's error(3).

This also fixes building on musl libc which misses the error(3) GNU
extension.
---
 unit/test-sdp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 6d699e2..eeed0cb 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -134,6 +134,12 @@ void btd_debug(const char *format, ...)
 {
 }
 
+void error(const char *format, ...);
+
+void error(const char *format, ...)
+{
+}
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
-- 
1.8.5.3

