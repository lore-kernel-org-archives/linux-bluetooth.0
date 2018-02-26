Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix missing encryption refresh on Security Request
Date: Mon, 26 Feb 2018 15:41:53 +0100
Message-Id: <20180226144153.3727-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If Security Request is received on connection that is already encrypted
with sufficient security master should perform encryption key refresh
procedure instead of just ignoring Slave Security Request
(Core Spec 5.0 Vol 3 Part H 2.4.6).

> ACL Data RX: Handle 3585 flags 0x02 dlen 6
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 3585
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 44264272a5c426a9e868f034cf0e69f3
> HCI Event: Command Status (0x0f) plen 4
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Key Refresh Complete (0x30) plen 3
        Status: Success (0x00)
        Handle: 3585

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 01117ae84f1d..a2ddae2f37d7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2296,8 +2296,14 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK)) {
+		/* If link is already encrypted with sufficient security we
+		 * still need refresh encryption as per Core Spec 5.0 Vol 3,
+		 * Part H 2.4.6
+		 */
+		smp_ltk_encrypt(conn, hcon->sec_level);
 		return 0;
+	}
 
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
-- 
2.14.3

