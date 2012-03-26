Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC PATCH BlueZ] event: Remove unused dev_class parameter from btd_event_conn_complete()
Date: Mon, 26 Mar 2012 13:29:39 -0400
Message-Id: <1332782979-27081-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This parameter is not being used by hciops nor mgmtops.
---
 plugins/hciops.c  |    5 ++---
 plugins/mgmtops.c |    3 +--
 src/event.c       |    2 +-
 src/event.h       |    2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4f287f0..5ed3614 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2279,7 +2279,7 @@ static inline void conn_complete(int index, void *ptr)
 	conn->handle = btohs(evt->handle);
 
 	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, ADDR_TYPE_BREDR,
-								NULL, NULL);
+									NULL);
 
 	if (conn->secmode3)
 		bonding_complete(dev, conn, 0);
@@ -2328,8 +2328,7 @@ static inline void le_conn_complete(int index, void *ptr)
 	conn->handle = btohs(evt->handle);
 
 	type = le_addr_type(evt->peer_bdaddr_type);
-	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, type,
-								NULL, NULL);
+	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, type, NULL);
 
 	/* check if the remote version needs be requested */
 	ba2str(&dev->bdaddr, local_addr);
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4aa38fe..b7683de 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -528,8 +528,7 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 
 	btd_event_conn_complete(&info->bdaddr, &ev->addr.bdaddr,
 						addr_type(ev->addr.type),
-						eir_data.name,
-						eir_data.dev_class);
+						eir_data.name);
 
 	eir_data_free(&eir_data);
 }
diff --git a/src/event.c b/src/event.c
index 113a2b6..7a32782 100644
--- a/src/event.c
+++ b/src/event.c
@@ -445,7 +445,7 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
 }
 
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
-						char *name, uint8_t *dev_class)
+								char *name)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
diff --git a/src/event.h b/src/event.h
index 503d35f..87a27e1 100644
--- a/src/event.h
+++ b/src/event.h
@@ -30,7 +30,7 @@ void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean lega
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
-					char *name, uint8_t *dev_class);
+								char *name);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
-- 
1.7.5.4

