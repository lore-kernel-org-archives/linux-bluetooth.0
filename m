Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 03/15] network: Move UUID defintion to core
Date: Wed, 30 May 2012 14:59:56 +0200
Message-Id: <1338382808-29725-4-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 network/common.c  |    2 ++
 network/common.h  |    5 -----
 network/manager.c |    2 ++
 network/server.c  |    1 +
 src/uuid.h        |    5 +++++
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/network/common.c b/network/common.c
index c498c25..9b59935 100644
--- a/network/common.c
+++ b/network/common.c
@@ -42,6 +42,8 @@
 
 #include <glib.h>
 
+#include "../src/uuid.h"
+
 #include "log.h"
 #include "common.h"
 
diff --git a/network/common.h b/network/common.h
index fefb754..cb1f08a 100644
--- a/network/common.h
+++ b/network/common.h
@@ -21,11 +21,6 @@
  *
  */
 
-#define PANU_UUID	"00001115-0000-1000-8000-00805f9b34fb"
-#define NAP_UUID	"00001116-0000-1000-8000-00805f9b34fb"
-#define GN_UUID		"00001117-0000-1000-8000-00805f9b34fb"
-#define BNEP_SVC_UUID	"0000000f-0000-1000-8000-00805f9b34fb"
-
 int bnep_init(void);
 int bnep_cleanup(void);
 
diff --git a/network/manager.c b/network/manager.c
index dd0f311..9d15ff5 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -32,6 +32,8 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include "../src/uuid.h"
+
 #include "log.h"
 
 #include "adapter.h"
diff --git a/network/server.c b/network/server.c
index e39769a..9a6dc83 100644
--- a/network/server.c
+++ b/network/server.c
@@ -41,6 +41,7 @@
 
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
+#include "../src/uuid.h"
 
 #include "log.h"
 #include "error.h"
diff --git a/src/uuid.h b/src/uuid.h
index 8aecec5..61ea6e5 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -36,3 +36,8 @@
 
 #define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
 #define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
+
+#define PANU_UUID		"00001115-0000-1000-8000-00805f9b34fb"
+#define NAP_UUID		"00001116-0000-1000-8000-00805f9b34fb"
+#define GN_UUID			"00001117-0000-1000-8000-00805f9b34fb"
+#define BNEP_SVC_UUID		"0000000f-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

