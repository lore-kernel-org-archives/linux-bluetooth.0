Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 5/6] Bluetooth: Correct packet len calculation
Date: Thu,  8 Dec 2011 14:53:05 +0200
Message-Id: <1323348786-18134-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove unneeded skb_pull and correct packet length calculation
removing magic number. Move BT_DBG after len check otherwise
it could possibly access wrong memory.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 670903b..c96d580 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2268,20 +2268,19 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
 	int i;
 
-	skb_pull(skb, sizeof(*ev));
-
-	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
-
 	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
 		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
-	if (skb->len < ev->num_hndl * 4) {
+	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
+			ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {
 		BT_DBG("%s bad parameters", hdev->name);
 		return;
 	}
 
+	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
+
 	tasklet_disable(&hdev->tx_task);
 
 	for (i = 0; i < ev->num_hndl; i++) {
-- 
1.7.4.1

