Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] tools/csr_usb: Fix compilation failure
Date: Thu,  2 Nov 2017 15:09:52 +0100
Message-Id: <20171102140953.21684-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GCC's "format-nonliteral" security check is enabled as an error in
recent versions of Fedora. Given the limited formats, pass a boolean
to switch between the 2 different formats.

tools/csr_usb.c: In function 'read_value':
tools/csr_usb.c:82:2: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
  n = fscanf(file, format, &value);
  ^
---
 tools/csr_usb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index a1d7324f7..f1ffb0086 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -31,6 +31,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <dirent.h>
 #include <limits.h>
@@ -67,7 +68,7 @@ struct usbfs_bulktransfer {
 #define USBFS_IOCTL_CLAIMINTF	_IOR('U', 15, unsigned int)
 #define USBFS_IOCTL_RELEASEINTF	_IOR('U', 16, unsigned int)
 
-static int read_value(const char *name, const char *attr, const char *format)
+static int read_value(const char *name, const char *attr, bool hex_number)
 {
 	char path[PATH_MAX];
 	FILE *file;
@@ -79,7 +80,7 @@ static int read_value(const char *name, const char *attr, const char *format)
 	if (!file)
 		return -1;
 
-	n = fscanf(file, format, &value);
+	n = fscanf(file, hex_number ? "%d" : "%04x", &value);
 	if (n != 1) {
 		fclose(file);
 		return -1;
@@ -89,26 +90,29 @@ static int read_value(const char *name, const char *attr, const char *format)
 	return value;
 }
 
+#define read_hex_value(name, file) read_value((name), (file), true)
+#define read_num_value(name, file) read_value((name), (file), false)
+
 static char *check_device(const char *name)
 {
 	char path[PATH_MAX];
 	int busnum, devnum, vendor, product;
 
-	busnum = read_value(name, "busnum", "%d");
+	busnum = read_num_value(name, "busnum");
 	if (busnum < 0)
 		return NULL;
 
-	devnum = read_value(name, "devnum", "%d");
+	devnum = read_num_value(name, "devnum");
 	if (devnum < 0)
 		return NULL;
 
 	snprintf(path, sizeof(path), "/dev/bus/usb/%03u/%03u", busnum, devnum);
 
-	vendor = read_value(name, "idVendor", "%04x");
+	vendor = read_hex_value(name, "idVendor");
 	if (vendor < 0)
 		return NULL;
 
-	product = read_value(name, "idProduct", "%04x");
+	product = read_hex_value(name, "idProduct");
 	if (product < 0)
 		return NULL;
 
-- 
2.14.3

