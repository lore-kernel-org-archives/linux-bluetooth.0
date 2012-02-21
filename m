Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: mgmt: Fix New Settings event for connectable/discoverable
Date: Tue, 21 Feb 2012 19:43:48 +0200
Message-Id: <1329846229-7919-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
References: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powered off and doing changes to the Connectable or Discoverable
setting we should also send an appropriate New Settings event in
addition to the command response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 439ec78..08b867a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -876,11 +876,20 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (!hdev_is_powered(hdev)) {
-		if (cp->val)
-			set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-		else
-			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		bool changed = false;
+
+		if (!!cp->val != test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
+			change_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+			changed = true;
+		}
+
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto failed;
 	}
 
@@ -938,13 +947,25 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
+		bool changed = false;
+
+		if (!!cp->val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+			changed = true;
+
 		if (cp->val)
 			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 		else {
 			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 		}
+
 		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto failed;
 	}
 
-- 
1.7.9

