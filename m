Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] Hardware Error event patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 25 Mar 2005 15:09:20 +0100 (CET)

Hi Marcel,

I've finished the patch for handling the Hardware Error event and you have
it attached below.

To briefly remind the context: when H4 (HCI over UART) is used
as the transport layer between the host and the Bluetooth controller
and the controller detects a loss of synchronization, it sends a
"Hardware Error" event to the host, which should then send a "Reset"
command for resynchronization. The procedure is described under "Error
Recovery" in the H:4 appendix of Bluetooth v1.1 specification.

The patch mainly follows your suggested steps for resetting the stack
state (a reset of the acl_cnt and sco_cnt was missing).

There is only one thing that's not quite right in that patch: I'm enabling
page and inquiry scanning after the reset. That's because on my hardware
after the reset it disables page and inquiry scanning. The specification
(v1.1) says that after a reset the controller reverts to the default
values of configuration parameters (for Scan_Enable that default value is
"no scans"). I don't think we maintain the state of Scan_Enable in the stack
although we could (of course, we can't do anything if the Write Scan Enable
command is issued directly from userspace with hci_send_cmd). It probably
makes more sense to remove that Write Scan Enable command.

I have tested the patch and it seems to work fine as you can see in the
log below. There's a while loop in the background starting l2test
instances that send to a remote host. (My comments are prepended by
"<<<").

l2test[3762]: Connected [imtu 672, omtu 672, flush_to 65535, handle 1]
l2test[3762]: Sending ...
<<< l2test starts
hci_hardware_error_evt: hci0 Hardware Error event: 1
l2test[3762]: Send failed: Software caused connection abort (103)
<<< hw error occurs
root@h3900:~# hcitool con
Connections:
<<< ACL connection is correctly torn down
root@h3900:~# hciconfig -a
hci0:   Type: UART
        BD Address: 08:00:17:1A:EB:76 ACL MTU: 339:4 SCO MTU: 60:9
        UP RUNNING PSCAN ISCAN
        RX bytes:12461 acl:66 sco:0 events:31 errors:0
        TX bytes:2119 acl:23 sco:0 commands:14 errors:0
        Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'POCKET_PC'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
        Manufacturer: RTX Telecom A/S (21)
<<< synchronization is still there (hciconfig -a issues a bunch of
<<< commands to fill in this information)
l2test[3770]: Connected [imtu 672, omtu 672, flush_to 65535, handle 1]
l2test[3770]: Sending ...
<<< second l2test starts
hci_hardware_error_evt: hci0 Hardware Error event: 1
l2test[3770]: Send failed: Software caused connection abort (103)
<<< another hw error event
root@h3900:~#: hcitool con
Connections:
root@h3900:~# cat /proc/bluetooth/l2cap
00:00:00:00:00:00 00:00:00:00:00:00 4 4097 0x0000 0x0000 672 0 0x0
<<< the l2cap connection is torn down (the remaining one is a different
<<< l2test instance that is listening)

The Bluetooth module in the HP PocketPC iPAQ h5550 is very buggy as you
can see. It turns out that going into "no scan" mode improves stability by
quite a lot (instead of hw error events occuring immediately, they occur
after some hours of testing, if at all). In fact, the Widcomm stack under
Windows CE on this machine appears to do two things:

1. Whenever a connection is established it goes into non-discoverable,
non-connectable mode.
2. Whenever a connection is ongoing, it refuses to open a second
connection to another device.

So basically it's limiting the user to one connection at a time.

Regards,

Catalin

diff -ur linux-2.6.11-mh2/include/net/bluetooth/hci.h linux-2.6.11-mh2-hwerr/include/net/bluetooth/hci.h
--- linux-2.6.11-mh2/include/net/bluetooth/hci.h	2005-03-24 13:02:39.000000000 +0100
+++ linux-2.6.11-mh2-hwerr/include/net/bluetooth/hci.h	2005-03-25 14:12:04.566749715 +0100
@@ -584,6 +584,12 @@
 	__u16    clock_offset;
 } __attribute__ ((packed));

