Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 12/14] core: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:36 +0200
Message-Id: <1338471818-20894-13-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h    |    3 +++
 src/device.c  |    1 -
 src/storage.c |    1 +
 src/storage.h |    2 --
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 3dfb00b..2c2b351 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -80,6 +80,9 @@ extern "C" {
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
 
+#define GAP_SVC_UUID		"00001800-0000-1000-8000-00805f9b34fb"
+#define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/src/device.c b/src/device.c
index 7ff09aa..39aa0cb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -71,7 +71,6 @@
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
-#define GAP_SVC_UUID "00001800-0000-1000-8000-00805f9b34fb"
 #define APPEARANCE_CHR_UUID 0x2a01
 
 struct btd_disconnect_data {
diff --git a/src/storage.c b/src/storage.c
index 7d65fe1..17e8001 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -41,6 +41,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "textfile.h"
 #include "glib-helper.h"
diff --git a/src/storage.h b/src/storage.h
index c541807..cc00e97 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -100,5 +100,3 @@ void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
 int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 							const char *key);
 gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type);
-
-#define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

