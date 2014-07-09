Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/7] Bluetooth: Enable page scan also if there are white list entries
Date: Wed,  9 Jul 2014 12:59:18 +0300
Message-Id: <1404899959-16479-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404899959-16479-1-git-send-email-johan.hedberg@gmail.com>
References: <1404899959-16479-1-git-send-email-johan.hedberg@gmail.com>
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
index 5a866b65371c..98392d61b78f 100644
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

