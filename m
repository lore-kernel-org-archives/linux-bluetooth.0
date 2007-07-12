Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1184227287.5997.2.camel@Epimenides>
References: <1184178600.6062.27.camel@Epimenides>
	<d89ddf300707111302n15fa8e01u65697135b8ab03fc@mail.gmail.com>
	<f74cej$323$1@sea.gmane.org>  <1184227287.5997.2.camel@Epimenides>
Content-Type: multipart/mixed; boundary="=-FZA1S3FTiFfSA9iqrZhL"
Date: Thu, 12 Jul 2007 14:57:13 +0530
Message-Id: <1184232433.6210.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Handling simultaneous SCO
	connections:	Does	BlueZhave multiple SCO buffers?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-FZA1S3FTiFfSA9iqrZhL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-07-12 at 04:01 -0400, George Hansel wrote:
> On Thu, 2007-07-12 at 06:58 +0200, Niels v/d Spek wrote: 
> > Brad Midgley wrote:
> > > George
> > >
> > > bluetooth adapters that are connected by usb need to have a kernel mod
> > > to allow the alternate setting to be changed dynamically. There's an
> > > experimental patch out there:
> > >
> > > http://article.gmane.org/gmane.linux.bluez.devel/11999
> > >
> > > the patch also assumes you have the flowcontrol patch applied first:
> > >
> > > http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff?view=log
> > >
> > Brad,
> > 
> > I'm using Ubuntu 7.4 and like to know of this patches are there also needed?
> > 
> > thanks anyway
> > 
> > Niels
> > > Brad
> > >
> > > -------------------------------------------------------------------------
> 
> Neils,
> 
> I am also using Ubuntu 7.04 (latest patches, etc). As it turned out, I
> created a workaround for my problem, not using the patches. Depending
> on your application, you will need them as well. The Bluetooth stack
> is developed independently, but is incorporated into the Linux kernel,
> and so should be quite uniform throughout different distributions.
> 
> George 

Hi, 

If you want to use  multiple SCO connections (and your adapter is
connected through USB )you need the alternate setting patch along with
the sco-flowcontrol patch.

Brad, There are some changes in that patch , I am attaching the latest
one. 
There can be some issues which i might have missed, will test it out and
send a final patch soon. 



Thanks to Whoopie for testing the new patch . 
 

Thanks, 
Alok Barsode.
  

--=-FZA1S3FTiFfSA9iqrZhL
Content-Disposition: attachment; filename=alternate-setting.patch
Content-Type: text/x-patch; name=alternate-setting.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index 406af57..03b362e 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -837,11 +837,112 @@ static void hci_usb_destruct(struct hci_dev *hdev)
 	kfree(husb);
 }
 
+#ifdef CONFIG_BT_HCIUSB_SCO
 static void hci_usb_notify(struct hci_dev *hdev, unsigned int evt)
 {
+	struct hci_usb *husb = (struct hci_usb *) hdev->driver_data;
+	unsigned long flags;
+	int new_alts;
+
 	BT_DBG("%s evt %d", hdev->name, evt);
+	new_alts = hdev->conn_hash.sco_num;
+	
+	if(hdev->voice_setting & 0x0020){
+		new_alts *= 2;
+		if(new_alts > 5)
+			new_alts = 5;
+	}
+		
+	write_lock_irqsave(&husb->completion_lock, flags);
+
+	if(new_alts != husb->curr_isoc_alts){
+		husb->new_isoc_alts = new_alts;
+		schedule_work(&husb->work);
+	}
+
+	write_unlock_irqrestore(&husb->completion_lock, flags); 
+    
 }
 
