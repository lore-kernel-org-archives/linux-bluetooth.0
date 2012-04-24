Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove useless code in hci_connect
Date: Tue, 24 Apr 2012 16:11:11 -0300
Message-Id: <1335294671-25585-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unneeded variable assignments in hci_connect.
'sec_level' is already assigned to BT_SECURITY_LOW in hci_le_connect
and 'pending_sec_level' and 'auth_type' are assigned right after
if statement.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f361d3b..140e00a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -536,9 +536,6 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 				return ERR_PTR(-ENOMEM);
 
 			le->dst_type = entry->bdaddr_type;
-			le->pending_sec_level = sec_level;
-			le->sec_level = BT_SECURITY_LOW;
-			le->auth_type = auth_type;
 			hci_le_connect(le);
 		}
 
-- 
1.7.10

