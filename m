Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] hciattach: send hci commands after hci socket bring up
Date: Fri, 19 Nov 2010 11:21:43 +0530
Message-ID: <1290145903-11452-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes The Atheros AR300x specific initialization code
to send power management command over HCI socket after bringing up
the device.

---
 tools/hciattach_ath3k.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index b891506..70ade30 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -884,6 +884,8 @@ int ath3k_post(int fd, int pm)
 	int dev_id, dd;
 	struct timespec tm = { 0, 50000 };
 
+	sleep(1);
+
 	dev_id = ioctl(fd, HCIUARTGETDEVICE, 0);
 	if (dev_id < 0) {
 		perror("cannot get device id");
@@ -896,11 +898,15 @@ int ath3k_post(int fd, int pm)
 		return dd;
 	}
 
-	sleep(2);
+	if (ioctl(dd, HCIDEVUP, dev_id) < 0 && errno != EALREADY) {
+		perror("hci down:Power management Disabled");
+		hci_close_dev(dd);
+		return -1;
+	}
 
 	/* send vendor specific command with Sleep feature Enabled */
 	if (hci_send_cmd(dd, OGF_VENDOR_CMD, HCI_SLEEP_CMD_OCF,	1, &pm) < 0)
-		perror("Power management Disabled");
+		perror("PM command failed, power management Disabled");
 
 	nanosleep(&tm, NULL);
 	hci_close_dev(dd);
-- 
1.7.0.4

