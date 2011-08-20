Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/8] Add link_type information to the mgmt "Device Connected" event
Date: Fri, 19 Aug 2011 21:09:22 -0300
Message-Id: <1313798969-8772-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the case of incomming connections we have to know the type of
the device that connected to us.

Through hciops we have the LE Connection Complete event, that
information was lost when Management interface was being used.

The documentation is updated to reflect this.
---
 doc/mgmt-api.txt  |    1 +
 lib/hci.h         |    2 ++
 lib/mgmt.h        |    1 +
 plugins/hciops.c  |    4 ++--
 plugins/mgmtops.c |    2 +-
 src/event.c       |    5 ++++-
 src/event.h       |    2 +-
 tools/hcitool.c   |    3 ---
 8 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 127af94..e700366 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -498,6 +498,7 @@ Device Connected Event
 Event Code		0x000B
 Controller Index:	<controller id>
 Event Parameters	Address (6 Octets)
+			Link Type (1 Octet)
 
 Device Disconnected Event
 =========================
diff --git a/lib/hci.h b/lib/hci.h
index d6f79f2..451e134 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -212,6 +212,8 @@ enum {
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
 #define ESCO_LINK	0x02
+/* Low Energy links do not have defined link type. Use invented one */
+#define LE_LINK		0x80
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0c52850..b0c2a5e 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -282,6 +282,7 @@ struct mgmt_ev_new_key {
 #define MGMT_EV_DEVICE_CONNECTED	0x000B
 struct mgmt_ev_device_connected {
 	bdaddr_t bdaddr;
+	uint8_t link_type;
 } __packed;
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 03eec82..5d7b0db 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2060,7 +2060,7 @@ static inline void conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr);
+	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, evt->link_type);
 
 	if (conn->secmode3)
 		bonding_complete(dev, conn, 0);
@@ -2096,7 +2096,7 @@ static inline void le_conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->peer_bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr);
+	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, LE_LINK);
 
 	/* check if the remote version needs be requested */
 	ba2str(&dev->bdaddr, local_addr);
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3fd1b3f..e6f5a4f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -436,7 +436,7 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 
 	info = &controllers[index];
 
-	btd_event_conn_complete(&info->bdaddr, &ev->bdaddr);
+	btd_event_conn_complete(&info->bdaddr, &ev->bdaddr, ev->link_type);
 }
 
 static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
diff --git a/src/event.c b/src/event.c
index ade882e..6d276f4 100644
--- a/src/event.c
+++ b/src/event.c
@@ -466,7 +466,7 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 	return ret;
 }
 
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer)
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t link_type)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -476,6 +476,9 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer)
 
 	update_lastused(local, peer);
 
+	if (link_type == LE_LINK)
+		device_set_type(device, DEVICE_TYPE_LE);
+
 	adapter_add_connection(adapter, device);
 }
 
diff --git a/src/event.h b/src/event.h
index 5047db1..3dd25f1 100644
--- a/src/event.h
+++ b/src/event.h
@@ -28,7 +28,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer);
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t link_type);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_bonding_complete(bdaddr_t *local, bdaddr_t *peer,
diff --git a/tools/hcitool.c b/tools/hcitool.c
index ece187c..dd13ced 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -46,9 +46,6 @@
 #include "textfile.h"
 #include "oui.h"
 
-/* Unofficial value, might still change */
-#define LE_LINK		0x03
-
 #define FLAGS_AD_TYPE 0x01
 #define FLAGS_LIMITED_MODE_BIT 0x01
 #define FLAGS_GENERAL_MODE_BIT 0x02
-- 
1.7.6

