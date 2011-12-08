Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/6] Bluetooth: Check for flow control mode
Date: Thu,  8 Dec 2011 14:53:03 +0200
Message-Id: <1323348786-18134-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 493e08b..a06cc60 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2273,6 +2273,11 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
 
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
+		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
+		return;
+	}
+
 	if (skb->len < ev->num_hndl * 4) {
 		BT_DBG("%s bad parameters", hdev->name);
 		return;
-- 
1.7.4.1

