Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/4] sixaxis: Add support for setting LEDs when connected over USB
Date: Sun,  1 Dec 2013 14:41:56 +0100
Message-Id: <1385905316-21800-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
References: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to setup LEDs when device is connected over USB, not
Bluetooth. This coverts two scenarios:
- user plugged PS3 controller and pressed PS3 button before unplugging,
  in that case LEDs are set
- user plugged already BT connected PS3 controller to USB, this results
  in new /dev/input/jsX device being create but controller is still
  transmitting over BT and old jsX device exists. In that case don't
  set LEDs as they are already set.

This is not directly related to Bluetooth itself but change is really
small and provides much better and consistent user experience.
---
 plugins/sixaxis.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index b8fe287..45fa170 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -181,7 +181,7 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	return FALSE;
 }
 
-static void setup_device(int fd, int index, struct btd_adapter *adapter)
+static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 {
 	char device_addr[18], master_addr[18], adapter_addr[18];
 	bdaddr_t device_bdaddr, master_bdaddr;
@@ -189,22 +189,23 @@ static void setup_device(int fd, int index, struct btd_adapter *adapter)
 	struct btd_device *device;
 
 	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
-		return;
+		return false;
 
 	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
-		return;
+		return false;
 
 	/* This can happen if controller was plugged while already connected
-	 * eg. to charge up battery */
+	 * eg. to charge up battery.
+	 * Don't set LEDs in that case, hence return false */
 	device = btd_adapter_find_device(adapter, &device_bdaddr);
 	if (device && btd_device_is_connected(device))
-		return;
+		return false;
 
 	adapter_bdaddr = btd_adapter_get_address(adapter);
 
 	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
 		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
-			return;
+			return false;
 	}
 
 	ba2str(&device_bdaddr, device_addr);
@@ -218,7 +219,7 @@ static void setup_device(int fd, int index, struct btd_adapter *adapter)
 	if (g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
 						(GCompareFunc)strcasecmp)) {
 		DBG("device %s already known, skipping", device_addr);
-		return;
+		return true;
 	}
 
 	info("sixaxis: setting up new device");
@@ -228,6 +229,8 @@ static void setup_device(int fd, int index, struct btd_adapter *adapter)
 				devices[index].pid, devices[index].version);
 	btd_device_set_temporary(device, FALSE);
 	btd_device_set_trusted(device, TRUE);
+
+	return true;
 }
 
 static int get_js_number(struct udev_device *udevice)
@@ -346,8 +349,10 @@ static void device_added(struct udev_device *udevice)
 
 	switch (bus) {
 	case BUS_USB:
-		setup_device(fd, index, adapter);
-		break;
+		if (!setup_device(fd, index, adapter))
+			break;
+
+		/* fall through */
 	case BUS_BLUETOOTH:
 		/* wait for events before setting leds */
 		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-- 
1.8.5

