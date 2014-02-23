Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/13] Bluetooth: Set the correct values for Identity Address Information
Date: Sun, 23 Feb 2014 19:42:18 +0200
Message-Id: <1393177349-361-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP Identity Address Information PDU should contain our Identity
Address. This patch updates the code to copy the correct values from the
hci_conn object.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8ef50c790b96..a5920e8cea59 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1196,9 +1196,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
 
-		/* Just public address */
-		memset(&addrinfo, 0, sizeof(addrinfo));
 		bacpy(&addrinfo.bdaddr, &hcon->src);
+		addrinfo.addr_type = hcon->src_type;
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
 			     &addrinfo);
-- 
1.8.5.3

