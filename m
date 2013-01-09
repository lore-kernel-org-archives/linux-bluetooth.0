Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Fix accepting set_dev_class for non-BR/EDR controllers
Date: Wed,  9 Jan 2013 15:29:36 +0200
Message-Id: <1357738180-4128-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The concept of Class of Device only exists for BR/EDR controllers. The
mgmt_set_dev_class command should therefore return a proper "not
supported" error if it is attempted for a controller that doesn't
support BR/EDR (e.g. a single mode LE-only one).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2785de2..6e6de9e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1424,6 +1424,12 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (!lmp_bredr_capable(hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				 MGMT_STATUS_NOT_SUPPORTED);
+		goto unlock;
+	}
+
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 				 MGMT_STATUS_BUSY);
-- 
1.7.10.4

