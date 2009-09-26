Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 16:26:36 +0200
Message-ID: <a70b8cd30909260726x6247bb0ajaa6b1fc46e009676@mail.gmail.com>
Subject: [PATCH 1/4] Bluez: input: created isolated data context for fake hid
	execution
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates data storage for fake input device drivers isolation.
Each input device, served by fakehid driver is now stored for daemon's
lifetime. New connections are trying to search if existing connection
exists using device pointer.

IdleTimeout config parameter is treated now in seconds for better
granularity.

Signed-off-by: Ruslan N. Marchenko <rufferson@gmail.com>
---
 input/device.c   |   22 ++++------------
 input/device.h   |   20 ++++++++++++++-
 input/fakehid.c  |   69 +++++++++++++++++++++++++++++++++++++++++------------
 input/fakehid.h  |    9 +++++++
 input/input.conf |    2 +-
 input/manager.c  |    9 ++++---
 6 files changed, 92 insertions(+), 39 deletions(-)

diff --git a/input/device.c b/input/device.c
index 2cfc5d8..8eedb6c 100644
--- a/input/device.c
+++ b/input/device.c
@@ -83,18 +83,6 @@ struct input_conn {
 	struct input_device	*idev;
 };

-struct input_device {
-	DBusConnection		*conn;
-	char			*path;
-	bdaddr_t		src;
-	bdaddr_t		dst;
-	uint32_t		handle;
-	guint			dc_id;
-	char			*name;
-	struct btd_device	*device;
-	GSList			*connections;
-};
-
 GSList *devices = NULL;

 static struct input_device *find_device_by_path(GSList *list, const char *path)
@@ -640,6 +628,7 @@ static int hidp_add_connection(const struct
input_device *idev,
 		fake->connect = fake_hid_connect;
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
+		fake->idev = idev;
 		err = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
 		goto cleanup;
 	}
@@ -1103,15 +1092,16 @@ static struct input_device
*input_device_new(DBusConnection *conn,

 static struct input_conn *input_conn_new(struct input_device *idev,
 					const char *uuid, const char *alias,
-					int timeout)
+					struct input_dev_conf *conf)
 {
 	struct input_conn *iconn;

 	iconn = g_new0(struct input_conn, 1);
-	iconn->timeout = timeout;
+	iconn->timeout = conf->timeout;
 	iconn->uuid = g_strdup(uuid);
 	iconn->alias = g_strdup(alias);
 	iconn->idev = idev;
+	idev->conf = conf;

 	return iconn;
 }
