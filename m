Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, juha.kuikka@gmail.com,
        frank.praznik@gmail.com, roderick.colenbrander@sony.com
Subject: [PATCH v2 1/4] sixaxis: Re-organize functions for refactoring
Date: Wed, 28 Dec 2016 16:32:40 -0800
Message-Id: <1482971563-15745-2-git-send-email-juha.kuikka@gmail.com>
In-Reply-To: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No functional changes, only moving functions around in file.
---
 plugins/sixaxis.c | 104 +++++++++++++++++++++++++++---------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index fcc93bc..d62c6db 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -255,58 +255,6 @@ out:
 	return FALSE;
 }
 
-static bool setup_device(int fd, int index, struct btd_adapter *adapter)
-{
-	char device_addr[18], master_addr[18], adapter_addr[18];
-	bdaddr_t device_bdaddr, master_bdaddr;
-	const bdaddr_t *adapter_bdaddr;
-	struct btd_device *device;
-
-	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
-		return false;
-
-	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
-		return false;
-
-	/* This can happen if controller was plugged while already connected
-	 * eg. to charge up battery.
-	 * Don't set LEDs in that case, hence return false */
-	device = btd_adapter_find_device(adapter, &device_bdaddr,
-							BDADDR_BREDR);
-	if (device && btd_device_is_connected(device))
-		return false;
-
-	adapter_bdaddr = btd_adapter_get_address(adapter);
-
-	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
-		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
-			return false;
-	}
-
-	ba2str(&device_bdaddr, device_addr);
-	ba2str(&master_bdaddr, master_addr);
-	ba2str(adapter_bdaddr, adapter_addr);
-	DBG("remote %s old_master %s new_master %s",
-				device_addr, master_addr, adapter_addr);
-
-	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
-
-	if (g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
-						(GCompareFunc)strcasecmp)) {
-		DBG("device %s already known, skipping", device_addr);
-		return true;
-	}
-
-	info("sixaxis: setting up new device");
-
-	btd_device_device_set_name(device, devices[index].name);
-	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
-				devices[index].pid, devices[index].version);
-	btd_device_set_temporary(device, false);
-
-	return true;
-}
-
 static int get_js_number(struct udev_device *udevice)
 {
 	struct udev_list_entry *devices, *dev_list_entry;
@@ -453,6 +401,58 @@ static struct leds_data *get_leds_data(struct udev_device *udevice)
 	return data;
 }
 
+static bool setup_device(int fd, int index, struct btd_adapter *adapter)
+{
+	char device_addr[18], master_addr[18], adapter_addr[18];
+	bdaddr_t device_bdaddr, master_bdaddr;
+	const bdaddr_t *adapter_bdaddr;
+	struct btd_device *device;
+
+	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
+		return false;
+
+	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
+		return false;
+
+	/* This can happen if controller was plugged while already connected
+	 * eg. to charge up battery.
+	 * Don't set LEDs in that case, hence return false */
+	device = btd_adapter_find_device(adapter, &device_bdaddr,
+							BDADDR_BREDR);
+	if (device && btd_device_is_connected(device))
+		return false;
+
+	adapter_bdaddr = btd_adapter_get_address(adapter);
+
+	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
+		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
+			return false;
+	}
+
+	ba2str(&device_bdaddr, device_addr);
+	ba2str(&master_bdaddr, master_addr);
+	ba2str(adapter_bdaddr, adapter_addr);
+	DBG("remote %s old_master %s new_master %s",
+				device_addr, master_addr, adapter_addr);
+
+	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
+
+	if (g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
+						(GCompareFunc)strcasecmp)) {
+		DBG("device %s already known, skipping", device_addr);
+		return true;
+	}
+
+	info("sixaxis: setting up new device");
+
+	btd_device_device_set_name(device, devices[index].name);
+	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
+				devices[index].pid, devices[index].version);
+	btd_device_set_temporary(device, false);
+
+	return true;
+}
+
 static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 {
 	struct udev_device *hid_parent;
-- 
2.7.4

