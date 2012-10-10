Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] event: Use bool instead gboolean for legacy parameter
Date: Wed, 10 Oct 2012 15:19:58 +0200
Message-ID: <1349875198-28913-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349875198-28913-1-git-send-email-szymon.janc@tieto.com>
References: <1349875198-28913-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will avoid mixing bool and gboolean in btd_event_device_found
definition. Whole execution chain for legacy parameter is also
converted to bool type.

---
 src/adapter.c |    4 ++--
 src/adapter.h |    4 ++--
 src/event.c   |    2 +-
 src/event.h   |    2 +-
 src/mgmt.c    |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 368eedb..1b1aadb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3032,7 +3032,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 static struct remote_dev_info *found_device_new(const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, const char *name,
 					const char *alias, uint32_t class,
-					gboolean legacy, int flags)
+					bool legacy, int flags)
 {
 	struct remote_dev_info *dev;
 
@@ -3145,7 +3145,7 @@ static gboolean connect_pending_cb(gpointer user_data)
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					bool confirm_name, gboolean legacy,
+					bool confirm_name, bool legacy,
 					uint8_t *data, uint8_t data_len)
 {
 	struct remote_dev_info *dev;
diff --git a/src/adapter.h b/src/adapter.h
index 6c29f2f..d36c717 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -83,7 +83,7 @@ struct remote_dev_info {
 	uint32_t class;
 	char *name;
 	char *alias;
-	gboolean legacy;
+	bool legacy;
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
@@ -129,7 +129,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					bool confirm_name, gboolean legacy,
+					bool confirm_name, bool legacy,
 					uint8_t *data, uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index 4f4fc93..5d0fd40 100644
--- a/src/event.c
+++ b/src/event.c
@@ -244,7 +244,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm_name,
-					gboolean legacy, uint8_t *data,
+					bool legacy, uint8_t *data,
 					uint8_t data_len)
 {
 	struct btd_adapter *adapter;
diff --git a/src/event.h b/src/event.h
index eca4409..1aa8704 100644
--- a/src/event.h
+++ b/src/event.h
@@ -25,7 +25,7 @@
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm_name,
-					gboolean legacy, uint8_t *data,
+					bool legacy, uint8_t *data,
 					uint8_t data_len);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
diff --git a/src/mgmt.c b/src/mgmt.c
index 921c565..2a66be2 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1635,7 +1635,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	uint16_t eir_len;
 	uint8_t *eir;
 	bool confirm_name;
-	gboolean legacy;
+	bool legacy;
 
 	if (len < sizeof(*ev)) {
 		error("mgmt_device_found too short (%zu bytes)", len);
@@ -1668,7 +1668,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 			index, addr, ev->rssi, flags, eir_len);
 
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
-	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING) ? TRUE : FALSE;
+	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
 
 	btd_event_device_found(&info->bdaddr, &ev->addr.bdaddr,
 						ev->addr.type,
-- 
1.7.9.5

