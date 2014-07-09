Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Always confirm incoming SMP just-works requests
Date: Wed,  9 Jul 2014 19:18:09 +0300
Message-Id: <1404922691-3881-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
References: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For incoming requests we want to let the user know that pairing is
happening since otherwise there could be access to MEDIUM security
services without any user interaction at all. Therefore, set the
selected method to JUST_CFM instead of JUST_WORKS and let it be
converted back to JUST_WORKS later if we are the initators.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 55c41de2f5a0..a17761c83820 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -391,10 +391,12 @@ static const u8 gen_method[5][5] = {
 
 static u8 get_auth_method(struct smp_chan *smp, u8 local_io, u8 remote_io)
 {
-	/* If either side has unknown io_caps, use JUST WORKS */
+	/* If either side has unknown io_caps, use JUST_CFM (which gets
+	 * converted later to JUST_WORKS if we're initiators.
+	 */
 	if (local_io > SMP_IO_KEYBOARD_DISPLAY ||
 	    remote_io > SMP_IO_KEYBOARD_DISPLAY)
-		return JUST_WORKS;
+		return JUST_CFM;
 
 	return gen_method[remote_io][local_io];
 }
@@ -414,10 +416,14 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 
 	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
 
-	/* If neither side wants MITM, use JUST WORKS */
-	/* Otherwise, look up method from the table */
+	/* If neither side wants MITM, either "just" confirm an incoming
+	 * request or use just-works for outgoing ones. The JUST_CFM
+	 * will be converted to JUST_WORKS if necessary later in this
+	 * function. If either side has MITM look up the method from the
+	 * table.
+	 */
 	if (!(auth & SMP_AUTH_MITM))
-		method = JUST_WORKS;
+		method = JUST_CFM;
 	else
 		method = get_auth_method(smp, local_io, remote_io);
 
-- 
1.9.3

