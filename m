Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 17/17] Bluetooth: Update background scan parameters
Date: Wed, 26 Feb 2014 20:21:56 -0300
Message-Id: <1393456916-22701-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If new scanning parameters are set while background scan is running,
we should restart background scanning so these parameters are updated.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2e6564e..4c4912e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3924,6 +3924,21 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0, NULL, 0);
 
+	/* If background scan is running, restart it so new parameters are
+	 * loaded.
+	 */
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    hdev->discovery.state == DISCOVERY_STOPPED) {
+		struct hci_request req;
+
+		hci_req_init(&req, hdev);
+
+		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_passive_scan(&req);
+
+		hci_req_run(&req, NULL);
+	}
+
 	hci_dev_unlock(hdev);
 
 	return err;
-- 
1.8.5.4

