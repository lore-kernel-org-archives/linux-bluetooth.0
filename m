Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 15/17] android: Add tracking for pending confirm name command
Date: Wed, 26 Feb 2014 02:57:26 +0100
Message-ID: <1393379848-4031-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull in case we want to cancel discovery during
big inflow on device found events.
---
 android/bluetooth.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7f37590..e0bc730 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -96,6 +96,8 @@ struct device {
 	GSList *uuids;
 
 	bool found; /* if device is found in current discovery session */
+	unsigned int confirm_id; /* mgtm command id if command pending */
+
 };
 
 struct browse_req {
@@ -315,6 +317,9 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 
 static void free_device(struct device *dev)
 {
+	if (dev->confirm_id)
+		mgmt_cancel(mgmt_if, dev->confirm_id);
+
 	g_free(dev->name);
 	g_free(dev->friendly_name);
 	g_slist_free_full(dev->uuids, g_free);
@@ -1020,10 +1025,24 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
-static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
+static void confirm_device_name_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_confirm_name *rp = param;
+	struct device *dev;
+
+	dev = find_device(&rp->addr.bdaddr);
+	if (!dev)
+		return;
+
+	dev->confirm_id = 0;
+}
+
+static unsigned int confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
 							bool resolve_name)
 {
 	struct mgmt_cp_confirm_name cp;
+	unsigned int res;
 
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, addr);
@@ -1032,9 +1051,13 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
 	if (!resolve_name)
 		cp.name_known = 1;
 
-	if (mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
-				sizeof(cp), &cp, NULL, NULL, NULL) == 0)
+	res = mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
+				sizeof(cp), &cp, confirm_device_name_cb,
+				NULL, NULL);
+	if (!res)
 		error("Failed to send confirm name request");
+
+	return res;
 }
 
 static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
@@ -1204,7 +1227,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		info("Device %s needs name confirmation (resolve_name=%d)",
 							addr, resolve_name);
-		confirm_device_name(bdaddr, bdaddr_type, resolve_name);
+		dev->confirm_id = confirm_device_name(bdaddr, bdaddr_type,
+								resolve_name);
 	}
 }
 
-- 
1.8.4

