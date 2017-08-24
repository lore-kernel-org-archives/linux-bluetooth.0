Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/3] obexd: Fix compilation error on F27
Date: Thu, 24 Aug 2017 20:28:23 +0200
Message-Id: <20170824182824.8465-2-hadess@hadess.net>
In-Reply-To: <20170824182824.8465-1-hadess@hadess.net>
References: <20170824182824.8465-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
2.13.5

