Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 11/14] pnat: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:35 +0200
Message-Id: <1338471818-20894-12-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h     |    2 ++
 plugins/pnat.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 7e34259..3dfb00b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -78,6 +78,8 @@ extern "C" {
 #define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
 
+#define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/plugins/pnat.c b/plugins/pnat.c
index 2d73910..3c611a9 100644
--- a/plugins/pnat.c
+++ b/plugins/pnat.c
@@ -39,6 +39,7 @@
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -54,7 +55,6 @@
 #define PNATD "/usr/bin/phonet-at"
 
 #define DUN_CHANNEL 1
-#define DUN_UUID "00001103-0000-1000-8000-00805F9B34FB"
 
 #define TTY_TIMEOUT 100
 #define TTY_TRIES 10
@@ -347,7 +347,7 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 		return;
 	}
 
-	if (btd_request_authorization(&server->bda, &client->bda, DUN_UUID,
+	if (btd_request_authorization(&server->bda, &client->bda, DUN_GW_UUID,
 						auth_cb, user_data) < 0) {
 		error("Requesting DUN authorization failed");
 		return;
-- 
1.7.10.130.g36e6c

