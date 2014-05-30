Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] shared/btsnoop: Use writev in btsnoop_write
Date: Fri, 30 May 2014 18:15:54 +0200
Message-ID: <1401466556-9040-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes btsnoop_write to use writev so there's single write
instead of two. It's useful when file descriptor is e.g. TCP socket
rather than regular file.
---
 src/shared/btsnoop.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index da993c5..59f8c65 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <arpa/inet.h>
 #include <sys/stat.h>
+#include <sys/uio.h>
 
 #include "src/shared/btsnoop.h"
 
@@ -225,6 +226,7 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
 	struct btsnoop_pkt pkt;
 	uint64_t ts;
 	ssize_t written;
+	struct iovec iov[2];
 
 	if (!btsnoop || !tv)
 		return false;
@@ -237,17 +239,14 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
 	pkt.drops = htobe32(0);
 	pkt.ts    = htobe64(ts + 0x00E03AB44A676000ll);
 
-	written = write(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
-	if (written < 0)
-		return false;
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = BTSNOOP_PKT_SIZE;
+	iov[1].iov_base = (void *) data;
+	iov[1].iov_len = size;
 
-	if (data && size > 0) {
-		written = write(btsnoop->fd, data, size);
-		if (written < 0)
-			return false;
-	}
+	written = writev(btsnoop->fd, iov, 2);
 
-	return true;
+	return written >= 0;
 }
 
 static uint32_t get_flags_from_opcode(uint16_t opcode)
-- 
1.9.3

