Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Hyuk Lee <hyuk0512.lee@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hyuk Lee <hyuk0512.lee@samsung.com>
Subject: [PATCH BlueZ] android: Typo fix
Date: Sun, 24 Sep 2017 12:45:34 +0900
Message-id: <1506224734-5017-2-git-send-email-hyuk0512.lee@samsung.com>
In-reply-to: <1506224734-5017-1-git-send-email-hyuk0512.lee@samsung.com>
References: <1506224734-5017-1-git-send-email-hyuk0512.lee@samsung.com>
        <CGME20170924034535epcas2p326bc27d558bd4077b96648babe82f60b@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index fe0ea2f..7a4cc8e 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -372,7 +372,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 	/*
-	 * Report porotocol mode reply contains id after hdr, in boot
+	 * Report protocol mode reply contains id after hdr, in boot
 	 * protocol mode id doesn't exist
 	 */
 	ev_len += (dev->boot_dev) ? (len - 1) : (len - 2);
@@ -381,7 +381,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	bdaddr2android(&dev->dst, ev->bdaddr);
 
 	/*
-	 * Report porotocol mode reply contains id after hdr, in boot
+	 * Report protocol mode reply contains id after hdr, in boot
 	 * protocol mode id doesn't exist
 	 */
 	if (dev->boot_dev) {
-- 
1.9.1

