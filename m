Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Use hci_request for discoverable timeout handling
Date: Tue, 15 Oct 2013 06:33:51 -0700
Message-Id: <1381844037-24424-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the discoverable timeout triggers and it is time to turn inquiry
scan back off, use the HCI request framework to do it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7add9c9..c53f7f9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1789,6 +1789,7 @@ static void hci_power_off(struct work_struct *work)
 static void hci_discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev;
+	struct hci_request req;
 	u8 scan = SCAN_PAGE;
 
 	hdev = container_of(work, struct hci_dev, discov_off.work);
@@ -1797,7 +1798,9 @@ static void hci_discov_off(struct work_struct *work)
 
 	hci_dev_lock(hdev);
 
-	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
+	hci_req_run(&req, NULL);
 
 	hdev->discov_timeout = 0;
 
-- 
1.8.3.1

