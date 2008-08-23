Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Sat, 23 Aug 2008 21:13:13 +0000 (UTC)
Message-ID: <loom.20080823T211230-83@post.gmane.org>
References: <loom.20080822T022926-635@post.gmane.org>
	<loom.20080823T192730-77@post.gmane.org>
	<1219522965.7591.482.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Patch] Flush Occurred Event
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

Hi, Marcel, please see if it is ok
Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> against 2.6.27-rc4 please and in unified diff format. I am not even
> going to bother reading context diffs.
> 
> Regards
> 
> Marcel

diff -ru orig/include/net/bluetooth/hci.h new/include/net/bluetooth/hci.h
--- orig/include/net/bluetooth/hci.h	2008-08-23 11:42:08.000000000 -0400
+++ new/include/net/bluetooth/hci.h	2008-08-23 11:44:22.000000000 -0400
@@ -682,6 +682,12 @@
 	__le16   opcode;
 } __attribute__ ((packed));
 
+#define HCI_EV_FLUSH_OCCURRED   0x11
+#define NUM_OF_FLUSH_PKT        0x1
+struct hci_ev_flush_occurred {
+        __le16   handle;
+} __attribute__ ((packed));
+
 #define HCI_EV_ROLE_CHANGE		0x12
 struct hci_ev_role_change {
 	__u8     status;
diff -ru orig/net/bluetooth/hci_event.c new/net/bluetooth/hci_event.c
--- orig/net/bluetooth/hci_event.c	2008-08-23 11:42:12.000000000 -0400
+++ new/net/bluetooth/hci_event.c	2008-08-23 11:50:36.000000000 -0400
@@ -1398,6 +1398,32 @@
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_flush_occurred_evt(struct hci_dev *hdev, struct sk_buff
*skb)
+{
+	struct hci_ev_flush_occurred *ev = (struct hci_ev_flush_occurred *) skb->data;
+	struct hci_conn *conn;
+	
+	tasklet_disable(&hdev->tx_task);
+
+	BT_DBG("handle is %x, skb->len %d\n", ev->handle, skb->len);	
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+
+	if (conn) {
+		atomic_sub(NUM_OF_FLUSH_PKT, &conn->sent);
+
+		if (conn->type == ACL_LINK) {
+			if ((hdev->acl_cnt += NUM_OF_FLUSH_PKT) > hdev->acl_pkts)
+				hdev->acl_cnt = hdev->acl_pkts;
+		}
+		BT_DBG("conn %p type %d hdev->acl_cnt %d conn->sent %d",
+			conn, conn->type, hdev->acl_cnt, atomic_read(&conn->sent));
+	}
+	hci_sched_tx(hdev);
+
+	tasklet_enable(&hdev->tx_task);
+}
+
 static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
@@ -1894,6 +1920,10 @@
 		hci_remote_host_features_evt(hdev, skb);
 		break;
 
+	case HCI_EV_FLUSH_OCCURRED:
+		hci_flush_occurred_evt(hdev, skb);
+		break;	
+
 	default:
 		BT_DBG("%s event 0x%x", hdev->name, event);
 		break;


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
