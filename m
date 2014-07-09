Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix forcing SMP just-works with no-bonding
Date: Wed,  9 Jul 2014 19:18:10 +0300
Message-Id: <1404922691-3881-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
References: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Whether we bond or not should not have any impact on the user
interaction model. This patch removes an incorrect fall-back from
JUST_CFM to JUST_WORKS in case we're not bonding.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a17761c83820..a5e51c686469 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -427,10 +427,6 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	else
 		method = get_auth_method(smp, local_io, remote_io);
 
-	/* If not bonding, don't ask user to confirm a Zero TK */
-	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
-		method = JUST_WORKS;
-
 	/* Don't confirm locally initiated pairing attempts */
 	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		method = JUST_WORKS;
-- 
1.9.3

