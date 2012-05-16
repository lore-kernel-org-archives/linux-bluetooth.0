Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Report proper error number in disconnection
Date: Wed, 16 May 2012 12:17:12 -0300
Message-Id: <1337181432-979-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337181432-979-2-git-send-email-gustavo@padovan.org>
References: <1337181432-979-1-git-send-email-gustavo@padovan.org>
 <1337181432-979-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If encryption change fails we should disconnect with auth failure error
code.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c60e0d..4eefb7f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2063,7 +2063,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 		if (ev->status && conn->state == BT_CONNECTED) {
-			hci_acl_disconn(conn, 0x13);
+			hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
 			hci_conn_put(conn);
 			goto unlock;
 		}
-- 
1.7.10.1

