Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] Bluetooth: bcm203x: Fix race condition on disconnect
Date: Tue, 25 Oct 2011 21:13:35 +0200
Message-Id: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When disconnecting a bcm203x device we kill and destroy the usb-urb, however,
there might still be a pending work-structure which resubmits the now invalid
urb. To avoid this race condition, we simply set a shutdown-flag and
synchronously kill the worker first.

This also adds a comment to all schedule_work()s, as it is really not clear
that they are used as replacement for short timers (which can be seen in the git
history).

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bcm203x.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 8b1b643..6b42732 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -24,6 +24,7 @@
 
 #include <linux/module.h>
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -65,6 +66,7 @@ struct bcm203x_data {
 	unsigned long		state;
 
 	struct work_struct	work;
+	atomic_t		shutdown;
 
 	struct urb		*urb;
 	unsigned char		*buffer;
@@ -97,6 +99,7 @@ static void bcm203x_complete(struct urb *urb)
 
 		data->state = BCM203X_SELECT_MEMORY;
 
+		/* use workqueue to have a small delay */
 		schedule_work(&data->work);
 		break;
 
@@ -155,6 +158,10 @@ static void bcm203x_work(struct work_struct *work)
 	struct bcm203x_data *data =
 		container_of(work, struct bcm203x_data, work);
 
+	smp_rmb();
+	if (atomic_read(&data->shutdown))
+		return;
+
 	if (usb_submit_urb(data->urb, GFP_ATOMIC) < 0)
 		BT_ERR("Can't submit URB");
 }
@@ -243,6 +250,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 
 	usb_set_intfdata(intf, data);
 
+	/* use workqueue to have a small delay */
 	schedule_work(&data->work);
 
 	return 0;
@@ -254,6 +262,10 @@ static void bcm203x_disconnect(struct usb_interface *intf)
 
 	BT_DBG("intf %p", intf);
 
+	atomic_inc(&data->shutdown);
+	smp_wmb();
+	cancel_work_sync(&data->work);
+
 	usb_kill_urb(data->urb);
 
 	usb_set_intfdata(intf, NULL);
-- 
1.7.7.1
