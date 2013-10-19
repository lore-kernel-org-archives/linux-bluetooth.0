Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: Add missing check for BREDR_ENABLED flag in update_class()
Date: Sat, 19 Oct 2013 23:38:17 +0300
Message-Id: <1382215103-6968-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We shouldn't be sending the HCI_Write_Class_Of_Device command when
BR/EDR is disabled since this is a BR/EDR-only command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dd0bd4a..c363285 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -749,6 +749,9 @@ static void update_class(struct hci_request *req)
 	if (!hdev_is_powered(hdev))
 		return;
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return;
+
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
-- 
1.8.3.1

