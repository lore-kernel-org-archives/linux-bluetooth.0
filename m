Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 15/16] Bluetooth: hidp: don't send boot-protocol messages as HID-reports
Date: Sat,  6 Apr 2013 20:28:51 +0200
Message-Id: <1365272932-571-16-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a device is registered as HID device, it is always in Report-Mode.
Therefore, we must not send Boot-Protocol messages on
hidinput_input_event() callbacks. This confuses devices and may cause
disconnects on protocol errors.

We disable the hidinput_input_event() callback for now. We can implement
it properly later, but lets first fix the current code by disabling it.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 5fcc038..13a0a05 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -143,13 +143,15 @@ static int hidp_send_intr_message(struct hidp_session *session,
 				 &session->intr_transmit, hdr, data, size);
 }
 
-static int hidp_queue_event(struct hidp_session *session, struct input_dev *dev,
-				unsigned int type, unsigned int code, int value)
+static int hidp_input_event(struct input_dev *dev, unsigned int type,
+			    unsigned int code, int value)
 {
+	struct hidp_session *session = input_get_drvdata(dev);
 	unsigned char newleds;
 	unsigned char hdr, data[2];
 
-	BT_DBG("session %p type %d code %d value %d", session, type, code, value);
+	BT_DBG("session %p type %d code %d value %d",
+	       session, type, code, value);
 
 	if (type != EV_LED)
 		return -1;
@@ -172,21 +174,6 @@ static int hidp_queue_event(struct hidp_session *session, struct input_dev *dev,
 	return hidp_send_intr_message(session, hdr, data, 2);
 }
 
-static int hidp_hidinput_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-	struct hidp_session *session = hid->driver_data;
-
-	return hidp_queue_event(session, dev, type, code, value);
-}
-
-static int hidp_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-	struct hidp_session *session = input_get_drvdata(dev);
-
-	return hidp_queue_event(session, dev, type, code, value);
-}
-
 static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
@@ -732,7 +719,6 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.stop = hidp_stop,
 	.open  = hidp_open,
 	.close = hidp_close,
-	.hidinput_input_event = hidp_hidinput_event,
 };
 
 /* This function sets up the hid device. It does not add it
-- 
1.8.2

