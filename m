Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove HCI notifier handling
Date: Mon, 20 Feb 2012 13:10:05 +0100
Message-Id: <1329739805-16235-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI notifier handling was never used outside of Bluetooth core layer
and thus remove it and replace it with direct function calls. Also move
the stack internal event generation into the HCI socket layer.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    7 +--
 net/bluetooth/hci_conn.c         |    1 -
 net/bluetooth/hci_core.c         |   16 +-----
 net/bluetooth/hci_event.c        |   29 ----------
 net/bluetooth/hci_sock.c         |  105 ++++++++++++++++++++++----------------
 5 files changed, 64 insertions(+), 94 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9209e4c..41adae5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -941,21 +941,18 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
-int hci_register_notifier(struct notifier_block *nb);
-int hci_unregister_notifier(struct notifier_block *nb);
-
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
-void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
-
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
 
+void hci_sock_dev_event(struct hci_dev *hdev, int event);
+
 /* Management interface */
 #define MGMT_ADDR_BREDR			0x00
 #define MGMT_ADDR_LE_PUBLIC		0x01
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8549d04..3c68e60 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
-#include <linux/notifier.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 638fa8c..4721728 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -40,7 +40,6 @@
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
-#include <linux/notifier.h>
 #include <linux/rfkill.h>
 #include <linux/timer.h>
 #include <linux/crypto.h>
@@ -69,24 +68,11 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 LIST_HEAD(hci_cb_list);
 DEFINE_RWLOCK(hci_cb_list_lock);
 
-/* HCI notifiers list */
-static ATOMIC_NOTIFIER_HEAD(hci_notifier);
-
 /* ---- HCI notifications ---- */
 
-int hci_register_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&hci_notifier, nb);
-}
-
-int hci_unregister_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&hci_notifier, nb);
-}
-
 static void hci_notify(struct hci_dev *hdev, int event)
 {
-	atomic_notifier_call_chain(&hci_notifier, event, hdev);
+	hci_sock_dev_event(hdev, event);
 }
 
 /* ---- HCI requests ---- */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e69db4a..f00faf0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
-#include <linux/notifier.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -3547,33 +3546,5 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hdev->stat.evt_rx++;
 }
 
-/* Generate internal stack event */
-void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
-{
-	struct hci_event_hdr *hdr;
-	struct hci_ev_stack_internal *ev;
-	struct sk_buff *skb;
-
-	skb = bt_skb_alloc(HCI_EVENT_HDR_SIZE + sizeof(*ev) + dlen, GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	hdr = (void *) skb_put(skb, HCI_EVENT_HDR_SIZE);
-	hdr->evt  = HCI_EV_STACK_INTERNAL;
-	hdr->plen = sizeof(*ev) + dlen;
-
-	ev  = (void *) skb_put(skb, sizeof(*ev) + dlen);
-	ev->type = type;
-	memcpy(ev->data, data, dlen);
-
-	bt_cb(skb)->incoming = 1;
-	__net_timestamp(skb);
-
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-	skb->dev = (void *) hdev;
-	hci_send_to_sock(hdev, skb);
-	kfree_skb(skb);
-}
-
 module_param(enable_le, bool, 0644);
 MODULE_PARM_DESC(enable_le, "Enable LE support");
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 73068c2..19b324b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -189,6 +189,67 @@ void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
 	read_unlock(&hci_sk_list.lock);
 }
 
+/* Generate internal stack event */
+static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
+{
+	struct hci_event_hdr *hdr;
+	struct hci_ev_stack_internal *ev;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(HCI_EVENT_HDR_SIZE + sizeof(*ev) + dlen, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	hdr = (void *) skb_put(skb, HCI_EVENT_HDR_SIZE);
+	hdr->evt  = HCI_EV_STACK_INTERNAL;
+	hdr->plen = sizeof(*ev) + dlen;
+
+	ev  = (void *) skb_put(skb, sizeof(*ev) + dlen);
+	ev->type = type;
+	memcpy(ev->data, data, dlen);
+
+	bt_cb(skb)->incoming = 1;
+	__net_timestamp(skb);
+
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	skb->dev = (void *) hdev;
+	hci_send_to_sock(hdev, skb);
+	kfree_skb(skb);
+}
+
+void hci_sock_dev_event(struct hci_dev *hdev, int event)
+{
+	struct hci_ev_si_device ev;
+
+	BT_DBG("hdev %s event %d", hdev->name, event);
+
+	/* Send event to sockets */
+	ev.event  = event;
+	ev.dev_id = hdev->id;
+	hci_si_event(NULL, HCI_EV_SI_DEVICE, sizeof(ev), &ev);
+
+	if (event == HCI_DEV_UNREG) {
+		struct sock *sk;
+		struct hlist_node *node;
+
+		/* Detach sockets from device */
+		read_lock(&hci_sk_list.lock);
+		sk_for_each(sk, node, &hci_sk_list.head) {
+			bh_lock_sock_nested(sk);
+			if (hci_pi(sk)->hdev == hdev) {
+				hci_pi(sk)->hdev = NULL;
+				sk->sk_err = EPIPE;
+				sk->sk_state = BT_OPEN;
+				sk->sk_state_change(sk);
+
+				hci_dev_put(hdev);
+			}
+			bh_unlock_sock(sk);
+		}
+		read_unlock(&hci_sk_list.lock);
+	}
+}
+
 static int hci_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -821,52 +882,12 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 	return 0;
 }
 
-static int hci_sock_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
-{
-	struct hci_dev *hdev = (struct hci_dev *) ptr;
-	struct hci_ev_si_device ev;
-
-	BT_DBG("hdev %s event %ld", hdev->name, event);
-
-	/* Send event to sockets */
-	ev.event  = event;
-	ev.dev_id = hdev->id;
-	hci_si_event(NULL, HCI_EV_SI_DEVICE, sizeof(ev), &ev);
-
-	if (event == HCI_DEV_UNREG) {
-		struct sock *sk;
-		struct hlist_node *node;
-
-		/* Detach sockets from device */
-		read_lock(&hci_sk_list.lock);
-		sk_for_each(sk, node, &hci_sk_list.head) {
-			bh_lock_sock_nested(sk);
-			if (hci_pi(sk)->hdev == hdev) {
-				hci_pi(sk)->hdev = NULL;
-				sk->sk_err = EPIPE;
-				sk->sk_state = BT_OPEN;
-				sk->sk_state_change(sk);
-
-				hci_dev_put(hdev);
-			}
-			bh_unlock_sock(sk);
-		}
-		read_unlock(&hci_sk_list.lock);
-	}
-
-	return NOTIFY_DONE;
-}
-
 static const struct net_proto_family hci_sock_family_ops = {
 	.family	= PF_BLUETOOTH,
 	.owner	= THIS_MODULE,
 	.create	= hci_sock_create,
 };
 
-static struct notifier_block hci_sock_nblock = {
-	.notifier_call = hci_sock_dev_event
-};
-
 int __init hci_sock_init(void)
 {
 	int err;
@@ -879,8 +900,6 @@ int __init hci_sock_init(void)
 	if (err < 0)
 		goto error;
 
-	hci_register_notifier(&hci_sock_nblock);
-
 	BT_INFO("HCI socket layer initialized");
 
 	return 0;
@@ -896,8 +915,6 @@ void hci_sock_cleanup(void)
 	if (bt_sock_unregister(BTPROTO_HCI) < 0)
 		BT_ERR("HCI socket unregistration failed");
 
-	hci_unregister_notifier(&hci_sock_nblock);
-
 	proto_unregister(&hci_sk_proto);
 }
 
-- 
1.7.7.6

