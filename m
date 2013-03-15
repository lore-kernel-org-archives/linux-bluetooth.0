Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 20/26] Bluetooth: Disable fast connectable when disabling connectable
Date: Fri, 15 Mar 2013 17:07:10 -0500
Message-Id: <1363385236-25704-21-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the connectable setting is disabled the fast connectable setting
must also be disabled. This is so that we're consistent with the
pre-requisites for enabling fast connectable, one of which is that the
connectable setting is enabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f03b10c..98f6295 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1119,6 +1119,9 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 
+	if (!cp->val && test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+		write_fast_connectable(&req, false);
+
 	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.10.4

