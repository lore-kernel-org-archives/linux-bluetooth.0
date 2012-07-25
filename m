Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 12/21] Bluetooth: Add state to hci_chan
Date: Wed, 25 Jul 2012 16:51:04 -0700
Message-Id: <1343260274-11953-13-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/hci_core.h | 7 ++++---
 net/bluetooth/hci_conn.c         | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 41d9439..4de510a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -336,11 +336,12 @@ struct hci_conn {
 };
 
 struct hci_chan {
-	struct list_head list;
+	struct list_head	list;
 
-	struct hci_conn *conn;
-	struct sk_buff_head data_q;
+	struct hci_conn	*conn;
+	struct sk_buff_head	data_q;
 	unsigned int	sent;
+	__u8	state;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5ad7da2..1b796e5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -903,6 +903,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 
 	chan->conn = conn;
 	skb_queue_head_init(&chan->data_q);
+	chan->state = BT_CONNECTED;
 
 	list_add_rcu(&chan->list, &conn->chan_list);
 
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
