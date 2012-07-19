Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: smp: Fix possible NULL dereference
Date: Thu, 19 Jul 2012 13:05:38 +0300
Message-Id: <1342692338-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

smp_chan_create might return NULL so we need to check before
dereferencing smp.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/smp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5bb5b51..1104c5a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -578,8 +578,11 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
 		smp = smp_chan_create(conn);
+	else
+		smp = conn->smp_chan;
 
-	smp = conn->smp_chan;
+	if (!smp)
+		return SMP_UNSPECIFIED;
 
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], req, sizeof(*req));
-- 
1.7.9.5

