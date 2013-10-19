Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Move HCI_LIMITED_DISCOVERABLE changes to a general place
Date: Sat, 19 Oct 2013 23:38:22 +0300
Message-Id: <1382215103-6968-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon be introducing also LE support for the Set Discoverable
management command, so move the HCI_LIMITED_DISCOVERABLE flag clearing
and setting out from the if-branch that is only used for a BR/EDR
specific HCI command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 67b95a8..796db58 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1220,6 +1220,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	cancel_delayed_work(&hdev->discov_off);
 	hdev->discov_timeout = timeout;
 
+	/* Limited discoverable mode */
+	if (cp->val == 0x02)
+		set_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+	else
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+
 	hci_req_init(&req, hdev);
 
 	scan = SCAN_PAGE;
@@ -1229,8 +1235,6 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cp->val == 0x02) {
 			/* Limited discoverable mode */
-			set_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-
 			hci_cp.num_iac = 2;
 			hci_cp.iac_lap[0] = 0x00;	/* LIAC */
 			hci_cp.iac_lap[1] = 0x8b;
@@ -1240,8 +1244,6 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			hci_cp.iac_lap[5] = 0x9e;
 		} else {
 			/* General discoverable mode */
-			clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-
 			hci_cp.num_iac = 1;
 			hci_cp.iac_lap[0] = 0x33;	/* GIAC */
 			hci_cp.iac_lap[1] = 0x8b;
-- 
1.8.3.1

