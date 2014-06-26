Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/15] lib/uuid: Add define for Scan Parameter UUID
Date: Thu, 26 Jun 2014 17:46:39 +0300
Message-Id: <1403794008-18585-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403794008-18585-1-git-send-email-luiz.dentz@gmail.com>
References: <1403794008-18585-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/uuid.h                | 1 +
 profiles/scanparam/scan.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 814fd92..b44d6ae 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -60,6 +60,7 @@ extern "C" {
 #define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
 #define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
 #define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
+#define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 25c906e..3eece9d 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -42,8 +42,6 @@
 #include "attrib/gatt.h"
 #include "src/attio.h"
 
-#define SCAN_PARAMETERS_UUID		"00001813-0000-1000-8000-00805f9b34fb"
-
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
 
-- 
1.9.3

