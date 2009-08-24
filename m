Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1250971418.2950.24.camel@localhost.localdomain>
References: <a70b8cd30908190910p35910657m28fe09905717d60@mail.gmail.com>
	 <1250698578.11521.0.camel@localhost.localdomain>
	 <1250971418.2950.24.camel@localhost.localdomain>
Date: Mon, 24 Aug 2009 23:06:05 +0200
Message-ID: <a70b8cd30908241406s50bd1b35o8cfc64609bcfbf63@mail.gmail.com>
Subject: Re: PATCH for input/fakehid.c to fix PS3 remote unpairing
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Here is next patch version, now it implements powersaving via implicit
unpairing.
It posted and verified here
http://www.xbmc.org/forum/showthread.php?t=50717&page=5#50
This patch now is watching for time passed since last keypress event,
and disconnecting BT channel on idle. Though, it keeps input device
always on, which allows application to receive keypress immediately on
pairing event.
Before that, application missed keypress pairing event due to new HID
creation and delays in evdev for new device recognition. Now, if
device is sleeping, you'll notice only one second delay for first
pairing keypress.
The point is, that remote is consuming 0.18mA wile paired and 0.03-4
mA while unpaired (sleeping). At least such numbers are shown by my
multimeter. %) And it doesn't matter if sleep mode is done explicitly
(holding ps) or implicitly by closing connection from host.
Idle timeout is used from input.conf, though in ps3 code it is
measured in seconds. If timeout is less then 5(sec) it is set to 300
(5 min). I'm using 15 sec. Sufficient to actively navigate through
menus but quickly goes sleeping.

