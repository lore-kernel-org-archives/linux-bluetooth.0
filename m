Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 2/4] android: Cache device name on device list.
Date: Fri, 15 Nov 2013 19:03:59 +0100
Message-ID: <1384538641-1873-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 69 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8f9712f..853f5a8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -96,6 +96,7 @@ static struct {
 struct device {
 	bdaddr_t bdaddr;
 	int bond_state;
+	char *name;
 };
 
 struct browse_req {
@@ -330,6 +331,30 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
+static void cache_device_name(const bdaddr_t *addr, const char *name)
+{
+	struct device *dev = NULL;
+	GSList *l;
+
+	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
+	if (l)
+		dev = l->data;
+
+	if (!dev) {
+		dev = g_new0(struct device, 1);
+		bacpy(&dev->bdaddr, addr);
+		dev->bond_state = HAL_BOND_STATE_NONE;
+		devices = g_slist_prepend(devices, dev);
+	}
+
+	if (!g_strcmp0(dev->name, name))
+		return;
+
+	g_free(dev->name);
+	dev->name = g_strdup(name);
+	/*TODO: Do some real caching here */
+}
+
 static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 								int state) {
 
@@ -542,14 +567,33 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	browse_remote_sdp(&addr->bdaddr);
 }
 
-static void send_remote_device_name_prop(const bdaddr_t *bdaddr,
-							const char *name)
+static const char * get_device_name(const bdaddr_t *addr)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
+	if (l) {
+		struct device *dev = l->data;
+		return dev->name;
+	}
+
+	return NULL;
+}
+
+static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 {
 	struct hal_ev_remote_device_props *ev;
-	uint8_t buf[BASELEN_REMOTE_DEV_PROP + strlen(name)];
+	size_t ev_len = BASELEN_REMOTE_DEV_PROP;
+	const char *name;
+	char dst[18];
 
-	ev = (void *) buf;
-	memset(buf, 0, sizeof(buf));
+	/* Use cached name or bdaddr string */
+	name = get_device_name(bdaddr);
+	if (!name)
+		name = dst;
+
+	ev_len += strlen(name);
+	ev = g_malloc0(ev_len);
 
 	ev->status = HAL_STATUS_SUCCESS;
 	bdaddr2android(bdaddr, ev->bdaddr);
@@ -559,7 +603,9 @@ static void send_remote_device_name_prop(const bdaddr_t *bdaddr,
 	memcpy(&ev->props[0].val, name, strlen(name));
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_REMOTE_DEVICE_PROPS, sizeof(buf), ev, -1);
+			HAL_EV_REMOTE_DEVICE_PROPS, sizeof(ev), ev, -1);
+
+	g_free(ev);
 }
 
 static void pin_code_request_callback(uint16_t index, uint16_t length,
@@ -577,15 +623,16 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 
 	/* Workaround for Android Bluetooth.apk issue: send remote
-	 * device property. Lets use address as a name for now */
-	send_remote_device_name_prop(&ev->addr.bdaddr, dst);
+	 * device property */
+	send_remote_device_name_prop(&ev->addr.bdaddr);
 
 	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
-	/* TODO name and CoD of remote devices should probably be cached */
+	/* TODO CoD of remote devices should probably be cached
+	 * Name we already send in remote device prop */
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
@@ -800,8 +847,10 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	props_size += sizeof(struct hal_property) + sizeof(eir.class);
 	props_size += sizeof(struct hal_property) + sizeof(rssi);
 
-	if (eir.name)
+	if (eir.name) {
 		props_size += sizeof(struct hal_property) + strlen(eir.name);
+		cache_device_name(remote, eir.name);
+	}
 
 	if (is_new_dev) {
 		struct hal_ev_device_found *ev = NULL;
-- 
1.8.4

