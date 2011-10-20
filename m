Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v2] gobex: fix includes of config.h
Date: Thu, 20 Oct 2011 10:49:42 +0300
Message-Id: <1319096982-3040-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-defs.c     |    2 +-
 gobex/gobex-header.c   |    2 +-
 gobex/gobex-packet.c   |    2 +-
 gobex/gobex-transfer.c |    4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex-defs.c b/gobex/gobex-defs.c
index beb773d..c184c9c 100644
--- a/gobex/gobex-defs.c
+++ b/gobex/gobex-defs.c
@@ -20,7 +20,7 @@
  */
 
 #ifdef HAVE_CONFIG_H
-# include "config.h"
+#include <config.h>
 #endif
 
 #include <glib.h>
diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 0dade51..c2f0085 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -20,7 +20,7 @@
  */
 
 #ifdef HAVE_CONFIG_H
-# include "config.h"
+#include <config.h>
 #endif
 
 #include <string.h>
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index df94031..de5a1a8 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -20,7 +20,7 @@
  */
 
 #ifdef HAVE_CONFIG_H
-# include "config.h"
+#include <config.h>
 #endif
 
 #include <string.h>
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 7278cb3..ab8cf2b 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <string.h>
 #include <errno.h>
 
-- 
1.7.6.4

