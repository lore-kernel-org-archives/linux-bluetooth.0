Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH BlueZ 5/5] plugins/sixaxis: add a set_leds_sysfs() function
Date: Tue,  6 May 2014 12:06:16 +0200
Message-Id: <1399370776-5027-6-git-send-email-ao2@ao2.it>
In-Reply-To: <1399370776-5027-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On recent kernels the hid-sony driver exposes leds class entries in
sysfs for setting the Sixaxis LEDs, use this interface and fall back to
hidraw in case using sysfs fails (e.g. on older hid-sony versions).

Setting the LEDs via sysfs is the preferred way on newer kernels, the
rationale behind that is:

  1. the Sixaxis uses the same HID output report for setting both LEDs
     and rumble effects;
  2. hid-sony remembers the state of LEDs in order to preserve them when
     setting rumble effects;
  3. when the LEDs are set via hidraw hid-sony has no way to know the
     new LEDs state and thus can change the LEDs in an inconsistent way
     when setting rumble effects later.
---
 plugins/sixaxis.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 2b35d1c..446d499 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -185,10 +185,40 @@ static gboolean set_leds_hidraw(int fd, uint8_t leds_bitmap)
 	return FALSE;
 }
 
+static gboolean set_leds_sysfs(struct leds_data *data)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		char path[PATH_MAX] = { 0 };
+		char buf[2] = { 0 };
+		int fd;
+		int ret;
+
+		if (data->syspaths[i] == NULL)
+			return FALSE;
+
+		snprintf(path, PATH_MAX, "%s/brightness", data->syspaths[i]);
+		fd = open(path, O_WRONLY);
+		if (fd < 0) {
+			error("Cannot open %s (%s)", path, strerror(errno));
+			return FALSE;
+		}
+
+		/* i+1 because leds start from 1, LED0 is never used */
+		buf[0] = '0' + !!(data->bitmap & (1 << (i+1)));
+		ret = write(fd, buf, sizeof(buf));
+		close(fd);
+		if (ret != sizeof(buf))
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
 static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-	int fd;
 	int i;
 	int ret;
 	struct leds_data *data = (struct leds_data *)user_data;
@@ -199,9 +229,11 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		goto out;
 
-	fd = g_io_channel_unix_get_fd(channel);
-
-	set_leds_hidraw(fd, data->bitmap);
+	ret = set_leds_sysfs(data);
+	if (ret == FALSE) {
+		int fd = g_io_channel_unix_get_fd(channel);
+		set_leds_hidraw(fd, data->bitmap);
+	}
 
 out:
 	for (i = 0; i < 4; i++)
@@ -324,6 +356,39 @@ static int get_js_number(struct udev_device *udevice)
 	return number;
 }
 
+static int get_leds_devices(struct udev_device *udevice, char *paths[4])
+{
+	struct udev_list_entry *devices, *dev_list_entry;
+	struct udev_enumerate *enumerate;
+	struct udev_device *hid_parent;
+	int index = 0;
+	int ret;
+
+	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
+								"hid", NULL);
+
+	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
+	udev_enumerate_add_match_parent(enumerate, hid_parent);
+	udev_enumerate_add_match_subsystem(enumerate, "leds");
+	udev_enumerate_scan_devices(enumerate);
+	devices = udev_enumerate_get_list_entry(enumerate);
+
+	if (devices == NULL) {
+		ret = FALSE;
+		goto out;
+	}
+
+	udev_list_entry_foreach(dev_list_entry, devices) {
+		const char *syspath = udev_list_entry_get_name(dev_list_entry);
+		paths[index++] = strdup(syspath);
+	}
+
+	ret = TRUE;
+out:
+	udev_enumerate_unref(enumerate);
+	return ret;
+}
+
 static struct leds_data *get_leds_data(struct udev_device *udevice)
 {
 	struct leds_data *data;
@@ -344,6 +409,10 @@ static struct leds_data *get_leds_data(struct udev_device *udevice)
 	if (ret == FALSE)
 		goto err;
 
+	/* it's OK if this fails, set_leds_hidraw() will be used if
+	 * any of the values in data->syspaths is not defined */
+	get_leds_devices(udevice, data->syspaths);
+
 	return data;
 
 err:
-- 
2.0.0.rc0

