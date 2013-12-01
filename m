Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/4] sixaxis: Add support for setting PS3 controller LEDs
Date: Sun,  1 Dec 2013 14:41:53 +0100
Message-Id: <1385905316-21800-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
References: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will set controller LEDs according to joystick device number
when controller is connected over Bluetooth. If joystick number is too
big (> 7) or falied to be read, set it to 0 to switch off all LEDs.
This will allow to disable LEDs blinking after connection.

Waiting for events is not really needed when connected over Bluetooth
but this is in preparation for supporting LEDs setup over USB.
---
 plugins/sixaxis.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 070b463..c3ca267 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -31,6 +31,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <sys/ioctl.h>
 #include <linux/hidraw.h>
 #include <linux/input.h>
@@ -124,6 +125,62 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
+static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	/*
+	 * the total time the led is active (0xff means forever)
+	 * |     duty_length: cycle time in deciseconds (0 - "blink very fast")
+	 * |     |     ??? (Maybe a phase shift or duty_length multiplier?)
+	 * |     |     |     % of duty_length led is off (0xff means 100%)
+	 * |     |     |     |     % of duty_length led is on (0xff means 100%)
+	 * |     |     |     |     |
+	 * 0xff, 0x27, 0x10, 0x00, 0x32,
+	 */
+	uint8_t leds_report[] = {
+		0x01,
+		0x00, 0x00, 0x00, 0x00, 0x00, /* rumble values TBD */
+		0x00, 0x00, 0x00, 0x00, 0x00, /* LED_1=0x02, LED_2=0x04 ... */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_4 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_3 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_2 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_1 */
+		0x00, 0x00, 0x00, 0x00, 0x00,
+	};
+	int number = GPOINTER_TO_INT(user_data);
+	int ret;
+	int fd;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		return FALSE;
+
+	DBG("number %d", number);
+
+	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
+	if (number > 7)
+		return FALSE;
+
+	if (number > 4) {
+		leds_report[10] |= 0x10;
+		number -= 4;
+	}
+
+	leds_report[10] |= 0x01 << number;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	ret = write(fd, leds_report, sizeof(leds_report));
+	if (ret == sizeof(leds_report))
+		return FALSE;
+
+	if (ret < 0)
+		error("sixaxis: failed to set LEDS (%s)", strerror(errno));
+	else
+		error("sixaxis: failed to set LEDS (%d bytes written)", ret);
+
+	return FALSE;
+}
+
 static void setup_device(int fd, int index, struct btd_adapter *adapter)
 {
 	char device_addr[18], master_addr[18], adapter_addr[18];
@@ -167,6 +224,69 @@ static void setup_device(int fd, int index, struct btd_adapter *adapter)
 	btd_device_set_trusted(device, TRUE);
 }
 
+static int get_js_number(struct udev_device *udevice)
+{
+	struct udev_list_entry *devices, *dev_list_entry;
+	struct udev_enumerate *enumerate;
+	struct udev_device *hid_parent;
+	const char *hidraw_node;
+	const char *hid_phys;
+	int number = 0;
+
+	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
+								"hid", NULL);
+
+	hid_phys = udev_device_get_property_value(hid_parent, "HID_PHYS");
+	hidraw_node = udev_device_get_devnode(udevice);
+	if (!hid_phys || !hidraw_node)
+		return 0;
+
+	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
+	udev_enumerate_add_match_sysname(enumerate, "js*");
+	udev_enumerate_scan_devices(enumerate);
+	devices = udev_enumerate_get_list_entry(enumerate);
+
+	udev_list_entry_foreach(dev_list_entry, devices) {
+		struct udev_device *input_parent;
+		struct udev_device *js_dev;
+		const char *input_phys;
+		const char *devname;
+
+		devname = udev_list_entry_get_name(dev_list_entry);
+		js_dev = udev_device_new_from_syspath(
+						udev_device_get_udev(udevice),
+						devname);
+
+		input_parent = udev_device_get_parent_with_subsystem_devtype(
+							js_dev, "input", NULL);
+		if (!input_parent)
+			goto next;
+
+		/* check if this is the joystick relative to the hidraw device
+		 * above */
+		input_phys = udev_device_get_sysattr_value(input_parent,
+									"phys");
+		if (!input_phys)
+			goto next;
+
+		if (!strcmp(input_phys, hid_phys)) {
+			number = atoi(udev_device_get_sysnum(js_dev));
+
+			/* joystick numbers start from 0, leds from 1 */
+			number++;
+
+			udev_device_unref(js_dev);
+			break;
+		}
+next:
+		udev_device_unref(js_dev);
+	}
+
+	udev_enumerate_unref(enumerate);
+
+	return number;
+}
+
 static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 {
 	struct udev_device *hid_parent;
@@ -195,6 +315,7 @@ static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 static void device_added(struct udev_device *udevice)
 {
 	struct btd_adapter *adapter;
+	GIOChannel *io;
 	uint16_t bus;
 	int index;
 	int fd;
@@ -215,10 +336,26 @@ static void device_added(struct udev_device *udevice)
 	if (fd < 0)
 		return;
 
-	if (bus == BUS_USB)
+	io = g_io_channel_unix_new(fd);
+
+	switch (bus) {
+	case BUS_USB:
 		setup_device(fd, index, adapter);
+		break;
+	case BUS_BLUETOOTH:
+		/* wait for events before setting leds */
+		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				setup_leds,
+				GINT_TO_POINTER(get_js_number(udevice)));
+
+		break;
+	default:
+		DBG("uknown bus type (%u)", bus);
+		break;
+	}
 
-	close(fd);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_unref(io);
 }
 
 static gboolean monitor_watch(GIOChannel *source, GIOCondition condition,
-- 
1.8.5

