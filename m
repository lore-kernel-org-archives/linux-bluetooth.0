Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv3 BlueZ 4/5] plugins/sixaxis: Add a get_leds_data() function
Date: Tue, 27 May 2014 13:25:14 +0200
Message-Id: <1401189915-2092-2-git-send-email-ao2@ao2.it>
In-Reply-To: <1401189915-2092-1-git-send-email-ao2@ao2.it>
References: <1400103605-25183-1-git-send-email-ao2@ao2.it>
 <1401189915-2092-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get all the data necessary to set the LEDs in a single function,
returning a leds_data structure to be passed as argument to the
setup_leds() callback.

For now only a 'bitmap' field is used, which is the only thing that
set_leds_hidraw() needs.
---

Changes since v2:
  - Don't introduce leds_data.syspath_prefix just yet as it is not used so
    far.
  - Make leds_data_destroy() get just pointer, not a pointer to pointer, also
    there is no need to NULL data from it as we have control on where it is
    called: it's not invoked multiple times and hence there is no risk of
    a double free().
  - Move the data allocation in get_leds_data() after get_js_number(udevice)
    and simplify the error path: avoid the goto since leds_data_destroy() is
    called only in one case. 
  - Fix indentation of the arguments of g_io_add_watch(), the last two fit on
    the same line.

Changes since v1:
  - Use capital letter after colon in the short commit message.
  - Add a leds_data_destroy() helper.
  - Use implicit NULL checks for pointers.
  - Use malloc0() from src/shared/utils.h.
  - Add empty line before the return statement in get_leds_data().
  - Remove casting on a void pointer.
  - Instead of 4 strings for the sysfs paths use a sigle string containing the
    common prefix of the sysfs paths of LEDs devices (i.e. the path omitting
    the LED number)

 plugins/sixaxis.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1b7bb30..0279e8e 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -44,6 +44,7 @@
 #include "src/device.h"
 #include "src/plugin.h"
 #include "src/log.h"
+#include "src/shared/util.h"
 
 static const struct {
 	const char *name;
@@ -61,6 +62,15 @@ static const struct {
 	},
 };
 
+struct leds_data {
+	uint8_t bitmap;
+};
+
+static void leds_data_destroy(struct leds_data *data)
+{
+	free(data);
+}
+
 static struct udev *ctx = NULL;
 static struct udev_monitor *monitor = NULL;
 static guint watch_id = 0;
@@ -181,20 +191,21 @@ static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
 static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-	int number = GPOINTER_TO_INT(user_data);
-	uint8_t bitmap;
 	int fd;
+	struct leds_data *data = user_data;
 
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+	if (!data)
 		return FALSE;
 
-	DBG("number %d", number);
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto out;
 
 	fd = g_io_channel_unix_get_fd(channel);
 
-	bitmap = calc_leds_bitmap(number);
-	if (bitmap != 0)
-		set_leds_hidraw(fd, bitmap);
+	set_leds_hidraw(fd, data->bitmap);
+
+out:
+	leds_data_destroy(data);
 
 	return FALSE;
 }
@@ -314,6 +325,27 @@ next:
 	return number;
 }
 
+static struct leds_data *get_leds_data(struct udev_device *udevice)
+{
+	struct leds_data *data;
+	int number;
+
+	number = get_js_number(udevice);
+	DBG("number %d", number);
+
+	data = malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->bitmap = calc_leds_bitmap(number);
+	if (data->bitmap == 0) {
+		leds_data_destroy(data);
+		return NULL;
+	}
+
+	return data;
+}
+
 static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 {
 	struct udev_device *hid_parent;
@@ -374,8 +406,7 @@ static void device_added(struct udev_device *udevice)
 	case BUS_BLUETOOTH:
 		/* wait for events before setting leds */
 		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				setup_leds,
-				GINT_TO_POINTER(get_js_number(udevice)));
+				setup_leds, get_leds_data(udevice));
 
 		break;
 	default:
-- 
2.0.0.rc4

