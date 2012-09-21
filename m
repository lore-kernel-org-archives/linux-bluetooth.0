Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 03/18] eir: Store class in struct eir_data as uint32_t
Date: Fri, 21 Sep 2012 14:36:20 +0200
Message-ID: <1348230995-8967-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This simplify code as class is stored on storage as uint32_t and
had to be converted to it in few places.

---
 src/adapter.c |   11 ++++-------
 src/eir.c     |    3 ++-
 src/eir.h     |    2 +-
 src/event.c   |   11 +++--------
 src/event.h   |    2 +-
 src/mgmt.c    |    2 +-
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f9acbd5..6d2ca69 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2914,7 +2914,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	struct eir_data eir_data;
 	char *alias, *name;
 	gboolean legacy, name_known;
-	uint32_t dev_class;
 	int err;
 	GSList *l;
 
@@ -2925,10 +2924,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
-	dev_class = eir_data.dev_class[0] | (eir_data.dev_class[1] << 8) |
-						(eir_data.dev_class[2] << 16);
-	if (dev_class != 0)
-		write_remote_class(&adapter->bdaddr, bdaddr, dev_class);
+	if (eir_data.class != 0)
+		write_remote_class(&adapter->bdaddr, bdaddr, eir_data.class);
 
 	if (eir_data.appearance != 0)
 		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
@@ -2984,8 +2981,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	alias = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type,
 								"aliases");
 
-	dev = found_device_new(bdaddr, bdaddr_type, name, alias, dev_class,
-						legacy, eir_data.flags);
+	dev = found_device_new(bdaddr, bdaddr_type, name, alias,
+				eir_data.class, legacy, eir_data.flags);
 	free(name);
 	free(alias);
 
diff --git a/src/eir.c b/src/eir.c
index c29be40..4b054ea 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -166,7 +166,8 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 		case EIR_CLASS_OF_DEV:
 			if (data_len < 3)
 				break;
-			memcpy(eir->dev_class, data, 3);
+			eir->class = data[0] | (data[1] << 8) |
+							(data[2] << 16);
 			break;
 
 		case EIR_GAP_APPEARANCE:
diff --git a/src/eir.h b/src/eir.h
index e6e870a..3a52563 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -47,7 +47,7 @@ struct eir_data {
 	GSList *services;
 	int flags;
 	char *name;
-	uint8_t dev_class[3];
+	uint32_t class;
 	uint16_t appearance;
 	gboolean name_complete;
 	uint8_t *hash;
diff --git a/src/event.c b/src/event.c
index 1db73be..9626053 100644
--- a/src/event.c
+++ b/src/event.c
@@ -452,7 +452,7 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 }
 
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-						char *name, uint8_t *dev_class)
+						char *name, uint32_t class)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -462,13 +462,8 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_typ
 
 	update_lastused(local, peer, bdaddr_type);
 
-	if (dev_class != NULL) {
-		uint32_t class = dev_class[0] | (dev_class[1] << 8) |
-							(dev_class[2] << 16);
-
-		if (class != 0)
-			write_remote_class(local, peer, class);
-	}
+	if (class != 0)
+		write_remote_class(local, peer, class);
 
 	device_set_addr_type(device, bdaddr_type);
 
diff --git a/src/event.h b/src/event.h
index 7031cc9..6d001dd 100644
--- a/src/event.h
+++ b/src/event.h
@@ -30,7 +30,7 @@ void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean lega
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					char *name, uint8_t *dev_class);
+						char *name, uint32_t class);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
diff --git a/src/mgmt.c b/src/mgmt.c
index dbd9786..9d78ce1 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -515,7 +515,7 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 	btd_event_conn_complete(&info->bdaddr, &ev->addr.bdaddr,
 						ev->addr.type,
 						eir_data.name,
-						eir_data.dev_class);
+						eir_data.class);
 
 	eir_data_free(&eir_data);
 }
-- 
1.7.9.5

