Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Add smp_ltk_sec_level() helper function
Date: Wed, 10 Sep 2014 17:37:45 -0700
Message-Id: <1410395866-24301-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
References: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several places that need to determine the security level that
an LTK can provide. This patch adds a convenience function for this to
help make the code more readable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 +----
 net/bluetooth/smp.c       | 2 +-
 net/bluetooth/smp.h       | 8 ++++++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3a8381ab992f..603a17cc52ac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4506,10 +4506,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
 
-	if (ltk->authenticated)
-		conn->pending_sec_level = BT_SECURITY_HIGH;
-	else
-		conn->pending_sec_level = BT_SECURITY_MEDIUM;
+	conn->pending_sec_level = smp_ltk_sec_level(ltk);
 
 	conn->enc_key_size = ltk->enc_size;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a08b077cb725..3700dd8d9d0b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1114,7 +1114,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	if (!key)
 		return false;
 
-	if (sec_level > BT_SECURITY_MEDIUM && !key->authenticated)
+	if (smp_ltk_sec_level(key) < sec_level)
 		return false;
 
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 5240537efde3..86a683a8b491 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -125,6 +125,14 @@ enum {
 	SMP_LTK_SLAVE,
 };
 
+static inline u8 smp_ltk_sec_level(struct smp_ltk *key)
+{
+	if (key->authenticated)
+		return BT_SECURITY_HIGH;
+
+	return BT_SECURITY_MEDIUM;
+}
+
 /* SMP Commands */
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-- 
1.9.3

