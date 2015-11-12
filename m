Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix powering on with privacy and advertising
Date: Thu, 12 Nov 2015 21:43:06 +0100
Message-Id: <1447360987-4129-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to enable advertising with privacy enabled, SMP has to be
registered in order to generate new RPA. During power on, it will be
registered at the very end which is the reason why advertising is not
enabled and it's not possible to enable it anymore due to mismatch
between hci_dev settings and actual controller state.

This fixes this problem by postponing advertising enable after SMP is
registered in case of power on.
---
 net/bluetooth/mgmt.c | 70 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index eca203e..d96b08c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7234,10 +7234,42 @@ static void restart_le_actions(struct hci_dev *hdev)
 	}
 }
 
-static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void mgmt_set_powered_complete(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
+	hci_dev_lock(hdev);
+
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	hci_dev_unlock(hdev);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
+static void powered_adv_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
+	BT_DBG("status 0x%02x", status);
+
+	mgmt_set_powered_complete(hdev);
+}
+
+static void powered_enable_advertising(struct hci_dev *hdev,
+				       struct hci_request *req)
+{
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		enable_advertising(req);
+	else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+		 hdev->cur_adv_instance)
+		schedule_adv_instance(req, hdev->cur_adv_instance,
+				      true);
+}
+
+static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
 	BT_DBG("status 0x%02x", status);
 
 	if (!status) {
@@ -7250,18 +7282,23 @@ static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 		restart_le_actions(hdev);
 		hci_update_background_scan(hdev);
-	}
-
-	hci_dev_lock(hdev);
-
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
-	new_settings(hdev, match.sk);
+		/* In case privacy is enabled we can now try to enable
+		 * advertising as this was not done before due to SMP not
+		 * registered.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
+			struct hci_request req;
 
-	hci_dev_unlock(hdev);
+			hci_req_init(&req, hdev);
+			powered_enable_advertising(hdev, &req);
+			if (!hci_req_run(&req, powered_adv_complete)) {
+				return;
+			}
+		}
+	}
 
-	if (match.sk)
-		sock_put(match.sk);
+	mgmt_set_powered_complete(hdev);
 }
 
 static int powered_update_hci(struct hci_dev *hdev)
@@ -7322,12 +7359,13 @@ static int powered_update_hci(struct hci_dev *hdev)
 			hdev->cur_adv_instance = adv_instance->instance;
 		}
 
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			enable_advertising(&req);
-		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-			 hdev->cur_adv_instance)
-			schedule_adv_instance(&req, hdev->cur_adv_instance,
-					      true);
+		/* Only enable advertising now if privacy is not enabled,
+		 * otherwise it will fail since SMP is not yet registered - in
+		 * such case advertising will be enabled later.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_PRIVACY)) {
+			powered_enable_advertising(hdev, &req);
+		}
 	}
 
 	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
-- 
2.6.2

