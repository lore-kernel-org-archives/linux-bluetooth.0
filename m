Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix lookup of fixed channels by local bdaddr
Date: Thu, 15 Jan 2015 13:06:45 +0200
Message-Id: <1421320005-26037-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com>
References: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The comparing of chan->src should always be done against the local
identity address, represented by hcon->src and hcon->src_type. This
patch modifies l2cap_global_fixed_chan() to take the full hci_conn so
that we can easily compare against hcon->src and hcon->src_type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b080133010e2..6ba33f9631e8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7207,8 +7207,10 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
  * global list (by passing NULL as first parameter).
  */
 static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
-						  bdaddr_t *src, u8 link_type)
+						  struct hci_conn *hcon)
 {
+	u8 src_type = bdaddr_src_type(hcon);
+
 	read_lock(&chan_list_lock);
 
 	if (c)
@@ -7221,11 +7223,9 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 			continue;
 		if (c->state != BT_LISTEN)
 			continue;
-		if (bacmp(&c->src, src) && bacmp(&c->src, BDADDR_ANY))
-			continue;
-		if (link_type == ACL_LINK && c->src_type != BDADDR_BREDR)
+		if (bacmp(&c->src, &hcon->src) && bacmp(&c->src, BDADDR_ANY))
 			continue;
-		if (link_type == LE_LINK && c->src_type == BDADDR_BREDR)
+		if (src_type != c->src_type)
 			continue;
 
 		l2cap_chan_hold(c);
@@ -7267,7 +7267,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	 * we left off, because the list lock would prevent calling the
 	 * potentially sleeping l2cap_chan_lock() function.
 	 */
-	pchan = l2cap_global_fixed_chan(NULL, &hdev->bdaddr, hcon->type);
+	pchan = l2cap_global_fixed_chan(NULL, hcon);
 	while (pchan) {
 		struct l2cap_chan *chan, *next;
 
@@ -7288,8 +7288,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_chan_unlock(pchan);
 next:
-		next = l2cap_global_fixed_chan(pchan, &hdev->bdaddr,
-					       hcon->type);
+		next = l2cap_global_fixed_chan(pchan, hcon);
 		l2cap_chan_put(pchan);
 		pchan = next;
 	}
-- 
2.1.0

