Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/11] Bluetooth: Fix stand-alone HCI command handling
Date: Tue,  5 Mar 2013 20:37:47 +0200
Message-Id: <1362508671-6460-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To have a consistent content for hdev->cmd_q all entries need to follow
the semantics of asynchronous HCI requests. This means that even single
commands need to be dressed as requests by having a request start
indicator. This patch adds these indicators to the two places needing
it (hci_send_cmd and hci_sock_sendmsg).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    5 +++++
 net/bluetooth/hci_sock.c |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a46d1f8..08a21c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2511,6 +2511,11 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hdev->init_last_cmd = opcode;
 
+	/* Stand-alone HCI commands must be flaged as
+	 * single-command requests.
+	 */
+	bt_cb(skb)->req.start = true;
+
 	skb_queue_tail(&hdev->cmd_q, skb);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 20c92de..4c41265 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -859,6 +859,11 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
+			/* Stand-alone HCI commands must be flaged as
+			 * single-command requests.
+			 */
+			bt_cb(skb)->req.start = true;
+
 			skb_queue_tail(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
 		}
-- 
1.7.10.4

