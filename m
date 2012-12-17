Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/11] adapter: Remove not used btd_adapter_get_mode
Date: Mon, 17 Dec 2012 15:44:58 +0100
Message-ID: <1355755498-2700-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not used anymore and adapter mode is now internal to
btd_adapter.
---
 src/adapter.c | 11 +++++------
 src/adapter.h |  7 -------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 035a4ca..96a23e9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -77,6 +77,11 @@
 #define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
 					    Device Capable (Host) */
 
+#define MODE_OFF		0x00
+#define MODE_CONNECTABLE	0x01
+#define MODE_DISCOVERABLE	0x02
+#define MODE_UNKNOWN		0xff
+
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 #define PENDING_FOUND_MAX 5
 
@@ -1692,12 +1697,6 @@ static void load_connections(struct btd_adapter *adapter)
 	g_slist_free_full(conns, g_free);
 }
 
-void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode)
-{
-	if (mode)
-		*mode = adapter->mode;
-}
-
 bool btd_adapter_get_pairable(struct btd_adapter *adapter)
 {
 	return adapter->pairable;
diff --git a/src/adapter.h b/src/adapter.h
index 44ba56a..bde76b2 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -32,11 +32,6 @@
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
 
-#define MODE_OFF		0x00
-#define MODE_CONNECTABLE	0x01
-#define MODE_DISCOVERABLE	0x02
-#define MODE_UNKNOWN		0xff
-
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
@@ -80,8 +75,6 @@ void btd_adapter_start(struct btd_adapter *adapter);
 
 int btd_adapter_stop(struct btd_adapter *adapter);
 
-void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode);
-
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 
 void btd_adapter_get_major_minor(struct btd_adapter *adapter, uint8_t *major,
-- 
1.8.0

