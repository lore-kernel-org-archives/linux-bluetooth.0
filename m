Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Don't try to confirm locally initiated SMP pairing
Date: Mon, 24 Mar 2014 14:39:07 +0200
Message-Id: <1395664748-13494-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
References: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the case that the just-works model would be triggered we only want to
confirm remotely initiated pairings (i.e. those triggered by a Security
Request or Pairing Request). This patch adds the necessary check to the
tk_request function to fall back to the JUST_WORKS method in the case of
a locally initiated pairing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7cb8440811e3..2ab1b3eb2bb7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -387,6 +387,11 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
 		method = JUST_WORKS;
 
+	/* Don't confirm locally initiated pairing attempts */
+	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR,
+					   &smp->smp_flags))
+		method = JUST_WORKS;
+
 	/* If Just Works, Continue with Zero TK */
 	if (method == JUST_WORKS) {
 		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
-- 
1.8.5.3

