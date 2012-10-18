Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv3 08/18] Bluetooth: Add state to hci_chan
Date: Thu, 18 Oct 2012 10:58:40 -0700
Message-Id: <1350583130-3241-9-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On an AMP controller, hci_chan maps to a logical link.  When a channel
is being moved, the logical link may or may not be connected already.
The hci_chan->state is used to determine the existance of a useable
logical link so the link can be either used or requested.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9fe8e2d..00abc52 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -355,6 +355,7 @@ struct hci_chan {
 	struct hci_conn *conn;
 	struct sk_buff_head data_q;
 	unsigned int	sent;
+	__u8		state;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe64621..6dcf452 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -959,6 +959,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 
 	chan->conn = conn;
 	skb_queue_head_init(&chan->data_q);
+	chan->state = BT_CONNECTED;
 
 	list_add_rcu(&chan->list, &conn->chan_list);
 
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
