Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 18/20] Bluetooth: mgmt: multi-adv for mgmt_reenable_advertising()
Date: Thu, 18 Jun 2015 03:16:51 +0200
Message-Id: <1434590213-26599-19-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During service discovery, advertising will be disabled. This patch
ensures that it is correctly being re-enabled, both for configuration
made via set advertising and add advertising, once the scanning
times out.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f44c6e3..b132032 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8610,13 +8610,24 @@ static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 void mgmt_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
+	u8 instance;
 
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		return;
 
+	instance = get_current_adv_instance(hdev);
+
 	hci_req_init(&req, hdev);
-	enable_advertising(&req);
+
+	if (instance) {
+		schedule_adv_instance(&req, instance, true);
+	} else {
+		update_adv_data(&req);
+		update_scan_rsp_data(&req);
+		enable_advertising(&req);
+	}
+
 	hci_req_run(&req, adv_enable_complete);
 }
 
-- 
1.9.1

