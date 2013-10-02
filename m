Return-Path: <cyrus@holtmann.org>
From: Giovanni Campagna <scampa.giovanni@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hid2hci: fix regression in /dev format after moving away from libusb
Date: Wed,  2 Oct 2013 18:00:16 +0200
Message-Id: <1380729616-26519-1-git-send-email-scampa.giovanni@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Giovanni Campagna <gcampagna@src.gnome.org>

The paths under /dev, in the default udev configuration, are formatted
with two leading zeros, but the number obtained from sysfs don't have
them, so we must convert them to integers and reformat them.

Signed-off-by: Giovanni Campagna <scampa.giovanni@gmail.com>
---
 tools/hid2hci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index bb8a521..76d0b5a 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -221,18 +221,21 @@ static int usb_switch_dell(int fd, enum mode mode)
 static int find_device(struct udev_device *udev_dev)
 {
 	char path[PATH_MAX];
-	const char *busnum, *devnum;
+	const char *busnum_s, *devnum_s;
+	int busnum, devnum;
 	int fd;
 
-	busnum = udev_device_get_sysattr_value(udev_dev, "busnum");
-	if (!busnum)
+	busnum_s = udev_device_get_sysattr_value(udev_dev, "busnum");
+	if (!busnum_s)
 		return -1;
+	busnum = strtol(busnum_s, NULL, 10);
 
-	devnum = udev_device_get_sysattr_value(udev_dev, "devnum");
-	if (!devnum)
+	devnum_s = udev_device_get_sysattr_value(udev_dev, "devnum");
+	if (!devnum_s)
 		return -1;
+	devnum = strtol(devnum_s, NULL, 10);
 
-	snprintf(path, sizeof(path), "/dev/bus/usb/%s/%s", busnum, devnum);
+	snprintf(path, sizeof(path), "/dev/bus/usb/%03d/%03d", busnum, devnum);
 
 	fd = open(path, O_RDWR, O_CLOEXEC);
 	if (fd < 0) {
-- 
1.8.3.1

