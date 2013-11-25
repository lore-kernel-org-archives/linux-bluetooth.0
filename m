Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 02/13] Rename adapter_get_device to btd_adapter_get_device
Date: Mon, 25 Nov 2013 22:15:41 +0000
Message-Id: <1385417752-25664-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 plugins/neard.c       |  6 ++++--
 profiles/health/hdp.c |  4 ++--
 src/adapter.c         | 28 +++++++++++++++++-----------
 src/adapter.h         |  2 +-
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index ea91c4d..073abec 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -701,7 +701,8 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 		return error_reply(msg, EINVAL);
 	}
 
-	device = adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+	device = btd_adapter_get_device(adapter, &remote.address,
+								BDADDR_BREDR);
 
 	err = check_device(device);
 	if (err < 0) {
@@ -769,7 +770,8 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	if (bacmp(&remote.address, BDADDR_ANY) == 0)
 		goto read_local;
 
-	device = adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+	device = btd_adapter_get_device(adapter, &remote.address,
+								BDADDR_BREDR);
 
 	err = check_device(device);
 	if (err < 0) {
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 7b4e799..86cebe6 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1205,8 +1205,8 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 		struct hdp_adapter *hdp_adapter = data;
 		struct btd_device *device;
 
-		device = adapter_get_device(hdp_adapter->btd_adapter, &addr,
-								BDADDR_BREDR);
+		device = btd_adapter_get_device(hdp_adapter->btd_adapter,
+							&addr, BDADDR_BREDR);
 		if (!device)
 			return;
 		hdp_device = create_health_device(device);
diff --git a/src/adapter.c b/src/adapter.c
index d904a56..8a6dadf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1072,7 +1072,7 @@ static void adapter_remove_device(struct btd_adapter *adapter,
 	device_remove(dev, TRUE);
 }
 
-struct btd_device *adapter_get_device(struct btd_adapter *adapter,
+struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 					const bdaddr_t *addr,
 					uint8_t addr_type)
 {
@@ -2726,7 +2726,8 @@ static void get_connections_complete(uint8_t status, uint16_t length,
 		ba2str(&addr->bdaddr, address);
 		DBG("Adding existing connection to %s", address);
 
-		device = adapter_get_device(adapter, &addr->bdaddr, addr->type);
+		device = btd_adapter_get_device(adapter, &addr->bdaddr,
+								addr->type);
 		if (device)
 			adapter_add_connection(adapter, device);
 	}
@@ -4687,7 +4688,8 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u %s confirm_hint %u", adapter->dev_id, addr,
 							ev->confirm_hint);
-	device = adapter_get_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
 	if (!device) {
 		error("Unable to get device object for %s", addr);
 		return;
@@ -4758,7 +4760,8 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u %s", index, addr);
 
-	device = adapter_get_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
 	if (!device) {
 		error("Unable to get device object for %s", addr);
 		return;
@@ -4790,7 +4793,8 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u %s", index, addr);
 
-	device = adapter_get_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
 	if (!device) {
 		error("Unable to get device object for %s", addr);
 		return;
@@ -4872,7 +4876,8 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	DBG("hci%u %s", adapter->dev_id, addr);
 
-	device = adapter_get_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
 	if (!device) {
 		error("Unable to get device object for %s", addr);
 		return;
@@ -4957,7 +4962,7 @@ static void bonding_complete(struct btd_adapter *adapter,
 	struct btd_device *device;
 
 	if (status == 0)
-		device = adapter_get_device(adapter, bdaddr, addr_type);
+		device = btd_adapter_get_device(adapter, bdaddr, addr_type);
 	else
 		device = adapter_find_device(adapter, bdaddr);
 
@@ -4984,7 +4989,7 @@ static void bonding_attempt_complete(struct btd_adapter *adapter,
 							addr_type, status);
 
 	if (status == 0)
-		device = adapter_get_device(adapter, bdaddr, addr_type);
+		device = btd_adapter_get_device(adapter, bdaddr, addr_type);
 	else
 		device = adapter_find_device(adapter, bdaddr);
 
@@ -5274,7 +5279,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	device = adapter_get_device(adapter, &addr->bdaddr, addr->type);
+	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
 	if (!device) {
 		error("Unable to get device object for %s", dst);
 		return;
@@ -5369,7 +5374,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 	DBG("hci%u new LTK for %s authenticated %u enc_size %u",
 		adapter->dev_id, dst, ev->key.authenticated, ev->key.enc_size);
 
-	device = adapter_get_device(adapter, &addr->bdaddr, addr->type);
+	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
 	if (!device) {
 		error("Unable to get device object for %s", dst);
 		return;
@@ -5720,7 +5725,8 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	DBG("hci%u device %s connected eir_len %u", index, addr, eir_len);
 
-	device = adapter_get_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
 	if (!device) {
 		error("Unable to get device object for %s", addr);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index 80c5f77..8a2ddae 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -90,7 +90,7 @@ bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
-struct btd_device *adapter_get_device(struct btd_adapter *adapter,
+struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 					const bdaddr_t *addr,
 					uint8_t addr_type);
 sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter);
-- 
1.8.4.4

