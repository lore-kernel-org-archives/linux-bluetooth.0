Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/8] Remove config.h from src/obex.h
Date: Wed,  2 Nov 2011 15:09:48 +0200
Message-Id: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

config.h should only be included in .c files
---
 src/obex.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/obex.h b/src/obex.h
index 6b7dc7e..f4fd159 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #define OBJECT_SIZE_UNKNOWN -1
 #define OBJECT_SIZE_DELETE -2
 
-- 
1.7.6.4

