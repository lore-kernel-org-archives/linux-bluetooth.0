Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 09/13] Remove btd_event_advertising_report
Date: Thu, 28 Apr 2011 19:37:05 -0300
Message-Id: <1304030229-6672-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Advertises should be notified using btd_event_device_found function
to keep the compatibility with mgmtops plugin.
---
 plugins/hciops.c  |   27 +++++++++++++++++++--------
 plugins/mgmtops.c |    3 ++-
 src/event.c       |   24 +++---------------------
 src/event.h       |    5 ++---
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c2aa614..91d5778 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1805,8 +1805,8 @@ static inline void inquiry_result(int index, int plen, void *ptr)
 						(info->dev_class[1] << 8) |
 						(info->dev_class[2] << 16);
 
-		btd_event_device_found(&dev->bdaddr, &info->bdaddr, class,
-								0, NULL);
+		btd_event_device_found(&dev->bdaddr, &info->bdaddr,
+					BDADDR_TYPE_BR, class, 0, NULL);
 		ptr += INQUIRY_INFO_SIZE;
 	}
 }
@@ -1828,7 +1828,8 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 						| (info->dev_class[2] << 16);
 
 			btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-						class, info->rssi, NULL);
+							BDADDR_TYPE_BR, class,
+							info->rssi, NULL);
 			ptr += INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE;
 		}
 	} else {
@@ -1839,7 +1840,8 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 						| (info->dev_class[2] << 16);
 
 			btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-						class, info->rssi, NULL);
+							BDADDR_TYPE_BR, class,
+							info->rssi, NULL);
 			ptr += INQUIRY_INFO_WITH_RSSI_SIZE;
 		}
 	}
@@ -1857,7 +1859,8 @@ static inline void extended_inquiry_result(int index, int plen, void *ptr)
 					| (info->dev_class[1] << 8)
 					| (info->dev_class[2] << 16);
 
-		btd_event_device_found(&dev->bdaddr, &info->bdaddr, class,
+		btd_event_device_found(&dev->bdaddr, &info->bdaddr,
+						BDADDR_TYPE_BR, class,
 						info->rssi, info->data);
 		ptr += EXTENDED_INQUIRY_INFO_SIZE;
 	}
@@ -2077,19 +2080,27 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
 	le_advertising_info *info;
-	uint8_t num_reports;
+	uint8_t num_reports, rssi;
 	const uint8_t RSSI_SIZE = 1;
 
 	num_reports = meta->data[0];
 
 	info = (le_advertising_info *) &meta->data[1];
-	btd_event_advertising_report(&dev->bdaddr, info);
+	rssi = *(info->data + info->length);
+
+	btd_event_device_found(&dev->bdaddr, &info->bdaddr,
+				info->bdaddr_type, 0, rssi, info->data);
+
 	num_reports--;
 
 	while (num_reports--) {
 		info = (le_advertising_info *) (info->data + info->length +
 								RSSI_SIZE);
-		btd_event_advertising_report(&dev->bdaddr, info);
+		rssi = *(info->data + info->length);
+
+		btd_event_device_found(&dev->bdaddr, &info->bdaddr,
+						info->bdaddr_type, 0,
+						rssi, info->data);
 	}
 }
 
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index be94267..15f024a 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1321,7 +1321,8 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	DBG("hci%u addr %s, class %u rssi %d %s", index, addr, cls,
 						ev->rssi, eir ? "eir" : "");
 
-	btd_event_device_found(&info->bdaddr, &ev->bdaddr, cls, ev->rssi, eir);
+	btd_event_device_found(&info->bdaddr, &ev->bdaddr, BDADDR_TYPE_BR,
+							cls, ev->rssi, eir);
 }
 
 static void mgmt_remote_name(int sk, uint16_t index, void *buf, size_t len)
diff --git a/src/event.c b/src/event.c
index 84a51cf..6dc40c0 100644
--- a/src/event.c
+++ b/src/event.c
@@ -250,23 +250,6 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
-{
-	struct btd_adapter *adapter;
-	int8_t rssi;
-
-	adapter = manager_find_adapter(local);
-	if (adapter == NULL) {
-		error("No matching adapter found");
-		return;
-	}
-
-	rssi = *(info->data + info->length);
-
-	adapter_update_found_devices(adapter, &info->bdaddr, info->bdaddr_type,
-					0, rssi, info->data, info->length);
-}
-
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
 {
 	time_t t;
@@ -289,8 +272,8 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
 	write_lastused_info(sba, dba, tm);
 }
 
-void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-				int8_t rssi, uint8_t *data)
+void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bda_type,
+				uint32_t class, int8_t rssi, uint8_t *data)
 {
 	struct btd_adapter *adapter;
 	int state;
@@ -318,9 +301,8 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		adapter_set_state(adapter, state);
 	}
 
-	adapter_update_found_devices(adapter, peer, BDADDR_TYPE_BR, class,
+	adapter_update_found_devices(adapter, peer, bda_type, class,
 						rssi, data, EIR_DATA_LENGTH);
-
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
diff --git a/src/event.h b/src/event.h
index 765390a..16a900c 100644
--- a/src/event.h
+++ b/src/event.h
@@ -23,9 +23,8 @@
  */
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba);
-void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info);
-void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-						int8_t rssi, uint8_t *data);
+void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bda_type,
+				uint32_t class, int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
-- 
1.7.5.rc3

