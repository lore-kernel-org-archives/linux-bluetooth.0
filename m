Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Refactor authentication method lookup into its own function
Date: Tue, 17 Jun 2014 13:07:38 +0300
Message-Id: <1402999659-4969-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
References: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll need to do authentication method lookups from more than one place,
so refactor the lookup into its own function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 513d39d5e099..84f0df21547b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -381,6 +381,16 @@ static const u8 gen_method[5][5] = {
 	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, OVERLAP     },
 };
 
+static u8 get_auth_method(struct smp_chan *smp, u8 local_io, u8 remote_io)
+{
+	/* If either side has unknown io_caps, use JUST WORKS */
+	if (local_io > SMP_IO_KEYBOARD_DISPLAY ||
+	    remote_io > SMP_IO_KEYBOARD_DISPLAY)
+		return JUST_WORKS;
+
+	return gen_method[remote_io][local_io];
+}
+
 static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 						u8 local_io, u8 remote_io)
 {
@@ -397,14 +407,11 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
 
 	/* If neither side wants MITM, use JUST WORKS */
-	/* If either side has unknown io_caps, use JUST WORKS */
 	/* Otherwise, look up method from the table */
-	if (!(auth & SMP_AUTH_MITM) ||
-	    local_io > SMP_IO_KEYBOARD_DISPLAY ||
-	    remote_io > SMP_IO_KEYBOARD_DISPLAY)
+	if (!(auth & SMP_AUTH_MITM))
 		method = JUST_WORKS;
 	else
-		method = gen_method[remote_io][local_io];
+		method = get_auth_method(smp, local_io, remote_io);
 
 	/* If not bonding, don't ask user to confirm a Zero TK */
 	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
-- 
1.9.3

