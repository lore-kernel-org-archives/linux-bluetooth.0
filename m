Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] lib/uuid: Add define for Battery UUID
Date: Tue, 24 Jun 2014 11:36:18 +0300
Message-Id: <1403598979-31032-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/uuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index b44d6ae..7901d34 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -60,6 +60,7 @@ extern "C" {
 #define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
 #define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
 #define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
+#define BATTERY_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
 #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
-- 
1.9.3

