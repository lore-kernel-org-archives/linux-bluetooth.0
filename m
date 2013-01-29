Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix handling of unexpected SMP PDUs
Date: Tue, 29 Jan 2013 10:44:23 -0600
Message-Id: <1359477863-24645-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The conn->smp_chan pointer can be NULL if SMP PDUs arrive at unexpected
moments. To avoid NULL pointer dereferences the code should be checking
for this and disconnect if an unexpected SMP PDU arrives. This patch
fixes the issue by adding a check for conn->smp_chan for all other PDUs
except pairing request and security request (which are are the first
PDUs to come to initialize the SMP context).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
CC: stable@vger.kernel.org
---
v2: Move the checks to a single place in smp_sig_channel() and instead
of ignoring the PDUs return failure from smp_sig_channel() to trigger a
disconnection.

 net/bluetooth/smp.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 68a9587..5abefb1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -859,6 +859,19 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(code));
 
+	/*
+	 * The SMP context must be initialized for all other PDUs except
+	 * pairing and security requests. If we get any other PDU when
+	 * not initialized simply disconnect (done if this function
+	 * returns an error).
+	 */
+	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
+	    !conn->smp_chan) {
+		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
+		kfree_skb(skb);
+		return -ENOTSUPP;
+	}
+
 	switch (code) {
 	case SMP_CMD_PAIRING_REQ:
 		reason = smp_cmd_pairing_req(conn, skb);
-- 
1.7.10.4

