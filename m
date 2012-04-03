Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove MGMT_ADDR_INVALID macro
Date: Tue,  3 Apr 2012 08:46:54 -0300
Message-Id: <1333453614-4954-1-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <CACJA=fXBCmA82uGhdi9x7gWNme1-VbXs8BLhkToXKT=eTbohTQ@mail.gmail.com>
References: <CACJA=fXBCmA82uGhdi9x7gWNme1-VbXs8BLhkToXKT=eTbohTQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the MGMT_ADDR_INVALID macro. If the address type
isn't LE, we consider it is BR/EDR type.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/mgmt.c             |   14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c8d5beb..c0b232c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -967,7 +967,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define MGMT_ADDR_BREDR			0x00
 #define MGMT_ADDR_LE_PUBLIC		0x01
 #define MGMT_ADDR_LE_RANDOM		0x02
-#define MGMT_ADDR_INVALID		0xff
 
 #define DISCOV_TYPE_BREDR		(BIT(MGMT_ADDR_BREDR))
 #define DISCOV_TYPE_LE			(BIT(MGMT_ADDR_LE_PUBLIC) | \
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b4f7e32..4e7a01f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1640,15 +1640,15 @@ static u8 link_to_mgmt(u8 link_type, u8 addr_type)
 		switch (addr_type) {
 		case ADDR_LE_DEV_PUBLIC:
 			return MGMT_ADDR_LE_PUBLIC;
-		case ADDR_LE_DEV_RANDOM:
-			return MGMT_ADDR_LE_RANDOM;
+
 		default:
-			return MGMT_ADDR_INVALID;
+			/* Fallback to LE Random address type */
+			return MGMT_ADDR_LE_RANDOM;
 		}
-	case ACL_LINK:
-		return MGMT_ADDR_BREDR;
+
 	default:
-		return MGMT_ADDR_INVALID;
+		/* Fallback to BR/EDR type */
+		return MGMT_ADDR_BREDR;
 	}
 }
 
@@ -1690,7 +1690,7 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		bacpy(&rp->addr[i].bdaddr, &c->dst);
 		rp->addr[i].type = link_to_mgmt(c->type, c->dst_type);
-		if (rp->addr[i].type == MGMT_ADDR_INVALID)
+		if (c->type == SCO_LINK || c->type == ESCO_LINK)
 			continue;
 		i++;
 	}
-- 
1.7.9.4

