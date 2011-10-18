Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] gobex: add missing checks for config.h
Date: Tue, 18 Oct 2011 11:12:25 +0300
Message-Id: <1318925545-4128-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-defs.c   |    4 ++++
 gobex/gobex-header.c |    4 ++++
 gobex/gobex-packet.c |    4 ++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex-defs.c b/gobex/gobex-defs.c
index f1f3b38..beb773d 100644
--- a/gobex/gobex-defs.c
+++ b/gobex/gobex-defs.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+# include "config.h"
+#endif
+
 #include <glib.h>
 
 #include "gobex-defs.h"
diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index e70d5e4..da982a7 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+# include "config.h"
+#endif
+
 #include <string.h>
 
 #include "gobex-header.h"
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index d59bbce..b539430 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+# include "config.h"
+#endif
+
 #include <string.h>
 #include <errno.h>
 
-- 
1.7.6.4

