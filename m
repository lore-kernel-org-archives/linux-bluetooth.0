Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make it clear that disabling LE disables advertising
Date: Sun,  6 Oct 2013 02:40:43 -0700
Message-Id: <1381052443-61915-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is not a functional change, just change the code to make it easy
to understand that advertising gets disabled before LE support will
be turned off.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7196722..e09ceff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1505,8 +1505,11 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val)
-		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(val), &val);
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val) {
+		u8 adv = 0x00;
+
+		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+	}
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
 		    &hci_cp);
-- 
1.8.3.1

