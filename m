Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] gobex: fix includes of config.h
Date: Wed, 19 Oct 2011 17:28:03 +0300
Message-Id: <1319034483-3215-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-defs.c     |    2 +-
 gobex/gobex-header.c   |    2 +-
 gobex/gobex-packet.c   |    2 +-
 gobex/gobex-transfer.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
index da982a7..035725b 100644
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
index b539430..c3e3953 100644
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
index b9c8507..6d2f7af 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -20,7 +20,7 @@
  */
 
 #ifdef HAVE_CONFIG_H
-# include "config.h"
+#include <config.h>
 #endif
 
 #include <string.h>
-- 
1.7.6.4