@@ -1119,7 +1109,7 @@ static struct input_conn *input_conn_new(struct
input_device *idev,
 int input_device_register(DBusConnection *conn, struct btd_device *device,
 			const char *path, const bdaddr_t *src,
 			const bdaddr_t *dst, const char *uuid,
-			uint32_t handle, int timeout)
+			uint32_t handle, struct input_dev_conf *conf)
 {
 	struct input_device *idev;
 	struct input_conn *iconn;
@@ -1132,7 +1122,7 @@ int input_device_register(DBusConnection *conn,
struct btd_device *device,
 		devices = g_slist_append(devices, idev);
 	}

-	iconn = input_conn_new(idev, uuid, "hid", timeout);
+	iconn = input_conn_new(idev, uuid, "hid", conf);
 	if (!iconn)
 		return -EINVAL;

diff --git a/input/device.h b/input/device.h
index f9ec7c2..7cbfe9f 100644
--- a/input/device.h
+++ b/input/device.h
@@ -27,7 +27,21 @@
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13

-struct input_device;
+struct input_dev_conf {
+	int timeout;
+};
+struct input_device {
+	DBusConnection		*conn;
+	char			*path;
+	bdaddr_t		src;
+	bdaddr_t		dst;
+	uint32_t		handle;
+	guint			dc_id;
+	char			*name;
+	struct btd_device	*device;
+	struct input_dev_conf	*conf;
+	GSList			*connections;
+};
 struct input_conn;

 struct fake_input {
@@ -39,6 +53,8 @@ struct fake_input {
 	gboolean	(*connect) (struct input_conn *iconn, GError **err);
 	int		(*disconnect) (struct input_conn *iconn);
 	void		*priv;
+	void		*data;
+	const struct input_device * idev;
 };

 int fake_input_register(DBusConnection *conn, struct btd_device *device,
@@ -47,7 +63,7 @@ int fake_input_register(DBusConnection *conn, struct
btd_device *device,
 int input_device_register(DBusConnection *conn, struct btd_device *device,
 			const char *path, const bdaddr_t *src,
 			const bdaddr_t *dst, const char *uuid,
-			uint32_t handle, int timeout);
+			uint32_t handle, struct input_dev_conf *conf);
 int input_device_unregister(const char *path, const char *uuid);

 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
diff --git a/input/fakehid.c b/input/fakehid.c
index 6c9a715..75c2650 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -147,10 +147,9 @@ static unsigned int ps3remote_keymap[] = {
 	[0xff] = KEY_MAX,
 };

-static int ps3remote_decode(char *buff, int size, unsigned int *value)
+static int ps3remote_decode(char *buff, int size, unsigned int *value,
+						struct ps3remote_data *ps3)
 {
-	static unsigned int lastkey = 0;
-	static unsigned int lastmask = 0;
 	unsigned int i, mask;
 	int retval;
 	guint8 key;
@@ -165,11 +164,11 @@ static int ps3remote_decode(char *buff, int
size, unsigned int *value)

 	/* first, check flags */
 	for (i = 0; i < 24; i++) {
-		if ((lastmask & (1 << i)) == (mask & (1 << i)))
+		if ((ps3->lastmask & (1 << i)) == (mask & (1 << i)))
 			continue;
 		if (ps3remote_bits[i] == 0)
 			goto error;
-		retval = ps3remote_keymap[ps3remote_bits[i]];
+		retval = ps3->keymap[ps3remote_bits[i]];
 		if (mask & (1 << i))
 			/* key pressed */
 			*value = 1;
@@ -182,21 +181,21 @@ static int ps3remote_decode(char *buff, int
size, unsigned int *value)

 	*value = buff[11];
 	if (buff[11] == 1) {
-		retval = ps3remote_keymap[key];
+		retval = ps3->keymap[key];
 	} else
-		retval = lastkey;
+		retval = ps3->lastkey;

 	if (retval == KEY_RESERVED)
 		goto error;
 	if (retval == KEY_MAX)
 		return retval;

-	lastkey = retval;
+	ps3->lastkey = retval;

 out:
 	fflush(stdout);

-	lastmask = mask;
+	ps3->lastmask = mask;

 	return retval;

@@ -204,8 +203,8 @@ error:
 	error("ps3remote: unrecognized sequence [%#x][%#x][%#x][%#x] [%#x],"
 			"last: [%#x][%#x][%#x][%#x]",
 			buff[2], buff[3], buff[4], buff[5], buff[11],
-				lastmask >> 16, lastmask >> 8 & 0xff,
-						lastmask & 0xff, lastkey);
+				ps3->lastmask >> 16, ps3->lastmask >> 8 & 0xff,
+					ps3->lastmask & 0xff, ps3->lastkey);
 	return -1;
 }

@@ -213,11 +212,13 @@ static gboolean ps3remote_event(GIOChannel
*chan, GIOCondition cond,
 				gpointer data)
 {
 	struct fake_input *fake = data;
+	struct ps3remote_data *ps3 = (struct ps3remote_data *)fake->data;
 	struct uinput_event event;
 	unsigned int key, value = 0;
 	gsize size;
 	char buff[50];

+	g_timer_start(ps3->timer);
 	if (cond & G_IO_NVAL)
 		return FALSE;

@@ -234,7 +235,7 @@ static gboolean ps3remote_event(GIOChannel *chan,
GIOCondition cond,
 		goto failed;
 	}

-	key = ps3remote_decode(buff, size, &value);
+	key = ps3remote_decode(buff, size, &value, ps3);
 	if (key == KEY_RESERVED) {
 		error("Got invalid key from decode");
 		goto failed;
@@ -275,6 +276,7 @@ static int ps3remote_setup_uinput(struct fake_input *fake,
 				  struct fake_hid *fake_hid)
 {
 	struct uinput_dev dev;
+	struct ps3remote_data *ps3 = (struct ps3remote_data *)fake->data;
 	int i;

 	fake->uinput = open("/dev/input/uinput", O_RDWR);
@@ -308,11 +310,11 @@ static int ps3remote_setup_uinput(struct fake_input *fake,

 	/* enabling keys */
 	for (i = 0; i < 256; i++)
-		if (ps3remote_keymap[i] != KEY_RESERVED)
+		if (ps3->keymap[i] != KEY_RESERVED)
 			if (ioctl(fake->uinput, UI_SET_KEYBIT,
-						ps3remote_keymap[i]) < 0) {
+						ps3->keymap[i]) < 0) {
 				error("Error enabling uinput key %i",
-							ps3remote_keymap[i]);
+							ps3->keymap[i]);
 				goto err;
 			}

@@ -328,6 +330,16 @@ err:
 	close(fake->uinput);
 	return 1;
 }
+static gboolean ps3remote_connect(struct fake_input *fake, GError **err)
+{
+	if(!fake->data) {
+		struct ps3remote_data *ps3 = g_new0(struct ps3remote_data, 1);
+		ps3->timeout = fake->idev->conf->timeout;
+		ps3->keymap = ps3remote_keymap;
+		fake->data = ps3;
+	}
+	return TRUE;
+}

 static gboolean fake_hid_common_connect(struct fake_input *fake, GError **err)
 {
@@ -344,10 +356,11 @@ static struct fake_hid fake_hid_table[] = {
 	{
 		.vendor		= 0x054c,
 		.product	= 0x0306,
-		.connect	= fake_hid_common_connect,
+		.connect	= ps3remote_connect,
 		.disconnect	= fake_hid_common_disconnect,
 		.event		= ps3remote_event,
 		.setup_uinput	= ps3remote_setup_uinput,
+		.fakes		= NULL,
 	},

 	{ },
@@ -369,10 +382,34 @@ struct fake_hid *get_fake_hid(uint16_t vendor,
uint16_t product)

 	return NULL;
 }
+struct fake_input * fake_find_input(GSList *list,
+					const struct input_device *idev)
+{
+        GSList *l;
+
+	if(!list)
+		return NULL;
+        for (l = list; l; l = l->next) {
+                struct fake_input *fake = l->data;
+
+                if (fake->idev == idev)
+                        return fake;
+        }
+        return NULL;
+}

 int fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
 						struct fake_hid *fake_hid)
 {
+	struct fake_input *finput;
+
+	if((finput = fake_find_input(fake_hid->fakes, fake->idev))) {
+		g_free(fake);
+		fake = finput;
+	} else {
+		fake_hid->fakes = g_slist_append(fake_hid->fakes, fake);
+	}
+	fake_hid->connect(fake,NULL);
 	if (fake_hid->setup_uinput(fake, fake_hid)) {
 		error("Error setting up uinput");
 		return ENOMEM;
diff --git a/input/fakehid.h b/input/fakehid.h
index 90aacb4..bda4f43 100644
--- a/input/fakehid.h
+++ b/input/fakehid.h
@@ -31,6 +31,15 @@ struct fake_hid {
 	int (*disconnect) (struct fake_input *fake_input);
 	gboolean (*event) (GIOChannel *chan, GIOCondition cond, gpointer data);
 	int (*setup_uinput) (struct fake_input *fake, struct fake_hid *fake_hid);
+	GSList *fakes;
+};
+
+struct ps3remote_data {
+	unsigned int	lastkey;
+	unsigned int	lastmask;
+	GTimer *	timer;
+	uint16_t 	timeout;
+	unsigned int *	keymap;
 };

 struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product);
diff --git a/input/input.conf b/input/input.conf
index abfb64f..6381dc2 100644
--- a/input/input.conf
+++ b/input/input.conf
@@ -4,6 +4,6 @@
 # particular interface
 [General]

-# Set idle timeout (in minutes) before the connection will
+# Set idle timeout (in seconds) before the connection will
 # be disconnect (defaults to 0 for no timeout)
 #IdleTimeout=30
diff --git a/input/manager.c b/input/manager.c
index e4c68b2..7d349ff 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -42,7 +42,7 @@
 #include "server.h"
 #include "manager.h"

-static int idle_timeout = 0;
+static struct input_dev_conf idev_conf;

 static DBusConnection *connection = NULL;
 static GSList *adapters = NULL;
@@ -72,7 +72,7 @@ static int hid_device_probe(struct btd_device
*device, GSList *uuids)
 	device_get_address(device, &dst);

 	return input_device_register(connection, device, path, &src, &dst,
-				HID_UUID, rec->handle, idle_timeout * 60);
+				HID_UUID, rec->handle, &idev_conf);
 }

 static void hid_device_remove(struct btd_device *device)
@@ -175,9 +175,10 @@ int input_manager_init(DBusConnection *conn,
GKeyFile *config)
 {
 	GError *err = NULL;

+	memset(&idev_conf,0,sizeof(struct input_dev_conf));
 	if (config) {
-		idle_timeout = g_key_file_get_integer(config, "General",
-						"IdleTimeout", &err);
+		idev_conf.timeout = g_key_file_get_integer(config,
+				     "General", "IdleTimeout", &err);
 		if (err) {
 			debug("input.conf: %s", err->message);
 			g_error_free(err);
-- 
1.6.0.4



-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
