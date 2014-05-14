Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv2 BlueZ 4/5] plugins/sixaxis: Add a get_leds_data() function
Date: Wed, 14 May 2014 23:40:04 +0200
Message-Id: <1400103605-25183-4-git-send-email-ao2@ao2.it>
In-Reply-To: <1400103605-25183-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
 <1400103605-25183-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get all the data necessary to set the LEDs (bitmap and/or sysfs path
prefix) in a single function, returning a leds_data structure to be
passed as argument to the setup_leds() callback.

For now only the bitmap field is populated, which is the only thing that
set_leds_hidraw() needs.
---

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

 plugins/sixaxis.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1b7bb30..56110a4 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -44,6 +44,7 @@
 #include "src/device.h"
 #include "src/plugin.h"
 #include "src/log.h"
+#include "src/shared/util.h"
 
 static const struct {
 	const char *name;
@@ -61,6 +62,20 @@ static const struct {
 	},
 };
 
+struct leds_data {
+	char *syspath_prefix;
+	uint8_t bitmap;
+};
+
+static void leds_data_destroy(struct leds_data **data)
+{
+	free((*data)->syspath_prefix);
+	(*data)->syspath_prefix = NULL;
+
+	free(*data);
+	*data = NULL;
+}
+
 static struct udev *ctx = NULL;
 static struct udev_monitor *monitor = NULL;
 static guint watch_id = 0;
@@ -181,20 +196,21 @@ static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
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
+	leds_data_destroy(&data);
 
 	return FALSE;
 }
@@ -314,6 +330,30 @@ next:
 	return number;
 }
 
+static struct leds_data *get_leds_data(struct udev_device *udevice)
+{
+	struct leds_data *data;
+	int number;
+
+	data = malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	number = get_js_number(udevice);
+	DBG("number %d", number);
+
+	data->bitmap = calc_leds_bitmap(number);
+	if (data->bitmap == 0)
+		goto err;
+
+	return data;
+
+err:
+	leds_data_destroy(&data);
+
+	return NULL;
+}
+
 static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 {
 	struct udev_device *hid_parent;
@@ -375,7 +415,7 @@ static void device_added(struct udev_device *udevice)
 		/* wait for events before setting leds */
 		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				setup_leds,
-				GINT_TO_POINTER(get_js_number(udevice)));
+				get_leds_data(udevice));
 
 		break;
 	default:
-- 
2.0.0.rc2

