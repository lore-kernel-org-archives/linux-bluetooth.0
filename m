Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 5/6] Bluetooth: Correct packet len calculation
Date: Wed,  7 Dec 2011 15:56:55 +0200
Message-Id: <1323266216-25261-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove unneeded skb_pull and correct packet length calculation
removing magic number.
---
 net/bluetooth/hci_event.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfccf7e..21c1bf0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2268,8 +2268,6 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
 	int i;
 
-	skb_pull(skb, sizeof(*ev));
-
 	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
 
 	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
@@ -2277,7 +2275,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 		return;
 	}
 
-	if (skb->len < ev->num_hndl * 4) {
+	if (skb->len < ev->num_hndl * sizeof(struct hci_comp_pkts_info) +
+			sizeof(*ev)) {
 		BT_DBG("%s bad parameters", hdev->name);
 		return;
 	}
-- 
1.7.4.1

