Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Fix reason code for pairing rejection
Date: Wed, 27 Apr 2011 16:04:38 -0700
Message-Id: <1303945480-25756-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

"Pairing not allowed" is 0x18 and not 0x16.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 003d731..0e8ccda 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2426,7 +2426,7 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		struct hci_cp_io_capability_neg_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x16; /* Pairing not allowed */
+		cp.reason = 0x18; /* Pairing not allowed */
 
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_NEG_REPLY,
 							sizeof(cp), &cp);
-- 
1.7.4.4

