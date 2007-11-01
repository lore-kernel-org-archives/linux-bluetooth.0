Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Hunyue Yau <hyau@mvista.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 1 Nov 2007 11:23:50 -0700
MIME-Version: 1.0
Message-Id: <200711011123.51291.hyau@mvista.com>
Subject: [Bluez-devel] [PATCH] SCO audio sync with commands
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

Hi,

Following up for my posting a few days ago, this patch works around the
synchronization problem where SCO data is queued up in the hci_usb
driver, and the socket is closed. Since there are multiple queues
corresponding to the different USB pipes, the DISCONNECT command
gets to the hardware before the data finishes.

This is likely not to be a good long term fix but it works. Comments
on a better long term fix? Patch is against 2.6.21 + sco flowcontrol v4.2
patch. Also applies to 2.6.23.1. 

-- Hunyue
---------------------------------------------------------------------------------------------------------
Signed-off-by: Hunyue Yau <hyau@mvista.com>

Description:
    Certain bluetooth adapter drivers such as hci_usb provide 
    different queues for command, data, and SCO data packets. This 
    introduces a situation where the one relative timing of commands 
    to data can be lost. An example is SCO data can be queued in 
    the SCO queue waiting to be sent and a DISCONNECT command is sent 
    from the higher level HCI stack. With the multiple queues, the 
    DISCONNECT command can be sent to the device before the SCO data 
    queue is drained. As a result, the hardware can confused.

    This change adds an API to the hardware drivers to query the amount 
    of pending data in its queue SCO data queue. This queue was specificly 
    choosen due to its fix rate draining characteristic. Prior to sending 
    a disconnect, if the current device implements this new API, it is 
    queried. The connection is not disconnected until the queue completely 
    drains.


Index: linux-2.6.21/drivers/bluetooth/hci_usb.c
===================================================================
--- linux-2.6.21.orig/drivers/bluetooth/hci_usb.c
+++ linux-2.6.21/drivers/bluetooth/hci_usb.c
@@ -842,6 +842,14 @@ static void hci_usb_notify(struct hci_de
 	BT_DBG("%s evt %d", hdev->name, evt);
 }
 
+#ifdef CONFIG_BT_HCIUSB_SCO
+static int hci_usb_sco_q_pend(struct hci_dev *hdev)
+{
+	struct hci_usb *husb = (struct hci_usb *) hdev->driver_data;
+	return atomic_read(__pending_tx(husb, HCI_SCODATA_PKT));
+}
+#endif
+
 static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -1004,6 +1012,9 @@ static int hci_usb_probe(struct usb_inte
 	hdev->send     = hci_usb_send_frame;
 	hdev->destruct = hci_usb_destruct;
 	hdev->notify   = hci_usb_notify;
+#ifdef CONFIG_BT_HCIUSB_SCO
+	hdev->sco_queue_pend	= hci_usb_sco_q_pend;
+#endif
 
 	hdev->owner = THIS_MODULE;
 
Index: linux-2.6.21/include/net/bluetooth/hci_core.h
===================================================================
--- linux-2.6.21.orig/include/net/bluetooth/hci_core.h
+++ linux-2.6.21/include/net/bluetooth/hci_core.h
@@ -141,6 +141,7 @@ struct hci_dev {
 	void (*destruct)(struct hci_dev *hdev);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
+	int (*sco_queue_pend)(struct hci_dev *hdev);
 };
 
 struct hci_conn {
Index: linux-2.6.21/net/bluetooth/hci_conn.c
===================================================================
--- linux-2.6.21.orig/net/bluetooth/hci_conn.c
+++ linux-2.6.21/net/bluetooth/hci_conn.c
@@ -133,6 +133,8 @@ static void hci_conn_timeout(unsigned lo
 {
 	struct hci_conn *conn = (void *) arg;
 	struct hci_dev *hdev = conn->hdev;
+	int	q_len = 0;
+	unsigned long timeo;
 
 	BT_DBG("conn %p state %d", conn, conn->state);
 
@@ -146,6 +148,16 @@ static void hci_conn_timeout(unsigned lo
 		hci_acl_connect_cancel(conn);
 		break;
 	case BT_CONNECTED:
+		if (conn->type == SCO_LINK) {
+			if (hdev->sco_queue_pend) {
+				q_len = (hdev->sco_queue_pend)(hdev);
+				if (q_len > 0) {
+					timeo = msecs_to_jiffies(1000);
+					mod_timer(&conn->disc_timer, jiffies + timeo);
+					break;
+				}
+			}
+		}
 		hci_acl_disconn(conn, 0x13);
 		break;
 	default:
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
