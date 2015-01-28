Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix check for SSP when enabling SC
Date: Wed, 28 Jan 2015 12:23:18 +0200
Message-Id: <1422440598-12210-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's a check in set_secure_conn() that's supposed to ensure that SSP
is enabled before we try to request the controller to enable SC (since
SSP is a pre-requisite for it). However, this check only makes sense for
controllers actually supporting BR/EDR SC. If we have a 4.0 controller
we're only interested in the LE part of SC and should therefore not be
requiring SSP to be enabled. This patch adds an additional condition to
check for lmp_sc_capable(hdev) before requiring SSP to be enabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8417ab387d1a..78939e0ed1f4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4818,6 +4818,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	    lmp_sc_capable(hdev) &&
 	    !test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_REJECTED);
-- 
2.1.0

