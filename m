Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix notifying discovery state upon reset
Date: Wed, 28 Jan 2015 15:13:17 +0200
Message-Id: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When HCI_Reset is issued the discovery state is assumed to be stopped.
The hci_cc_reset() handler was trying to set the state but it was doing
it without using the hci_discovery_set_state() function. Because of this
e.g. the mgmt Discovering event could go without being sent. This patch
fixes the code to use the hci_discovery_set_state() function instead of
just blindly setting the state value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 00c160634e7b..4175470ff48e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -200,7 +200,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Reset all non-persistent flags */
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
-	hdev->discovery.state = DISCOVERY_STOPPED;
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 
-- 
2.1.0

