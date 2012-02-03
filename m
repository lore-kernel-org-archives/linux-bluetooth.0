Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] src/obex.h: Include stdint.h
Date: Fri,  3 Feb 2012 11:59:22 +0100
Message-Id: <1328266762-23552-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/obex.h b/src/obex.h
index 7f07fd2..95e9c4e 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <stdint.h>
+
 #define OBJECT_SIZE_UNKNOWN -1
 #define OBJECT_SIZE_DELETE -2
 
-- 
1.7.4.1

