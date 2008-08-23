Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Sat, 23 Aug 2008 19:33:31 +0000 (UTC)
Message-ID: <loom.20080823T192730-77@post.gmane.org>
References: <loom.20080822T022926-635@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [Patch] Flush Occurred Event
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

>
The following is a patch against 2.6.22 kernel to catch HCI "Flush Occurred"
event. (meaningful for ACL; useless for SCO)

One more thing to NOTICE is that the handle in the event packet from my adapter
seems to be "Big Endian", so that I use ntohs to convert it.
Normally it should be __le16_to_cpu(ev->handle)

diff -r linux-source-2.6.22/include/net/bluetooth/hci_core.h
patch-2.6.22/include/net/bluetooth/hci_core.h
27a28
> 
diff -r linux-source-2.6.22/include/net/bluetooth/hci.h
patch-2.6.22/include/net/bluetooth/hci.h
587a588,595
> /* Flush Occurred Event JuiHao --*/
> #define HCI_EV_FLUSH_OCCURRED	0x11
> #define NUM_OF_FLUSH_PKT	0x1
> struct hci_ev_flush_occurred {
> 	__le16   handle;
> } __attribute__ ((packed));
> /* --Flush Occurred Event JuiHao */
> 
diff -r linux-source-2.6.22/net/bluetooth/hci_event.c
patch-2.6.22/net/bluetooth/hci_event.c
854a855,882
> /* Flush Occurred packet JuiHao*/
> static inline void hci_flush_occurred_evt(struct hci_dev *hdev, struct sk_buff
*skb)
> {
> 	struct hci_ev_flush_occurred *ev = (struct hci_ev_flush_occurred *) skb->data;
> 	struct hci_conn *conn;
> 	
> 	tasklet_disable(&hdev->tx_task);
> 
> 	BT_DBG("handle is %x, skb->len %d\n", ev->handle, skb->len);	
> 
> 	/* The handle returned is probably Big Endian such that  __le16_to_cpu is
useless*/
> 	conn = hci_conn_hash_lookup_handle(hdev, ntohs(ev->handle));
> 
> 	if (conn) {
> 		atomic_sub(NUM_OF_FLUSH_PKT, &conn->sent);
> 
> 		if (conn->type == ACL_LINK) {
> 			if ((hdev->acl_cnt += NUM_OF_FLUSH_PKT) > hdev->acl_pkts)
> 				hdev->acl_cnt = hdev->acl_pkts;
> 		}
> 		BT_DBG("conn %p type %d hdev->acl_cnt %d conn->sent %d",
> 			conn, conn->type, hdev->acl_cnt, atomic_read(&conn->sent));
> 	}
> 	hci_sched_tx(hdev);
> 
> 	tasklet_enable(&hdev->tx_task);
> }
> 
1289a1318,1322
> 	/* handle Flush Occurred Event JuiHao --*/
> 	case HCI_EV_FLUSH_OCCURRED:
> 		hci_flush_occurred_evt(hdev, skb);
> 		break;	
> 	/* -- handle Flush Occurred Event JuiHao */

Bests,
Jui-Hao


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
