Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 16/26] Bluetooth: Limit fast connectable support to >= 1.2 controllers
Date: Wed, 13 Mar 2013 11:12:07 -0700
Message-Id: <1363198337-3896-17-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI commands that are necessary for fast connectable mode are only
available from HCI specification version 1.2 onwards. This should be
reflected in the supported settings as well as error response for the
set_fast_connectable command when dealing with a < 1.2 capable
controller.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd61318..34caf30 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -384,7 +384,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 
 	if (lmp_bredr_capable(hdev)) {
 		settings |= MGMT_SETTING_CONNECTABLE;
-		settings |= MGMT_SETTING_FAST_CONNECTABLE;
+		if (hdev->hci_ver >= BLUETOOTH_VER_1_2)
+			settings |= MGMT_SETTING_FAST_CONNECTABLE;
 		settings |= MGMT_SETTING_DISCOVERABLE;
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
@@ -2934,7 +2935,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!lmp_bredr_capable(hdev) || hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-- 
1.7.10.4

