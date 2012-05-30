Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 13/15] storage: Move UUID defintion to uuid.h
Date: Wed, 30 May 2012 15:00:06 +0200
Message-Id: <1338382808-29725-14-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/storage.c |    1 +
 src/storage.h |    2 --
 src/uuid.h    |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 7d65fe1..36a5595 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -45,6 +45,7 @@
 #include "textfile.h"
 #include "glib-helper.h"
 #include "storage.h"
+#include "uuid.h"
 
 struct match {
 	GSList *keys;
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
diff --git a/src/uuid.h b/src/uuid.h
index 70408a0..6d94593 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -69,3 +69,5 @@
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
 
 #define GAP_SVC_UUID		"00001800-0000-1000-8000-00805f9b34fb"
+
+#define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

