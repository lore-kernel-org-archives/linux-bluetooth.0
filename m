Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	bjorn.andersson@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: btqcomsmd: Fix rx/tx stats
Date: Fri,  6 Apr 2018 11:23:45 +0200
Message-Id: <1523006625-17257-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

HCI RX/TX byte counters were only incremented when sending ACL packets.
To reflect the real HCI traffic, we need to increment these counters on
HCI events and HCI commands as well.

Increment error counter on rpmsg errors.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/btqcomsmd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 2c9a5fc..7df3eed 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -65,6 +65,7 @@ static int btqcomsmd_cmd_callback(struct rpmsg_device *rpdev, void *data,
 {
 	struct btqcomsmd *btq = priv;
 
+	btq->hdev->stat.byte_rx += count;
 	return btqcomsmd_recv(btq->hdev, HCI_EVENT_PKT, data, count);
 }
 
@@ -76,12 +77,21 @@ static int btqcomsmd_send(struct hci_dev *hdev, struct sk_buff *skb)
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_ACLDATA_PKT:
 		ret = rpmsg_send(btq->acl_channel, skb->data, skb->len);
+		if (ret) {
+			hdev->stat.err_tx++;
+			break;
+		}
 		hdev->stat.acl_tx++;
 		hdev->stat.byte_tx += skb->len;
 		break;
 	case HCI_COMMAND_PKT:
 		ret = rpmsg_send(btq->cmd_channel, skb->data, skb->len);
+		if (ret) {
+			hdev->stat.err_tx++;
+			break;
+		}
 		hdev->stat.cmd_tx++;
+		hdev->stat.byte_tx += skb->len;
 		break;
 	default:
 		ret = -EILSEQ;
-- 
2.7.4
