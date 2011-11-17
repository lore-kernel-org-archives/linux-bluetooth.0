Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2] syncevolution: fix missing header file
Date: Thu, 17 Nov 2011 11:42:05 +0100
Message-ID: <1321526525-2727-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This missing include directive makes the syncevolution plugin fail to
compile. In Fedora 16 with gcc version 4.6.1 20110908, the output is:

make --no-print-directory all-am
  CC     plugins/syncevolution.o
In file included from plugins/syncevolution.c:40:0:
./src/mimetype.h:33:46: error: unknown type name ‘mode_t’
plugins/syncevolution.c:277:54: error: unknown type name ‘mode_t’
plugins/syncevolution.c:438:2: error: unknown field ‘open’ specified in initializer
plugins/syncevolution.c:438:10: error: ‘synce_open’ undeclared here (not in a function)
make[1]: *** [plugins/syncevolution.o] Error 1
---
 src/mimetype.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/mimetype.h b/src/mimetype.h
index 79529b8..374dcac 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -21,6 +21,8 @@
  *
  */
 
+#include <sys/types.h>
+
 typedef gboolean (*obex_object_io_func) (void *object, int flags, int err,
 							void *user_data);
 
-- 
1.7.6.4

