Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix setting correct security level when initiating SMP
Date: Thu, 18 Sep 2014 11:26:32 +0300
Message-Id: <1411028792-1049-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can only determine the final security level when both pairing request
and response have been exchanged. When initiating pairing the starting
target security level is set to MEDIUM unless explicitly specified to be
HIGH, so that we can still perform pairing even if the remote doesn't
have MITM capabilities. However, once we've received the pairing
response we should re-consult the remote and local IO capabilities and
upgrade the target security level if necessary.

Without this patch the resulting Long Term Key will occasionally be
reported to be unauthenticated when it in reality is an authenticated
one.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 51fc7db2d84e..f09b6b65cf6b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -494,8 +494,11 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	}
 
 	/* Not Just Works/Confirm results in MITM Authentication */
-	if (method != JUST_CFM)
+	if (method != JUST_CFM) {
 		set_bit(SMP_FLAG_MITM_AUTH, &smp->flags);
+		if (hcon->pending_sec_level < BT_SECURITY_HIGH)
+			hcon->pending_sec_level = BT_SECURITY_HIGH;
+	}
 
 	/* If both devices have Keyoard-Display I/O, the master
 	 * Confirms and the slave Enters the passkey.
-- 
1.9.3

