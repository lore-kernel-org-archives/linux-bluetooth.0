Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] hcitool: Bring up device before sending commands over socket
Date: Tue,  9 Nov 2010 14:29:57 -0400
Message-Id: <1289327397-21935-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Texas specific initialization code sends HCI commands over the
bluetooth socket, but does not bring up the device. This gives these
errors when running "hciattach /dev/ttyUSB0 texas":

Found a Texas Instruments' chip!
Firmware file : /lib/firmware/TIInit_XX.Y.ZZ.bts
Loaded BTS script version 1
Cannot send hci command to socket: Network is down
Can't initialize device: Network is down
---
 tools/hciattach_ti.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 7627bc1..e107a65 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -514,6 +514,13 @@ int texas_post(int fd, struct termios *ti)
 		return -1;
 	}
 
+	if (ioctl(dd, HCIDEVUP, dev_id) < 0 && errno != EALREADY) {
+		fprintf(stderr, "Can't init device hci%d: %s (%d)", dev_id,
+							strerror(errno), errno);
+		hci_close_dev(dd);
+		return -1;
+	}
+
 	ret = brf_do_script(dd, ti, NULL);
 
 	hci_close_dev(dd);
-- 
1.7.0.4

