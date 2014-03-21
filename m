Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] core: Move EIR flags definitions to eir.h
Date: Fri, 21 Mar 2014 17:34:07 +0100
Message-Id: <1395419649-15647-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 15 ++++-----------
 src/eir.h     |  9 +++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e3de8cf..ac756c1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -72,15 +72,6 @@
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
 
-/* Flags Descriptions */
-#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
-#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
-#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
-#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Controller) */
-#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Host) */
-
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
 #define MODE_DISCOVERABLE	0x02
@@ -4309,7 +4300,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
-			!(eir_data.flags & (EIR_LIM_DISC | EIR_GEN_DISC))) {
+			!(eir_data.flags &
+				(EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC))) {
 		eir_data_free(&eir_data);
 		return;
 	}
@@ -4339,7 +4331,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_update_last_seen(dev, bdaddr_type);
 
-	if (bdaddr_type != BDADDR_BREDR && !(eir_data.flags & EIR_BREDR_UNSUP))
+	if (bdaddr_type != BDADDR_BREDR &&
+				!(eir_data.flags & EIR_FLAG_BREDR_UNSUP))
 		device_set_bredr_support(dev, true);
 
 	if (eir_data.name != NULL && eir_data.name_complete)
diff --git a/src/eir.h b/src/eir.h
index 3fa1cb3..326292a 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -38,6 +38,15 @@
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 
+/* Flags Descriptions */
+#define EIR_FLAG_LIM_DISC           0x01 /* LE Limited Discoverable Mode */
+#define EIR_FLAG_GEN_DISC           0x02 /* LE General Discoverable Mode */
+#define EIR_FLAG_BREDR_UNSUP        0x04 /* BR/EDR Not Supported */
+#define EIR_FLAG_CONTROLLER         0x08 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Controller) */
+#define EIR_FLAG_SIM_HOST           0x10 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Host) */
+
 struct eir_data {
 	GSList *services;
 	int flags;
-- 
1.8.3.2

