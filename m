Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Fix logic in hci_pin_code_request_evt
Date: Wed, 27 Apr 2011 16:04:39 -0700
Message-Id: <1303945480-25756-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The mgmt_ev_pin_code_request event should not be sent to user space if
the request gets rejected by the kernel due to the pairable flag not
being set.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0e8ccda..acb4e64 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2019,8 +2019,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_bit(HCI_PAIRABLE, &hdev->flags))
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
-
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	else if (test_bit(HCI_MGMT, &hdev->flags))
 		mgmt_pin_code_request(hdev->id, &ev->bdaddr);
 
 	hci_dev_unlock(hdev);
-- 
1.7.4.4

