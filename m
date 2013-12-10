Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/8] android/bluetooth: Use single list for device caching
Date: Tue, 10 Dec 2013 16:06:16 +0100
Message-Id: <1386687982-1799-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
References: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes code much simpler and easier to follow. It is also
a preparation for supporting remote device properties getting, setting
and storing.
---
 android/bluetooth.c | 160 ++++++++++++++++++++++------------------------------
 1 file changed, 67 insertions(+), 93 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f8df473..17c8e7a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -111,9 +111,59 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
-static GSList *found_devices = NULL;
 static GSList *devices = NULL;
 
+static int bdaddr_cmp(gconstpointer a, gconstpointer b)
+{
+	const bdaddr_t *bda = a;
+	const bdaddr_t *bdb = b;
+
+	return bacmp(bdb, bda);
+}
+
+static struct device *find_device(const bdaddr_t *bdaddr)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(devices, bdaddr, bdaddr_cmp);
+	if (l)
+		return l->data;
+
+	return NULL;
+}
+
+static struct device *create_device(const bdaddr_t *bdaddr)
+{
+	struct device *dev;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("%s", addr);
+
+	dev = g_new0(struct device, 1);
+
+	bacpy(&dev->bdaddr, bdaddr);
+	dev->bond_state = HAL_BOND_STATE_NONE;
+
+	/* use address for name, will be change if one is present
+	 * eg. in EIR or set by set_property. */
+	dev->name = g_strdup(addr);
+	devices = g_slist_prepend(devices, dev);
+
+	return dev;
+}
+
+static struct device *get_device(const bdaddr_t *bdaddr)
+{
+	struct device *dev;
+
+	dev = find_device(bdaddr);
+	if (dev)
+		return dev;
+
+	return create_device(bdaddr);
+}
+
 static void adapter_name_changed(const uint8_t *name)
 {
 	struct hal_ev_adapter_props_changed *ev;
@@ -308,14 +358,6 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 
 }
 
-static int bdaddr_cmp(gconstpointer a, gconstpointer b)
-{
-	const bdaddr_t *bda = a;
-	const bdaddr_t *bdb = b;
-
-	return bacmp(bdb, bda);
-}
-
 static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 								uint8_t state)
 {
@@ -329,46 +371,12 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 							sizeof(ev), &ev);
 }
 
-static void cache_device_name(const bdaddr_t *addr, const char *name)
-{
-	struct device *dev = NULL;
-	GSList *l;
-
-	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
-	if (l)
-		dev = l->data;
-
-	if (!dev) {
-		dev = g_new0(struct device, 1);
-		bacpy(&dev->bdaddr, addr);
-		dev->bond_state = HAL_BOND_STATE_NONE;
-		devices = g_slist_prepend(devices, dev);
-	}
-
-	if (!g_strcmp0(dev->name, name))
-		return;
-
-	g_free(dev->name);
-	dev->name = g_strdup(name);
-	/*TODO: Do some real caching here */
-}
-
 static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 								int state) {
 
-	struct device *dev = NULL;
-	GSList *l;
-
-	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
-	if (l)
-		dev = l->data;
+	struct device *dev;
 
-	if (!dev) {
-		dev = g_new0(struct device, 1);
-		bacpy(&dev->bdaddr, addr);
-		dev->bond_state = HAL_BOND_STATE_NONE;
-		devices = g_slist_prepend(devices, dev);
-	}
+	dev = get_device(addr);
 
 	if (dev->bond_state != state) {
 		dev->bond_state = state;
@@ -566,42 +574,23 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	browse_remote_sdp(&addr->bdaddr);
 }
 
-static const char *get_device_name(const bdaddr_t *addr)
-{
-	GSList *l;
-
-	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
-	if (l) {
-		struct device *dev = l->data;
-		return dev->name;
-	}
-
-	return NULL;
-}
-
 static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 {
 	struct hal_ev_remote_device_props *ev;
-	const char *name;
+	struct device *dev;
 	size_t ev_len;
-	char dst[18];
 
-	/* Use cached name or bdaddr string */
-	name = get_device_name(bdaddr);
-	if (!name) {
-		ba2str(bdaddr, dst);
-		name = dst;
-	}
+	dev = get_device(bdaddr);
 
-	ev_len = BASELEN_REMOTE_DEV_PROP + strlen(name);
+	ev_len = BASELEN_REMOTE_DEV_PROP + strlen(dev->name);
 	ev = g_malloc0(ev_len);
 
 	ev->status = HAL_STATUS_SUCCESS;
 	bdaddr2android(bdaddr, ev->bdaddr);
 	ev->num_props = 1;
 	ev->props[0].type = HAL_PROP_DEVICE_NAME;
-	ev->props[0].len = strlen(name);
-	memcpy(&ev->props[0].val, name, strlen(name));
+	ev->props[0].len = strlen(dev->name);
+	memcpy(&ev->props[0].val, dev->name, strlen(dev->name));
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
 								ev_len, ev);
@@ -749,14 +738,10 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	DBG("new discovering state %u", ev->discovering);
 
-	if (adapter.discovering) {
+	if (adapter.discovering)
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
-	} else {
-		g_slist_free_full(found_devices, g_free);
-		found_devices = NULL;
-
+	else
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
-	}
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
@@ -793,8 +778,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					const uint8_t *data, uint8_t data_len)
 {
 	uint8_t buf[BLUEZ_HAL_MTU];
-	bool new_dev = false;
 	struct eir_data eir;
+	struct device *dev;
 	uint8_t *num_prop;
 	uint8_t opcode;
 	int size = 0;
@@ -804,25 +789,13 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	eir_parse(&eir, data, data_len);
 
-	if (!g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp)) {
-		bdaddr_t *new_bdaddr;
-		char addr[18];
-
-		new_bdaddr = g_new0(bdaddr_t, 1);
-		bacpy(new_bdaddr, bdaddr);
-
-		found_devices = g_slist_prepend(found_devices, new_bdaddr);
-
-		ba2str(new_bdaddr, addr);
-		DBG("New device found: %s", addr);
-
-		new_dev = true;
-	}
-
-	if (new_dev) {
+	dev = find_device(bdaddr);
+	if (!dev) {
 		struct hal_ev_device_found *ev = (void *) buf;
 		bdaddr_t android_bdaddr;
 
+		dev = create_device(bdaddr);
+
 		size += sizeof(*ev);
 
 		num_prop = &ev->num_props;
@@ -858,7 +831,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	}
 
 	if (eir.name) {
-		cache_device_name(bdaddr, eir.name);
+		g_free(dev->name);
+		dev->name = g_strdup(eir.name);
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
 						strlen(eir.name), eir.name);
-- 
1.8.3.2

