Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Pass inquiry length to bredr_inquiry()
Date: Wed, 11 Nov 2015 12:24:21 +0200
Message-Id: <1447237463-29233-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
References: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Passing the needed inquiry length to bredr_inquiry() makes it possible
to also use this helper for interleaved discovery where the controller
doesn't support simultaneous Inquiry & LE scan.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3219ee66faad..98827e7631ca 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1044,6 +1044,7 @@ static void le_scan_restart_work(struct work_struct *work)
 
 static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 {
+	u8 length = opt;
 	struct hci_cp_inquiry cp;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
@@ -1056,7 +1057,7 @@ static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(&cp.lap, lap, sizeof(cp.lap));
-	cp.length = DISCOV_BREDR_INQUIRY_LEN;
+	cp.length = length;
 
 	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
 
@@ -1150,7 +1151,7 @@ static int interleaved_discov(struct hci_request *req, unsigned long opt)
 	if (err)
 		return err;
 
-	return bredr_inquiry(req, opt);
+	return bredr_inquiry(req, DISCOV_BREDR_INQUIRY_LEN);
 }
 
 static void start_discovery(struct hci_dev *hdev, u8 *status)
@@ -1162,7 +1163,8 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
 		if (!hci_dev_test_flag(hdev, HCI_INQUIRY))
-			hci_req_sync(hdev, bredr_inquiry, 0, HCI_CMD_TIMEOUT,
+			hci_req_sync(hdev, bredr_inquiry,
+				     DISCOV_BREDR_INQUIRY_LEN, HCI_CMD_TIMEOUT,
 				     status);
 		return;
 	case DISCOV_TYPE_INTERLEAVED:
-- 
2.5.0

