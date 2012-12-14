Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 12/12] Bluetooth: Enable support for observer mode when powered off.
Date: Fri, 14 Dec 2012 14:51:38 -0400
Message-Id: <1355511098-10190-13-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

We have to enable le scan in mgmt_powered if observer mode is on.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 net/bluetooth/mgmt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e960da2..04407d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2848,8 +2848,20 @@ static int set_observer_le(struct sock *sk, struct hci_dev *hdev, u8 enable)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_OBSERVER,
-				 MGMT_STATUS_NOT_POWERED);
+		bool changed = false;
+
+		if (enable != test_bit(HCI_OBSERVER, &hdev->dev_flags)) {
+			change_bit(HCI_OBSERVER, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_OBSERVER, hdev);
+		if (err < 0)
+			goto unlock;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto unlock;
 	}
 
@@ -3156,6 +3168,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 				hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 					     sizeof(enable), &enable);
 			}
+
+			if (test_bit(HCI_OBSERVER, &hdev->dev_flags)) {
+				hci_le_scan(hdev, LE_SCAN_TYPE_PASSIVE,
+					    LE_SCAN_INT,
+					    LE_SCAN_WIN, LE_SCAN_NO_TIMEOUT,
+					    LE_SCAN_REQ_REASON_OBSERVER);
+			}
 		}
 
 		if (lmp_bredr_capable(hdev)) {
-- 
1.8.0.2

