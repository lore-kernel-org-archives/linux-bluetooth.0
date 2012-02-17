Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set DISCOVERY_STOPPED if controller resets
Date: Fri, 17 Feb 2012 20:12:40 -0300
Message-Id: <1329520360-16874-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If controller is reset during the discovery procedure, Start
Discovery command stops working. This can be easily reproduced
by running "hciconfig hci0 reset" while discovering devices,
for instance.

We should force discovery state to DISCOVERY_STOPPED in case we
receive a reset command complete event. Otherwise we may stuck
in one of the active discovery states (DISCOVERY_INQUIRY,
DISCOVERY_LE_SCAN and DISCOVERY_RESOLVING) and subsequent Start
Discovery commands will simply fail.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 179d127..6bd3bd2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -198,6 +198,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Reset all flags, except persistent ones */
 	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF) |
 				BIT(HCI_LINK_KEYS) | BIT(HCI_DEBUG_KEYS);
+
+	hdev->discovery.state = DISCOVERY_STOPPED;
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.9.1

