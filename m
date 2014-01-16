Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] android/bluetooth: Fix discovering new devices
Date: Thu, 16 Jan 2014 14:35:25 +0100
Message-Id: <1389879325-21217-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device found events should be send also for known devices if this is
new discovery session. Otherwise Android will ignore those devices.
---
V2: report bonded devices in same way as non-bonded


 android/bluetooth.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f1e5458..b235cbd 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -90,6 +90,8 @@ struct device {
 	uint32_t timestamp;
 
 	GSList *uuids;
+
+	bool found; /* if device is found in current discovery session */
 };
 
 struct browse_req {
@@ -903,6 +905,13 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
 
+static void clear_device_found(gpointer data, gpointer user_data)
+{
+	struct device *dev = data;
+
+	dev->found = false;
+}
+
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -924,10 +933,12 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	DBG("new discovering state %u", ev->discovering);
 
-	if (adapter.discovering)
+	if (adapter.discovering) {
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
-	else
+	} else {
+		g_slist_foreach(devices, clear_device_found, NULL);
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
+	}
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
@@ -983,12 +994,15 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	eir_parse(&eir, data, data_len);
 
 	dev = find_device(bdaddr);
-	if (!dev) {
+	if (!dev || !dev->found) {
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

