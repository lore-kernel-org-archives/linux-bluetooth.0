Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 06/14] sap: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:30 +0200
Message-Id: <1338471818-20894-7-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h   |    2 ++
 sap/server.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 86679a9..71af5ae 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -61,6 +61,8 @@ extern "C" {
 #define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
 #define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
 
+#define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/sap/server.c b/sap/server.c
index c83e68a..f5d19c4 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -32,6 +32,7 @@
 #include <glib.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "adapter.h"
 #include "btio.h"
@@ -43,7 +44,6 @@
 #include "server.h"
 
 #define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
-#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
 
 #define PADDING4(x) ((4 - ((x) & 0x03)) & 0x03)
-- 
1.7.10.130.g36e6c

