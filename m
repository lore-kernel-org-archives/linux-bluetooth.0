Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Fix SMP error and response to be mutually exclusive
Date: Mon, 18 Aug 2014 20:33:31 +0300
Message-Id: <1408383214-16366-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Returning failure from the SMP data parsing function will cause an
immediate disconnect, making any attempts to send a response PDU futile.
This patch updates the function to always either send a response or
return an error, but never both at the same time:

* In the case that HCI_LE_ENABLED is not set we want to send a Pairing Not
  Supported response but it is not required to force a disconnection, so
  do not set the error return in this case.

* If we get garbage SMP data we can just fail with the handler function
  instead of also trying to send an SMP Failure PDU.

* There's no reason to force a disconnection if we receive an unknown SMP
  command. Instead simply send a proper Command Not Supported SMP
  response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 496584921fdc..16c181181775 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1430,7 +1430,6 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -EILSEQ;
 
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags)) {
-		err = -EOPNOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
 	}
@@ -1447,7 +1446,6 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
 	    !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
 		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
-		reason = SMP_CMD_NOTSUPP;
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1459,7 +1457,6 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	case SMP_CMD_PAIRING_FAIL:
 		smp_failure(conn, 0);
-		reason = 0;
 		err = -EPERM;
 		break;
 
@@ -1501,17 +1498,17 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
-
 		reason = SMP_CMD_NOTSUPP;
-		err = -EOPNOTSUPP;
 		goto done;
 	}
 
 done:
-	if (reason)
-		smp_failure(conn, reason);
-	if (!err)
+	if (!err) {
+		if (reason)
+			smp_failure(conn, reason);
 		kfree_skb(skb);
+	}
+
 	return err;
 }
 
-- 
1.9.3

