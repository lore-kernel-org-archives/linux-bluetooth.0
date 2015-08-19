Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix NULL pointer deference issue in the function load_irks
Date: Wed, 19 Aug 2015 10:25:30 -0400
Message-Id: <1439994330-27508-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a possible NULL pointer deference issue in the function
load_irks if the call to the function hci_add_link fails and returns
NULL by instead checking if this return value occurs before returning
-ENOMEM to the function load_irks caller as the function hci_add_link
only fails due to a memory allocation error therfore due to this we
only need to return the error -ENOMEM directly to the function load_irks

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 92720f3..e286d63 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5602,8 +5602,9 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
-		hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
-			    BDADDR_ANY);
+		if (!hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
+				 BDADDR_ANY))
+			return -ENOMEM;
 	}
 
 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
-- 
2.1.4
