Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Add workaround for buggy max_page features page value
Date: Fri, 18 Oct 2013 12:04:47 -0700
Message-Id: <1382123092-35256-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some controllers list the max_page value from the extended features
response as 0 when SSP has not yet been enabled. To workaround this
issue, force the max_page value to 1 when SSP support has been
detected.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 8 ++++++++
 net/bluetooth/hci_event.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 47fcb49..e445f35 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -834,6 +834,14 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (lmp_ssp_capable(hdev)) {
+		/* When SSP is available, then the host features page
+		 * should also be available as well. However some
+		 * controllers list the max_page as 0 as long as SSP
+		 * has not been enabled. To achieve proper debugging
+		 * output, force the minimum max_page to 1 at least.
+		 */
+		hdev->max_page = 0x01;
+
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
 			hci_req_add(req, HCI_OP_WRITE_SSP_MODE,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e43de98..c171c07 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -555,7 +555,8 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	hdev->max_page = rp->max_page;
+	if (hdev->max_page < rp->max_page)
+		hdev->max_page = rp->max_page;
 
 	if (rp->page < HCI_MAX_PAGES)
 		memcpy(hdev->features[rp->page], rp->features, 8);
-- 
1.8.3.1

