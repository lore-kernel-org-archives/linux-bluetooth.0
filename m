Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 1/3] shared: include endian.h for be32toh, htobe32 and htobe64 functions
Date: Fri, 14 Mar 2014 09:59:25 +0000
Message-Id: <1394791167-29933-2-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
References: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The man page says that #include <endian.h> is needed for those.

This fixes the following compile error when building with musl libc on
Alpine Linux:

src/shared/btsnoop.o: In function `btsnoop_write':
.../src/bluez/src/shared/btsnoop.c:208: undefined reference to `htobe32'
.../src/bluez/src/shared/btsnoop.c:209: undefined reference to `htobe32'
.../src/bluez/src/shared/btsnoop.c:210: undefined reference to `htobe32'
.../src/bluez/src/shared/btsnoop.c:211: undefined reference to `htobe32'
.../src/bluez/src/shared/btsnoop.c:212: undefined reference to `htobe64'
src/shared/btsnoop.o: In function `btsnoop_open':
.../src/bluez/src/shared/btsnoop.c:100: undefined reference to `be32toh'
.../src/bluez/src/shared/btsnoop.c:103: undefined reference to `be32toh'
src/shared/btsnoop.o: In function `btsnoop_create':
.../src/bluez/src/shared/btsnoop.c:151: undefined reference to `htobe32'
.../src/bluez/src/shared/btsnoop.c:152: undefined reference to `htobe32'
src/shared/btsnoop.o: In function `pklg_read_hci':
.../src/bluez/src/shared/btsnoop.c:336: undefined reference to `be32toh'
.../src/bluez/src/shared/btsnoop.c:338: undefined reference to `be64toh'
src/shared/btsnoop.o: In function `btsnoop_read_hci':
.../src/bluez/src/shared/btsnoop.c:416: undefined reference to `be32toh'
.../src/bluez/src/shared/btsnoop.c:417: undefined reference to `be32toh'
.../src/bluez/src/shared/btsnoop.c:419: undefined reference to `be64toh'
---

This was introduced with 83afd2d1a (shared: Use be32toh, htobe32 and
htobe64 functions)

 src/shared/btsnoop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index d2b3b4b..17a872c 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <endian.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
-- 
1.9.0