diff --git a/input/device.c b/input/device.c
index 2cfc5d8..f4d8e29 100644
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
@@ -636,6 +624,8 @@ static int hidp_add_connection(const struct
input_device *idev,

 	fake_hid = get_fake_hid(req->vendor, req->product);
 	if (fake_hid) {
+		fake_hid->idev = idev;
+		fake_hid->timeout = iconn->timeout/60;
 		fake = g_new0(struct fake_input, 1);
 		fake->connect = fake_hid_connect;
 		fake->disconnect = fake_hid_disconnect;
diff --git a/input/device.h b/input/device.h
index f9ec7c2..d9b141d 100644
--- a/input/device.h
+++ b/input/device.h
@@ -27,7 +27,18 @@
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13

-struct input_device;
+struct input_device {
+	DBusConnection		*conn;
+	char			*path;
+	bdaddr_t		src;
+	bdaddr_t		dst;
+	uint32_t		handle;
+	guint			dc_id;
+	char			*name;
+	struct btd_device	*device;
+	GSList			*connections;
+};
+
 struct input_conn;

 struct fake_input {
diff --git a/input/fakehid.c b/input/fakehid.c
index 6c9a715..dc444d3 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -31,11 +31,13 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include <sys/stat.h>

 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/hidp.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/hci.h>

 #include <glib.h>
 #include <dbus/dbus.h>
@@ -208,18 +210,64 @@ error:
 						lastmask & 0xff, lastkey);
 	return -1;
 }
+static gboolean ps3remote_sendkey(int uinput, unsigned int key,
+				  unsigned int value)
+{
+	struct uinput_event event;
+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_KEY;
+	event.code = key;
+	event.value = value;
+	if (write(uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		return FALSE;
+	}

+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_SYN;
+	event.code = SYN_REPORT;
+	if (write(uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		return FALSE;
+	}
+	return TRUE;
+}
+static gboolean ps3remote_out(GIOChannel *chan, GIOCondition cond,
+                                gpointer data)
+{
+	struct fake_hid *fake_hid = ((struct fake_input *)data)->priv;
+	const struct input_device *idev = fake_hid->idev;
+	uint16_t to = (fake_hid->timeout < 5) ? 300 : fake_hid->timeout;
+	gulong ms;
+
+	if(g_timer_elapsed(fake_hid->timer,&ms) > to) {
+		DBG("idle timeout, disconnecting BT channel");
+		device_request_disconnect(idev->device, NULL);
+		return FALSE;
+	} else
+		usleep(1000);
+	return TRUE;
+}
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
+	static unsigned int lastkey = 0;
+	static unsigned int lastval = 0;
 	struct fake_input *fake = data;
-	struct uinput_event event;
 	unsigned int key, value = 0;
 	gsize size;
 	char buff[50];

-	if (cond & G_IO_NVAL)
-		return FALSE;
+	g_timer_start(((struct fake_hid *)fake->priv)->timer);
+	if (cond & G_IO_NVAL) {
+		if(lastkey == KEY_HOMEPAGE && lastval == 1)
+			DBG("Remote turned off");
+		else
+			DBG("Remote unpaired [%u:%u]", lastkey, lastval);
+		goto failed;
+	}

 	if (cond & (G_IO_HUP | G_IO_ERR)) {
 		error("Hangup or error on rfcomm server socket");
@@ -233,50 +281,52 @@ static gboolean ps3remote_event(GIOChannel
*chan, GIOCondition cond,
 		error("IO Channel read error");
 		goto failed;
 	}
-
 	key = ps3remote_decode(buff, size, &value);
 	if (key == KEY_RESERVED) {
 		error("Got invalid key from decode");
 		goto failed;
 	} else if (key == KEY_MAX)
 		return TRUE;
-
-	memset(&event, 0, sizeof(event));
-	gettimeofday(&event.time, NULL);
-	event.type = EV_KEY;
-	event.code = key;
-	event.value = value;
-	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
-		error("Error writing to uinput device");
+	/* Delaying key till release, assuming possible turn-off */
+	if(key == KEY_HOMEPAGE) {
+		if(value == 0 && lastkey == KEY_HOMEPAGE && lastval == 1) {
+			ps3remote_sendkey(fake->uinput, key, 1);
+			ps3remote_sendkey(fake->uinput, key, 0);
+		} else
+			DBG("Delayed: %u:%u (%u:%u)", key, value, lastkey,
+								  lastval);
+	} else if(!ps3remote_sendkey(fake->uinput, key, value))
 		goto failed;
-	}
-
-	memset(&event, 0, sizeof(event));
-	gettimeofday(&event.time, NULL);
-	event.type = EV_SYN;
-	event.code = SYN_REPORT;
-	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
-		error("Error writing to uinput device");
-		goto failed;
-	}
-
+	lastkey = key;
+	lastval = value;
+	DBG("Passed key %u:%u", key, value);
 	return TRUE;

-failed:
+failed: /*
 	ioctl(fake->uinput, UI_DEV_DESTROY);
 	close(fake->uinput);
-	fake->uinput = -1;
+	fake->uinput = -1;*/
+	g_timer_stop(((struct fake_hid *)fake->priv)->timer);
 	g_io_channel_unref(fake->io);
-
+	DBG("Event failed");
 	return FALSE;
 }
-
 static int ps3remote_setup_uinput(struct fake_input *fake,
 				  struct fake_hid *fake_hid)
 {
 	struct uinput_dev dev;
+	struct stat sbuf;
 	int i;

+	if(fake->uinput > 0) {
+		if(!(i=fstat(fake->uinput, &sbuf))) {
+			DBG("input %d is opened", fake->uinput);
+			return 0;
+		} else
+			DBG("fstat(%d): error[%d]: %s", fake->uinput, i,
+							strerror(errno));
+	}
+
 	fake->uinput = open("/dev/input/uinput", O_RDWR);
 	if (fake->uinput < 0) {
 		fake->uinput = open("/dev/uinput", O_RDWR);
@@ -348,6 +398,8 @@ static struct fake_hid fake_hid_table[] = {
 		.disconnect	= fake_hid_common_disconnect,
 		.event		= ps3remote_event,
 		.setup_uinput	= ps3remote_setup_uinput,
+		.fake		= NULL,
+		.timeout	= 15,
 	},

 	{ },
@@ -373,6 +425,13 @@ struct fake_hid *get_fake_hid(uint16_t vendor,
uint16_t product)
 int fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
 						struct fake_hid *fake_hid)
 {
+	if(fake_hid->fake == NULL) {
+		fake_hid->fake = fake;
+		fake_hid->timer = g_timer_new();
+	} else {
+		g_free(fake);
+		fake = fake_hid->fake;
+	}
 	if (fake_hid->setup_uinput(fake, fake_hid)) {
 		error("Error setting up uinput");
 		return ENOMEM;
@@ -382,6 +441,6 @@ int fake_hid_connadd(struct fake_input *fake,
GIOChannel *intr_io,
 	g_io_channel_set_close_on_unref(fake->io, TRUE);
 	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) fake_hid->event, fake);
-
+	g_io_add_watch(fake->io, G_IO_OUT, (GIOFunc) ps3remote_out, fake);
 	return 0;
 }
diff --git a/input/fakehid.h b/input/fakehid.h
index 90aacb4..ced1302 100644
--- a/input/fakehid.h
+++ b/input/fakehid.h
@@ -31,6 +31,10 @@ struct fake_hid {
 	int (*disconnect) (struct fake_input *fake_input);
 	gboolean (*event) (GIOChannel *chan, GIOCondition cond, gpointer data);
 	int (*setup_uinput) (struct fake_input *fake, struct fake_hid *fake_hid);
+	struct fake_input *fake;
+	const struct input_device *idev;
+	GTimer *timer;
+	uint16_t timeout;
 };

 struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product);


2009/8/22, Marcel Holtmann <marcel@holtmann.org>:
> Hi Bastien,
>
>
>  > > Here is the patch to correctly handle PS3 remote unpairing and manual
>  > > turning off.
>  >
>  > How do you test this?
>  >
>  > <snip>
>  >
>  > > I'm also thinking on implementing keymapping through input.conf
>  > > configuration section. Will it be accepted or not worth trying?
>  >
>  > You should handle this in the input user-space, or in X itself, rather
>  > than in bluez.
>
>
> I am not sure about that. The PS3 remote has pretty clear keys and we
>  should just assign them to default key values. If anyone wants to do
>  something different with them, then they can use X support for
>  keymapping. In reality, I believe nobody will.
>
>  Regards
>
>
>  Marcel
>
>
>


-- 
----
Looking forward to reading yours.
 RUFF-RIPE DI76-GANDI RUFF-6BONE
     Ruslan N. Marchenko
