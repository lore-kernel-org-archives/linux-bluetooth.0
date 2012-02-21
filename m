Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Bluetooth: mgmt: Fix set_fast_connectable error return
Date: Tue, 21 Feb 2012 18:00:03 +0200
Message-Id: <1329840005-4977-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch ensures that Set Fast Connectable fails apropriately if we
are not already in a connectable state (which is a pre-requisite for
fast connectable).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 96386ff..abad38c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2607,6 +2607,13 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
 						MGMT_STATUS_INVALID_PARAMS);
+	if (!hdev_is_powered(hdev))
+		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_NOT_POWERED);
+
+	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+							MGMT_STATUS_REJECTED);
 
 	hci_dev_lock(hdev);
 
-- 
1.7.9

