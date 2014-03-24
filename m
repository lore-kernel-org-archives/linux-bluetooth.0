Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 1/5] core: Move EIR flags definitions to eir.h
Date: Mon, 24 Mar 2014 13:36:42 +0100
Message-Id: <1395664606-32263-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
References: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 9 ---------
 src/eir.h     | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 88d94b4..e396a3d 100644
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
diff --git a/src/eir.h b/src/eir.h
index 9e53983..e486fa2 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -38,6 +38,15 @@
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 
+/* Flags Descriptions */
+#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
+#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
+#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
+#define EIR_CONTROLLER              0x08 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Controller) */
+#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Host) */
+
 struct eir_data {
 	GSList *services;
 	unsigned int flags;
-- 
1.9.1

