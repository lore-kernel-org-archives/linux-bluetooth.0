Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix request completion for command status events
Date: Mon, 21 Nov 2011 20:01:23 +0200
Message-Id: <1321898484-17952-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a HCI command triggered by hci_request() fails at the command status
phase we need to properly inform the request tracking code of the
completion of the request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..af24b3d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2115,6 +2115,8 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
+		if (ev->status)
+			hci_req_complete(hdev, opcode, ev->status);
 		break;
 	}
 
-- 
1.7.7.3

