Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/7] Bluetooth: Enable page scan also if there are white list entries
Date: Wed,  9 Jul 2014 11:43:11 +0300
Message-Id: <1404895392-12588-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Page scan should be enabled either if the connectable setting is set or
if there are any entries in the BR/EDR white list. This patch implements
such behavior by updating the two places that were making decisions on
whether to enable page scan or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 83435a08b0c0..cac663f89cd0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4357,7 +4357,8 @@ static void set_bredr_scan(struct hci_request *req)
 	 */
 	write_fast_connectable(req, false);
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
+	    !list_empty(&hdev->whitelist))
 		scan |= SCAN_PAGE;
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		scan |= SCAN_INQUIRY;
@@ -4471,7 +4472,8 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
+	    !list_empty(&hdev->whitelist))
 		set_bredr_scan(&req);
 
 	/* Since only the advertising data flags will change, there
-- 
1.9.3

