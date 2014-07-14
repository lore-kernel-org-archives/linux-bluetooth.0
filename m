Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix trying LTK re-encryption when we don't have an LTK
Date: Mon, 14 Jul 2014 14:34:55 +0300
Message-Id: <1405337695-16462-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the case that the key distribution bits cause us not to generate a
local LTK we should not try to re-encrypt if we're currently encrypted
with an STK. This patch fixes the check for this in the
smp_sufficient_security function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index bf3568c46847..8339d6b0f2b8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -876,9 +876,12 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
 	/* If we're encrypted with an STK always claim insufficient
 	 * security. This way we allow the connection to be re-encrypted
 	 * with an LTK, even if the LTK provides the same level of
-	 * security.
+	 * security. Only exception is if we don't have an LTK (e.g.
+	 * because of key distribution bits).
 	 */
-	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags))
+	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
+	    hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
+				 hcon->out))
 		return false;
 
 	if (hcon->sec_level >= sec_level)
-- 
1.9.3

