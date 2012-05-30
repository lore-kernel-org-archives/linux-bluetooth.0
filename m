Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 06/15] sap: Move UUID definition to core
Date: Wed, 30 May 2012 14:59:59 +0200
Message-Id: <1338382808-29725-7-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 sap/server.c |    3 ++-
 src/uuid.h   |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sap/server.c b/sap/server.c
index c83e68a..6f446f5 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -33,6 +33,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "../src/uuid.h"
+
 #include "adapter.h"
 #include "btio.h"
 #include "sdpd.h"
@@ -43,7 +45,6 @@
 #include "server.h"
 
 #define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
-#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
 
 #define PADDING4(x) ((4 - ((x) & 0x03)) & 0x03)
diff --git a/src/uuid.h b/src/uuid.h
index 2fc3d54..66164b8 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -49,3 +49,5 @@
 #define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
 #define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
 #define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
+
+#define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

