Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Add extra channel checks for control open/close messages
Date: Tue, 30 Aug 2016 05:00:38 +0200
Message-Id: <1472526040-21804-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The control open and close monitoring events require special channel
checks to ensure messages are only send when the right events happen.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5c7d3fba9817..d5581ca7a07e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -479,7 +479,7 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 {
 	struct hci_mon_hdr *hdr;
 	struct sk_buff *skb;
-	u16 format = 0x0001;
+	u16 format;
 	u8 ver[3];
 	u32 flags;
 
@@ -487,11 +487,20 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 	if (!hci_pi(sk)->cookie)
 		return NULL;
 
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_CONTROL:
+		format = 0x0001;
+		mgmt_fill_version_info(ver);
+		break;
+	default:
+		/* No message for unsupported format */
+		return NULL;
+	}
+
 	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
 	if (!skb)
 		return NULL;
 
-	mgmt_fill_version_info(ver);
 	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
 
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
@@ -523,6 +532,14 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	if (!hci_pi(sk)->cookie)
 		return NULL;
 
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_CONTROL:
+		break;
+	default:
+		/* No message for unsupported format */
+		return NULL;
+	}
+
 	skb = bt_skb_alloc(4, GFP_ATOMIC);
 	if (!skb)
 		return NULL;
@@ -652,9 +669,6 @@ static void send_monitor_control_replay(struct sock *mon_sk)
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *skb;
 
-		if (hci_pi(sk)->channel != HCI_CHANNEL_CONTROL)
-			continue;
-
 		skb = create_monitor_ctrl_open(sk);
 		if (!skb)
 			continue;
-- 
2.7.4

