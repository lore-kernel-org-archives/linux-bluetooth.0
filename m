Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, juha.kuikka@gmail.com,
        frank.praznik@gmail.com, roderick.colenbrander@sony.com
Subject: [PATCH v2 3/4] sixaxis: Add support for pairing DS4 over USB
Date: Wed, 28 Dec 2016 16:32:42 -0800
Message-Id: <1482971563-15745-4-git-send-email-juha.kuikka@gmail.com>
In-Reply-To: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "pairing" a Dualshock4 controller over USB
into the sixaxis plugin.

Pairing is in quotes because we cannot do real bonding due to lack of
API of setting link keys from the plugin so instead we set up the
interval device and tell the controller that we are the master and to
connect to us.

Actual bonding happens on first connection per usual. Note that this
requires an agent to confirm the request.

The DS4 allows setting the link key over USB so true bonding could
happen over that channel. However currently there is no API in
bluetoothd to allow for this.

This is a convenience feature for people who use the same controllers
with both their PS4 and a Linux gaming system. This feature makes
switching a controller back-and-forth between the systems more
convenient as there would be no need for keyboard and mouse to go
through the BT discovery and pairing process every time they change
systems, instead the user could just plug it in.

This is exactly how the PS4 pairs/bonds the controllers so it would
mimic that functionality as well.

This patch is based on DS4 supprt for sixpair tool by t0xicCode:
https://github.com/t0xicCode/sixpair/commit/975c38cb6cd61a2f0be350714f0f64cef5f0432c
I merely translated from raw libusb to hid operations.
---
 plugins/sixaxis.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 99f4d0b..58e6c47 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -392,6 +392,70 @@ static int sixaxis_post_connect(int fd, struct udev_device *udevice)
 	g_io_channel_unref(io);
 }
 
+static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[7];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x81;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("ds4: failed to read device address (%s)",
+							strerror(errno));
+		return ret;
+	}
+
+	/* address is little-endian on DS4 */
+	bacpy(bdaddr, (bdaddr_t*) (buf + 1));
+
+	return 0;
+}
+
+static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[16];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x12;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("ds4: failed to read master address (%s)",
+							strerror(errno));
+		return ret;
+	}
+
+	/* address is little-endian on DS4 */
+	bacpy(bdaddr, (bdaddr_t*) (buf + 10));
+
+	return 0;
+}
+
+static int ds4_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+{
+	uint8_t buf[23];
+	int ret;
+
+	buf[0] = 0x13;
+	bacpy((bdaddr_t*) (buf + 1), bdaddr);
+	/* TODO: we could put the key here but
+	   there is no way to force a re-loading
+	   of link keys to the kernel from here. */
+	memset(buf + 7, 0, 16);
+
+	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
+	if (ret < 0)
+		error("ds4: failed to write master address (%s)",
+							strerror(errno));
+
+	return ret;
+}
+
 static const struct {
 	const char *name;
 	uint16_t source;
@@ -425,6 +489,26 @@ static const struct {
 		.set_master_bdaddr = sixaxis_set_master_bdaddr,
 		.post_connect = sixaxis_post_connect,
 	},
+	{
+		.name = "Wireless Controller",
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x05c4,
+		.version = 0x0001,
+		.get_device_bdaddr = ds4_get_device_bdaddr,
+		.get_master_bdaddr = ds4_get_master_bdaddr,
+		.set_master_bdaddr = ds4_set_master_bdaddr,
+	},
+	{
+		.name = "Wireless Controller",
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x09cc,
+		.version = 0x0001,
+		.get_device_bdaddr = ds4_get_device_bdaddr,
+		.get_master_bdaddr = ds4_get_master_bdaddr,
+		.set_master_bdaddr = ds4_set_master_bdaddr,
+	},
 };
 
 static bool setup_device(int fd, int index, struct btd_adapter *adapter)
-- 
2.7.4

