Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update New CSRK event to match latest specification
Date: Fri, 27 Feb 2015 10:11:13 +0200
Message-Id: <1425024673-19657-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The 'master' parameter of the New CSRK event was recently renamed to
'type', with the old values kept for backwards compatibility as
unauthenticated local/remote keys. This patch updates the code to take
into account the two new (authenticated) values and ensures they get
used based on the security level of the connection that the respective
keys get distributed over.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 include/net/bluetooth/mgmt.h     |  7 ++++++-
 net/bluetooth/mgmt.c             |  2 +-
 net/bluetooth/smp.c              | 10 ++++++++--
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 40831d1c9b0c..bc70830cf7d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -108,7 +108,7 @@ struct bt_uuid {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 master;
+	u8 type;
 	u8 val[16];
 };
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e218a30f2061..fe8eef00e9ca 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -647,9 +647,14 @@ struct mgmt_ev_new_irk {
 	struct mgmt_irk_info irk;
 } __packed;
 
+#define MGMT_CSRK_LOCAL_UNAUTHENTICATED		0x00
+#define MGMT_CSRK_REMOTE_UNAUTHENTICATED	0x01
+#define MGMT_CSRK_LOCAL_AUTHENTICATED		0x02
+#define MGMT_CSRK_REMOTE_AUTHENTICATED		0x03
+
 struct mgmt_csrk_info {
 	struct mgmt_addr_info addr;
-	__u8 master;
+	__u8 type;
 	__u8 val[16];
 } __packed;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a11d41572887..ccb725de8c39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6660,7 +6660,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
-	ev.key.master = csrk->master;
+	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
 	mgmt_event(MGMT_EV_NEW_CSRK, hdev, &ev, sizeof(ev), NULL);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b2803bd6e0d8..c91c19bfc0a8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1252,7 +1252,10 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 		csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
 		if (csrk) {
-			csrk->master = 0x00;
+			if (hcon->sec_level > BT_SECURITY_MEDIUM)
+				csrk->type = MGMT_CSRK_LOCAL_AUTHENTICATED;
+			else
+				csrk->type = MGMT_CSRK_LOCAL_UNAUTHENTICATED;
 			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
 		}
 		smp->slave_csrk = csrk;
@@ -2352,7 +2355,10 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
 	if (csrk) {
-		csrk->master = 0x01;
+		if (conn->hcon->sec_level > BT_SECURITY_MEDIUM)
+			csrk->type = MGMT_CSRK_REMOTE_AUTHENTICATED;
+		else
+			csrk->type = MGMT_CSRK_REMOTE_UNAUTHENTICATED;
 		memcpy(csrk->val, rp->csrk, sizeof(csrk->val));
 	}
 	smp->csrk = csrk;
-- 
2.1.0

