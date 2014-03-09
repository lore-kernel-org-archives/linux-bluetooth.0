Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/3] android: Add tracking for pending confirm name command
Date: Mon, 10 Mar 2014 00:06:35 +0100
Message-ID: <1394406397-6843-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ba4f14b..60ca17d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -97,6 +97,8 @@ struct device {
 	GSList *uuids;
 
 	bool found; /* if device is found in current discovery session */
+	unsigned int confirm_id; /* mgtm command id if command pending */
+
 };
 
 struct browse_req {
@@ -318,6 +320,9 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 
 static void free_device(struct device *dev)
 {
+	if (dev->confirm_id)
+		mgmt_cancel(mgmt_if, dev->confirm_id);
+
 	g_free(dev->name);
 	g_free(dev->friendly_name);
 	g_slist_free_full(dev->uuids, g_free);
@@ -1023,10 +1028,31 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
-static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
+static void confirm_device_name_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_confirm_name *rp = param;
+	struct device *dev;
+
+	DBG("Confirm name status: %s (0x%02x)", mgmt_errstr(status), status);
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of confirm name response");
+		return;
+	}
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
@@ -1035,9 +1061,13 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
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
@@ -1205,7 +1235,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		info("Device %s needs name confirmation (resolve_name=%d)",
 							addr, resolve_name);
-		confirm_device_name(bdaddr, bdaddr_type, resolve_name);
+		dev->confirm_id = confirm_device_name(bdaddr, bdaddr_type,
+								resolve_name);
 	}
 }
 
-- 
1.8.4

