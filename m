Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv3 BlueZ 5/5] plugins/sixaxis: Add a set_leds_sysfs() function
Date: Tue, 27 May 2014 13:25:15 +0200
Message-Id: <1401189915-2092-3-git-send-email-ao2@ao2.it>
In-Reply-To: <1401189915-2092-1-git-send-email-ao2@ao2.it>
References: <1400103605-25183-1-git-send-email-ao2@ao2.it>
 <1401189915-2092-1-git-send-email-ao2@ao2.it>
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

Also require libudev >= 172, this is where
udev_enumerate_add_match_parent() has been first introduced.

NOTE: using udev_enumerate_add_match_parent() results in a memory leak
when enumerating child devices, this has been fixed in udev 207; the
commit which fixes the issue is this one:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=51cc07576e119dea6e65478eeba9472979fd0936
---

Changes since v2:
  - Remove some trailing spaces.
  - Re-introduce leds_data.syspath_prefix here where it's actually used for the
    first time.
  - In set_leds_sysfs() move the check for data->syspath_prefix outside the
    loop as it's loop-invariant.
  - Return true/false instead of TRUE/FALSE in set_leds_sysfs() as its return
    type is bool, not gboolean.
  - Wrap the snprintf() invocation in set_leds_sysfs() to fit the 80 chars
    limit.

Changes since v1:
  - Use capital letter after colon in the short commit message.
  - Make set_leds_sysfs() return a bool.
  - Use implicit NULL checks for pointers.
  - Rename get_leds_devices() to get_leds_syspath_prefix() and make it return
    a char * representing the common prefix for all LEDs sysfs paths.
  - Start the loop from 1 in set_leds_sysfs(), now that we use the syspath
    prefix the loop index can match the LEDs numbers.
  - Check the return value of set_leds_sysfs() directly in the condition, do
    not use a 'ret' variable. Being used to the linux kernel style I don't
    particularly like calling functions in conditions but Szymon said it's OK
    in BlueZ for function retuning boolean values.
  - Fix the style of a multi-line comment.

 configure.ac      |  4 +--
 plugins/sixaxis.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index d858ff6..b527530 100644
--- a/configure.ac
+++ b/configure.ac
@@ -125,8 +125,8 @@ AM_CONDITIONAL(MONITOR, test "${enable_monitor}" != "no")
 AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
 		[disable udev device support]), [enable_udev=${enableval}])
 if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
-	PKG_CHECK_MODULES(UDEV, libudev >= 143, dummy=yes,
-				AC_MSG_ERROR(libudev >= 143 is required))
+	PKG_CHECK_MODULES(UDEV, libudev >= 172, dummy=yes,
+				AC_MSG_ERROR(libudev >= 172 is required))
 	AC_SUBST(UDEV_CFLAGS)
 	AC_SUBST(UDEV_LIBS)
 	AC_CHECK_LIB(udev, udev_hwdb_new,
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 0279e8e..de878d1 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -63,11 +63,13 @@ static const struct {
 };
 
 struct leds_data {
+	char *syspath_prefix;
 	uint8_t bitmap;
 };
 
 static void leds_data_destroy(struct leds_data *data)
 {
+	free(data->syspath_prefix);
 	free(data);
 }
 
@@ -188,10 +190,41 @@ static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
 		error("sixaxis: failed to set LEDS (%d bytes written)", ret);
 }
 
+static bool set_leds_sysfs(struct leds_data *data)
+{
+	int i;
+
+	if (!data->syspath_prefix)
+		return false;
+
+	/* start from 1, LED0 is never used */
+	for (i = 1; i <= 4; i++) {
+		char path[PATH_MAX] = { 0 };
+		char buf[2] = { 0 };
+		int fd;
+		int ret;
+
+		snprintf(path, PATH_MAX, "%s%d/brightness",
+			 data->syspath_prefix, i);
+		fd = open(path, O_WRONLY);
+		if (fd < 0) {
+			error("sixaxis: cannot open %s (%s)", path, strerror(errno));
+			return false;
+		}
+
+		buf[0] = '0' + !!(data->bitmap & (1 << i));
+		ret = write(fd, buf, sizeof(buf));
+		close(fd);
+		if (ret != sizeof(buf))
+			return false;
+	}
+
+	return true;
+}
+
 static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-	int fd;
 	struct leds_data *data = user_data;
 
 	if (!data)
@@ -200,9 +233,10 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		goto out;
 
-	fd = g_io_channel_unix_get_fd(channel);
-
-	set_leds_hidraw(fd, data->bitmap);
+	if(!set_leds_sysfs(data)) {
+		int fd = g_io_channel_unix_get_fd(channel);
+		set_leds_hidraw(fd, data->bitmap);
+	}
 
 out:
 	leds_data_destroy(data);
@@ -325,6 +359,45 @@ next:
 	return number;
 }
 
+static char *get_leds_syspath_prefix(struct udev_device *udevice)
+{
+	struct udev_list_entry *dev_list_entry;
+	struct udev_enumerate *enumerate;
+	struct udev_device *hid_parent;
+	const char *syspath;
+	char *syspath_prefix;
+
+	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
+								"hid", NULL);
+
+	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
+	udev_enumerate_add_match_parent(enumerate, hid_parent);
+	udev_enumerate_add_match_subsystem(enumerate, "leds");
+	udev_enumerate_scan_devices(enumerate);
+
+	dev_list_entry = udev_enumerate_get_list_entry(enumerate);
+	if (!dev_list_entry) {
+		syspath_prefix = NULL;
+		goto out;
+	}
+
+	syspath = udev_list_entry_get_name(dev_list_entry);
+
+	/*
+	 * All the sysfs paths of the LEDs have the same structure, just the
+	 * number changes, so strip it and store only the common prefix.
+	 *
+	 * Subtracting 1 here means assuming that the LED number is a single
+	 * digit, this is safe as the kernel driver only exposes 4 LEDs.
+	 */
+	syspath_prefix = strndup(syspath, strlen(syspath) - 1);
+
+out:
+	udev_enumerate_unref(enumerate);
+
+	return syspath_prefix;
+}
+
 static struct leds_data *get_leds_data(struct udev_device *udevice)
 {
 	struct leds_data *data;
@@ -343,6 +416,12 @@ static struct leds_data *get_leds_data(struct udev_device *udevice)
 		return NULL;
 	}
 
+	/*
+	 * It's OK if this fails, set_leds_hidraw() will be used in
+	 * case data->syspath_prefix is NULL.
+	 */
+	data->syspath_prefix = get_leds_syspath_prefix(udevice);
+
 	return data;
 }
 
-- 
2.0.0.rc4

