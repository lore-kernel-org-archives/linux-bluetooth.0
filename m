Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: "J.D." <jd@freeshell.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.60.0407240115590.25504@norge.freeshell.org>
References: <Pine.NEB.4.60.0407131537590.12135@norge.freeshell.org>
	 <1089826204.4517.0.camel@pegasus>
	 <Pine.NEB.4.60.0407141844100.22049@mx.freeshell.org>
	 <1090055676.4558.15.camel@pegasus>
	 <Pine.NEB.4.60.0407240115590.25504@norge.freeshell.org>
Content-Type: multipart/mixed; boundary="=-9PQUsk2OxE9uPi2FUj6+"
Message-Id: <1090701315.4791.75.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Linux 2.4.27rc3 and Bluetooth
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 24 Jul 2004 22:35:15 +0200


--=-9PQUsk2OxE9uPi2FUj6+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi John,

> I finally burned some time, studied the code, and created a
> working patch for bt3c_cs.c (patch attached).  It adds a test
> in bt3c_release to check whether the DEV_CONFIG_PENDING bit of
> link->state is clear before a call to bt3c_close.  If the
> DEV_CONFIG_PENDING bit is not clear, bt3c_open has failed,
> and never succeeded in a call to hci_register_dev and friends.
> 
> When loading the firmware fails, the unpatched code ignores the
> failure of bt3c_open, goes ahead with bt3c_close, and invokes 
> hci_unregister_dev and friends (despite the fact that
> hci_register_dev was never called), thus provoking a kernel panic
> with the NULL pointer dereference. (aiee!)

you are right. That is the problem. I fixed it in a different way.
Please try out the attached patch and report if it also works.

> I suspect the 2.6 kernel may have the same problem by casual
> inspection, but I have neither confirmed the existence of a problem
> through testing of the 2.6 kernel, nor carefully traced that code
> of Linux 2.6 for possible key differences.

No. The 2.6 kernel is not affected, because the hdev is a pointer in
that kernel series and we have the NULL pointer check in place.

Regards

Marcel


--=-9PQUsk2OxE9uPi2FUj6+
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/dtl1_cs.c 1.2 vs edited =====
--- 1.2/drivers/bluetooth/dtl1_cs.c	2002-08-03 13:53:56 +02:00
+++ edited/drivers/bluetooth/dtl1_cs.c	2004-07-24 22:30:33 +02:00
@@ -535,6 +535,9 @@
 	unsigned int iobase = info->link.io.BasePort1;
 	struct hci_dev *hdev = &(info->hdev);
 
+	if (info->link.state & DEV_CONFIG_PENDING)
+		return -ENODEV;
+
 	dtl1_hci_close(hdev);
 
 	spin_lock_irqsave(&(info->lock), flags);
===== drivers/bluetooth/bluecard_cs.c 1.1 vs edited =====
--- 1.1/drivers/bluetooth/bluecard_cs.c	2002-08-03 13:54:07 +02:00
+++ edited/drivers/bluetooth/bluecard_cs.c	2004-07-24 22:30:53 +02:00
@@ -803,6 +803,9 @@
 	unsigned int iobase = info->link.io.BasePort1;
 	struct hci_dev *hdev = &(info->hdev);
 
+	if (info->link.state & DEV_CONFIG_PENDING)
+		return -ENODEV;
+
 	bluecard_hci_close(hdev);
 
 	clear_bit(CARD_READY, &(info->hw_state));
===== drivers/bluetooth/bt3c_cs.c 1.2 vs edited =====
--- 1.2/drivers/bluetooth/bt3c_cs.c	2004-04-16 14:05:25 +02:00
+++ edited/drivers/bluetooth/bt3c_cs.c	2004-07-24 22:31:11 +02:00
@@ -643,6 +643,9 @@
 {
 	struct hci_dev *hdev = &(info->hdev);
 
+	if (info->link.state & DEV_CONFIG_PENDING)
+		return -ENODEV;
+
 	bt3c_hci_close(hdev);
 
 	if (hci_unregister_dev(hdev) < 0)
===== drivers/bluetooth/btuart_cs.c 1.1 vs edited =====
--- 1.1/drivers/bluetooth/btuart_cs.c	2002-10-20 21:42:54 +02:00
+++ edited/drivers/bluetooth/btuart_cs.c	2004-07-24 22:30:46 +02:00
@@ -556,6 +556,9 @@
 	unsigned int iobase = info->link.io.BasePort1;
 	struct hci_dev *hdev = &(info->hdev);
 
+	if (info->link.state & DEV_CONFIG_PENDING)
+		return -ENODEV;
+
 	btuart_hci_close(hdev);
 
 	spin_lock_irqsave(&(info->lock), flags);

--=-9PQUsk2OxE9uPi2FUj6+--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
