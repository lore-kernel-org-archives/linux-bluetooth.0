Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Add support for sending MGMT commands and events to monitor
Date: Sat, 27 Aug 2016 20:23:41 +0200
Message-Id: <1472322221-86761-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for tracing all management commands and events via the
monitor interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++
 include/net/bluetooth/hci_mon.h  |  2 +
 net/bluetooth/hci_sock.c         | 94 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt_util.c        | 66 ++++++++++++++++++++++++++--
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9f181b583b96..a48f71d73dc8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1406,6 +1406,9 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			 int flag, struct sock *skip_sk);
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_send_monitor_ctrl_event(struct hci_dev *hdev, u16 event,
+				 void *data, u16 data_len, ktime_t tstamp,
+				 int flag, struct sock *skip_sk);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 9640790cbbcc..240786b04a46 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -47,6 +47,8 @@ struct hci_mon_hdr {
 #define HCI_MON_USER_LOGGING	13
 #define HCI_MON_CTRL_OPEN	14
 #define HCI_MON_CTRL_CLOSE	15
+#define HCI_MON_CTRL_COMMAND	16
+#define HCI_MON_CTRL_EVENT	17
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ccbc3f711152..3e6a649a0601 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -315,6 +315,60 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
+void hci_send_monitor_ctrl_event(struct hci_dev *hdev, u16 event,
+				 void *data, u16 data_len, ktime_t tstamp,
+				 int flag, struct sock *skip_sk)
+{
+	struct sock *sk;
+	__le16 index;
+
+	if (hdev)
+		index = cpu_to_le16(hdev->id);
+	else
+		index = cpu_to_le16(MGMT_INDEX_NONE);
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, &hci_sk_list.head) {
+		struct hci_mon_hdr *hdr;
+		struct sk_buff *skb;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_CONTROL)
+			continue;
+
+		/* Ignore socket without the flag set */
+		if (!hci_sock_test_flag(sk, flag))
+			continue;
+
+		/* Skip the original socket */
+		if (sk == skip_sk)
+			continue;
+
+		skb = bt_skb_alloc(6 + data_len, GFP_ATOMIC);
+		if (!skb)
+			continue;
+
+		put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+		put_unaligned_le16(event, skb_put(skb, 2));
+
+		if (data)
+			memcpy(skb_put(skb, data_len), data, data_len);
+
+		skb->tstamp = tstamp;
+
+		hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+		hdr->opcode = cpu_to_le16(HCI_MON_CTRL_EVENT);
+		hdr->index = index;
+		hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+				    HCI_SOCK_TRUSTED, NULL);
+		kfree_skb(skb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+}
+
 static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 {
 	struct hci_mon_hdr *hdr;
@@ -447,6 +501,33 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	return skb;
 }
 
+static struct sk_buff *create_monitor_ctrl_command(struct sock *sk, u16 index,
+						   u16 opcode, u16 len,
+						   const void *buf)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(6 + len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+	put_unaligned_le16(opcode, skb_put(skb, 2));
+
+	if (buf)
+		memcpy(skb_put(skb, len), buf, len);
+
+	__net_timestamp(skb);
+
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_COMMAND);
+	hdr->index = cpu_to_le16(index);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
 static void __printf(2, 3)
 send_monitor_note(struct sock *sk, const char *fmt, ...)
 {
@@ -1257,6 +1338,19 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 		goto done;
 	}
 
+	if (chan->channel == HCI_CHANNEL_CONTROL) {
+		struct sk_buff *skb;
+
+		/* Send event to monitor */
+		skb = create_monitor_ctrl_command(sk, index, opcode, len,
+						  buf + sizeof(*hdr));
+		if (skb) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
+			kfree_skb(skb);
+		}
+	}
+
 	if (opcode >= chan->handler_count ||
 	    chan->handlers[opcode].func == NULL) {
 		BT_DBG("Unknown op %u", opcode);
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 8c30c7eb8bef..c933bd08c1fe 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -21,12 +21,41 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <asm/unaligned.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_mon.h>
 #include <net/bluetooth/mgmt.h>
 
 #include "mgmt_util.h"
 
+static struct sk_buff *create_monitor_ctrl_event(__le16 index, u32 cookie,
+						 u16 opcode, u16 len, void *buf)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(6 + len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	put_unaligned_le32(cookie, skb_put(skb, 4));
+	put_unaligned_le16(opcode, skb_put(skb, 2));
+
+	if (buf)
+		memcpy(skb_put(skb, len), buf, len);
+
+	__net_timestamp(skb);
+
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_EVENT);
+	hdr->index = index;
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
 int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
 		    void *data, u16 data_len, int flag, struct sock *skip_sk)
 {
@@ -52,14 +81,18 @@ int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
 	__net_timestamp(skb);
 
 	hci_send_to_channel(channel, skb, flag, skip_sk);
-	kfree_skb(skb);
 
+	if (channel == HCI_CHANNEL_CONTROL)
+		hci_send_monitor_ctrl_event(hdev, event, data, data_len,
+					    skb_get_ktime(skb), flag, skip_sk);
+
+	kfree_skb(skb);
 	return 0;
 }
 
 int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb, *mskb;
 	struct mgmt_hdr *hdr;
 	struct mgmt_ev_cmd_status *ev;
 	int err;
@@ -80,17 +113,30 @@ int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 	ev->status = status;
 	ev->opcode = cpu_to_le16(cmd);
 
+	mskb = create_monitor_ctrl_event(hdr->index, hci_sock_get_cookie(sk),
+					 MGMT_EV_CMD_STATUS, sizeof(*ev), ev);
+	if (mskb)
+		skb->tstamp = mskb->tstamp;
+	else
+		__net_timestamp(skb);
+
 	err = sock_queue_rcv_skb(sk, skb);
 	if (err < 0)
 		kfree_skb(skb);
 
+	if (mskb) {
+		hci_send_to_channel(HCI_CHANNEL_MONITOR, mskb,
+				    HCI_SOCK_TRUSTED, NULL);
+		kfree_skb(mskb);
+	}
+
 	return err;
 }
 
 int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 		      void *rp, size_t rp_len)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb, *mskb;
 	struct mgmt_hdr *hdr;
 	struct mgmt_ev_cmd_complete *ev;
 	int err;
@@ -114,10 +160,24 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 	if (rp)
 		memcpy(ev->data, rp, rp_len);
 
+	mskb = create_monitor_ctrl_event(hdr->index, hci_sock_get_cookie(sk),
+					 MGMT_EV_CMD_COMPLETE,
+					 sizeof(*ev) + rp_len, ev);
+	if (mskb)
+		skb->tstamp = mskb->tstamp;
+	else
+		__net_timestamp(skb);
+
 	err = sock_queue_rcv_skb(sk, skb);
 	if (err < 0)
 		kfree_skb(skb);
 
+	if (mskb) {
+		hci_send_to_channel(HCI_CHANNEL_MONITOR, mskb,
+				    HCI_SOCK_TRUSTED, NULL);
+		kfree_skb(mskb);
+	}
+
 	return err;
 }
 
-- 
2.7.4

