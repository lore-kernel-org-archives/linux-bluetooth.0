Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix rejecting pairing in case of insufficient capabilities
Date: Tue, 17 Jun 2014 13:07:39 +0300
Message-Id: <1402999659-4969-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
References: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we need an MITM protected connection but the local and remote IO
capabilities cannot provide it we should reject the pairing attempt in
the appropriate way. This patch adds the missing checks for such a
situation to the smp_cmd_pairing_req() and smp_cmd_pairing_req()
functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 84f0df21547b..28f4ef48095b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -705,6 +705,16 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
 
+	/* If we need MITM check that it can be acheived */
+	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
+		u8 method;
+
+		method = get_auth_method(smp, conn->hcon->io_capability,
+					 req->io_capability);
+		if (method == JUST_WORKS || method == JUST_CFM)
+			return SMP_AUTH_REQUIREMENTS;
+	}
+
 	build_pairing_cmd(conn, req, &rsp, auth);
 
 	key_size = min(req->max_key_size, rsp.max_key_size);
@@ -751,6 +761,16 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
+	/* If we need MITM check that it can be acheived */
+	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
+		u8 method;
+
+		method = get_auth_method(smp, req->io_capability,
+					 rsp->io_capability);
+		if (method == JUST_WORKS || method == JUST_CFM)
+			return SMP_AUTH_REQUIREMENTS;
+	}
+
 	get_random_bytes(smp->prnd, sizeof(smp->prnd));
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
-- 
1.9.3

