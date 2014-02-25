Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Ignore IRKs with no Identity Address
Date: Tue, 25 Feb 2014 22:24:37 +0200
Message-Id: <1393359877-17839-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Core Specification (4.1) leaves room for sending an SMP Identity
Address Information PDU with an all-zeros BD_ADDR value. This
essentially means that we would not have an Identity Address for the
device and the only means of identifying it would be the IRK value
itself.

Due to lack of any known implementations behaving like this it's best to
keep our implementation as simple as possible as far as handling such
situations is concerned. This patch updates the Identity Address
Information handler function to simply ignore the IRK received from such
a device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 79a80f44c832..50355d045992 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1003,6 +1003,19 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 
 	skb_pull(skb, sizeof(*info));
 
+	/* Strictly speaking the Core Specification (4.1) allows sending
+	 * an empty address which would force us to rely on just the IRK
+	 * as "identity information". However, since such
+	 * implementations are not known of and in order to not over
+	 * complicate our implementation, simply pretend that we never
+	 * received an IRK for such a device.
+	 */
+	if (!bacmp(&info->bdaddr, BDADDR_ANY)) {
+		BT_ERR("Ignoring IRK with no identity address");
+		smp_distribute_keys(conn, 1);
+		return 0;
+	}
+
 	bacpy(&smp->id_addr, &info->bdaddr);
 	smp->id_addr_type = info->addr_type;
 
-- 
1.8.5.3

