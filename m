Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Fix SMP security level when we have no IO capabilities
Date: Wed, 10 Sep 2014 17:37:44 -0700
Message-Id: <1410395866-24301-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
References: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the local IO capability is NoInputNoOutput any attempt to convert
the remote authentication requirement to a target security level is
futile. This patch makes sure that we set the target security level at
most to MEDIUM if the local IO capability is NoInputNoOutput.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index be8371b4eb63..a08b077cb725 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -959,7 +959,11 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
-	sec_level = authreq_to_seclevel(auth);
+	if (conn->hcon->io_capability == 0x03)
+		sec_level = BT_SECURITY_MEDIUM;
+	else
+		sec_level = authreq_to_seclevel(auth);
+
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
 
@@ -1165,7 +1169,11 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rp->auth_req & AUTH_REQ_MASK;
 
-	sec_level = authreq_to_seclevel(auth);
+	if (hcon->io_capability == 0x03)
+		sec_level = BT_SECURITY_MEDIUM;
+	else
+		sec_level = authreq_to_seclevel(auth);
+
 	if (smp_sufficient_security(hcon, sec_level))
 		return 0;
 
-- 
1.9.3

