Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 14/15] Bluetooth: Fix hci_create_le_conn()
Date: Wed, 16 Oct 2013 20:18:04 -0300
Message-Id: <1381965485-9159-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a LE device we want automatically connect to is found during the
device discovery procedure, we create the connection. Since some LE
controllers don't support scanning and initiating state combination,
the scanning will be disabled therefore we should set the discovery
state to DISCOVERY_STOPPED

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6ae42c2..5caf13b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -576,6 +576,11 @@ static int hci_create_le_conn(struct hci_conn *conn)
 		enable_cp.enable = LE_SCAN_DISABLE;
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 			    &enable_cp);
+
+		if (hdev->discovery.state == DISCOVERY_FINDING) {
+			cancel_delayed_work(&hdev->le_scan_disable);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		}
 	}
 
 	memset(&cp, 0, sizeof(cp));
-- 
1.8.4

