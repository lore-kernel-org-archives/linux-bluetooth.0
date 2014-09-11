Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Remove unnecessary early initialization of variable
Date: Wed, 10 Sep 2014 17:37:41 -0700
Message-Id: <1410395866-24301-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
References: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We do nothing else with the auth variable in smp_cmd_pairing_rsp()
besides passing it to tk_request() which in turn only cares about
whether one of the sides had the MITM bit set. It is therefore
unnecessary to assign a value to it until just before calling
tk_request(), and this value can simply be the bit-wise or of the local
and remote requirements.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index dc575aba2e65..dbd17a07dc2e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1003,7 +1003,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
-	u8 key_size, auth = SMP_AUTH_NONE;
+	u8 key_size, auth;
 	int ret;
 
 	BT_DBG("conn %p", conn);
@@ -1044,11 +1044,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 */
 	smp->remote_key_dist &= rsp->resp_key_dist;
 
-	if ((req->auth_req & SMP_AUTH_BONDING) &&
-	    (rsp->auth_req & SMP_AUTH_BONDING))
-		auth = SMP_AUTH_BONDING;
-
-	auth |= (req->auth_req | rsp->auth_req) & SMP_AUTH_MITM;
+	auth = (req->auth_req | rsp->auth_req);
 
 	ret = tk_request(conn, 0, auth, req->io_capability, rsp->io_capability);
 	if (ret)
-- 
1.9.3

