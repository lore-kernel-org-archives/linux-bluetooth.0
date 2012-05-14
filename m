Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 3/5] Propagate disconnect reason to adapter
Date: Mon, 14 May 2012 17:33:02 +0200
Message-Id: <1337009584-17181-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Internally propagate disconnect reason in order to make it public in the
D-Bus API.
---
 lib/mgmt.h        |    5 +++++
 plugins/hciops.c  |    2 +-
 plugins/mgmtops.c |   10 ++++++++--
 src/adapter.c     |    5 +++--
 src/adapter.h     |    2 +-
 src/event.c       |    4 ++--
 src/event.h       |    3 ++-
 7 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a58915b..39d4e71 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -374,6 +374,11 @@ struct mgmt_ev_device_disconnected {
 	struct mgmt_addr_info addr;
 } __packed;
 
+struct mgmt_ev_device_disconnected_2 {
+	struct mgmt_addr_info addr;
+	uint8_t reason;
+} __packed;
+
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
 	struct mgmt_addr_info addr;
diff --git a/plugins/hciops.c b/plugins/hciops.c
index d74f2ea..ab2edb5 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2364,7 +2364,7 @@ static inline void disconn_complete(int index, void *ptr)
 
 	dev->connections = g_slist_remove(dev->connections, conn);
 
-	btd_event_disconn_complete(&dev->bdaddr, &conn->bdaddr);
+	btd_event_disconn_complete(&dev->bdaddr, &conn->bdaddr, evt->reason);
 
 	conn_free(conn);
 }
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 22fa329..47c73b6 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -511,12 +511,18 @@ static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 	struct mgmt_addr_info *ev = buf;
 	struct controller_info *info;
 	char addr[18];
+	uint8_t reason;
 
 	if (len < sizeof(*ev)) {
 		error("Too small device_disconnected event");
 		return;
 	}
 
+	if (len < sizeof(struct mgmt_ev_device_disconnected_2))
+		reason = 0;
+	else
+		reason = ((struct mgmt_ev_device_disconnected_2 *)buf)->reason;
+
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u device %s disconnected", index, addr);
@@ -528,7 +534,7 @@ static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 
 	info = &controllers[index];
 
-	btd_event_disconn_complete(&info->bdaddr, &ev->bdaddr);
+	btd_event_disconn_complete(&info->bdaddr, &ev->bdaddr, reason);
 }
 
 static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
@@ -1108,7 +1114,7 @@ static void disconnect_complete(int sk, uint16_t index, uint8_t status,
 
 	info = &controllers[index];
 
-	btd_event_disconn_complete(&info->bdaddr, &rp->addr.bdaddr);
+	btd_event_disconn_complete(&info->bdaddr, &rp->addr.bdaddr, 0);
 
 	bonding_complete(info, &rp->addr.bdaddr, HCI_CONNECTION_TERMINATED);
 }
diff --git a/src/adapter.c b/src/adapter.c
index 93b55e8..b9a90dd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2304,7 +2304,8 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 
 	while (adapter->connections) {
 		struct btd_device *device = adapter->connections->data;
-		adapter_remove_connection(adapter, device);
+		adapter_remove_connection(adapter, device,
+					HCI_OE_USER_ENDED_CONNECTION);
 	}
 
 	if (adapter->scan_mode == (SCAN_PAGE | SCAN_INQUIRY))
@@ -2991,7 +2992,7 @@ void adapter_add_connection(struct btd_adapter *adapter,
 }
 
 void adapter_remove_connection(struct btd_adapter *adapter,
-						struct btd_device *device)
+				struct btd_device *device, uint8_t reason)
 {
 	DBG("");
 
diff --git a/src/adapter.h b/src/adapter.h
index b7ea62b..a9043de 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -128,7 +128,7 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
 						struct btd_device *device);
 void adapter_remove_connection(struct btd_adapter *adapter,
-						struct btd_device *device);
+				struct btd_device *device, uint8_t reason);
 gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
diff --git a/src/event.c b/src/event.c
index 514744b..0fcc2ec 100644
--- a/src/event.c
+++ b/src/event.c
@@ -499,7 +499,7 @@ void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 		adapter_remove_device(conn, adapter, device, TRUE);
 }
 
-void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
+void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -512,7 +512,7 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 	if (!device)
 		return;
 
-	adapter_remove_connection(adapter, device);
+	adapter_remove_connection(adapter, device, reason);
 }
 
 void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer)
diff --git a/src/event.h b/src/event.h
index dfc158d..cf2c091 100644
--- a/src/event.h
+++ b/src/event.h
@@ -32,7 +32,8 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					char *name, uint8_t *dev_class);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
-void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
+void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer,
+					uint8_t reason);
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
-- 
1.7.7.6

