Return-Path: <cyrus@holtmann.org>
From: Tom Gundersen <teg@jklm.no>
To: linux-bluetooth@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH] udev: remove deprecated function
Date: Sun, 27 May 2012 01:07:57 +0200
Message-Id: <1338073677-27983-1-git-send-email-teg@jklm.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function has in the past returned "/sys" unconditionally. As of udev-183 it
is gone, so just replace it with the string.
---
 tools/hid2hci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 45a3a3d..e3a5b2e 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -291,7 +291,7 @@ int main(int argc, char *argv[])
 	if (udev == NULL)
 		goto exit;
 
-	snprintf(syspath, sizeof(syspath), "%s/%s", udev_get_sys_path(udev), devpath);
+	snprintf(syspath, sizeof(syspath), "/sys/%s", devpath);
 	udev_dev = udev_device_new_from_syspath(udev, syspath);
 	if (udev_dev == NULL) {
 		fprintf(stderr, "error: could not find '%s'\n", devpath);
-- 
1.7.10.2

