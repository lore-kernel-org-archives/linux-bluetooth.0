Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/9] Bluetooth: Improve fixed channel lookup based on link type
Date: Thu,  7 Aug 2014 22:56:48 +0300
Message-Id: <1407441410-13312-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
References: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When notifying global fixed channels of new connections it doesn't make
sense to consider channels meant for a different link type than the one
available. This patch adds an extra parameter to the
l2cap_global_fixed_chan() lookup function and ensures that only channels
matching the current hci_conn type are looked up.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8c4767f91a23..191b58f48245 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7231,7 +7231,7 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
  * global list (by passing NULL as first parameter).
  */
 static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
-						  bdaddr_t *src)
+						  bdaddr_t *src, u8 link_type)
 {
 	read_lock(&chan_list_lock);
 
@@ -7247,6 +7247,10 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 			continue;
 		if (bacmp(&c->src, src) && bacmp(&c->src, BDADDR_ANY))
 			continue;
+		if (link_type == ACL_LINK && c->src_type != BDADDR_BREDR)
+			continue;
+		if (link_type == LE_LINK && c->src_type == BDADDR_BREDR)
+			continue;
 
 		l2cap_chan_hold(c);
 		read_unlock(&chan_list_lock);
@@ -7287,7 +7291,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	 * we left off, because the list lock would prevent calling the
 	 * potentially sleeping l2cap_chan_lock() function.
 	 */
-	pchan = l2cap_global_fixed_chan(NULL, &hdev->bdaddr);
+	pchan = l2cap_global_fixed_chan(NULL, &hdev->bdaddr, hcon->type);
 	while (pchan) {
 		struct l2cap_chan *chan, *next;
 
@@ -7308,7 +7312,8 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_chan_unlock(pchan);
 next:
-		next = l2cap_global_fixed_chan(pchan, &hdev->bdaddr);
+		next = l2cap_global_fixed_chan(pchan, &hdev->bdaddr,
+					       hcon->type);
 		l2cap_chan_put(pchan);
 		pchan = next;
 	}
-- 
1.9.3

