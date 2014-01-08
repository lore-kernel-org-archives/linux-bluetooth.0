Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix outgoing authentication requirement check
Date: Wed,  8 Jan 2014 16:40:39 +0200
Message-Id: <1389192039-29493-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The check for HIGH security level dates back to pre-mgmt times when a
raw L2CAP socket with HIGH security level was used to trigger dedicated
bonding. For legacy pairing checking for the security level was the only
way to catch the need to authenticate in all scenarios. With mgmt
however, the pair_device command does not use HIGH security but MEDIUM
security. Therefore, the existing code would never trigger
authentication for a non-SSP connection without an MITM requirement
(e.g. if user space provided a NoInputNoOutput IO capability). In such a
scenario the mgmt_pair_device command would return success without
actually triggering any kind of pairing.

This patch updates the authentication requirement check to also consider
MEDIUM security level, and thereby ensures that mgmt_pair_device will
always trigger authentication.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
This one should probably get a Cc: stable flag. It's also a
pre-requisite for the first mgmt-tester pairing test case that was
recently added to user space git.

 net/bluetooth/hci_event.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5f812455a450..cfcce448957b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1185,9 +1185,12 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 		return 0;
 
 	/* Only request authentication for SSP connections or non-SSP
-	 * devices with sec_level HIGH or if MITM protection is requested */
+	 * devices with sec_level MEDIUM or HIGH or if MITM protection
+	 * is requested.
+	 */
 	if (!hci_conn_ssp_enabled(conn) && !(conn->auth_type & 0x01) &&
-	    conn->pending_sec_level != BT_SECURITY_HIGH)
+	    conn->pending_sec_level != BT_SECURITY_HIGH &&
+	    conn->pending_sec_level != BT_SECURITY_MEDIUM)
 		return 0;
 
 	return 1;
-- 
1.8.4.2

