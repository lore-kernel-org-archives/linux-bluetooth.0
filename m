Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/2] Move EIR flags definitions to adapter.c
Date: Mon, 20 Dec 2010 14:16:44 -0400
Message-Id: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++++
 src/sdpd.h    |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 669a0ac..db3649f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -56,6 +56,15 @@
 #include "agent.h"
 #include "storage.h"
 
+/* Flags Descriptions */
+#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
+#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
+#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
+#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Controller) */
+#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Host) */
+
 #define ADV_TYPE_IND		0x00
 #define ADV_TYPE_DIRECT_IND	0x01
 
diff --git a/src/sdpd.h b/src/sdpd.h
index 98e5b20..dc7a256 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -48,15 +48,6 @@
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 
-/* Flags Descriptions */
-#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
-#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
-#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
-#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Controller) */
-#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Host) */
-
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.0.4

