Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 10/11] plugins/sixaxis: Add cable pairing for PS3 Keypads
Date: Wed, 18 Oct 2017 03:58:14 +0200
Message-Id: <20171018015815.10045-10-hadess@hadess.net>
In-Reply-To: <20171018015815.10045-1-hadess@hadess.net>
References: <20171018015815.10045-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As documented in qtsixa's sixpair_kbd.c, from unknown origin:
https://github.com/falkTX/qtsixa/blob/master/utils/sixpair_kbd.c
---
 plugins/sixaxis.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index a05e95c1f..a2946f864 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -127,10 +127,33 @@ static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int ps3_keypad_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[16];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x4;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("sixaxis: failed to read device address (%s)",
+							strerror(errno));
+		return ret;
+	}
+
+	baswap(bdaddr, (bdaddr_t *) (buf + 1));
+
+	return 0;
+}
+
 static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
 		return sixaxis_get_device_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_PS3_WIRELESS_KEYPAD)
+		return ps3_keypad_get_device_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_get_device_bdaddr(fd, bdaddr);
 	return -1;
@@ -179,10 +202,33 @@ static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int ps3_keypad_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[16];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x4;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("sixaxis: failed to read master address (%s)",
+							strerror(errno));
+		return ret;
+	}
+
+	bacpy(bdaddr, (bdaddr_t *) (buf + 10));
+
+	return 0;
+}
+
 static int get_master_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
 		return sixaxis_get_master_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_PS3_WIRELESS_KEYPAD)
+		return ps3_keypad_get_master_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_get_master_bdaddr(fd, bdaddr);
 	return -1;
@@ -226,11 +272,30 @@ static int ds4_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
+static int ps3_keypad_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+{
+	uint8_t buf[7];
+	int ret;
+
+	buf[0] = 0x05;
+
+	baswap((bdaddr_t*) (buf + 1), bdaddr);
+
+	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
+	if (ret < 0)
+		error("sixaxis: failed to write PS3 Keypad master address (%s)",
+							strerror(errno));
+
+	return ret;
+}
+
 static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr,
 					CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
 		return sixaxis_set_master_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_PS3_WIRELESS_KEYPAD)
+		return ps3_keypad_set_master_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_set_master_bdaddr(fd, bdaddr);
 	return -1;
@@ -424,7 +489,8 @@ static void device_added(struct udev_device *udevice)
 						&source,
 						&version);
 	if (type != CABLE_PAIRING_SIXAXIS &&
-	    type != CABLE_PAIRING_DS4)
+	    type != CABLE_PAIRING_DS4 &&
+	    type != CABLE_PAIRING_PS3_WIRELESS_KEYPAD)
 		return;
 	if (bus != BUS_USB)
 		return;
-- 
2.14.2

