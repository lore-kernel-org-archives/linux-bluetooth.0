Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 11/15] pnat: Move UUID defintion to core
Date: Wed, 30 May 2012 15:00:04 +0200
Message-Id: <1338382808-29725-12-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/pnat.c |    5 +++--
 src/uuid.h     |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/pnat.c b/plugins/pnat.c
index 2d73910..ac35978 100644
--- a/plugins/pnat.c
+++ b/plugins/pnat.c
@@ -50,11 +50,12 @@
 #include "adapter.h"
 #include "log.h"
 
+#include "../src/uuid.h"
+
 /* FIXME: This location should be build-time configurable */
 #define PNATD "/usr/bin/phonet-at"
 
 #define DUN_CHANNEL 1
-#define DUN_UUID "00001103-0000-1000-8000-00805F9B34FB"
 
 #define TTY_TIMEOUT 100
 #define TTY_TRIES 10
@@ -347,7 +348,7 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 		return;
 	}
 
-	if (btd_request_authorization(&server->bda, &client->bda, DUN_UUID,
+	if (btd_request_authorization(&server->bda, &client->bda, DUN_GW_UUID,
 						auth_cb, user_data) < 0) {
 		error("Requesting DUN authorization failed");
 		return;
diff --git a/src/uuid.h b/src/uuid.h
index 4bcc397..534a245 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -65,3 +65,5 @@
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
 
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
+
+#define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

