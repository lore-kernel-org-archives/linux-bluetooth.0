Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] Bluetooth: Set the correct address type in Identity Address Information
Date: Sun, 23 Feb 2014 16:23:49 +0200
Message-Id: <1393165438-13610-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP Identity Address Information PDU contains our Identity Address.
The address type can either be static random or public and it is tracked
in the hdev->own_address_type variable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8ef50c790b96..ce2c461d07e3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1196,8 +1196,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
 
-		/* Just public address */
-		memset(&addrinfo, 0, sizeof(addrinfo));
+		addrinfo.addr_type = hdev->own_addr_type;
 		bacpy(&addrinfo.bdaddr, &hcon->src);
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
-- 
1.8.5.3

