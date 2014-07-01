Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Allow re-encryption with LTK when STK is in use
Date: Tue,  1 Jul 2014 19:02:09 +0300
Message-Id: <1404230529-16137-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404230529-16137-1-git-send-email-johan.hedberg@gmail.com>
References: <1404230529-16137-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're encrypted with the STK we should allow re-encryption with an
LTK even though the acheived security level is the same. This patch adds
the necessary logic to the smp_sufficient_security function which is
used to determine whether to proceed with encryption or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index de29ad74e571..6407b22c1a00 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -868,6 +868,14 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
 	if (sec_level == BT_SECURITY_LOW)
 		return true;
 
+	/* If we're encrypted with an STK always claim insufficient
+	 * security. This way we allow the connection to be re-encrypted
+	 * with an LTK, even if the LTK provides the same level of
+	 * security.
+	 */
+	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags))
+		return false;
+
 	if (hcon->sec_level >= sec_level)
 		return true;
 
-- 
1.9.3

