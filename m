Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] Bluetooth: Add mgmt_send_event() helper to send to any HCI channel
Date: Mon,  2 Mar 2015 22:13:53 +0200
Message-Id: <1425327233-4427-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425327233-4427-1-git-send-email-johan.hedberg@gmail.com>
References: <1425327233-4427-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Currently the mgmt_event() function is only capable of sending to
HCI_CHANNEL_CONTROL. To void having to change all users of it, add a new
mgmt_send_event() function that takes a channel parameter, and make the
old mgmt_event() a wrapper that passes MGMT_CHANNEL_CONTROL to it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54ad6ad91e37..ccdf405920dd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -219,8 +219,9 @@ static u8 mgmt_status(u8 hci_status)
 	return MGMT_STATUS_FAILED;
 }
 
-static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
-		      struct sock *skip_sk)
+static int mgmt_send_event(u16 event, struct hci_dev *hdev,
+			   unsigned short channel, void *data, u16 data_len,
+			   struct sock *skip_sk)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -243,12 +244,19 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	hci_send_to_channel(HCI_CHANNEL_CONTROL, skb, skip_sk);
+	hci_send_to_channel(channel, skb, skip_sk);
 	kfree_skb(skb);
 
 	return 0;
 }
 
+static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
+		      struct sock *skip_sk)
+{
+	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
+			       skip_sk);
+}
+
 static int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
-- 
2.1.0

