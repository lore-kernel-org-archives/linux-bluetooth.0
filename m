Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/6] Bluetooth: Simplify num_comp_pkts_evt function
Date: Thu,  8 Dec 2011 14:53:02 +0200
Message-Id: <1323348786-18134-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify function and remove fourth level of indentation.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   47 +++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 273e1cb..493e08b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2288,28 +2288,39 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 		count  = get_unaligned_le16(ptr++);
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
-		if (conn) {
-			conn->sent -= count;
-
-			if (conn->type == ACL_LINK) {
+		if (!conn)
+			continue;
+
+		conn->sent -= count;
+
+		switch (conn->type) {
+		case ACL_LINK:
+			hdev->acl_cnt += count;
+			if (hdev->acl_cnt > hdev->acl_pkts)
+				hdev->acl_cnt = hdev->acl_pkts;
+			break;
+
+		case LE_LINK:
+			if (hdev->le_pkts) {
+				hdev->le_cnt += count;
+				if (hdev->le_cnt > hdev->le_pkts)
+					hdev->le_cnt = hdev->le_pkts;
+			} else {
 				hdev->acl_cnt += count;
 				if (hdev->acl_cnt > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
-			} else if (conn->type == LE_LINK) {
-				if (hdev->le_pkts) {
-					hdev->le_cnt += count;
-					if (hdev->le_cnt > hdev->le_pkts)
-						hdev->le_cnt = hdev->le_pkts;
-				} else {
-					hdev->acl_cnt += count;
-					if (hdev->acl_cnt > hdev->acl_pkts)
-						hdev->acl_cnt = hdev->acl_pkts;
-				}
-			} else {
-				hdev->sco_cnt += count;
-				if (hdev->sco_cnt > hdev->sco_pkts)
-					hdev->sco_cnt = hdev->sco_pkts;
 			}
+			break;
+
+		case SCO_LINK:
+			hdev->sco_cnt += count;
+			if (hdev->sco_cnt > hdev->sco_pkts)
+				hdev->sco_cnt = hdev->sco_pkts;
+			break;
+
+		default:
+			BT_ERR("Unknown type %d conn %p", conn->type, conn);
+			break;
 		}
 	}
 
-- 
1.7.4.1

