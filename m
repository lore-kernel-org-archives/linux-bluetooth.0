Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix request completion for command status events
Date: Mon, 21 Nov 2011 17:18:59 +0200
Message-Id: <1321888740-15598-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a HCI command triggered by hci_request() fails at the command status
phase we need to properly inform the request tracking code of the
completion of the request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..236f895 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2055,6 +2055,9 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	opcode = __le16_to_cpu(ev->opcode);
 
+	if (ev->status != 0)
+		hci_req_complete(hdev, opcode, ev->status);
+
 	switch (opcode) {
 	case HCI_OP_INQUIRY:
 		hci_cs_inquiry(hdev, ev->status);
-- 
1.7.7.3

