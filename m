Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/49] Bluetooth: Add SMP flag for SC and set it when necessary.
Date: Wed,  3 Dec 2014 17:01:57 +0200
Message-Id: <1417618963-18010-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a new SMP flag for tracking whether Secure Connections
is in use and sets the flag when both remote and local side have elected
to use Secure Connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index bfa839eed89b..3808ade96d08 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -45,6 +45,7 @@ enum {
 	SMP_FLAG_MITM_AUTH,
 	SMP_FLAG_COMPLETE,
 	SMP_FLAG_INITIATOR,
+	SMP_FLAG_SC,
 };
 
 struct smp_chan {
@@ -973,6 +974,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	build_pairing_cmd(conn, req, &rsp, auth);
 
+	if (rsp.auth_req & SMP_AUTH_SC)
+		set_bit(SMP_FLAG_SC, &smp->flags);
+
 	key_size = min(req->max_key_size, rsp.max_key_size);
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
@@ -1020,6 +1024,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rsp->auth_req & AUTH_REQ_MASK(hdev);
 
+	if ((req->auth_req & SMP_AUTH_SC) && (auth & SMP_AUTH_SC))
+		set_bit(SMP_FLAG_SC, &smp->flags);
+
 	/* If we need MITM check that it can be achieved */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
-- 
2.1.0

