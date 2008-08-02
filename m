Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Sat, 2 Aug 2008 12:49:24 +0000 (UTC)
Message-ID: <loom.20080802T123158-266@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [Share] dynamic alternative setting needs usb core
	change
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

>Hi, all:
  After working on this subject for one month. (no matter on old hci_usb.c or on
btusb.c), eventually I found that if we want to change the alternative setting
of a usb interface, the only way is to use "Set Interface" in "Standard Device
Request" defined by usb specification. In usb core message.c, the corresponding
is usb_set_interface() function. Besides, there is no additional behavior
definition after the "Set Interface" request.
  From my current experiment, it seems that once the interface is set, the
reserved bandwidth will be reset, which means the adapter may find out "oh! my
bandwidth is reset, what should I do to my current voice link ?"
  Anyway, maybe I am too pessimistic, maybe it just needs to change the usb core
driver to support some asynchronous action instead of brutal force to reset the
bandwidth of all current connections. I will look into it later.
The following is a update to Alok's patch, which tries to resubmit a new urb
request after usb_set_interface()

Bests,
Jui-Hao


diff -r a/hci_usb.c b/hci_usb.c
845a846
> #ifdef CONFIG_BT_HCIUSB_SCO
847a849,852
> 	struct hci_usb *husb = (struct hci_usb *) hdev->driver_data;
> 	unsigned long flags;
> 	int new_alts;
> 
848a854,870
> 	new_alts = hdev->conn_hash.sco_num;
> 	
> 	if(hdev->voice_setting & 0x0020){
> 		new_alts *= 2;
> 		if(new_alts > 5)
> 			new_alts = 5;
> 	}
> 		
> 	write_lock_irqsave(&husb->completion_lock, flags);
> 
> 	if(new_alts != husb->curr_isoc_alts){
> 		husb->new_isoc_alts = new_alts;
> 		schedule_work(&husb->work);
> 	}
> 
> 	write_unlock_irqrestore(&husb->completion_lock, flags); 
>     
850a873,973
> static void set_isoc_alternate(struct work_struct *work)
> {
> 	struct hci_usb *husb = container_of(work, struct hci_usb, work);
> 	struct _urb *_urb, *_tmp;
> 	struct _urb_queue *q = &husb->pending_q[HCI_SCODATA_PKT-1];
> 	/*This list holds the already submitted URBs */
> 	struct list_head inprocess;
> 	unsigned long flags;
> 	/*Holds the number of URBs we need to skip(which are submitted) */
> 	atomic_t temp;
> 	int isoc_ifnum=1, e;
> 
> 	struct usb_interface *isocIface;
> 	struct usb_host_endpoint *ep;
> 	struct usb_host_interface *uif;
> 	struct usb_host_endpoint *out = NULL;
> 	struct usb_host_endpoint *in = NULL;
> 
> 	INIT_LIST_HEAD(&inprocess);
> 	temp = husb->pending_tx[HCI_SCODATA_PKT-1];
> 
> 	e = HCI_MAX_ISOC_RX;
> 	while ((_urb = _urb_dequeue(q))) {
> 		/* clean the urbs from hci_usb_isoc_rx_submit */
> 		if (e--) {
> 			_urb_unlink(_urb);
> 			usb_kill_urb(&_urb->urb);
> 			_urb_free(_urb);
> 		/*Dequeue all the submitted URBs and put them in the temporary list */
> 		} else if (!atomic_dec_and_test(&temp)) {
> 			BT_DBG("dequeue other submitted %p", &_urb->urb);
> 			_urb->queue = q;
> 			list_add(&_urb->list, &inprocess);
> 		} else {
> 			/*Unlink all the rest of URBs and put them into the completed queue. */
> 			BT_DBG("unlink urb %p", &_urb->urb);
> 			_urb_unlink(_urb);
> 			_urb_queue_tail(__completed_q(husb, HCI_SCODATA_PKT),
> 					_urb);
> 		}
> 	}
> 
> 	clear_bit(HCI_USB_TX_WAKEUP, &husb->state);
> 
> 	isocIface = usb_ifnum_to_if(husb->udev, isoc_ifnum); 
> 	
> 	/* Set the setting and the in/out endpoints */
> 	if (isocIface) {
> 		uif = &isocIface->altsetting[husb->new_isoc_alts];
> 		for (e = 0; e < uif->desc.bNumEndpoints; e++) {
> 			ep = &uif->endpoint[e];
> 			switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
> 			case USB_ENDPOINT_XFER_ISOC:
> 				if (ep->desc.bEndpointAddress & USB_DIR_IN)
> 					in = ep;
> 				else
> 					out = ep;
> 				break;
> 			}
> 		} 
> 
> 		if (!in || !out)
> 			BT_DBG("Isoc endpoints not found");
> 		else {
> 			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, husb->new_isoc_alts);
> 
> 			if (usb_set_interface(husb->udev, isoc_ifnum, husb->new_isoc_alts)) {
> 				BT_ERR("Can't set isoc interface settings");
> 				husb->isoc_iface = isocIface;
> 				usb_driver_release_interface(&hci_usb_driver,husb->isoc_iface);
> 				husb->isoc_iface = NULL;
> 			} else {
> 				husb->isoc_iface = isocIface;
> 				husb->isoc_in_ep = in;
> 				husb->isoc_out_ep = out;
> 				husb->curr_isoc_alts = husb->new_isoc_alts;
> 
> 				write_lock_irqsave(&husb->completion_lock, flags);
> 				if (husb->isoc_iface) //resubmit isoc_rx urbs here
> 				for (i = 0; i < HCI_MAX_ISOC_RX; i++)
> 					hci_usb_isoc_rx_submit(husb);
> 				write_unlock_irqrestore(&husb->completion_lock, flags);
> 			}
> 
> 		}
> 
> 	}
> 
> 	set_bit(HCI_USB_TX_WAKEUP, &husb->state);
> 
> 	/*merge the inprocess queue with the pending queue */
> 	spin_lock_irqsave(&q->lock, flags);
> 
> 	list_for_each_entry_safe(_urb, _tmp, &inprocess, list) {
> 		list_move_tail(&_urb->list, &q->head);
> 	}
> 	spin_unlock_irqrestore(&q->lock, flags);
> 
> }
> #endif
> 
862c985
< 	int i, e, size, isoc_ifnum, isoc_alts;
---
> 	int i, e, size, isoc_ifnum;
931c1054
< 	isoc_alts  = 0;
---
> 	husb->curr_isoc_alts  = 0;
955c1078
< 					isoc_alts = uif->desc.bAlternateSetting;
---
> 					husb->curr_isoc_alts = uif->desc.bAlternateSetting;
969c1092
< 			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, isoc_alts);
---
> 			BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, husb->curr_isoc_alts);
972c1095
< 			else if (usb_set_interface(udev, isoc_ifnum, isoc_alts)) {
---
> 			else if (usb_set_interface(udev, isoc_ifnum, husb->curr_isoc_alts)) {
983a1107
> 	INIT_WORK(&husb->work,set_isoc_alternate);
diff -r a/hci_usb.h b/hci_usb.h
111c111
< 
---
> #ifdef CONFIG_BT_HCIUSB_SCO
115c115,118
< 
---
> 	struct work_struct           work;
> 	int curr_isoc_alts;
> 	int new_isoc_alts;
> #endif


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
