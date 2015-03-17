Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 3/7] Bluetooth: Split triggering le and interleaved scan into separate cases
Date: Mon, 16 Mar 2015 18:37:30 -0700
Message-Id: <1426556254-1480-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch splits triggering of le and interleaved scan into
separate cases.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 92fa8e88..9d3c7a1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4009,9 +4009,13 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 		break;
 
 	case DISCOV_TYPE_LE:
+		if (!trigger_le_scan(req, status,
+				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
+			return false;
+		break;
+
 	case DISCOV_TYPE_INTERLEAVED:
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 			*status = MGMT_STATUS_NOT_SUPPORTED;
 			return false;
 		}
-- 
2.2.0.rc0.207.ga3a616c

