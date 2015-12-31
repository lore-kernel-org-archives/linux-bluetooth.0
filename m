Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] bluetooth:Fix return statement in the function load_link_keys
Date: Wed, 30 Dec 2015 23:29:27 -0500
Message-Id: <1451536167-32366-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the final return statement in the function load_link_keys
to properly return the internal call to mgmt_cmd_complete return
value rather then zero to properly indicate when the function
load_link_keys fails due to a internal failed call to the function
mgmt_cmd_complete.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 92720f3..52b039a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2954,6 +2954,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	u16 key_count, expected_len;
 	bool changed;
 	int i;
+	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
@@ -3020,11 +3021,11 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				 key->type, key->pin_len, NULL);
 	}
 
-	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
 
 	hci_dev_unlock(hdev);
 
-	return 0;
+	return err;
 }
 
 static int device_unpaired(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
2.1.4
