Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix incorrect clearing of SMP_FLAG_INITIATOR
Date: Wed,  9 Jul 2014 19:18:11 +0300
Message-Id: <1404922691-3881-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
References: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the SMP context is created all flags default to zero. To determine
that we are the initiators it's therefore best to simply change the flag
value when we know we're sending the first SMP PDU. Clearing the flag
when receiving a Pairing Request is not correct since the request may be
a response to a previous Security Request from us (for which we would
already have correctly set the flag). Same goes for receiving a Security
Request which may be coming after us already starting pairing by sending
a Pairing Request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a5e51c686469..627d683203cf 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -735,8 +735,6 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
-
 	return 0;
 }
 
@@ -927,8 +925,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
-	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
-
 	return 0;
 }
 
-- 
1.9.3

