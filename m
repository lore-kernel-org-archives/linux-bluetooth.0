Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Fix discovering new devices
Date: Tue, 14 Jan 2014 10:31:03 +0100
Message-Id: <1389691863-4827-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device found events should be send also for known devices if this is
new discovery session. Otherwise Android will ignore those devices.
---
 android/bluetooth.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f1e5458..735b03e 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -90,6 +90,8 @@ struct device {
 	uint32_t timestamp;
 
 	GSList *uuids;
+
+	bool found; /* if device is found in current discovery session */
 };
 
 struct browse_req {
@@ -924,10 +926,19 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	DBG("new discovering state %u", ev->discovering);
 
-	if (adapter.discovering)
+	if (adapter.discovering) {
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
-	else
+	} else {
+		GSList *l;
+
+		for(l = devices; l; l = g_slist_next(l)) {
+			struct device *dev = l->data;
+
+			dev->found = false;
+		}
+
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
+	}
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
@@ -966,6 +977,17 @@ static uint8_t bdaddr_type2android(uint8_t type)
 	return HAL_TYPE_LE;
 }
 
+static bool device_found_needed(struct device *dev)
+{
+	if (!dev)
+		return true;
+
+	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+		return false;
+
+	return !dev->found;
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
@@ -983,12 +1005,15 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	eir_parse(&eir, data, data_len);
 
 	dev = find_device(bdaddr);
-	if (!dev) {
+	if (device_found_needed(dev)) {
 		struct hal_ev_device_found *ev = (void *) buf;
 		bdaddr_t android_bdaddr;
 		uint8_t android_type;
 
-		dev = create_device(bdaddr, bdaddr_type);
+		if (!dev)
+			dev = create_device(bdaddr, bdaddr_type);
+
+		dev->found = true;
 
 		size += sizeof(*ev);
 
-- 
1.8.3.2

