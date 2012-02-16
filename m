Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: mgmt: Use more consistent error variable names
Date: Fri, 17 Feb 2012 01:22:58 +0200
Message-Id: <1329434578-5928-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For simple integer errors the variable name "err" is more consistent
with the existing code base than "ret".

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ecfb747..86a7a5c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2696,7 +2696,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
 	__le32 ev;
-	int ret;
+	int err;
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
@@ -2707,50 +2707,50 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 
 	ev = cpu_to_le32(get_current_settings(hdev));
 
-	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
+	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
 								match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
 
-	return ret;
+	return err;
 }
 
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
 	struct cmd_lookup match = { NULL, hdev };
 	__le32 ev;
-	int ret;
+	int err;
 
 	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, settings_rsp, &match);
 
 	ev = cpu_to_le32(get_current_settings(hdev));
 
-	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
+	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
 								match.sk);
 	if (match.sk)
 		sock_put(match.sk);
 
-	return ret;
+	return err;
 }
 
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
 	__le32 ev;
 	struct cmd_lookup match = { NULL, hdev };
-	int ret;
+	int err;
 
 	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, settings_rsp,
 								&match);
 
 	ev = cpu_to_le32(get_current_settings(hdev));
 
-	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
+	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
 
-	return ret;
+	return err;
 }
 
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
-- 
1.7.9

