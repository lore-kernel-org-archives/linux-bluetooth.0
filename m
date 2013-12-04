Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/31] Bluetooth: Add smp_sufficient_security helper function
Date: Wed,  4 Dec 2013 16:11:05 +0200
Message-Id: <1386166287-13693-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function is needed both by the smp_conn_security function as well
as upcoming code to check for the security requirements when receiving
an L2CAP connect request over LE.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 16 ++++++++++++----
 net/bluetooth/smp.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e61e74a1aabb..45007362683b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -750,6 +750,17 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
+{
+	if (sec_level == BT_SECURITY_LOW)
+		return true;
+
+	if (hcon->sec_level >= sec_level)
+		return true;
+
+	return false;
+}
+
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -761,10 +772,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
-	if (sec_level == BT_SECURITY_LOW)
-		return 1;
-
-	if (hcon->sec_level >= sec_level)
+	if (smp_sufficient_security(hcon, sec_level))
 		return 1;
 
 	if (hcon->link_mode & HCI_LM_MASTER)
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f8ba07f3e5fa..a700bcb490d7 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -136,6 +136,7 @@ struct smp_chan {
 };
 
 /* SMP Commands */
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
-- 
1.8.4.2

