Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix missing break in hci_cmd_complete_evt
Date: Fri, 13 Apr 2012 12:32:42 +0200
Message-ID: <1334313162-12290-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Command complete event for HCI_OP_USER_PASSKEY_NEG_REPLY would result
in calling handler function also for HCI_OP_LE_SET_SCAN_PARAM. This
could result in undefined behaviour.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb6d802..f8c6174 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2344,6 +2344,7 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 	case HCI_OP_USER_PASSKEY_NEG_REPLY:
 		hci_cc_user_passkey_neg_reply(hdev, skb);
+		break;
 
 	case HCI_OP_LE_SET_SCAN_PARAM:
 		hci_cc_le_set_scan_param(hdev, skb);
-- 
on behalf of ST-Ericsson

