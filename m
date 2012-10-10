Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Pass confirm name as bool value
Date: Wed, 10 Oct 2012 15:19:57 +0200
Message-ID: <1349875198-28913-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

confirm_name is a boolean value and can be pass as such instead of
uint8_t.

---
 src/adapter.c |    2 +-
 src/adapter.h |    3 ++-
 src/event.c   |    2 +-
 src/event.h   |    2 +-
 src/mgmt.c    |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ad8ee06..368eedb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3145,7 +3145,7 @@ static gboolean connect_pending_cb(gpointer user_data)
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, gboolean legacy,
+					bool confirm_name, gboolean legacy,
 					uint8_t *data, uint8_t data_len)
 {
 	struct remote_dev_info *dev;
diff --git a/src/adapter.h b/src/adapter.h
index b5bff10..6c29f2f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -28,6 +28,7 @@
 #include <bluetooth/hci_lib.h>
 #include <dbus/dbus.h>
 #include <glib.h>
+#include <stdbool.h>
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter"
 
@@ -128,7 +129,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, gboolean legacy,
+					bool confirm_name, gboolean legacy,
 					uint8_t *data, uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index 83b6e90..4f4fc93 100644
--- a/src/event.c
+++ b/src/event.c
@@ -243,7 +243,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 }
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
+					int8_t rssi, bool confirm_name,
 					gboolean legacy, uint8_t *data,
 					uint8_t data_len)
 {
diff --git a/src/event.h b/src/event.h
index a9afa1e..eca4409 100644
--- a/src/event.h
+++ b/src/event.h
@@ -24,7 +24,7 @@
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
+					int8_t rssi, bool confirm_name,
 					gboolean legacy, uint8_t *data,
 					uint8_t data_len);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
diff --git a/src/mgmt.c b/src/mgmt.c
index 9353c7d..921c565 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1634,7 +1634,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	uint32_t flags;
 	uint16_t eir_len;
 	uint8_t *eir;
-	gboolean confirm_name;
+	bool confirm_name;
 	gboolean legacy;
 
 	if (len < sizeof(*ev)) {
-- 
1.7.9.5

