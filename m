Return-Path: <cyrus@holtmann.org>
From: Matthew Monaco <dgbaley27@0x01b.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/hci2hid: properly format device path
Date: Sun,  3 Nov 2013 18:46:53 -0700
Message-Id: <963b569308352e0b0fc18a0a17e2b0c0fe721d72.1383529026.git.matthew.monaco@0x01b.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Matthew Monaco <matthew.monaco@0x01b.net>

---
Hello! I hope this is the correct place to send a bugfix for bluez.
 tools/hid2hci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index bb8a521..8f22047 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -221,18 +221,21 @@ static int usb_switch_dell(int fd, enum mode mode)
 static int find_device(struct udev_device *udev_dev)
 {
 	char path[PATH_MAX];
-	const char *busnum, *devnum;
+	const char *str;
+	long int busnum, devnum;
 	int fd;
 
-	busnum = udev_device_get_sysattr_value(udev_dev, "busnum");
-	if (!busnum)
+	str = udev_device_get_sysattr_value(udev_dev, "busnum");
+	if (!str)
 		return -1;
+	busnum = strtol(str, NULL, 0);
 
-	devnum = udev_device_get_sysattr_value(udev_dev, "devnum");
-	if (!devnum)
+	str = udev_device_get_sysattr_value(udev_dev, "devnum");
+	if (!str)
 		return -1;
+	devnum = strtol(str, NULL, 0);
 
-	snprintf(path, sizeof(path), "/dev/bus/usb/%s/%s", busnum, devnum);
+	snprintf(path, sizeof(path), "/dev/bus/usb/%03d/%03d", busnum, devnum);
 
 	fd = open(path, O_RDWR, O_CLOEXEC);
 	if (fd < 0) {
-- 
1.8.4.2

