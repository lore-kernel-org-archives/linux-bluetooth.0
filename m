Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use EOPNOTSUPP instead of ENOTSUPP
Date: Fri, 18 Jul 2014 11:15:26 +0300
Message-Id: <1405671326-32431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The EOPNOTSUPP and ENOTSUPP errors are very similar in meaning, but
ENOTSUPP is a fairly new addition to POSIX. Not all libc versions know
about the value the kernel uses for ENOTSUPP so it's better to use
EOPNOTSUPP to ensure understandable error messages.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c   | 2 +-
 net/bluetooth/l2cap_core.c | 2 +-
 net/bluetooth/l2cap_sock.c | 2 +-
 net/bluetooth/smp.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0d76054efd26..1ac9f7f52acd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -834,7 +834,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_conn *acl;
 
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c8c259f21d80..f3fb61c9f96f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7094,7 +7094,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			break;
 		/* fall through */
 	default:
-		err = -ENOTSUPP;
+		err = -EOPNOTSUPP;
 		goto done;
 	}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3bb1cdf34f07..1884f72083c2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -279,7 +279,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 			break;
 		/* fall through */
 	default:
-		err = -ENOTSUPP;
+		err = -EOPNOTSUPP;
 		goto done;
 	}
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 74a0308e39f3..e49c83d8b957 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1189,7 +1189,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags)) {
-		err = -ENOTSUPP;
+		err = -EOPNOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
 	}
@@ -1207,7 +1207,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	    !conn->smp_chan) {
 		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
 		kfree_skb(skb);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	switch (code) {
-- 
1.9.3

