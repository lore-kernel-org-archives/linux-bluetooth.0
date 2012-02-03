Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/6] Bluetooth: Minor code refactoring
Date: Fri,  3 Feb 2012 17:47:58 -0300
Message-Id: <1328302082-17405-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
References: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial code refacting in hci_discovery_active.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1705d93..1175f27 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -360,12 +360,15 @@ bool hci_discovery_active(struct hci_dev *hdev)
 {
 	struct discovery_state *discov = &hdev->discovery;
 
-	if (discov->state == DISCOVERY_INQUIRY ||
-					discov->state == DISCOVERY_LE_SCAN ||
-					discov->state == DISCOVERY_RESOLVING)
+	switch (discov->state) {
+	case DISCOVERY_INQUIRY:
+	case DISCOVERY_LE_SCAN:
+	case DISCOVERY_RESOLVING:
 		return true;
 
-	return false;
+	default:
+		return false;
+	}
 }
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state)
-- 
1.7.9