+#define HCI_EV_HARDWARE_ERROR	0x10
+struct hci_ev_hardware_error {
+	 __u8     hwcode;
+} __attribute__ ((packed));
+
+
 /* Internal events generated by Bluetooth stack */
 #define HCI_EV_STACK_INTERNAL	0xFD
 struct hci_ev_stack_internal {
diff -ur linux-2.6.11-mh2/net/bluetooth/hci_core.c linux-2.6.11-mh2-hwerr/net/bluetooth/hci_core.c
--- linux-2.6.11-mh2/net/bluetooth/hci_core.c	2005-03-24 13:02:43.000000000 +0100
+++ linux-2.6.11-mh2-hwerr/net/bluetooth/hci_core.c	2005-03-25 14:23:23.891761572 +0100
@@ -646,6 +646,64 @@
 	return ret;
 }

+int hci_dev_reset_hwerr(struct hci_dev *hdev) {
+	int ret = 0;
+	 __u8 scan = 0x03;
+
+	hci_req_lock(hdev);
+
+	/* Disable RX and TX tasks */
+	tasklet_disable(&hdev->rx_task);
+	tasklet_disable(&hdev->tx_task);
+
+	/* Flush connection hash */
+	hci_dev_lock_bh(hdev);
+	hci_conn_hash_flush(hdev);
+	hci_dev_unlock_bh(hdev);
+
+	/* Flush driver */
+	if (hdev->flush)
+		hdev->flush(hdev);
+
+	/* Disable cmd task */
+	tasklet_disable(&hdev->cmd_task);
+
+	/* Drop queues */
+	skb_queue_purge(&hdev->rx_q);
+        skb_queue_purge(&hdev->cmd_q);
+        skb_queue_purge(&hdev->raw_q);
+
+        /* Reset command counter */
+	atomic_set(&hdev->cmd_cnt, 1);
+
+	/* Drop last sent command */
+	if (hdev->sent_cmd) {
+		kfree_skb(hdev->sent_cmd);
+		hdev->sent_cmd = NULL;
+	}
+
+	/* Send reset command */
+	hci_send_cmd(hdev, OGF_HOST_CTL, OCF_RESET, 0, NULL);
+
+	/* Send read buffer size command to reset ACL and SCO counters */
+	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE, 0, NULL);
+
+	/* Optional initialization for buggy hardware */
+
+	/* Enable inquiry and page scanning */
+	hci_send_cmd(hdev, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE, 1, &scan);
+
+	/* Enable tasks */
+	tasklet_enable(&hdev->rx_task);
+	tasklet_enable(&hdev->tx_task);
+	tasklet_enable(&hdev->cmd_task);
+
+	hci_req_unlock(hdev);
+
+	return ret;
+}
+EXPORT_SYMBOL(hci_dev_reset_hwerr);
+
 int hci_dev_cmd(unsigned int cmd, void __user *arg)
 {
 	struct hci_dev *hdev;
diff -ur linux-2.6.11-mh2/net/bluetooth/hci_event.c linux-2.6.11-mh2-hwerr/net/bluetooth/hci_event.c
--- linux-2.6.11-mh2/net/bluetooth/hci_event.c	2005-03-24 13:08:31.000000000 +0100
+++ linux-2.6.11-mh2-hwerr/net/bluetooth/hci_event.c	2005-03-25 14:16:26.405451648 +0100
@@ -866,6 +866,16 @@
 	hci_dev_unlock(hdev);
 }

+/* Hardware Error */
+static inline void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb) {
+	struct hci_ev_hardware_error *ev = (struct hci_ev_hardware_error *) skb->data;
+
+	BT_ERR("%s Hardware Error event: %d", hdev->name, ev->hwcode);
+
+	hci_dev_reset_hwerr(hdev);
+}
+
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (struct hci_event_hdr *) skb->data;
@@ -938,6 +948,10 @@
 		hci_clock_offset_evt(hdev, skb);
 		break;

+	case HCI_EV_HARDWARE_ERROR:
+		hci_hardware_error_evt(hdev, skb);
+		break;
+
 	case HCI_EV_CMD_STATUS:
 		cs = (struct hci_ev_cmd_status *) skb->data;
 		skb_pull(skb, sizeof(cs));




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
