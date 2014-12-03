Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 27/49] Bluetooth: Set correct LTK type and authentication for SC
Date: Wed,  3 Dec 2014 17:02:21 +0200
Message-Id: <1417618963-18010-28-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

After generating the LTK we should set the correct type (normal SC or
debug) and authentication information for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 13fbe05d33cb..8c7862044e44 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2060,6 +2060,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	u8 a[7], b[7], *local_addr, *remote_addr;
 	u8 io_cap[3], r[16], e[16];
+	u8 key_type, auth;
 	int err;
 
 	BT_DBG("conn %p", conn);
@@ -2092,8 +2093,18 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (memcmp(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
+	if (test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags))
+		key_type = SMP_LTK_P256_DEBUG;
+	else
+		key_type = SMP_LTK_P256;
+
+	if (hcon->pending_sec_level == BT_SECURITY_FIPS)
+		auth = 1;
+	else
+		auth = 0;
+
 	smp->ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			       SMP_LTK_P256, 0, smp->tk, smp->enc_key_size,
+			       key_type, auth, smp->tk, smp->enc_key_size,
 			       0, 0);
 
 	if (hcon->out) {
-- 
2.1.0

