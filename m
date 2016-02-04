Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Add proper protection to the critical region in the function hci_connect_sco
Date: Thu,  4 Feb 2016 10:51:58 -0500
Message-Id: <1454601118-21914-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds proper protection to the critical region in the function
hci_connect_sco by locking and unlocking the structure pointer hdev
before and after the critical region of this function has executed
including on error paths too.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/hci_conn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..27e3440 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -900,11 +900,13 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	if (IS_ERR(acl))
 		return acl;
 
+	hci_dev_lock(hdev);
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
 		sco = hci_conn_add(hdev, type, dst, HCI_ROLE_MASTER);
 		if (!sco) {
 			hci_conn_drop(acl);
+			hci_dev_unlock(hdev);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -924,12 +926,14 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->flags)) {
 			/* defer SCO setup until mode change completed */
 			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->flags);
+			hci_dev_unlock(hdev);
 			return sco;
 		}
 
 		hci_sco_setup(acl, 0x00);
 	}
-
+
+	hci_dev_unlock(hdev);
 	return sco;
 }
 
-- 
2.1.4
