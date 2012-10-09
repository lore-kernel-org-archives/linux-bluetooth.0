Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/9] Pass confirm name as gboolean value
Date: Tue, 9 Oct 2012 14:11:55 +0200
Message-ID: <1349784722-14578-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

confirm_name is a boolean value and can be pass as such instead of
uint8_t.

---
 src/adapter.c |    2 +-
 src/adapter.h |    2 +-
 src/event.c   |    2 +-
 src/event.h   |    2 +-
 src/mgmt.c    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index abb9691..f3e381b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3141,7 +3141,7 @@ static gboolean connect_pending_cb(gpointer user_data)
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, gboolean legacy,
+					gboolean confirm_name, gboolean legacy,
 					uint8_t *data, uint8_t data_len)
 {
 	struct remote_dev_info *dev;
diff --git a/src/adapter.h b/src/adapter.h
index a089075..9fd034d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -128,7 +128,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, gboolean legacy,
+					gboolean confirm_name, gboolean legacy,
 					uint8_t *data, uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index d552a0f..ac7140c 100644
--- a/src/event.c
+++ b/src/event.c
@@ -243,7 +243,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 }
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
+					int8_t rssi, gboolean confirm_name,
 					gboolean legacy, uint8_t *data,
 					uint8_t data_len)
 {
diff --git a/src/event.h b/src/event.h
index a9afa1e..a7c3ce2 100644
--- a/src/event.h
+++ b/src/event.h
@@ -24,7 +24,7 @@
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
+					int8_t rssi, gboolean confirm_name,
 					gboolean legacy, uint8_t *data,
 					uint8_t data_len);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
diff --git a/src/mgmt.c b/src/mgmt.c
index 9353c7d..719af06 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1667,7 +1667,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u",
 			index, addr, ev->rssi, flags, eir_len);
 
-	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
+	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME) ? TRUE : FALSE;
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING) ? TRUE : FALSE;
 
 	btd_event_device_found(&info->bdaddr, &ev->addr.bdaddr,
-- 
1.7.9.5

