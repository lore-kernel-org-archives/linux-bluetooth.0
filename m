Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Make hci_get_cmd_complete() function public
Date: Thu,  5 Feb 2015 11:18:24 +0200
Message-Id: <1423127905-27281-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
References: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the HCI request API is able to pass the final skb to the
callback it will be useful to have a helper function to dig out the
actual cmd_complete parameters from it. We already have such a function
in the form of hci_get_cmd_complete() and this patch makes it public for
other code besides hci_core.c to use.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7026885aefaf..1b18b1d6a299 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1308,6 +1308,9 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
+struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
+				     u8 event, struct sk_buff *skb);
+
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 700f57762158..8a0a750b8463 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -166,8 +166,8 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 	}
 }
 
-static struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
-					    u8 event, struct sk_buff *skb)
+struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
+				     u8 event, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev;
 	struct hci_event_hdr *hdr;
-- 
2.1.0

