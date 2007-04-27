Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1177702819.14980.136.camel@aeonflux.holtmann.net>
References: <fc27e74b0704251424k32e3173eud439d5edeb64f148@mail.gmail.com>
	<1177538646.14980.26.camel@aeonflux.holtmann.net>
	<1177702819.14980.136.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="=-ULn/TBP6fPxqGPe4mGR+"
Date: Fri, 27 Apr 2007 22:10:04 +0200
Message-Id: <1177704604.14980.138.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Modified patch (Dynamic Alternate Setting)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-ULn/TBP6fPxqGPe4mGR+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

> > > I have made the changes u suggested.
> > > Take a look and let me know.
> > 
> > please fix the coding style of your additions. This patch is unreadable
> > in this state. No forward declarations and no heavy nesting.
> 
> the following patch follows more my understanding how this should look
> like. However the attached patch doesn't contain the code for stopping
> and resubmitting the ISOC URBs.

attached is a revised patch that improves the case where
CONFIG_BT_HCIUSB_SCO is not set.

Regards

Marcel


--=-ULn/TBP6fPxqGPe4mGR+
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index 406af57..0727f68 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -837,10 +837,50 @@ static void hci_usb_destruct(struct hci_dev *hdev)
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
+
+	new_alts = hdev->conn_hash.sco_num;
+
+	if (hdev->voice_setting & 0x0020) {
+		new_alts *= 2;
+		if (new_alts > 5)
+			new_alts = 5;
+	}
+
+	write_lock_irqsave(&husb->completion_lock, flags);
+
+	if (new_alts != husb->isoc_alts) {
+		husb->pend_alts = new_alts;
+		schedule_work(&husb->work);
+	}
+
+	write_unlock_irqrestore(&husb->completion_lock, flags);
+}
+
+static void set_isoc_alternate(struct work_struct *work)
+{
+	struct hci_usb *husb = container_of(work, struct hci_usb, work);
+
+	write_lock(&husb->completion_lock);
+
+	usb_set_interface(husb->udev, husb->isoc_ifnum, husb->pend_alts);
+
+	husb->isoc_alts = husb->pend_alts;
+
+	write_unlock(&husb->completion_lock);
+}
+#else
+static void hci_usb_notify(struct hci_dev *hdev, unsigned int evt)
+{
 }
+#endif
 
 static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
@@ -974,7 +1014,14 @@ static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id
 				husb->isoc_out_ep = isoc_out_ep;
 			}
 		}
+
+		husb->isoc_ifnum = isoc_ifnum;
+		husb->isoc_alts  = 0;
+
+		usb_set_interface(udev, isoc_ifnum, husb->isoc_alts);
 	}
+
+	INIT_WORK(&husb->work, set_isoc_alternate);
 #endif
 
 	rwlock_init(&husb->completion_lock);
diff --git a/drivers/bluetooth/hci_usb.h b/drivers/bluetooth/hci_usb.h
index 963fc55..fbe0954 100644
--- a/drivers/bluetooth/hci_usb.h
+++ b/drivers/bluetooth/hci_usb.h
@@ -102,17 +102,26 @@ struct hci_usb {
 	struct hci_dev		*hdev;
 
 	unsigned long		state;
-	
+
 	struct usb_device	*udev;
-	
+
 	struct usb_host_endpoint	*bulk_in_ep;
 	struct usb_host_endpoint	*bulk_out_ep;
 	struct usb_host_endpoint	*intr_in_ep;
 
 	struct usb_interface		*isoc_iface;
+
+#ifdef CONFIG_BT_HCIUSB_SCO
 	struct usb_host_endpoint	*isoc_out_ep;
 	struct usb_host_endpoint	*isoc_in_ep;
 
+	int			isoc_ifnum;
+	int			isoc_alts;
+	int			pend_alts;
+
+	struct work_struct	work;
+#endif
+
 	__u8			ctrl_req;
 
 	struct sk_buff_head	transmit_q[4];

--=-ULn/TBP6fPxqGPe4mGR+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-ULn/TBP6fPxqGPe4mGR+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-ULn/TBP6fPxqGPe4mGR+--
