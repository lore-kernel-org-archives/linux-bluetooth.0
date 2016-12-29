Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, juha.kuikka@gmail.com,
        frank.praznik@gmail.com, roderick.colenbrander@sony.com
Subject: [PATCH v2 2/4] sixaxis: Refactor to add device-specific functions
Date: Wed, 28 Dec 2016 16:32:41 -0800
Message-Id: <1482971563-15745-3-git-send-email-juha.kuikka@gmail.com>
In-Reply-To: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In preparation for adding support for DS4 controller, refactor
address access methods per device type.

Also move the sixaxis controller LED setup into a "post_connect"
function.
---
 plugins/sixaxis.c | 111 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 46 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index d62c6db..99f4d0b 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -48,29 +48,6 @@
 #include "src/log.h"
 #include "src/shared/util.h"
 
-static const struct {
-	const char *name;
-	uint16_t source;
-	uint16_t vid;
-	uint16_t pid;
-	uint16_t version;
-} devices[] = {
-	{
-		.name = "PLAYSTATION(R)3 Controller",
-		.source = 0x0002,
-		.vid = 0x054c,
-		.pid = 0x0268,
-		.version = 0x0000,
-	},
-	{
-		.name = "Navigation Controller",
-		.source = 0x0002,
-		.vid = 0x054c,
-		.pid = 0x042f,
-		.version = 0x0000,
-	},
-};
-
 struct leds_data {
 	char *syspath_prefix;
 	uint8_t bitmap;
@@ -86,7 +63,7 @@ static struct udev *ctx = NULL;
 static struct udev_monitor *monitor = NULL;
 static guint watch_id = 0;
 
-static int get_device_bdaddr(int fd, bdaddr_t *bdaddr)
+static int sixaxis_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[18];
 	int ret;
@@ -107,7 +84,7 @@ static int get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+static int sixaxis_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -128,7 +105,7 @@ static int get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+static int sixaxis_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -146,7 +123,7 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
-static uint8_t calc_leds_bitmap(int number)
+static uint8_t sixaxis_calc_leds_bitmap(int number)
 {
 	uint8_t bitmap = 0;
 
@@ -164,7 +141,7 @@ static uint8_t calc_leds_bitmap(int number)
 	return bitmap;
 }
 
-static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
+static void sixaxis_set_leds_hidraw(int fd, uint8_t leds_bitmap)
 {
 	/*
 	 * the total time the led is active (0xff means forever)
@@ -199,7 +176,7 @@ static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
 		error("sixaxis: failed to set LEDS (%d bytes written)", ret);
 }
 
-static bool set_leds_sysfs(struct leds_data *data)
+static bool sixaxis_set_leds_sysfs(struct leds_data *data)
 {
 	int i;
 
@@ -233,7 +210,7 @@ static bool set_leds_sysfs(struct leds_data *data)
 	return true;
 }
 
-static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
+static gboolean sixaxis_setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	struct leds_data *data = user_data;
@@ -244,9 +221,9 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		goto out;
 
-	if(!set_leds_sysfs(data)) {
+	if(!sixaxis_set_leds_sysfs(data)) {
 		int fd = g_io_channel_unix_get_fd(channel);
-		set_leds_hidraw(fd, data->bitmap);
+		sixaxis_set_leds_hidraw(fd, data->bitmap);
 	}
 
 out:
@@ -374,7 +351,7 @@ out:
 	return syspath_prefix;
 }
 
-static struct leds_data *get_leds_data(struct udev_device *udevice)
+static struct leds_data *sixaxis_get_leds_data(struct udev_device *udevice)
 {
 	struct leds_data *data;
 	int number;
@@ -386,7 +363,7 @@ static struct leds_data *get_leds_data(struct udev_device *udevice)
 	if (!data)
 		return NULL;
 
-	data->bitmap = calc_leds_bitmap(number);
+	data->bitmap = sixaxis_calc_leds_bitmap(number);
 	if (data->bitmap == 0) {
 		leds_data_destroy(data);
 		return NULL;
@@ -401,6 +378,55 @@ static struct leds_data *get_leds_data(struct udev_device *udevice)
 	return data;
 }
 
+static int sixaxis_post_connect(int fd, struct udev_device *udevice)
+{
+	GIOChannel *io;
+
+	io = g_io_channel_unix_new(fd);
+
+	/* wait for events before setting leds */
+	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			sixaxis_setup_leds, sixaxis_get_leds_data(udevice));
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_unref(io);
+}
+
+static const struct {
+	const char *name;
+	uint16_t source;
+	uint16_t vid;
+	uint16_t pid;
+	uint16_t version;
+	int (*get_device_bdaddr)(int fd, bdaddr_t *bdaddr);
+	int (*get_master_bdaddr)(int fd, bdaddr_t *bdaddr);
+	int (*set_master_bdaddr)(int fd, const bdaddr_t *bdaddr);
+	int (*post_connect)(int fd, struct udev_device *udevice); /* optional */
+} devices[] = {
+	{
+		.name = "PLAYSTATION(R)3 Controller",
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x0268,
+		.version = 0x0000,
+		.get_device_bdaddr = sixaxis_get_device_bdaddr,
+		.get_master_bdaddr = sixaxis_get_master_bdaddr,
+		.set_master_bdaddr = sixaxis_set_master_bdaddr,
+		.post_connect = sixaxis_post_connect,
+	},
+	{
+		.name = "Navigation Controller",
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x042f,
+		.version = 0x0000,
+		.get_device_bdaddr = sixaxis_get_device_bdaddr,
+		.get_master_bdaddr = sixaxis_get_master_bdaddr,
+		.set_master_bdaddr = sixaxis_set_master_bdaddr,
+		.post_connect = sixaxis_post_connect,
+	},
+};
+
 static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 {
 	char device_addr[18], master_addr[18], adapter_addr[18];
@@ -408,10 +434,10 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	const bdaddr_t *adapter_bdaddr;
 	struct btd_device *device;
 
-	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
+	if (devices[index].get_device_bdaddr(fd, &device_bdaddr) < 0)
 		return false;
 
-	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
+	if (devices[index].get_master_bdaddr(fd, &master_bdaddr) < 0)
 		return false;
 
 	/* This can happen if controller was plugged while already connected
@@ -425,7 +451,7 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	adapter_bdaddr = btd_adapter_get_address(adapter);
 
 	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
-		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
+		if (devices[index].set_master_bdaddr(fd, adapter_bdaddr) < 0)
 			return false;
 	}
 
@@ -481,7 +507,6 @@ static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
 static void device_added(struct udev_device *udevice)
 {
 	struct btd_adapter *adapter;
-	GIOChannel *io;
 	uint16_t bus;
 	int index;
 	int fd;
@@ -502,8 +527,6 @@ static void device_added(struct udev_device *udevice)
 	if (fd < 0)
 		return;
 
-	io = g_io_channel_unix_new(fd);
-
 	switch (bus) {
 	case BUS_USB:
 		if (!setup_device(fd, index, adapter))
@@ -511,18 +534,14 @@ static void device_added(struct udev_device *udevice)
 
 		/* fall through */
 	case BUS_BLUETOOTH:
-		/* wait for events before setting leds */
-		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				setup_leds, get_leds_data(udevice));
+		if (devices[index].post_connect)
+			devices[index].post_connect(fd, udevice);
 
 		break;
 	default:
 		DBG("uknown bus type (%u)", bus);
 		break;
 	}
-
-	g_io_channel_set_close_on_unref(io, TRUE);
-	g_io_channel_unref(io);
 }
 
 static gboolean monitor_watch(GIOChannel *source, GIOCondition condition,
-- 
2.7.4

