Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6424D8.3040306@xyzw.org>
Date: Mon, 20 Jul 2009 01:03:36 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Wait for child devices to go away before deleting a connection
Content-Type: multipart/mixed;
 boundary="------------000302000806010701090207"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000302000806010701090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the device removal order when a connection is closed, 
which allows HAL to see the remove event and prevents a bunch of 
duplicate devices from piling up and eventually hitting the limit for 
the for input devices in X.

Posting for discussion since I used a polling loop (with a sleep) to 
wait for child devices to go away. I assume it'd be preferable to wait 
in a more proper way. In that case, before I start, is this the right 
place to be waiting?


--------------000302000806010701090207
Content-Type: text/x-patch;
 name="0001-Bluetooth-Wait-for-child-devices-to-go-away-before-d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Bluetooth-Wait-for-child-devices-to-go-away-before-d.pa";
 filename*1="tch"

>From 2779df84b73363d309fad933b6fb00e1276e8ff7 Mon Sep 17 00:00:00 2001
From: Brian Rogers <brian@xyzw.org>
Date: Sun, 19 Jul 2009 03:43:24 -0700
Subject: [PATCH 1/2] Bluetooth: Wait for child devices to go away before deleting a connection.

---
 net/bluetooth/hci_sysfs.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 95f7a7a..ebb0d15 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -100,14 +100,9 @@ static void add_conn(struct work_struct *work)
 	hci_dev_hold(hdev);
 }
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
+static int __match_any(struct device *dev, void *data)
 {
-	return !strncmp(dev_name(dev), "rfcomm", 6);
+	return 1;
 }
 
 static void del_conn(struct work_struct *work)
@@ -118,14 +113,16 @@ static void del_conn(struct work_struct *work)
 	if (!device_is_registered(&conn->dev))
 		return;
 
+	/* wait for child devices to go away first */
 	while (1) {
 		struct device *dev;
 
-		dev = device_find_child(&conn->dev, NULL, __match_tty);
+		dev = device_find_child(&conn->dev, NULL, __match_any);
 		if (!dev)
 			break;
-		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
 		put_device(dev);
+
+		msleep(100);
 	}
 
 	device_del(&conn->dev);
-- 
1.6.3.3


--------------000302000806010701090207--
