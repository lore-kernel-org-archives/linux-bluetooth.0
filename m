Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] obexd: Fix compilation error on newer glibc
Date: Thu,  2 Nov 2017 15:11:00 +0100
Message-Id: <20171102141100.21883-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since this glibc commit:
https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=37f802f86400684c8d13403958b2c598721d6360

glibc doesn't include declare ssize_t when fcntl.h is included (fcntl.h
included <bits/uio.h> which includes <sys/types.h>).

This fixes the following compile-time error:

In file included from obexd/plugins/mas.c:41:0:
./obexd/src/obex.h:37:1: error: unknown type name ‘ssize_t’; did you mean ‘size_t’?
 ssize_t obex_get_size(struct obex_session *os);
 ^~~~~~~
---
 obexd/src/obex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/src/obex.h b/obexd/src/obex.h
index fc1674755..67593f11b 100644
--- a/obexd/src/obex.h
+++ b/obexd/src/obex.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <unistd.h>
+
 #define OBJECT_SIZE_UNKNOWN -1
 #define OBJECT_SIZE_DELETE -2
 
-- 
2.14.3

