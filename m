Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix MITM flag when initiating SMP pairing
Date: Tue, 18 Mar 2014 15:42:30 +0200
Message-Id: <1395150150-31418-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The pairing process initiated through mgmt sets the conn->auth_type
value regardless of BR/EDR or LE pairing. This value will contain the
MITM flag if the local IO capability allows it. When sending the SMP
pairing request we should check the value and ensure that the MITM bit
gets correctly set in the bonding flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6f29430c29c4..a0150033e797 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -909,6 +909,12 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	authreq = seclevel_to_authreq(sec_level);
 
+	/* hcon->auth_type is set by pair_device in mgmt.c. If the MITM
+	 * flag is set we should also set it for the SMP request.
+	 */
+	if ((hcon->auth_type & 0x01))
+		authreq |= SMP_AUTH_MITM;
+
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 
-- 
1.8.5.3

