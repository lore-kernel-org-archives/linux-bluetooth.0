Return-Path: <cyrus@holtmann.org>
Message-ID: <1412602169.28177.2.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Date: Mon, 06 Oct 2014 15:29:29 +0200
In-Reply-To: <CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	 <1412598268.1132.15.camel@linux-0dmf.site>
	 <CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	 <1412600108.28177.0.camel@linux-0dmf.site>
	 <CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-CVq7vkVDEYrMBB7w80+z"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-CVq7vkVDEYrMBB7w80+z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-10-06 at 18:33 +0530, Naveen Kumar Parna wrote:
> Thank you very much. I will try that patch.

Then please try.

	Regards
		Oliver


--=-CVq7vkVDEYrMBB7w80+z
Content-Disposition: attachment; filename="0001-btusb-clear-halt-if-intr-in-stalls.patch"
Content-Type: text/x-patch; name="0001-btusb-clear-halt-if-intr-in-stalls.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From f9f74591abed07ee71c46d443dd10176d05096c5 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.de>
Date: Mon, 6 Oct 2014 15:27:54 +0200
Subject: [PATCH] btusb: clear halt if intr in stalls

Use a work queue for clearing a halt.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 292c38e..65a2c6b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -273,6 +273,7 @@ struct btusb_data {
 
 	struct work_struct work;
 	struct work_struct waker;
+	struct work_struct intr_in_work;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
@@ -314,14 +315,15 @@ static void btusb_intr_complete(struct urb *urb)
 	struct hci_dev *hdev = urb->context;
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
+	int status = urb->status;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+					urb, status, urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
 
-	if (urb->status == 0) {
+	if (status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
 		if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
@@ -330,6 +332,10 @@ static void btusb_intr_complete(struct urb *urb)
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
+	} else if (status == -EPIPE) {
+		usb_mark_last_busy(data->udev);
+		schedule_work(&data->intr_in_work);
+		return;
 	}
 
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
@@ -971,6 +977,29 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static void clear_halt_intr_in(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data, waker);
+	int err;
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return;
+
+	err = usb_clear_halt(data->udev,
+			     usb_rcvbulkpipe(data->udev,
+					     data->intr_ep->bEndpointAddress));
+	if (err < 0)
+		return;
+
+	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
+		return;
+
+	btusb_submit_intr_urb(data->hdev, GFP_ATOMIC);
+
+	usb_autopm_put_interface(data->intf);
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1759,6 +1788,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_WORK(&data->intr_in_work, clear_halt_intr_in);
 	spin_lock_init(&data->txlock);
 
 	init_usb_anchor(&data->tx_anchor);
-- 
1.8.4.5


--=-CVq7vkVDEYrMBB7w80+z--

