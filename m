Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] Bluetooth: Fix missing NULL check for smp_chan_create() return value
Date: Mon, 16 Jun 2014 19:25:14 +0300
Message-Id: <1402935919-32348-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp_chan_create function may return NULL, e.g. in the case of memory
allocation failure, so we always need to check for this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f2829a7932e2..e779e5298ebf 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -856,6 +856,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 
 	smp = smp_chan_create(conn);
+	if (!smp)
+		return SMP_UNSPECIFIED;
 
 	skb_pull(skb, sizeof(*rp));
 
-- 
1.9.3

