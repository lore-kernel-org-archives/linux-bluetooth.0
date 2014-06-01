Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix requiring SMP MITM for outgoing connections
Date: Sun,  1 Jun 2014 09:45:24 +0300
Message-Id: <1401605124-330-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Due to recent changes to the way that the MITM requirement is set for
outgoing pairing attempts we can no longer rely on the hcon->auth_type
variable (which is actually good since it was formed from BR/EDR
concepts that don't really exist for SMP).

To match the logic that BR/EDR now uses simply rely on the local IO
capability and/or needed security level to set the MITM requirement for
outgoing pairing requests.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4f9662d0fd81..3d1cc164557d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -909,10 +909,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	authreq = seclevel_to_authreq(sec_level);
 
-	/* hcon->auth_type is set by pair_device in mgmt.c. If the MITM
-	 * flag is set we should also set it for the SMP request.
+	/* Require MITM if IO Capability allows or the security level
+	 * requires it.
 	 */
-	if ((hcon->auth_type & 0x01))
+	if (hcon->io_capability != HCI_IO_NO_INPUT_OUTPUT ||
+	    sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
-- 
1.9.3

