Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] Bluetooth: Fix logic in hci_pin_code_request_evt
Date: Thu, 28 Apr 2011 11:28:58 -0700
Message-Id: <1304015344-12238-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
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
index 278a860..8b72b8a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2035,8 +2035,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_bit(HCI_PAIRABLE, &hdev->flags))
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
-
-	if (test_bit(HCI_MGMT, &hdev->flags)) {
+	else if (test_bit(HCI_MGMT, &hdev->flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
-- 
1.7.4.4

