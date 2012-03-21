Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 3/4] Bluetooth: Check HCI_PERIODIC_INQ in start_discovery
Date: Wed, 21 Mar 2012 00:03:37 -0300
Message-Id: <1332299018-15933-4-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1332299018-15933-1-git-send-email-aguedespe@gmail.com>
References: <1332299018-15933-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a HCI_PERIODIC_INQ check to start_discovery.
If periodic inquiry is enabled, we fail MGMT Start Discovery
command with MGMT_STATUS_BUSY code.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d93f2bf..e399581 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2315,6 +2315,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				 MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 				 MGMT_STATUS_BUSY);
-- 
1.7.9.4

