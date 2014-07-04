Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] Bluetooth: Remove unnecessary usage of hci_pend_le_conn_add
Date: Fri,  4 Jul 2014 12:37:24 +0300
Message-Id: <1404466647-16352-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This is the last place using hci_pend_le_conn_add() and we can more
just as simply manipulate the list directly here.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0ccdf9df2188..9e0b2e888bba 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2209,7 +2209,9 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			/* Fall through */
 
 		case HCI_AUTO_CONN_ALWAYS:
-			hci_pend_le_conn_add(hdev, params);
+			list_del_init(&params->action);
+			list_add(&params->action, &hdev->pend_le_conns);
+			hci_update_background_scan(hdev);
 			break;
 
 		default:
-- 
1.9.3

