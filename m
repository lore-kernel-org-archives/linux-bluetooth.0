Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 03/14] network: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:27 +0200
Message-Id: <1338471818-20894-4-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h        |    5 +++++
 network/common.c  |    1 +
 network/common.h  |    5 -----
 network/manager.c |    1 +
 network/server.c  |    1 +
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index a44426a..848baed 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -48,6 +48,11 @@ extern "C" {
 #define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
 #define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
 
+#define PANU_UUID		"00001115-0000-1000-8000-00805f9b34fb"
+#define NAP_UUID		"00001116-0000-1000-8000-00805f9b34fb"
+#define GN_UUID			"00001117-0000-1000-8000-00805f9b34fb"
+#define BNEP_SVC_UUID		"0000000f-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/network/common.c b/network/common.c
index c498c25..4704072 100644
--- a/network/common.c
+++ b/network/common.c
@@ -39,6 +39,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
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
index dd0f311..7fcd8f0 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -28,6 +28,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/bnep.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <gdbus.h>
diff --git a/network/server.c b/network/server.c
index e39769a..480c7e2 100644
--- a/network/server.c
+++ b/network/server.c
@@ -34,6 +34,7 @@
 #include <bluetooth/bnep.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 #include <netinet/in.h>
 
 #include <glib.h>
-- 
1.7.10.130.g36e6c

