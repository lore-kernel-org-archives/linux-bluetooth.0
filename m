Return-Path: <cyrus@holtmann.org>
From: Giovanni Campagna <scampa.giovanni@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] hid2hci: fix regression in /dev format after moving away from libusb
Date: Thu,  3 Oct 2013 13:03:49 +0200
Message-Id: <1380798229-4319-1-git-send-email-scampa.giovanni@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Giovanni Campagna <gcampagna@src.gnome.org>

The paths under /dev, in the default udev configuration, are formatted
with two leading zeros, but the number obtained from sysfs don't have
them, so we must convert them to integers and reformat them.
---
 tools/hid2hci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index bb8a521..95b4abf 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -221,18 +221,21 @@ static int usb_switch_dell(int fd, enum mode mode)
 static int find_device(struct udev_device *udev_dev)
 {
 	char path[PATH_MAX];
-	const char *busnum, *devnum;
+	const char *busnum_str, *devnum_str;
+	int busnum, devnum;
 	int fd;
 
-	busnum = udev_device_get_sysattr_value(udev_dev, "busnum");
-	if (!busnum)
+	busnum_str = udev_device_get_sysattr_value(udev_dev, "busnum");
+	if (!busnum_str)
 		return -1;
+	busnum = strtol(busnum_str, NULL, 10);
 
-	devnum = udev_device_get_sysattr_value(udev_dev, "devnum");
-	if (!devnum)
+	devnum_str = udev_device_get_sysattr_value(udev_dev, "devnum");
+	if (!devnum_str)
 		return -1;
+	devnum = strtol(devnum_str, NULL, 10);
 
-	snprintf(path, sizeof(path), "/dev/bus/usb/%s/%s", busnum, devnum);
+	snprintf(path, sizeof(path), "/dev/bus/usb/%03d/%03d", busnum, devnum);
 
 	fd = open(path, O_RDWR, O_CLOEXEC);
 	if (fd < 0) {
-- 
1.8.3.1

