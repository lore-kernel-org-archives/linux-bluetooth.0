Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Fix setting initial local auth_req value
Date: Tue, 20 May 2014 09:45:48 +0300
Message-Id: <1400568352-20454-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There is no reason to have the initial local value conditional to
whether the remote value has bonding set or not. We can either way start
off with the value we received.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index df91ed28084f..72743f87b22f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -685,8 +685,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct smp_chan *smp;
-	u8 key_size;
-	u8 auth = SMP_AUTH_NONE;
+	u8 key_size, auth;
 	int ret;
 
 	BT_DBG("conn %p", conn);
@@ -710,8 +709,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(*req));
 
 	/* We didn't start the pairing, so match remote */
-	if (req->auth_req & SMP_AUTH_BONDING)
-		auth = req->auth_req;
+	auth = req->auth_req;
 
 	conn->hcon->pending_sec_level = authreq_to_seclevel(auth);
 
-- 
1.9.0