+static void set_isoc_alternate(struct work_struct *work)
+{
+	struct hci_usb *husb = container_of(work, struct hci_usb, work);
+	struct _urb *_urb, *_tmp;
+	struct _urb_queue *q = &husb->pending_q[isoc];
+	/*This list holds the already submitted URBs */
+	struct list_head inprocess;
+	unsigned long flags;
+	/*Holds the number of URBs we need to skip(which are submitted) */
+	atomic_t temp;
+	int isoc_ifnum=1,e;
+
+	struct usb_interface *isocIface;
+	struct usb_host_endpoint *ep;
+	struct usb_host_interface *uif;
+	struct usb_host_endpoint *out = NULL;
+	struct usb_host_endpoint *in = NULL;
+
+	INIT_LIST_HEAD(&inprocess);
+	temp = husb->pending_tx[isoc];
+	
+	while ((_urb = _urb_dequeue(q))) {
+		/*Dequeue all the submitted URBs and put them in the temporary list */
+		if (!atomic_dec_and_test(&temp)) {
+			_urb->queue = q;
+			list_add(&_urb->list, &inprocess);
+		} else {
+			/*Unlink all the rest of URBs and put them into the completed queue. */
+			_urb_unlink(_urb);
+			_urb_queue_tail(__completed_q(husb, HCI_SCODATA_PKT),
+					_urb);
+		}
+	}
+	/*merge the inprocess queue with the pending queue */
+	spin_lock_irqsave(&q->lock, flags);
+	list_for_each_entry_safe(_urb, _tmp, &inprocess, list) {
+		list_move_tail(&_urb->list, &q->head);
+	}
+	spin_unlock_irqrestore(&q->lock, flags);
+	clear_bit(HCI_USB_TX_WAKEUP, &husb->state);
+	isocIface = usb_ifnum_to_if(husb->udev, isoc_ifnum); 
+	
+	/* Set the setting and the in/out endpoints */
+	if (isocIface) {
+		uif = &isocIface->altsetting[husb->new_isoc_alts];
+		for (e = 0; e < uif->desc.bNumEndpoints; e++) {
+			ep = &uif->endpoint[e];
+			switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
+			case USB_ENDPOINT_XFER_ISOC:
+				if (ep->desc.bEndpointAddress & USB_DIR_IN)
+					in = ep;
+				else
+					out = ep;
+				break;
+			}
+		}
+		if (!in || !out)
+			BT_DBG("Isoc endpoints not found");
+		else {
+			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, husb->new_isoc_alts);
+
+			if (usb_set_interface(husb->udev, isoc_ifnum, husb->new_isoc_alts)) {
+				BT_ERR("Can't set isoc interface settings");
+				husb->isoc_iface = isocIface;
+				usb_driver_release_interface(&hci_usb_driver,husb->isoc_iface);
+				husb->isoc_iface = NULL;
+			} else {
+				husb->isoc_iface = isocIface;
+				husb->isoc_in_ep = in;
+				husb->isoc_out_ep = out;
+				husb->curr_isoc_alts = husb->new_isoc_alts;
+			}
+		}
+	}
+
+	set_bit(HCI_USB_TX_WAKEUP, &husb->state);
+}
+#endif
+
 static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -853,7 +954,7 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 	struct usb_interface *isoc_iface;
 	struct hci_usb *husb;
 	struct hci_dev *hdev;
-	int i, e, size, isoc_ifnum, isoc_alts;
+	int i, e, size, isoc_ifnum;
 
 	BT_DBG("udev %p intf %p", udev, intf);
 
@@ -922,7 +1023,7 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 	/* Find isochronous endpoints that we can use */
 	size = 0; 
 	isoc_iface = NULL;
-	isoc_alts  = 0;
+	husb->curr_isoc_alts  = 0;
 	isoc_ifnum = 1;
 
 #ifdef CONFIG_BT_HCIUSB_SCO
@@ -946,7 +1047,7 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 						break;
 					size = le16_to_cpu(ep->desc.wMaxPacketSize);
 
-					isoc_alts = uif->desc.bAlternateSetting;
+					husb->curr_isoc_alts = uif->desc.bAlternateSetting;
 
 					if (ep->desc.bEndpointAddress & USB_DIR_IN)
 						isoc_in_ep  = ep;
@@ -960,10 +1061,10 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 		if (!isoc_in_ep || !isoc_out_ep)
 			BT_DBG("Isoc endpoints not found");
 		else {
-			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, isoc_alts);
+			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, husb->curr_isoc_alts);
 			if (usb_driver_claim_interface(&hci_usb_driver, isoc_iface, husb) != 0)
 				BT_ERR("Can't claim isoc interface");
-			else if (usb_set_interface(udev, isoc_ifnum, isoc_alts)) {
+			else if (usb_set_interface(udev, isoc_ifnum, husb->curr_isoc_alts)) {
 				BT_ERR("Can't set isoc interface settings");
 				husb->isoc_iface = isoc_iface;
 				usb_driver_release_interface(&hci_usb_driver, isoc_iface);
@@ -975,6 +1076,7 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 			}
 		}
 	}
+	INIT_WORK(&husb->work,set_isoc_alternate);
 #endif
 
 	rwlock_init(&husb->completion_lock);
diff --git a/drivers/bluetooth/hci_usb.h b/drivers/bluetooth/hci_usb.h
index 963fc55..c9fbf0e 100644
--- a/drivers/bluetooth/hci_usb.h
+++ b/drivers/bluetooth/hci_usb.h
@@ -108,11 +108,14 @@ struct hci_usb {
 	struct usb_host_endpoint	*bulk_in_ep;
 	struct usb_host_endpoint	*bulk_out_ep;
 	struct usb_host_endpoint	*intr_in_ep;
-
+#ifdef CONFIG_BT_HCIUSB_SCO
 	struct usb_interface		*isoc_iface;
 	struct usb_host_endpoint	*isoc_out_ep;
 	struct usb_host_endpoint	*isoc_in_ep;
-
+	struct work_struct           work;
+	int curr_isoc_alts;
+	int new_isoc_alts;
+#endif
 	__u8			ctrl_req;
 
 	struct sk_buff_head	transmit_q[4];

--=-FZA1S3FTiFfSA9iqrZhL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-FZA1S3FTiFfSA9iqrZhL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-FZA1S3FTiFfSA9iqrZhL--
